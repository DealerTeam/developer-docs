/**
 * Cashier Controller 
 * @description Custom controller used in the cashier payments page
 */
global with sharing class Cashier {
    
    /**
     * @description
     */
    private final Service_Repair_Order__c servicero;
    
    /**
     * @description
     */
    private final Parts_Invoice__c partsinvoice;
    
    /**
     * @description
     */
    public List<Cashering__c> clines {get; set;}
    
    /**
     * @description
     */
    public Cashering__c cashierPaidBy {get;set;}
    
    /**
     * @description
     */
    public DMS_Settings__c dms {get; private set;}
    
    /**
     * @description
     */
    public Decimal totalDue {get; set;}
    
    /**
     * @description
     */
    public Decimal invoiceAmount { get; set; }
    
    /**
     * @description
     */
    public Decimal applyAmount {get; set;}
    
    /**
     * @description
     */
    public String authCode {get;set;}
    
    /**
     * @description
     */
    public String closeDate {get { Date cDate = Date.today(); return String.valueOf(cDate); } set;}
    
    /**
     * @description
     */
    public boolean deposit {get;set;}
    
    /**
     * @description
     */
    public String invoiceNumber {get; private set;}
    
    /**
     * @description
     */
    public String companyNumber {get; private set;}
    
    /**
     * @description
     */
    public String customer {get; private set;}
    
    /**
     * @description
     */
    public String account {get; private set;}
    
    /**
     * @description
     */
    public Id customerId {get;private set;}
    
    /**
     * @description
     */
    public String department {get;private set;}
    
    /**
     * @description
     */
    public String invoiceId {get;private set;}
    
    /**
     * @description
     */
    public Boolean posted {get;private set;}
    
    /**
     * @description
     */
    public String paymethods {get;set;}
    
    /**
    * Constructor : instantiates the object, loads settings and performs configuration validation.
    *               based on the referenced department in the GET Variables 
    *               an invoice is loaded from the database.
    */
    public Cashier() 
    {
        // Used to capture who paid the amount
        cashierPaidBy = new Cashering__c();

        // Standard setup 
        dms = DMS_Settings__c.getValues('ActiveSettings');
        invoiceId=ApexPages.currentPage().getParameters().get('id');
        Map<String, Payment_Methods__c> methods = Payment_Methods__c.getAll();
        if(methods.isEmpty()) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Payment methods not configured, Please define payment methods in the DMS Setup.'));   
        }
        
        if(ApexPages.currentPage().getParameters().get('department')=='service') {
            department='service';
            loadServiceInvoice();
        }
        
        if(ApexPages.currentPage().getParameters().get('department')=='parts') {
            department='parts';
            loadPartsInvoice();
        }

        applyAmount = applyAmount.setScale(2, System.RoundingMode.HALF_UP);  
    }
    
    /**
     * getPaymentMethods 
     * @return List<SelectOption>
     * @description
     */ 
    global List<SelectOption> getPaymentMethods() 
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', '-- Select One --'));
        
        Map<String, Payment_Methods__c> methods = Payment_Methods__c.getAll();
        for(String paymentMethodName : methods.keySet()) {
            Payment_Methods__c pm = methods.get(paymentMethodName);
            options.add(new SelectOption(pm.Name, pm.Method__c));
        }
        return options;
    }
    
    /**
     * applyPayment 
     * @return  PageReference
     * @description 
     */
    public PageReference applyPayment() 
    {

        SavePoint sp = Database.setSavePoint();

        applyAmount =   applyAmount.setScale(2, System.RoundingMode.HALF_UP);
        totalDue    =   totalDue.setScale(2, System.RoundingMode.HALF_UP);

        if(paymethods==null || paymethods == '') {

            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Payment method required.  Please chose the appropriate payment method. '));
            return null;

        } else {

            Payment_Methods__c pm = Payment_Methods__c.getValues(paymethods);

                if(pm == null) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Payment Methods not setup.  Please setup payment methods before attempting to cashier. '));
                    return null;
                }
                
                // Check to ensure more cannot be collected than is due.
                if(applyAmount>totalDue){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Amount collected can not excede amount due.'));
                    return null;
                }
                
                if(deposit==true && applyAmount <= 0) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Deposits can not be less than or equal to $0'));
                    return null;                    
                }
                
            Cashering__c cashierRecord = new Cashering__c();

            // Insert Cashier
            cashierRecord.Payment_Method__c = pm.Method__c;   
            if(department=='service') {     cashierRecord.Service_Repair_Order__c = invoiceId;    }
            if(department=='parts') {       cashierRecord.Parts_Invoice__c = invoiceId;   }
            if(deposit==true) { cashierRecord.Deposit__c = true; }

            // Check to see who payment was collected by, if blank, place Account from the Parent record in place.
            cashierRecord.Customer__c=customerId;
            if(cashierPaidBy.Customer__c!=null) {
                cashierRecord.Customer__c=cashierPaidBy.Customer__c;
            }

            cashierRecord.Close_Date__c=  Date.today();
            cashierRecord.Amount__c= applyAmount.setScale(2, System.RoundingMode.HALF_UP);
            cashierRecord.Credit_Card_Authorization_Code__c = authCode;

            Task t = new Task( Subject='Cashier applied payment: $'+applyAmount,
                               ActivityDate=Date.today(),
                               WhatId=invoiceId,
                               Status='Completed');

            try {
                
                insert cashierRecord;
                insert t;  

                // Hook to Posting Engine if necessary
                String accountingPayload = '{"recordId" : "'+cashierRecord.Id+'", "orgId" : "'+UserInfo.getOrganizationId()+'", "requestedBy" : "'+UserInfo.getUserId()+'", "action" : "cashier_receipt"}';
                Cashier.emailAsyncHandler(accountingPayload);

            } Catch(DmlException e) {
                Database.rollBack(sp);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
                return null;                  
            }
            
            if(applyAmount==totalDue && dms.Cashier_Auto_Close__c==true) {              
                
            }
            // Partial Payment, return to cashier screen
            
            PageReference cashierPayments = Page.CashierPayments;
            cashierPayments.setRedirect(true);
            cashierPayments.getParameters().put('department', department);
            cashierPayments.getParameters().put('id', invoiceId);
            return cashierPayments;
        }
    }
    
    /**
     * postInvoice 
     * @return PageReference  
     * @description
     */
    public PageReference postInvoice() 
    {
            
            // In Balance, if not can not post invoice
            if(applyAmount!=Decimal.valueOf('0.0')) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Payment must be made before attempting to post Invoice.'));
                return null;
            }
        
            // Determin if the ID is for Service or Parts, else NULL
            if(ApexPages.currentPage().getParameters().get('Id')!=null || ApexPages.currentPage().getParameters().get('Id')!='') {
                Schema.SObjectType objType  =   CustomObjects.getObjectType(ApexPages.currentPage().getParameters().get('Id'));
            } else {
                return null;
            }
            
        
            // Move Ticket to post status
            if(department=='parts') {
                
                Parts_Invoice__c pi = [Select Id, Invoice_Date_Time__c, Post_Date_Time__c from Parts_Invoice__c where Id =:invoiceId limit 1];
                if(pi.Invoice_Date_Time__c==null) {
                    pi.Invoice_Date_Time__c=DateTime.now();
                }
                pi.Post_Date_Time__c= DateTime.now();
                pi.Status__c = 'Posted';
                
                // Craft Payload
                String accountingPayload = '{"recordId" : "'+pi.Id+'", "orgId" : "'+UserInfo.getOrganizationId()+'", "requestedBy" : "'+UserInfo.getUserId()+'", "action" : "parts_invoice"}';

                try {
                    Cashier.emailAsyncHandler(accountingPayload);
                    update pi;
                }Catch(DmlException e) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
                    return null;
                }
                
                // Redirect back to Ticket
                PageReference partsInvoice = Page.PartsInvoice;
                partsInvoice.setRedirect(true);
                partsInvoice.getParameters().put('id', pi.Id);
                return PartsInvoice;
            }
            
            // Move Repair Order to Post Status
            if(department=='service') {
                Service_Repair_Order__c si = [Select Id, Invoiced_Date_Time__c, Posted_Date_Time__c, Status__c
                                                         from Service_Repair_Order__c where Id = :invoiceId limit 1];
                if(si.Invoiced_Date_Time__c == null) {
                    si.Invoiced_Date_Time__c=DateTime.now();
                }
                si.Status__c = 'Posted';
                si.Posted_Date_Time__c=DateTime.now();
                
                // Craft Payload
                String accountingPayload = '{"recordId" : "'+si.Id+'", "orgId" : "'+UserInfo.getOrganizationId()+'", "requestedBy" : "'+UserInfo.getUserId()+'", "action" : "service_repair_order_post"}';

                try {
                    Cashier.emailAsyncHandler(accountingPayload);
                    update si;
                }Catch(DmlException e) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
                    return null;
                }

                
                // Redirect back to Service Repair Order               
                ApexPages.StandardController ROCont = new ApexPages.StandardController(si);
                PageReference serviceInvoice = ROCont.view();
                serviceInvoice.setRedirect(true);
                return serviceInvoice;

            }
            
            return null;            
    }

    /**
    * returnToInvoice
    * @return PageReference
    * @description method to return the user to the Service or Parts invoice that this application was directed from
    */
    public PageReference returnToInvoice() 
    {
        if(invoiceId==null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to return to source document, no invoiceId provided.'));
            return null;     
        }       

        PageReference p = new PageReference('/'+invoiceId);
        p.setRedirect(true);
        return p;
    }

    /**
     * cancel -  to return to the record that the cashiering is taking place from
     * @return PageReference
     * @description supports dynamic refering and returns the user to the page that they are cashiering
     */
    public PageReference cancel() 
    {
        if(invoiceId==null) {
            return null;
        }

        PageReference p = new PageReference('/'+invoiceId);
        p.setRedirect(true);
        return p;
    }

    /**
     * loadServiceInvoice description
     * @returns void
     * @description
     */
    public void loadServiceInvoice() 
    {
        Service_Repair_Order__c sro = [Select d.Deposit__c, d.Customer__c, 
                                                d.Customer_Contact__c, 
                                                d.Customer_Contact__r.Name, 
                                                d.Name, d.Customer_Charges__c, 
                                                d.Company_Number__c, 
                                                d.Customer__r.Type, 
                                                d.Customer__r.Name, 
                                                d.Tax__c, 
                                                d.Discount_Total__c,
                                                d.Posted_Date_Time__c
                                                    From Service_Repair_Order__c d
                                                        where d.Id = :ApexPages.currentPage().getParameters().get('id')
                                                        limit 1];   
                                                        
        clines = [Select d.Service_Repair_Order__c, d.Payment_Method__c, 
                                d.Parts_Invoice__c, d.Customer__c,
                                d.Customer__r.Type,
                                d.Credit_Card_Authorization_Code__c, 
                                d.Close_Date__c, d.Amount__c, 
                                d.SystemModstamp, d.OwnerId, d.Name, d.LastModifiedDate, 
                                d.LastModifiedById, d.IsDeleted, d.Id, d.CreatedDate, 
                                d.CreatedById, d.Deposit__c, d.Customer__r.Name,
                                d.Print_Receipt__c
                            From Cashering__c d 
                            where d.Service_Repair_Order__c = :invoiceId 
                            and d.Amount__c != null limit 200];

        if(sro.Posted_Date_Time__c!=null) {
            posted = true;
        }
                            
        Decimal tmpAmount = 0;
        for(Cashering__c dC : clines) {
            tmpAmount += dC.Amount__c;
        }                                                                   

        // Null reference checks
        if(sro.Discount_Total__c==null) { sro.Discount_Total__c=0; }
        if(sro.Tax__c==null) { sro.Tax__c=0; }
        if(sro.Customer_Charges__c==null) { sro.Customer_Charges__c=0; }
        this.totalDue      = ((sro.Customer_Charges__c + sro.Tax__c + sro.Discount_Total__c) - tmpAmount);
        this.totalDue      = this.totalDue.setScale(2, RoundingMode.HALF_UP);
        this.applyAmount   = this.totalDue.setScale(2, RoundingMode.HALF_UP);
        this.invoiceAmount = (sro.Customer_Charges__c + sro.Tax__c + sro.Discount_Total__c);
        this.invoiceNumber = sro.Name;
        this.companyNumber = sro.Company_Number__c;
        this.customer      = sro.Customer_Contact__r.Name;
        this.account       = sro.Customer__r.Name;
        this.customerId    = sro.Customer__c;                                               
    } 
    
    /**
     * loadPartsInvoice description
     * @return void
     * @description
     */
    public void loadPartsInvoice() 
    {
        Parts_Invoice__c pi = [Select d.Total_Invoice__c, d.Customer__r.Type,
                                            d.Customer__r.Name, d.Customer__c,
                                            d.Company_Number__c, d.Name, d.Id,
                                            d.Customer_Contact__r.Name, d.Deposit__c
                                              From Parts_Invoice__c d
                                              where d.Id = :ApexPages.currentPage().getParameters().get('id')
                                              limit 1];
                                              
                clines = [Select d.Service_Repair_Order__c, d.Payment_Method__c, d.Parts_Invoice__c, d.Customer__c, 
                                d.Customer__r.Name, d.Customer__r.Type,
                                d.Credit_Card_Authorization_Code__c, d.Close_Date__c, d.Amount__c, d.SystemModstamp, 
                                d.OwnerId, d.Name, d.LastModifiedDate, d.LastModifiedById, d.IsDeleted, d.Id, d.CreatedDate, d.CreatedById,
                                d.Deposit__c, d.Print_Receipt__c 
                                From Cashering__c d 
                                where d.Parts_Invoice__c = :invoiceId 
                                and d.Amount__c != null limit 200];
                    
        Decimal tmpAmount = 0;
        for(Cashering__c dC : clines) {
            tmpAmount += dC.Amount__c;
        }   
                                              
        this.totalDue      = (pi.Total_Invoice__c - tmpAmount);
        this.applyAmount   = this.totalDue.setScale(2, RoundingMode.HALF_UP);
        this.invoiceAmount = pi.Total_Invoice__c;
        this.invoiceNumber = pi.Name;
        this.companyNumber = pi.Company_Number__c;
        this.customer      = pi.Customer_Contact__r.Name;
        this.account       = pi.Customer__r.Name;   
        this.customerId    = pi.Customer__c;                                          
    }

    /**
     * voidRepairOrder 
     * @return PageReference 
     * @description
     */ 
    public PageReference voidRepairOrder() 
    {
        // Void this repair order

       Service_Repair_Order__c ro = [Select Id, Total_Repair_Order_Charges__c from Service_Repair_Order__c where Id=:invoiceId limit 1];
        if(ro.Total_Repair_Order_Charges__c>0) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to void repair order.  Charges still exist.'));
            return null;
        }

        ro.Invoiced_Date_Time__c=Datetime.now();
        ro.Posted_Date_Time__c=DateTime.now();
        ro.Status__c='Void';

        try {
            update ro;

            if(test.isRunningTest())
                throw new DmlException('test exception');

        } Catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));

             if(!test.isRunningTest())
                return null;            
        }

        PageReference p = new PageReference('/'+invoiceId);
        p.setRedirect(true);
        return p;        
    }

    /**
     * reOpenRO 
     * @return PageReference
     * @description
     */
    public PageReference reOpenRO() 
    {
        Id roId=ApexPages.currentPage().getParameters().get('Id');
        if(roId==null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Invalid Repair Order ID, unable to process request.'));
            return null;
        }

        Service_Repair_Order__c ro = [SELECT Id, Name, Status__c FROM Service_Repair_Order__c WHERE Id=:roId LIMIT 1];
        if(ro.Status__c != 'Posted') {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Repair Order is not posted, please check Repair Order Status before attempting to Re-Open.'));
            return null;
        }

        // Craft Payload
        String accountingPayload = '{"recordId" : "'+ro.Id+'", "orgId" : "'+UserInfo.getOrganizationId()+'", "requestedBy" : "'+UserInfo.getUserId()+'", "action" : "service_repair_order_post"}';

        try {
            Cashier.emailAsyncHandler(accountingPayload);
        }Catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return null;
        }
        
        // Redirect back to Service Repair Order               
        ApexPages.StandardController ROCont = new ApexPages.StandardController(ro);
        PageReference serviceInvoice = ROCont.view();
        serviceInvoice.setRedirect(true);
        return serviceInvoice;        
    }


    /**
     * emailAsyncHandler 
     * @param payload
     * @return void
     * @description
     */
    global static void emailAsyncHandler(String payload) 
    {
        
        String emailHandle = Cashier.emailServiceAddress();
        
        // Get the Org Defaults
        DMS_Settings__c dms = Utility.getDMSSettings();
        if(dms.Integrated_Financial_Application__c==null 
           	|| dms.Integrated_Financial_Application__c==''
	        || emailHandle==null 
             || emailHandle=='') {
                 
	            Cashier.storeFinancialRequestEvent(payload);     
     	       return;
        }

        try {
            // Derive Email Handle from Org Configuation
            if(Test.isRunningTest()) {
                emailHandle = 'fake@blackhole.org';
            }

            Messaging.SingleEmailMessage mail=new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {emailHandle};
            mail.setToAddresses(toAddresses); 
            mail.setSubject('Asyncnronous Processing Request');
            mail.setPlainTextBody(payload);
        
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        } catch(Exception e) {
            throw new CashierException(e.getMessage());            
        } 
    } 

    /**
     * storeFinancialRequestEvent 
     * @param payload
     * @return void
     * @description
     */
    public static void storeFinancialRequestEvent(String payload) 
    {
        try {
           
            List<FinancialRecordRequest__e> fres = new List<FinancialRecordRequest__e>();
            fres.add(new FinancialRecordRequest__e(
            	ProcessingRequestPayload__c=payload
            ));
            
            // Call method to publish events
            List<Database.SaveResult> results = EventBus.publish(fres);
            
            // Inspect publishing result for each event
            String eventPublishError = '';
            Boolean isPublishError = false;
            for (Database.SaveResult sr : results) {
                if (!sr.isSuccess()) {
                    isPublishError=true;
                    for(Database.Error err : sr.getErrors()) {
                        eventPublishError += 'Error returned: ' + err.getStatusCode() + ' - ' +err.getMessage()+' \r\n';
                    }
                }       
            }  
            
            if(isPublishError) {
                throw new CashierException(eventPublishError);
            }
            
        } Catch(Exception e) {
            throw new CashierException(e.getMessage());
        }
    }

    /**
     * emailServiceAddress
     * @return String
     * @description determines the email handle for processing the integrated financials requests
     */
    public static String emailServiceAddress() 
    {

        String emailHandle = '';

        // Get the Org Defaults
        DMS_Settings__c dms = Utility.getDMSSettings();
        if(dms.Integrated_Financial_Application__c==null || dms.Integrated_Financial_Application__c=='') {
            return null;
        }
        
        // Are we integrated with the Financial Force Application
        if(dms.Integrated_Financial_Application__c=='FinancialForce') {

            ApexClass apexClass= [SELECT Id, Name FROM ApexClass where (Name = 'FinancialForceEmailService' and NamespacePrefix = 'dtffa') or (Name='AccountingEmailService') limit 1];
            
            EmailServicesFunction emailServicesFunction = [SELECT Id, FunctionName, IsActive, ApexClassId, ErrorRoutingAddress FROM EmailServicesFunction where ApexClassId=:apexClass.Id limit 1]; 

            EmailServicesAddress emailServicesAddress = [SELECT LocalPart, EmailDomainName, Id, RunAsUserId, FunctionId FROM EmailServicesAddress where FunctionId=:emailServicesFunction.Id limit 1];

            emailHandle = emailServicesAddress.LocalPart+'@'+emailServicesAddress.EmailDomainName;
        }

        if(dms.Integrated_Financial_Application__c=='SageLive') {

            ApexClass apexClass= [SELECT Id, Name FROM ApexClass where (Name = 'SageLiveEmailService' and NamespacePrefix = 'dtsa') limit 1];
            
            EmailServicesFunction emailServicesFunction = [SELECT Id, FunctionName, IsActive, ApexClassId, ErrorRoutingAddress FROM EmailServicesFunction where ApexClassId=:apexClass.Id limit 1]; 

            EmailServicesAddress emailServicesAddress = [SELECT LocalPart, EmailDomainName, Id, RunAsUserId, FunctionId FROM EmailServicesAddress where FunctionId=:emailServicesFunction.Id limit 1];

            emailHandle = emailServicesAddress.LocalPart+'@'+emailServicesAddress.EmailDomainName;
        }        // Are we integrated with SageLive


        if(dms.Integrated_Financial_Application__c=='SageFinancials') {

            ApexClass apexClass= [SELECT Id, Name FROM ApexClass where (Name = 'FinancialsEmailHandler' and NamespacePrefix = 'dtfin') limit 1];
            
            EmailServicesFunction emailServicesFunction = [SELECT Id, FunctionName, IsActive, ApexClassId, ErrorRoutingAddress FROM EmailServicesFunction where ApexClassId=:apexClass.Id limit 1]; 

            EmailServicesAddress emailServicesAddress = [SELECT LocalPart, EmailDomainName, Id, RunAsUserId, FunctionId FROM EmailServicesAddress where FunctionId=:emailServicesFunction.Id limit 1];

            emailHandle = emailServicesAddress.LocalPart+'@'+emailServicesAddress.EmailDomainName;
        }


        return emailHandle;
    }   

    /**
     * CashierException
     * @description
     */
    public class CashierException extends Exception {}
}