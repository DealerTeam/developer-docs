/**
 * 2016.08.29       |Sneha                |Case#1978
 *   Comment RO Number assignment code as its added in trigger
 *       
 */

public with sharing class ServiceEstimate_EXT { 
    
    public dealer__Service_Estimate__c se {get;set;}
    public list<dealer__DMS_Settings__c> dms = dealer__DMS_Settings__c.getall().values();
    public dealer__Vehicle_Inventory__c vid;
    private ApexPages.Standardcontroller m_controller;
    private String showRecordValue;
    private String idValue;
    public String InventoryVehicleId;   
    public String email {get;set;}
    public String subject {get { return 'Service Estimate'; } set;}
    public String body { get; set; }
    private Messaging.EmailFileAttachment defaultAttachment;
    
    public void setInventoryVehicleId(String n) {
        InventoryVehicleId = n;
    }
    
    public String getInventoryVehicleId() {
        return InventoryVehicleId;
    }
    
    // <name>ServiceEstimate_EXT</name>
    // <summary>controller extension for Service_Estimate__c, process all logic used in Estimates presentation layer</summary>
    // <param name='sc'>Standard Controller</param>
    public ServiceEstimate_EXT(ApexPages.Standardcontroller sc) {
        m_controller = sc;
        List<String> af = new List<String>();
        if(!Test.isRunningTest()) {
            /*
            | Had to prevent test class from error: 
            |   System.SObjectException: You cannot call addFields when the data is being passed into the controller by the caller.
            */          
            af.add('dealer__Parts_Sublet_Total__c');
            af.add('Inventory_vehicle__r.dealer__Stock_Number__c');
            af.add('Inventory_vehicle__r.dealer__Year__c');
            af.add('Inventory_vehicle__r.dealer__Model__c');
            af.add('Inventory_vehicle__r.dealer__Trim_Level__c');
            af.add('Inventory_vehicle__r.dealer__VIN__c');
            af.add('Inventory_vehicle__r.dealer__Mileage__c');
            af.add('dealer__EmailApprover__c');
            af.add('dealer__Customer__c');
            af.add('dealer__Service_Vehicle__c');
            af.add('dealer__Service_Vehicle__r.Id');
            af.add('dealer__Estimate_Total__c');
            sc.addFields(af);
        }
        se = (dealer__Service_Estimate__c)sc.getRecord();
        
        if(se.RecordTypeId != null) {
            RecordType[] r = [Select Id, Name, DeveloperName from RecordType where Id = :se.RecordTypeId limit 1];
            if(r[0].Id != null && se.Id != null) {
                if(r[0].DeveloperName == 'X4_square') {
                
                this.idValue = se.Id;
                this.showRecordValue = '4-Square';
                } else {
                    this.idValue = se.Id;
                    this.showRecordValue = 'Service Estimate';
                }
            } else {
                
                this.idValue = se.Id;
                this.showRecordValue = 'default';
            }
        } else {
            this.idValue = se.Id;
            this.showRecordValue = 'default';
        }
        
        if(ApexPages.currentPage().getParameters().get('vId') != null) {
            RecordType[] recfoursquare = [Select Id, Name from RecordType where DeveloperName = 'X4_Square' limit 1];
            this.setInventoryVehicleId(ApexPages.currentPage().getParameters().get('vId'));
            this.getVehicle();
            se.dealer__Inventory_Vehicle__c = vid.Id;
            if(recfoursquare[0].Id != null) {
                se.RecordTypeId = recfoursquare[0].Id;
            }
        }
    }

    /*
        Finalizes the Service Estimate and Updates the Vehicle Cost
    */
    public pageReference finalize() {
        if(dms[0].dealer__StandAloneMode__c  == true) {
            dealer__Vehicle_Inventory__c v = [select Id, dealer__Vehicle_Cost__c 
                                                from dealer__Vehicle_Inventory__c 
                                                where Id=:se.dealer__Inventory_Vehicle__c
                                                limit 1
                                                for update];

            if(v.dealer__Vehicle_Cost__c==null) {
                v.dealer__Vehicle_Cost__c=0;
            }                                                
        
            v.dealer__Work_in_Process__c = 0;
            v.dealer__Vehicle_Cost__c += se.dealer__Estimate_Total__c;
            update v;
        }
        
        se.dealer__Finish_Date__c = Date.today();
        se.dealer__Finalized_By__c = UserInfo.getUserId();
        se.dealer__Status__c = 'Finalized';
        update se;

        PageReference EstimatePage = new ApexPages.StandardController(se).view();
        EstimatePage.setRedirect(true);
        
        return EstimatePage;        
    }

    /** It converts Service Estimate to Service Repair Order
        and Service Estimate Lines to Service Job lines 
        @ added by Mahesh S
        **/
    public pageReference convertToRO(){

        SavePoint sp = Database.setSavePoint();

        dealer__Service_Repair_Order__c s = new dealer__Service_Repair_Order__c();
        
        s.dealer__Customer_Contact__c = se.dealer__Customer_Contact__c;
        s.dealer__Customer__c = se.dealer__Customer__c;
        s.dealer__Create_Date_Time__c= DateTime.now();
        s.dealer__Vehicle__c = se.dealer__Service_Vehicle__c;
        s.dealer__Service_Advisor__c = UserInfo.getUserId();
        s.dealer__Mileage_In__c = (se.dealer__Current_Mileage__c!=null) ? se.dealer__Current_Mileage__c : 0;
        s.dealer__Customer_Sublet_Charges__c=se.Total_Sublet_Charges__c;
        s.dealer__Customer_Labor_Charges__c=se.Total_Labor_Charges__c;
        s.dealer__Customer_Parts_Charges__c=se.Total_Parts_Charges__c;        

        try {
            insert s;
        } Catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            database.rollback(sp);
        }

        List<dealer__Service_Job__c> serviceJobs=new List<dealer__Service_Job__c>();
        List<dealer__Service_Estimate_Line__c> serviceLineEstimate=[Select d.dealer__damageCoordinateY__c, d.dealer__damageCoordinateX__c, d.dealer__Vendor__c, 
                d.dealer__Tax__c, d.dealer__Sublet_Work__c, d.dealer__Sublet_Charges__c, d.dealer__Sub_Total__c, 
                d.dealer__Repair_Type__c, d.dealer__Parts__c, d.dealer__Part_Item__c, d.dealer__Part_Description__c, 
                d.dealer__Labor__c, d.dealer__Labor_Operation__c, d.dealer__Discount_Parts__c, d.dealer__Discount_Labor__c, 
                d.dealer__Diagram_Reference_Number__c, d.dealer__Description__c, d.dealer__Cosmetic_Estimate__c, d.dealer__Labor_Operation__r.Name,
                d.dealer__Book_Time__c 
                From dealer__Service_Estimate_Line__c d
                Where d.dealer__Service_Estimate__c = :se.Id];

        Integer sjln = 0;        
        for(dealer__Service_Estimate_Line__c sel:serviceLineEstimate){
            // serviceSettings.dealer__Service_Job_Line_Number__c += 1;
            sjln = sjln + 1;
            dealer__Service_Job__c SJ=new dealer__Service_Job__c(Name=sel.dealer__Labor_Operation__r.Name,
                                                //Name=String.valueOf(serviceSettings.dealer__Service_Current_Invoice_Number__c),
                                                dealer__Line_Number__c=sjln,
                                                dealer__Book_Time__c=sel.dealer__Book_Time__c ,
                                                dealer__CustomerConcern__c=sel.dealer__Description__c,
                                                //dealer__Estimate__c=sel.dealer__Cosmetic_Estimate__c,
                                                dealer__Estimate__c=0,
                                                dealer__Parts_Cost__c=sel.dealer__Parts__c,
                                                dealer__Labor_Charges__c=sel.dealer__Labor__c,
                                                dealer__Op_Code__c=sel.dealer__Labor_Operation__r.Name,
                                                dealer__Standard_Operation_Code__c=sel.dealer__Labor_Operation__c,
                                                dealer__Service_Repair_Order__c=s.Id
                        );
            
            serviceJobs.add(SJ);
        }
        if(serviceJobs.size()>0){
            try {
                insert serviceJobs;
            } Catch(DmlException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
                database.rollback(sp);
            }
        }        
            
        PageReference RepairOrderPage = new ApexPages.StandardController(s).view();
        RepairOrderPage.setRedirect(true);
        
        return RepairOrderPage;
    }
    
    // <name>getEstimateLines</name>
    // <summary>Retrieve estimate lines so Page.getContent has data available</summary>
    public dealer__Service_Estimate_Line__c[] getEstimateLines() {
        return [Select d.dealer__damageCoordinateY__c, d.dealer__damageCoordinateX__c, d.dealer__Vendor__c, 
                d.dealer__Tax__c, d.dealer__Sublet_Work__c, d.dealer__Sublet_Charges__c, d.dealer__Sub_Total__c, 
                d.dealer__Repair_Type__c, d.dealer__Parts__c, d.dealer__Part_Item__c, d.dealer__Part_Description__c, 
                d.dealer__Labor__c, d.dealer__Labor_Operation__c, d.dealer__Discount_Parts__c, d.dealer__Discount_Labor__c, 
                d.dealer__Diagram_Reference_Number__c, d.dealer__Description__c, d.dealer__Cosmetic_Estimate__c, 
                d.dealer__Book_Time__c, d.dealer__Labor_Operation__r.dealer__Op_Code_Description__c 
                    From dealer__Service_Estimate_Line__c d
                    Where d.dealer__Service_Estimate__c = :se.Id limit 100];
    }
    
    // <name>addService</name>
    // <summary>Send user to service estimate line page to add service work</summary>
    public PageReference addService() {
        PageReference estLine = Page.ServiceEstimateServiceLine;
        if(se != null ) {
            estLine.getParameters().put('sId', string.valueOf(se.Id));
        }
        return estLine;
    }
    
    // <name>addPart</name>
    // <summary>Send user to service estimate line page to add part</summary>
    public PageReference addPart() {
        PageReference estLine = Page.ServiceEstimatePartLine;
        if(se != null) {
            estLine.getParameters().put('sId', string.valueOf(se.Id));
        }
        return estLine;
    }
    
    // <name>addSublet</name>
    // <summary>Send user to service estimate line page to add sublet</summary>
    public PageReference addSublet() {
        PageReference estLine =  Page.ServiceEstimateSubletLine;
        if(se != null) {
            estLine.getParameters().put('sId', string.valueOf(se.Id));
        }
        return estLine;
    }  
    
    public PageReference addCosmetic() {
        PageReference cosLine = Page.ServiceEstimateCosmeticLines;
        if(se != null) {
            cosLine.getParameters().put('sId', string.valueOf(se.Id));
        }
        return cosLine;
    } 
    
    // <name>emailButton</email>
    // <summary>Send user to email estimate page</summary>
    public PageReference emailButton() {
        PageReference eb = Page.ServiceEstimateEmailPDF;
        if(se != null) {
            eb.getParameters().put('id', string.valueOf(se.Id));
        }
        return eb;
    }
    
    // <name>noRefresh</name>
    // <summary>blank page reference to prevent update to page resources</summary>
    public PageReference noRefresh() {
        return null;
    }
    
    public PageReference saveMobile4Square() {
        m_controller.save();
        // Record Activity
        if(!Test.isRunningTest()) {
        Task t = new Task( Subject='Created Used Reconditioning Estimate',
                           ActivityDate=Date.today(),
                           WhatId=vid.Id,
                           OwnerId=UserInfo.getUserId(),
                           Status='Completed');
        insert t;   
        }
        return null;
    }
    
    public PageReference Save() {
        if(se.dealer__Service_Vehicle__c==null && se.dealer__Inventory_Vehicle__c != null) {
            se.dealer__Service_Vehicle__c = [Select Id from dealer__Service_Vehicle__c where dealer__VIN__c =:se.dealer__Inventory_Vehicle__r.dealer__VIN__c limit 1].Id;
        }
        m_controller.save();
        return null;    
    }
    
    public PageReference saveEstimate() {
        if(se.dealer__Service_Vehicle__c==null && se.dealer__Inventory_Vehicle__c != null) {
            se.dealer__Service_Vehicle__c = [Select Id from dealer__Service_Vehicle__c where dealer__VIN__c =:se.dealer__Inventory_Vehicle__r.dealer__VIN__c limit 1].Id;
        }
        m_controller.save();
        return null;
    }
    
    // <name>HasEstimateLines</name>
    // <summary>Does this service estimate have any lines?</summary>
    public boolean getHasEstimateLines() {
        return se.dealer__Service_Estimate_Lines__r.size() >0;
    }
    
    // <name>HasActivityHistories</name>
    // <summary>Does this service estimate any activity history</summary>
    public boolean getHasActivityHistories() {
        return se.ActivityHistories.size() >0;
    }
    
    // <name>getVehicle</name>
    // <summary>If get method variable requesting vehicle is set, get record</
    public dealer__Vehicle_Inventory__c getVehicle() {
        if(getInventoryVehicleId() != null) {
        dealer__Vehicle_Inventory__c[] vid_temp =  [Select Id, Name, dealer__VIN__c 
                                                        from dealer__Vehicle_Inventory__c 
                                                        where Id = :getInventoryVehicleId() limit 1 ];
                                                    
            if(vid_temp.size() > 0) { 
                vid = vid_temp[0];
            } 
        }
        return vid;                                     
    }
    
    // <name>GetServiceROLines</name>
    // <summary>Retrieve all lines of Service Jobs</summary>
    public List<dealer__Service_Job__c> getROJobLines() {
        if(se.dealer__Service_Vehicle__c!=null) {
            return [Select d.dealer__Stat__c, d.dealer__Standard_Operation_Code__r.dealer__Op_Code__c, d.dealer__Standard_Operation_Code__r.dealer__Op_Code_Description__c, 
                            d.dealer__Standard_Operation_Code__c, d.dealer__Repair_Order__c, d.dealer__RO_Number__c, d.dealer__RO_Invoice_Date_Time__c, 
                            d.dealer__Line_Total__c, d.dealer__Line_Number__c, d.dealer__Labor_Type__c, d.dealer__Estimate__c, d.dealer__Correction__c, d.dealer__Repair_Order_Id__c,
                            d.dealer__CustomerConcern__c, d.dealer__Cause__c, d.dealer__Book_Time__c, d.dealer__Actual_Time__c, d.Name, d.IsDeleted, d.Id, d.CreatedDate 
                            From dealer__Service_Job__c d
                            where d.dealer__Service_Vehicle_Id__c =: String.valueOf(se.dealer__Service_Vehicle__r.Id).left(15)
                            order by d.dealer__RO_Number__c desc, d.dealer__Line_Number__c asc  
                            limit 1000];                        
        } else {
            return new List<dealer__Service_Job__c>();
        }
    }
        
    // <name>ShowRecord</name>
    // <summary>get method to return record type associated visualforce page user has requested</summary>
    public String ShowRecord {
        get {
            return showRecordValue;
        }
    }
    
    // <name>RecordID</name>
    // <summary>get method to return record ID of associated parent record</summary>
    public String RecordID {
        get {
            return idValue;
        }
    }
    
    // <name>AttachPDF</name>
    // <summary></summary>
    public Messaging.EmailFileAttachment AttachPDF() {
        
        String getURL = 'ServiceEstimatePDF';     
        if(this.showRecordValue == '4-Square') {
            getURL = 'ReconAppraisalBlankPDF';
        } else {
            getURL = 'ServiceEstimatePDF';
        }
                
        PageReference pdf = new PageReference('/apex/'+getURL);
        // add parent id to the parameters for standardcontroller
        pdf.getParameters().put('id', string.valueOf(se.Id));
     
        // the contents of the attachment from the pdf
        Blob body;
        
        try {
          // returns the output of the page as a PDF
          body = pdf.getContent();
          
        } catch (VisualforceException e) {
          body = Blob.valueOf('Error Generating Attachment');
        }
     
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setContentType('application/pdf');
        attach.setFileName(se.Name+'-Estimate.pdf');
        attach.setInline(false);
        attach.Body = body;
        
        return attach;
    }
    
     public PageReference sendPdf() {
               
        // Get Customer Email address
        if(se.dealer__Customer__c != null) {
            Account a = [Select Id, dealer__Billing_Email__c from Account where Id =:se.dealer__Customer__c limit 1];
            if(a.dealer__Billing_Email__c != null) {
                email = a.dealer__Billing_Email__c;
            } else {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Customer Account has no Email Address'));
                return null;
            }
            
        } else {
            
            // Get User Email Address
            User[] u = [Select Id, Name, Email from User where Id = :se.dealer__EmailApprover__c limit 1];
            if(u.size() == 0) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Estiamte not emailed, no user account selected'));
                return null;            
            }
            
            email  = u[0].Email;
            if(se.dealer__EmailApprover__c == null || u[0].Email == null) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Estiamte not emailed, no user account selected'));
                return null;
            }           
            
        }
        
        Messaging.EmailFileAttachment attach = AttachPDF();
     
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setUseSignature(false);
        mail.setToAddresses(new String[] { email });
        mail.setSubject(this.subject);
        mail.setHtmlBody(this.body);
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 
     
        // Send the email
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email with estimate sent to '+email));
        
        // Record Activity
        Task t = new Task( Subject='Emailed 4-Square to '+email,
                           ActivityDate=Date.today(),
                           WhatId=se.Id,
                           Status='Completed');
        insert t;             
                            
        
        if(this.showRecordValue == '4-Square') {
            PageReference sq = Page.UsedRecon4Square;
            sq.getParameters().put('id', string.valueOf(se.Id));
            return sq;
        } else {
            PageReference sq = Page.ServiceEstimate;
            sq.getParameters().put('id', string.valueOf(se.Id));
            return sq;          
        }
     
      }           
}