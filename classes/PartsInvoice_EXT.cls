global with sharing class PartsInvoice_EXT {
    
    public Id userID;
    public Id jobLineId {get;set;}
    public Id roId {get;set;}
    public String userName;
    public dealer__FixedOperationsSettings__c fixedops_settings = dealer__FixedOperationsSettings__c.getValues(UserInfo.getUserId());
    public Boolean defaultTaxOn {get;set;}
    public List<dealer__Parts_Service_Pricing_Strategy__c> PriceLevels;
    public dealer__Parts_Service_Pricing_Strategy__c defaultPriceLevel = new dealer__Parts_Service_Pricing_Strategy__c();
    public List<dealer__Stock_Order__c> CurrentOrders {get;set;}
    public String inventorySearch { get; set; }
    public String serviceHistoryJSON {get;set;}
    public String selectedLocation {get;set;}                                                                              
                                           
    // public static Parts_Inventory__c Inventory { get; private set; }
    private final dealer__Parts_Invoice__c invoiceRecord;
    
    public dealer__Service_Repair_Order__c roData {get;set;}
    
    public boolean roPage {get;set;}
    public String email {get;set;}
    public String subject {get { return 'Parts Invoice from '+UserInfo.getOrganizationName(); } set;}
    public String body { get; set; }
    private Messaging.EmailFileAttachment defaultAttachment;
    

    /**
     * PartsInvoice_EXT 
     * @param  controller [description]
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT
     */
    public PartsInvoice_EXT (ApexPages.StandardController controller) {

        // Get DMS Settings
        List<dealer__DMS_Settings__c> dmsSettings = dealer__DMS_Settings__c.getall().values();
        if(dmsSettings.isEmpty()) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'DMS Configuration not defined, please contact your systems administrator.'));
        }
        
        // set Default Tax Settings based on fixed ops setting for the user.
        if(fixedops_settings!=null) { defaultTaxOn = fixedops_settings.dealer__Parts_Invoice_Tax_Exempt__c; } else { defaultTaxOn = true; }
        Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__Parts_Invoice__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet(); 
        af.add('RecordType.DeveloperName');
        af.addAll(fieldnames);
        if(!Test.isRunningTest()) {             
                controller.addFields(af);
        }

        invoiceRecord = (dealer__Parts_Invoice__c)controller.getRecord();
        
        //Check if record is created from account
        Id accId;
        if(!String.isEmpty(ApexPages.currentPage().getParameters().get('AccId'))){
            accId = ApexPages.currentPage().getParameters().get('AccId');
            invoiceRecord.Customer__c = accId;
            
            //Check if record is created from contact
        }else if(!String.isEmpty(ApexPages.currentPage().getParameters().get('cId'))){ 
			accId = ApexPages.currentPage().getParameters().get('cId');
            
            try{
                Contact relatedAccount = [Select AccountId From Contact Where Id =: accId Limit 1].get(0);
                invoiceRecord.Customer__c = relatedAccount.AccountId;

            }catch(Exception e){
                system.debug('Error: '+ e.getMessage());
            }
        }   

        if(invoiceRecord.dealer__Counterman__c==null) {
            invoiceRecord.dealer__Counterman__c=UserInfo.getUserId();
        }

        if(invoiceRecord.dealer__Location__c == null ) {
            User u = [Select Id, Division from User where Id=:UserInfo.getUserId() limit 1];
            
            List<dealer__Dealer_Location__c> listLoc = [SELECT Id FROM dealer__Dealer_Location__c WHERE dealer__Company_Number__c =: u.Division LIMIT 1];
            
            if (listLoc != null) {
                selectedLocation = invoiceRecord.dealer__Location__c = listLoc[0].Id;
            }
            else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'User has no Division. Please contact your system administrator'));
            }
        }

        // Check to see if a Price Level is Selected.  If one is not selected, select one and set.
        List<dealer__Parts_Service_Pricing_Strategy__c> defaultPriceLevelList = new List<dealer__Parts_Service_Pricing_Strategy__c>();
        if(invoiceRecord.dealer__Wholesale_Pricing_Strategy__c==null) {
        defaultPriceLevelList = [SELECT dealer__Active__c, 
                                dealer__Description_Formula__c, dealer__Description__c, 
                                dealer__Formula_Operand__c, dealer__Minimum_Parts_Gross_Proft__c, dealer__Order__c, 
                                dealer__Parts_Forumula_Base__c, dealer__Parts_Variable_Amount__c, dealer__Company_Number__c,
                                dealer__Method__c, dealer__Default__c, Id 
                                FROM dealer__Parts_Service_Pricing_Strategy__c
                                WHERE dealer__Default__c = true
                                limit 1];
        } else {
        defaultPriceLevelList = [SELECT dealer__Active__c, 
                                dealer__Description_Formula__c, dealer__Description__c, 
                                dealer__Formula_Operand__c, dealer__Minimum_Parts_Gross_Proft__c, dealer__Order__c, 
                                dealer__Parts_Forumula_Base__c, dealer__Parts_Variable_Amount__c, dealer__Company_Number__c,
                                dealer__Method__c, dealer__Default__c, Id 
                                FROM dealer__Parts_Service_Pricing_Strategy__c
                                WHERE Id=:invoiceRecord.dealer__Wholesale_Pricing_Strategy__c
                                limit 1];            
        }
        if(defaultPriceLevelList.size()==1) {
            defaultPriceLevel=defaultPriceLevelList[0];
        }

        if(invoiceRecord.Id == null) {
            // Default taxable based on user setting
            invoiceRecord.dealer__Tax_Exempt__c = defaultTaxOn;
        }

        if(ApexPages.currentPage().getParameters().get('id')!=null && ApexPages.currentPage().getParameters().get('id')!='') {
            // invoiceRecord = (dealer__Parts_Invoice__c)controller.getRecord();
        }
        
        // Service Repair Order Sales
        if(ApexPages.currentPage().getParameters().get('jid')!=null && ApexPages.currentPage().getParameters().get('jid')!='') {
            jobLineId=ApexPages.currentPage().getParameters().get('jid');
        }
        // Service Repair Order Sales
        if(ApexPages.currentPage().getParameters().get('rid')!=null && ApexPages.currentPage().getParameters().get('rid')!='') {
            roId=ApexPages.currentPage().getParameters().get('rid');
            roData = ROPartsSalesPrep(roId);
            serviceHistoryJSON = ServiceHistory.serviceHistoryJSON(roData.dealer__Vehicle__c);
        }
                    
    }
    
    /**
     * getdefaultPriceLevel 
     * @return dealer__Parts_Service_Pricing_Stratgey
     */
    public dealer__Parts_Service_Pricing_Strategy__c getdefaultPriceLevel() {
        return defaultPriceLevel;
    }
    
    /**
     * lookupCurrentOrders
     * @return  void
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT
     */
    public void lookupCurrentOrders() {
        CurrentOrders = [Select Id, dealer__Manufacturer__c, dealer__Date_Ordered__c from dealer__Stock_Order__c where dealer__Date_Ordered__c = TODAY limit 1000];
    }
    
    /**
     * PartsOrderLine - Generates a parts oder line
     * @param partId          [description]
     * @param invoiceId       [description]
     * @param invoiceLineId   [description]
     * @param quantityOrdered [description]
     * @param requestedBy     [description]
     * @param orderType       [description]
     * @param mfg             [description]
     */
    public static void PartsOrderLine(String partId, String invoiceId, String invoiceLineId, Decimal quantityOrdered, String requestedBy, String orderType, String mfg) {
        
        ID orderNumber;
        dealer__Parts_Inventory__c  inventoryRecord = [Select Id, dealer__Cost__c from dealer__Parts_Inventory__c where Id =:partId limit 1];
        Decimal orderValue  =   quantityOrdered * inventoryRecord.dealer__Cost__c;
        
        List<dealer__Stock_Order__c> so = [Select Id, dealer__Manufacturer__c
                                                    from dealer__Stock_Order__c
                                                    where dealer__Date_Ordered__c = TODAY 
                                                    and dealer__Manufacturer__c = :mfg
                                                    and dealer__Order_Type__c =:orderType
                                                    and dealer__Status__c != 'Posted'
                                                    limit 1];
                                                    
        if(so.size()==0) {
            Date todaysDate = Date.today();
            dealer__Stock_Order__c dSo = new dealer__Stock_Order__c(Name=mfg+String.valueOf(todaysDate.month())+String.valueOf(todaysDate.day()),
                                                                    dealer__Manufacturer__c=String.valueOf(mfg),
                                                                    dealer__Date_Ordered__c=Date.today(),
                                                                    dealer__Status__c='Incomplete',
                                                                    dealer__Order_Type__c=orderType
                                                                    );
            insert dSo; 
            orderNumber=dSo.Id;                                                 
        } else {
            orderNumber=so[0].Id;
        }           
        
        // Set the lines 
        dealer__Parts_Order__c orderLine = new dealer__Parts_Order__c(dealer__Order__c=orderNumber,
                                                                      dealer__Order_Date__c=Date.today(),
                                                                      dealer__Parts_Inventory__c=partId,
                                                                      dealer__Parts_Invoice__c=invoiceId,
                                                                      dealer__Quantity_Ordered__c=quantityOrdered,
                                                                      dealer__Requested_By__c=requestedBy,
                                                                      dealer__Parts_Line__c=invoiceLineId,
                                                                      dealer__Value__c=orderValue   
                                                                     );
        System.debug(orderLine);                                                             
        insert orderLine;
        
        /*
        if(orderLine.Id=='') {
            return false;
        } else {
            return true;
        }
        */                          
        
    }    
    
    /**
     * ROPartsSalesPrep 
     * @param  roNumber [description]
     * @return dealer__Service_Repair_Order__c [object relating the service repair order to the parts invoice]
     */
    public dealer__Service_Repair_Order__c ROPartsSalesPrep(ID roNumber) {
        return [Select d.dealer__Vehicle__c, d.dealer__Status__c, d.dealer__Service_Advisor__c, d.dealer__Posted_Date_Time__c, d.dealer__Parts_Invoice__c, 
                        d.dealer__Customer_Contact__r.Name, dealer__Customer__r.Name,
                        d.dealer__Invoiced_Date_Time__c, d.dealer__Customer_Contact__c, d.Company__c, d.dealer__Create_Date_Time__c, d.dealer__Company_Number__c, d.dealer__RO_Number__c,
                        d.dealer__Comments__c, d.Name, d.Id, (Select Id, Name, dealer__CustomerConcern__c, dealer__Labor_Type__c, dealer__Line_Number__c, dealer__Op_Code__c, 
                        dealer__Standard_Operation_Code__c, dealer__Stat__c From dealer__Job_Lines__r) 
                        From dealer__Service_Repair_Order__c d
                        where d.Id =:roNumber limit 1];
    }
    
    /**
     * CounterManName
     * @return String 
     * @notets defaults the countermans name to the person who is logged in
     */
    public String CounterManName {
        get {
            return UserInfo.getName();
        }
    }
    
    /**
     * Counterman 
     * @return  Id 
     * @notes   The ID of the user who is currently accessing the page
     */
    public Id CounterMan { 
        get {
            return UserInfo.getUserId();
        }
    }
    

    /**
     * clines
     * @return  List<dealer__Cashering__c> 
     * @notes   returns a list of the cashiering lines associated with this invoice
     */
    public List<dealer__Cashering__c> clines { 
            get {
                return [Select d.dealer__Payment_Method__c, d.dealer__Parts_Invoice__c, d.dealer__Customer__c, 
                            d.dealer__Credit_Card_Authorization_Code__c, d.dealer__Close_Date__c, d.dealer__Amount__c, d.SystemModstamp, 
                            d.OwnerId, d.Name, d.LastModifiedDate, d.LastModifiedById, d.IsDeleted, d.Id, d.CreatedDate, d.CreatedById,
                            d.Deposit__c , d.Print_Receipt__c 
                            From dealer__Cashering__c d 
                            where d.dealer__Parts_Invoice__c = :invoiceRecord.Id
                            and d.dealer__Service_Repair_Order__c = null
                            and d.dealer__Deposit__c=true
                            and d.dealer__Amount__c != null limit 200];
            } private set;
   }
   
    
   /**
    * getPriceLevels
    * @return   List<dealer__Parts_Service_Pricing_Strategy__c>
    * @notes    returns a list of the available price levels
    * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT
    */
    public List<dealer__Parts_Service_Pricing_Strategy__c> getPriceLevels() {
            return [Select dealer__Description__c, Name, Id, dealer__Default__c, dealer__Order__c From dealer__Parts_Service_Pricing_Strategy__c ORDER BY dealer__Default__c DESC, dealer__Order__c ASC Limit 100];
    }


    @remoteAction 
    global static List<dealer__Parts_Inventory__c> searchInventory(String searchString) {
        List<List<sObject>> soslResults = [FIND :searchstring IN ALL FIELDS RETURNING dealer__Parts_Inventory__c (Id, Name, dealer__Part_No__c ) LIMIT 50];
        List<dealer__Parts_Inventory__c> cResults = (List<dealer__Parts_Inventory__c>)soslResults[0];  

        System.debug(cResults);

        return cResults;      
    }
   
    
    /**
     * getInventory
     * @param  inventorySearch [String of the inventory record to search, this is a part#]
     * @return dealer__Parts_Inventory__c 
     * @notes  matched invnentory record
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT
     */
    @RemoteAction
    global static dealer__Parts_Inventory__c getInventory(String inventorySearch) {
    
        Integer slength = inventorySearch.length();
        // inventorySearch = '%'+String.escapeSingleQuotes(inventorySearch)+'%';
        
        if(slength>=3) {   
        List<Parts_Inventory__c> Inventory = [SELECT Id, Name, Bin__c, Source__c, Part_No__c, 
                                                        Comments__c, List__c, Cost__c, Description__c, 
                                                        Pack_QTY__c, On_Hand__c, On_Order__c, Core__c, 
                                                        MFG__c, Kit__c, Parts_Master__c, Jobber__c
                                         FROM Parts_Inventory__c
                                         WHERE Part_No__c = :inventorySearch
                                         LIMIT 1];
        if(Inventory.size()>0) { return Inventory[0]; } else { return null; }
        } else {
           return null;
        }
    }

    /**
     * matchedInventory
     * @param  partno : 
     * @return List<dealer__Parts_Invoice_Line__c> : returns a list of matched inventory
     * @notes 3/28/2016 | J.Kuljis | create a specific inventory part if one does not exist
     * 
     */
    @RemoteAction 
    global static List<dealer__Parts_Inventory__c> matchedInventory(String partno) {
        // Get store level inventory
        dealer__Parts_Inventory__c pi = [Select Id, dealer__Parts_Master__c from dealer__Parts_Inventory__c where dealer__Part_No__c=:partno limit 1];
        List<dealer__Parts_Inventory__c> pl = [Select Id, Name, dealer__Location__r.Name, dealer__On_Hand__c 
                                                    from dealer__Parts_Inventory__c 
                                                    where dealer__Parts_Master__c =:pi.dealer__Parts_Master__c
                                                    limit 500];
        return pl;
    }
    
    /**
     *
     *  getMaster: return parts master data   
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT
     */
    @RemoteAction
    global static dealer__Parts_Master__c getMaster(String inventorySearch) {
    
        Integer slength = inventorySearch.length();
        // inventorySearch = '%'+String.escapeSingleQuotes(inventorySearch)+'%';
        
        if(slength>=3) {   
        List<dealer__Parts_Master__c> Inventory = [SELECT Id, Name, dealer__Part_Description__c, dealer__Part_No_Display__c, dealer__Part_No__c, dealer__Retail_Price__c
                                         FROM dealer__Parts_Master__c
                                         WHERE name = :inventorySearch
                                         LIMIT 10];
        if(Inventory.size()>0) {
             return Inventory[0];
        } else {
            return null;
        }
        } else {
           return null;
        }
    }   
    
    /**
     *
     *   getKitItems: return parts kit items for addition to invoices
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT
     */
    @RemoteAction
    global static List<dealer__Parts_Kit_Item__c> getPartsKitItems(String kitId) {
        return [Select Id, dealer__Part__c, dealer__Quantity__c, dealer__Part_Name__c from dealer__Parts_Kit_Item__c where dealer__Parts_Kit__c = :kitId limit 1000];
    }
    
    /**
     *
     *  loadPartsLines - Invoice
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT
     */
    @RemoteAction
    global static List<dealer__Parts_Invoice_Line__c> loadPartsInvoiceLines(String masterRecordId){
        return [Select Id, Name, dealer__Core__c, dealer__Cost__c, dealer__List__c, dealer__Part_Description__c, dealer__Bin__c, dealer__Currently_Available__c,
                                                    dealer__Part_Number__c, dealer__Part__c, dealer__Quantity_Sold__c, dealer__Extended_Price__c, dealer__Price__c,
                                                    dealer__Source__c, dealer__Sold_Via__c, dealer__Price_Level__c, dealer__Drop_Ship__c, dealer__Transaction_Code__c,
                                                    dealer__Job_Line__c, dealer__Service_Job_Line_Number__c, dealer__Service_Repair_Order__c,  
                                                        (Select Title from Notes where IsPrivate = false)
                                                    From dealer__Parts_Invoice_Line__c 
                                                    where dealer__Parts_Invoice__c = :masterRecordId
                                                    order by  dealer__Service_Job_Line_Number__c asc
                                                    limit 100];                                                   
    }
    
    /**
     *
     *  loadPartsLines - Quote
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT
     */
    @RemoteAction
    global static List<dealer__Parts_Quote_Line__c> loadPartsQuoteLines(String masterRecordId){
        return [Select Id, Name, dealer__Core__c, dealer__Cost__c, dealer__List__c, dealer__Part_Description__c, dealer__Bin__c, dealer__On_Hand__c,
                                                    dealer__Part_Number__c, dealer__Parts_Inventory__c, dealer__Parts_Quote__c, dealer__Quantity__c
                                                    From dealer__Parts_Quote_Line__c where dealer__Parts_Quote__c = :masterRecordId limit 100];                                                   
    }
    
    /**
     *
     *   invoicePricing - get Totals of this Invoice based on Parts Invoice ID, used when adding parts to ticket, w/o page refresh
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT
     */ 
    @RemoteAction
    global static dealer__Parts_Invoice__c invoicePricing(String RecordId) {
        return [Select Id, dealer__Parts_Price__c, dealer__Total_Tax__c, dealer__Total_Invoice__c from dealer__Parts_Invoice__c Where Id = : RecordId limit 1];
    }
    
    /**
     *
     *   invoiceLine - get Line specific information via remoting
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT
     */
    @RemoteAction 
    global static dealer__Parts_Invoice_Line__c invoiceLine(String LineId) {
        return [Select Id, dealer__Bin__c, dealer__Core__c, dealer__Cost__c, dealer__Counterman__c, dealer__Part_Number__c,
                        dealer__Part_Description__c, dealer__Part__c, dealer__Price__c, dealer__Quantity_Ordered__c, 
                        dealer__Quantity_Sold__c, dealer__Drop_Ship__c, dealer__Sold_Via__c, dealer__Part__r.Name, dealer__Part__r.dealer__Cost__c, 
                        dealer__Part__r.dealer__List__c, dealer__Currently_Available__c, dealer__Transaction_Code__c, dealer__Job_Line__c, 
                        dealer__Service_Job_Line_Number__c, dealer__Service_Repair_Order__c
                        From dealer__Parts_Invoice_Line__c
                        Where Id =: LineId limit 1];
    }
    
    /**
     *
     *   invoiceAddPartLine - XML Payload passed to add invoice line to this existing invoice
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT
     */
    @RemoteAction
    global static dealer__Parts_Invoice_Line__c InvoiceAddPartLine(String xmlString) {
        
        Dom.Document doc    =   new Dom.Document();
        doc.load(xmlString);
    
        Dom.XMLNode invoice =   doc.getRootElement();
        String invoiceId    =   invoice.getChildElement('InvoiceId', null).getText();
        String partId       =   invoice.getChildElement('Id', null).getText();
        
        if(invoiceId == null || partId == null) {
        }
        
        // Check partno on invoice for dupe prevention      
        dealer__Parts_Invoice_Line__c[] invoiceLines = [Select Id, Name, dealer__Part__c From dealer__Parts_Invoice_Line__c Where dealer__Parts_Invoice__c = :invoiceId limit 1000];
        Integer lineCount = 0;
        for(dealer__Parts_Invoice_Line__c pl : invoiceLines) {
            if(pl.dealer__Part__c == partId) {
            }
            lineCount++;
        }
        
        // Add partno to invoice
        dealer__Parts_Invoice_Line__c pi = new dealer__Parts_Invoice_Line__c();   
        
             pi.Name = invoice.getChildElement('InvoiceName', null).getText()+'-'+lineCount;
             pi.dealer__Part__c    = invoice.getChildElement('Id', null).getText();
             pi.dealer__List__c    = decimal.valueOf(invoice.getChildElement('dealer__List__c', null).getText());
             pi.dealer__Price__c   = decimal.valueOf(invoice.getChildElement('dealer__Price__c', null).getText());
             pi.dealer__Core__c    = decimal.valueOf(invoice.getChildElement('dealer__Core__c', null).getText());
             pi.dealer__Cost__c    = decimal.valueOf(invoice.getChildElement('dealer__Cost__c', null).getText());
             pi.dealer__Bin__c     = invoice.getChildElement('dealer__Bin__c', null).getText();
             pi.dealer__Counterman__c  = UserInfo.getUserId();
             pi.dealer__Sale_Date__c   = Date.today();
             pi.dealer__Part_Number__c = invoice.getChildElement('dealer__Part_No__c', null).getText();
             pi.dealer__Part_Description__c = invoice.getChildElement('dealer__Description__c', null).getText();
             pi.dealer__Quantity_Sold__c = decimal.valueOf(invoice.getChildElement('dealer__Quantity_Sold__c',null).getText());
             pi.dealer__Quantity_Ordered__c = decimal.valueOf(invoice.getChildElement('sold_Order',null).getText());
             pi.dealer__MFG__c = invoice.getChildElement('dealer__MFG__c',null).getText();
             pi.dealer__Source__c = invoice.getChildElement('dealer__Source__c',null).getText();
             pi.dealer__Sold_Via__c = invoice.getChildElement('dealer__Sold_Via__c',null).getText();

             Boolean dsEnabled = false; 
             if(invoice.getChildElement('dealer__Drop_Ship__c',null).getText()=='true') {
                dsEnabled=true;
             }
             pi.dealer__Drop_Ship__c =dsEnabled; 
             pi.dealer__Parts_Invoice__c = invoiceId;
             
             // Service Items
             if(invoice.getChildElement('dealer__Job_Line__c',null).getText()!='') {
                pi.dealer__Job_Line__c=invoice.getChildElement('dealer__Job_Line__c',null).getText();
             }
             if(invoice.getChildElement('dealer__Service_Repair_Order__c',null).getText()!='') {
                pi.dealer__Service_Repair_Order__c=invoice.getChildElement('dealer__Service_Repair_Order__c',null).getText();
             }
            
        Parts_Invoice_Line__c piline = new Parts_Invoice_Line__c();
        try{
            piline = PartInvoiceAPI.addInvoiceLine(pi.dealer__Parts_Invoice__c, pi.dealer__Job_Line__c, pi.dealer__Part__c, pi.dealer__Quantity_Sold__c, pi.dealer__Price__c, ''); 
        } Catch(Exception e) {
            throw new PartsInvoiceException(e.getMessage());
        }
                                
        return [Select Id, dealer__List__c, dealer__Price__c, dealer__Core__c, dealer__Cost__c, dealer__Bin__c, dealer__Counterman__c, dealer__Part__r.dealer__On_Hand__c,
                dealer__Part_Number__c, dealer__Part_Description__c, dealer__Quantity_Sold__c, dealer__Net_Price__c, dealer__Extended_Price__c, dealer__Gross_Margin__c,
                dealer__Source__c, dealer__MFG__c, dealer__Currently_Available__c, dealer__Sold_Via__c, dealer__Order_Type__c, dealer__Drop_Ship__c,
                dealer__Transaction_Code__c, dealer__Job_Line__c, dealer__Service_Job_Line_Number__c, dealer__Service_Repair_Order__c
                From dealer__Parts_Invoice_Line__c 
                Where Id = :piline.Id limit 1];
        
        
    }
    
    /**
     * Creates parts quote from provided string
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT
     */
    @RemoteAction 
    global static PageReference CreatePartsQuote(String xmlString) {
        xmlString = xmlString.replace('&', '&amp;');
        Dom.Document doc = new Dom.Document();
        doc.load(xmlString);
    
        Dom.XMLNode quote = doc.getRootElement();
        String location     =   quote.getChildElement('location', null).getText();
        Dealer_Location__c loc = new Dealer_Location__c();
        if(location != null)
            loc = [Select Id, Name, dealer__Company_Number__c 
                                    From dealer__Dealer_Location__c 
                                    where Name=:location or Id=:location limit 1];
        // PQ Next Available #
        dealer__DMS_Settings__c pset = [Select Id, dealer__Parts_Current_Quote_Number__c From dealer__DMS_Settings__c where Name = 'ActiveSettings' limit 1];
        pset.dealer__Parts_Current_Quote_Number__c += 1;
        String invoiceName = String.valueOf(pset.dealer__Parts_Current_Quote_Number__c);
        // Check Multi-Company mode to see if we are to prefix the RO# with Company Location
        dealer__FixedOperationsSettings__c fixedOpsSettings = dealer__FixedOperationsSettings__c.getOrgDefaults();
        if(fixedOpsSettings.dealer__Multi_Company_Mode__c==true) {
            User u = [Select Id, Division from User where Id=:UserInfo.getUserId() limit 1];
            if(u.Division!=null) {
                invoiceName=u.Division+'-'+invoiceName;
            }
        }        
        
        // Setup Account Id String
        String customerId = quote.getChildElement('customer', null).getText(); // AccountID

        // Setup Parts Quote
        dealer__Parts_Quote__c pq = new dealer__Parts_Quote__c(                                                                           
                Name='PQ#'+invoiceName,                                                                         
                dealer__Counterman__c=UserInfo.getUserId(),
                dealer__Customer__c = customerId,
                dealer__Price_Level__c=quote.getChildElement('pricelevel', null).getText(),
                dealer__Status__c='Open'
              );
        if(loc != null)
            pq.Location__c = loc.Id;

        // Tax Exemption
        Contact[] c = [Select Id, Account.dealer__Tax_Id__c from Contact where AccountId = :customerId limit 1];

        // Was a contact returned? If so set the customer field
        if(c.size() > 0) {
            pq.dealer__Customer_Contact__c = c[0].Id;
        }

        // check tax exemption status
        if(quote.getChildElement('taxexempt', null).getText()=='true') {
            pq.dealer__Tax_Exempt__c = true;
        }
        
        Database.SaveResult insResult = Database.Insert(pq, false);
        String pqInsResultId = string.valueOf(insResult.getId());
        
        System.debug(pqInsResultId);    
        if(!insResult.isSuccess()) {
              Database.Error err = insResult.getErrors()[0];
              System.debug(err);

            for(Database.Error error : insResult.getErrors()) {
                System.debug('The following error has occurred.');                   
                System.debug(error.getStatusCode() + ': ' + error.getMessage());
                System.debug('Account fields that affected this error: ' + error.getFields());
            }
        }

        try {

            update pset;
            
        } catch (DmlException e) {
         // TODO - Write exception code for insert
 
        }
        
        List<dealer__Parts_Quote_Line__c> quoteLineList = new List<dealer__Parts_Quote_Line__c>();  
        
        Integer i = 1;
        for(Dom.XMLNode lines : quote.getChildElements()) {
            if(lines.getName() == 'lines') {
                
            System.debug(lines.getChildElement('Id', null).getText());
            System.debug(lines.getChildElement('dealer__Description__c', null).getText());         
            Decimal linePrice = decimal.valueOf(lines.getChildElement('dealer__Net__c', null).getText());
            
            dealer__Parts_Quote_Line__c ql = new dealer__Parts_Quote_Line__c();   
             ql.Name = pset.dealer__Parts_Current_Quote_Number__c+'-'+i;
             ql.dealer__Parts_Inventory__c = lines.getChildElement('Id', null).getText();
             ql.dealer__List__c = decimal.valueOf(lines.getChildElement('dealer__List__c', null).getText());
             ql.dealer__Core__c = decimal.valueOf(lines.getChildElement('dealer__Core__c', null).getText());
             ql.dealer__Cost__c = decimal.valueOf(lines.getChildElement('dealer__Cost__c', null).getText());
             ql.dealer__Part_Number__c = lines.getChildElement('dealer__Part_No__c', null).getText();
             ql.dealer__Part_Description__c = lines.getChildElement('dealer__Description__c', null).getText();
             ql.dealer__Quantity__c = decimal.valueOf(lines.getChildElement('dealer__Quantity_Sold__c', null).getText());
             ql.dealer__Price__c = linePrice;
             ql.dealer__Parts_Quote__c = pqInsResultId;

             quoteLineList.add(ql);
                         
             i++;
            }
        }
        // Insert Lines
        insert quoteLineList;
                
        // Create PQ Page reference
        PageReference quotePage = new ApexPages.StandardController(pq).view();
        quotePage.setRedirect(true);
         
        return quotePage;
                
    }
    /**
     * updates parts invoice line with new data
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT
     */
    @RemoteAction
    global static dealer__Parts_Invoice_Line__c updateLineQty(String linedata) {
        // For ease of use data will appear as {part line ID(Id)}-{qty(Int)}
        String[] dat = linedata.split('-');
        dealer__Parts_Invoice_Line__c line = [Select Id, dealer__Quantity_Sold__c, dealer__Price__c, dealer__Currently_Available__c, dealer__Part__c, dealer__Parts_Invoice__c
                                                 from dealer__Parts_Invoice_Line__c 
                                                 where Id = :dat[0] limit 1];
        
        // Adjust QTY Based on what was sold prior
        if(dat[3]=='Quantity Change') {
            // Update Parts Line
            // Argument 2 contains the quantity sold in addition to the current qty
            Integer change_qty = Integer.valueOf(dat[1]);
           
            try {
                line = PartInvoiceAPI.updateInvoiceLine(line.Id, change_qty, line.dealer__Price__c, '');
            } Catch(Exception e) {
                throw new PartsInvoiceException(e.getMessage()+'. Stack: '+e.getStackTraceString());
            }
        }
        
        if(dat[3] == 'Order') {
            line.dealer__Quantity_Ordered__c = decimal.valueOf(dat[2]);
        } else {
            line.dealer__Quantity_Ordered__c = 0; 
        }
        line.dealer__Sold_Via__c = dat[3];
        
        // Check drop ship
        if(dat[4]=='true') {
            line.dealer__Drop_Ship__c = true;
        } else {
            line.dealer__Drop_Ship__c = false;
        }
        update line;
        
        line = [Select Id, dealer__Quantity_Sold__c, dealer__Currently_Available__c, dealer__Part__c, dealer__Parts_Invoice__c, dealer__Extended_Price__c
                                                 from dealer__Parts_Invoice_Line__c 
                                                 where Id = :dat[0] limit 1];
        return line;
    }
    
    /**
     * updates parts invoice line with new price
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT
     */
    @RemoteAction
    global static boolean setLinePrice(String linedata) {
        // Linedata will contain line ID and price seperated by -
        String[] dat = linedata.split('-');
        dealer__Parts_Invoice_Line__c line = [Select Id from dealer__Parts_Invoice_Line__c where Id = :dat[0] limit 1];
        
        line.dealer__Price__c = decimal.valueOf(dat[1]);
        update line;
        
        return true;
    }
    
    @remoteAction
    global static dealer__Parts_Service_Pricing_Strategy__c setPL(String plID) {
        return [SELECT Id, Name, Method__c, Parts_Variable_Amount__c, Formula_Operand__c FROM Parts_Service_Pricing_Strategy__c  WHERE Id = :plId limit 1];
    }
    
    @remoteAction 
    global static boolean setPLonInvoice(String ipl) {
        String[] dat = ipl.split('-');
        List<dealer__Parts_Invoice_Line__c> updateList = new List<dealer__Parts_Invoice_Line__c>();
        dealer__Parts_Service_Pricing_Strategy__c pl = [Select d.Name, d.dealer__Parts_Variable_Amount__c, d.dealer__Parts_Forumula_Base__c, d.dealer__Method__c, 
                                                                d.dealer__Formula_Operand__c, d.dealer__Description_Formula__c, d.dealer__Active__c 
                                                                From dealer__Parts_Service_Pricing_Strategy__c d
                                                                where d.Id = :dat[1]];
        
        dealer__Parts_Invoice__c inv = [Select Id from dealer__Parts_Invoice__c where Id = :dat[0] limit 1];
        inv.dealer__Wholesale_Pricing_Strategy__c = pl.Id;
        update inv;                                                     
                                                            
        for(dealer__Parts_Invoice_Line__c line : [Select d.dealer__Quantity_Sold__c, d.dealer__Price__c, d.dealer__Price_Level__c, d.dealer__Price_Level_Strategy__c, 
                                                            d.dealer__Net__c, d.dealer__List__c, d.dealer__Extended_Price__c, d.dealer__Cost__c, 
                                                            d.Id From dealer__Parts_Invoice_Line__c d
                                                            where d.dealer__Parts_Invoice__c = :dat[0]]) 
        {
            
            if(pl.dealer__Method__c == 'List') {
                line.dealer__Price__c = line.dealer__List__c * ((100 + pl.dealer__Parts_Variable_Amount__c) / 100);
            }
            
            if(pl.dealer__Method__c == 'Cost') {
                line.dealer__Price__c = line.dealer__Cost__c * ((100 + pl.dealer__Parts_Variable_Amount__c) / 100);
            }
            
            line.dealer__Net__c = line.dealer__Price__c;
            line.dealer__Price_Level_Strategy__c = pl.Id;
            line.dealer__Price_Level__c=pl.Name;
            
            updateList.add(line);
            
        }           
        System.debug(updateList);
        if(updateList.size() > 0) {
            update updateList;
            return true;
        } else {                                    
            return false;
        }
    }
    
    
    /**
     * Create Parts Invoice from Quote Screen
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT
     */
    @RemoteAction 
    global static PageReference CreateInvoice(String xmlString) {
        
        xmlString = xmlString.replace('&', '&amp;');
        Dom.Document doc = new Dom.Document();
        doc.load(xmlString);
        System.debug(xmlString);
        Dom.XMLNode invoice = doc.getRootElement();
       
        String customerId   =   invoice.getChildElement('customer', null).getText();
        String contactId    =   invoice.getChildElement('contact', null).getText();
        String location     =   invoice.getChildElement('location', null).getText();

        // Get record type ID
        RecordType rt = [Select Id from RecordType where DeveloperName = 'Retail_Sale' limit 1];
        // If B2C Record, get the customer contact ID
        if((contactId==null || contactId=='') && customerId!=null && customerId!='') {
            List<Contact> matchedContacts = [Select Id from Contact where AccountId=:customerId limit 1];
            if(!matchedContacts.isEmpty()) {
                contactId=matchedContacts[0].Id;
            }
        }
		dealer__Dealer_Location__c loc;
        try{
            // Get Location Company Number
            loc = [Select Id, Name, dealer__Company_Number__c 
                                                From dealer__Dealer_Location__c 
                                                where Name=:location or Id=:location limit 1];
            
            List<dealer__Dealer_Location_User__c> availableLocations = [SELECT Id FROM dealer__Dealer_Location_User__c 
                                                                        where dealer__User__c =: UserInfo.getUserId()
                                                                        and dealer__Dealer_Location__c =: loc.Id LIMIT 1];
            
            if(availableLocations == null || availableLocations.isEmpty()) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Selected location is not valid for the current user. Please select a valid location.'));
            	return null;
            }
                
        } catch(Exception e) {
            throw new PartsInvoiceException(e.getMessage());
        }
        // Build Invoice Object        
        dealer__Parts_Invoice__c pi = new dealer__Parts_Invoice__c(           
                dealer__Customer__c = customerId,           
                dealer__Location__c = loc.Id,             
                dealer__Counterman__c=invoice.getChildElement('counterman', null).getText(),
                dealer__Comments__c=EncodingUtil.UrlDecode(invoice.getChildElement('comments', null).getText(), 'UTF-8'),
                dealer__Wholesale_Pricing_Strategy__c=String.valueOf(invoice.getChildElement('pricelevel',null).getText()),
                dealer__Tax_Exempt__c=false,
                dealer__Status__c='Open',
                dealer__Company_Number__c=loc.dealer__Company_Number__c,
                RecordTypeId=rt.Id
            );
        if(contactId!=null&&contactId!='') {
            pi.dealer__Customer_Contact__c=contactId;
        }

        if(pi.dealer__Customer__c!=null) {
            Account a = [Select Id, dealer__Tax_Id__c from Account where Id=:pi.dealer__Customer__c limit 1];
            if(a.dealer__Tax_Id__c!=null) {
                pi.dealer__Tax_Exempt__c = true;
            }
        }

        if(invoice.getChildElement('taxexempt', null).getText()=='true' ) {
            pi.dealer__Tax_Exempt__c = true;
        }                                   
                                                    
        // Database.SaveResult insResult = Database.Insert(pi, false);
        
        if(pi==null) {
             new PartsInvoiceException('Unable to create invoice, parent ID missing ');
        } else {
            pi = PartInvoiceAPI.createInvoice(pi);

        }

        pi = [SELECT Id, Name, Invoice_Number__c FROM Parts_Invoice__c WHERE Id =: pi.Id];
        dealer__DMS_Settings__c pset = [Select Id, dealer__Parts_Current_Invoice_Number__c 
                                                                From dealer__DMS_Settings__c 
                                                                where Name = 'ActiveSettings' limit 1];
        // Build Invoice Lines
        Integer i = 1;
        for(Dom.XMLNode lines : invoice.getChildElements()) {
            if(lines.getName() == 'lines') {
                
                System.debug(lines.getChildElement('Id', null).getText());
                System.debug(lines.getChildElement('dealer__Description__c', null).getText());
                
                    dealer__Parts_Invoice_Line__c ql = new dealer__Parts_Invoice_Line__c();             
                     ql.Name = pi.Name + '-'+i;
                     ql.dealer__Part__c = lines.getChildElement('Id', null).getText();
                     ql.dealer__List__c = decimal.valueOf(lines.getChildElement('dealer__List__c', null).getText());
                     ql.dealer__Price__c= decimal.valueOf(lines.getChildElement('dealer__Net__c', null).getText());
                     ql.dealer__Core__c = decimal.valueOf(lines.getChildElement('dealer__Core__c', null).getText());
                     ql.dealer__Cost__c = decimal.valueOf(lines.getChildElement('dealer__Cost__c', null).getText());
                     ql.dealer__Bin__c  = lines.getChildElement('dealer__Bin__c', null).getText();
                     ql.dealer__Counterman__c = UserInfo.getUserId();
                     ql.dealer__Part_Number__c = lines.getChildElement('dealer__Part_No__c', null).getText();
                     ql.dealer__Part_Description__c = lines.getChildElement('dealer__Description__c', null).getText();
                     ql.dealer__Quantity_Sold__c = decimal.valueOf(lines.getChildElement('dealer__Quantity_Sold__c', null).getText());
                     ql.dealer__Quantity_Ordered__c=decimal.valueOf(lines.getChildElement('sold_Order', null).getText());
                     ql.dealer__Sale_Date__c=Date.today();
                     ql.dealer__Source__c=String.valueOf(lines.getChildElement('dealer__Source__c', null).getText());
                     ql.dealer__MFG__c=String.valueOf(lines.getChildElement('dealer__MFG__c', null).getText());
                     ql.dealer__Sold_Via__c=String.valueOf(lines.getChildElement('dealer__Sold_Via__c', null).getText());
                     ql.dealer__Order_Type__c=String.valueOf(lines.getChildElement('OrderType',null).getText());
                     ql.dealer__Parts_Invoice__c = pi.Id;
                     
                     // Get Drop Ship Data
                     if(lines.getChildElement('dealer__Drop_Ship__c', null).getText()=='true') {
                        ql.dealer__Drop_Ship__c=true;
                     }
                     
                     // Get PL Related ID
                     if(lines.getChildElement('dealer__PL',null).getText()!='') {
                        ql.dealer__Price_Level_Strategy__c=String.valueOf(lines.getChildElement('dealer__PL',null).getText());
                     } 
        
                     // invoiceLineList.add(ql);
                     List<Parts_Invoice_Line__c> linestoInsert = new List<Parts_Invoice_Line__c>();
                     linestoInsert.add(ql);
                     linestoInsert = PartInvoiceAPI.addInvoiceLines(linestoInsert);
                     ql = linestoInsert[0];
                     
                     //check for lines to be ordered
                     /* To Be - Moved to Trigger */
                     Decimal soQ    = decimal.valueOf(lines.getChildElement('sold_Order', null).getText());
                     Decimal lPrice = decimal.valueOf(lines.getChildElement('dealer__Net__c', null).getText());
                     if(soQ>0 && lPrice>0) {
                                        // PartsOrderLine( String.valueOf(ql.dealer__Part__c), 
                                        //     String.valueOf(ql.dealer__Parts_Invoice__c),
                                        //     String.valueOf(ql.Id),
                                        //     soQ,
                                        //     String.valueOf(UserInfo.getUserId()),
                                        //     'Special Order',
                                        //     String.valueOf(lines.getChildElement('dealer__MFG__c', null).getText())
                                        //  );
                                                                             
                    }         
                i++;
            }
        } 
                
        PageReference partsInvoicePage = new ApexPages.StandardController(pi).view();
        partsInvoicePage.setRedirect(true);
         
        return partsInvoicePage;
    }  
    
    @RemoteAction 
    global static Boolean DeleteInvoiceLine(String partId) {

        dealer__Parts_Invoice_Line__c partline = [Select Id, dealer__Quantity_Sold__c, dealer__Part__c, dealer__Parts_Invoice__c from dealer__Parts_Invoice_Line__c where Id = :partId limit 1];

        List<dealer__Parts_Order__c> orderLine = [Select Id from dealer__Parts_Order__c where dealer__Parts_Line__c = :partId and dealer__Order_Status__c = 'Incomplete' limit 1];

        if(orderLine.size()>0) {            
            try { 
                delete orderLine;
            } catch(DmlException e) {
                throw new PartsInvoiceException(e.getMessage());
            }
        }
        
        try {
            PartInvoiceAPI.removeInvoiceLine(partline.Id);
        } Catch(Exception e) {
            throw new PartsInvoiceException(e.getMessage());
        }

        return true;
    }   
    
    /**
     * Updates customer shipping address from json string
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT
     */
    @RemoteAction
    global static Boolean updateShipToAddress(String jsonAddress) {
        Map<String, Object> addr = (Map<String, Object>)JSON.deserializeUntyped(jsonAddress);
        String invoiceId = String.valueOf(addr.get('Id'));
        if(invoiceId == null) {
            return false;
        }
        dealer__Parts_Invoice__c pi = [Select Id from dealer__Parts_Invoice__c where Id = :invoiceId limit 1];
        pi.dealer__Customer_ShipTo_Street__c = String.valueOf(addr.get('Street'));
        pi.dealer__Customer_ShipTo_City__c = String.valueOf(addr.get('City'));
        pi.dealer__Customer_Shipto_State__c = String.valueOf(addr.get('State'));
        pi.dealer__Customer_ShipTo_Zip__c = String.valueOf(addr.get('Zip'));
        pi.dealer__Customer_ShipTo_Country__c = String.valueOf(addr.get('Country'));
        update pi;
        return true;
    }  

    @RemoteAction
    global static List<Contact> businessAccountContacts(String s) {
        if(s==null || s=='' || s=='000000000000000') return new List<Contact>();
        return [Select FirstName, LastName from Contact where AccountId =:s and isPersonAccount = false limit 100];
    }
     
    public PageReference locationChanged() {
        
		system.debug('-->myParam ' + Apexpages.currentPage().getParameters().get('myParam'));
        List<dealer__Dealer_Location_User__c> availableLocations = [SELECT Id FROM dealer__Dealer_Location_User__c 
                                                                    where dealer__User__c =: UserInfo.getUserId()
                                                                    and dealer__Dealer_Location__c =: invoiceRecord.dealer__Location__c LIMIT 1];
        
        if(availableLocations == null || availableLocations.isEmpty()) {
            selectedLocation = '';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Selected location is not valid for the current user. Please select a valid location.'));

        }else if(Apexpages.currentPage().getParameters().get('myParam') != null && Apexpages.currentPage().getParameters().get('myParam') != ''){
            selectedLocation = invoiceRecord.dealer__Location__c;
            
        }else{
            selectedLocation = '';
        }
        
       return null;
    }
    

    /* Not release ready
    @RemoteAction
    public static List<dealer__Parts_Inventory__c> searchPartsInventory(String s) {
        return PartsInvoiceReST.searchParts(s);
    } 
    */
   
    //
    //  PDF Emailer
    //
    
    // <name>emailButton</email>
    /**
     * Send user to email estimate page
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT
     */
    public PageReference emailInvoice() {
        PageReference eb = Page.PartsInvoiceEmailPDF;
        if(invoiceRecord != null) {
            eb.getParameters().put('id', string.valueOf(invoiceRecord.Id));
        }
        return eb;
    }
    
    //  <name>sendPdf</name>
    /**
     * send client invoice as pdf email attachment
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT
     */
    public PageReference sendPdf() {
               
        // Get Customer Email address
        
        Contact c = [Select Id, Email from Contact where Id =: invoiceRecord.dealer__Customer_Contact__c limit 1];
        
        if(c.Email == null) {
            
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Customer Account has no Email Address'));
                return null;
            
        }
        
        Messaging.EmailFileAttachment attach = AttachPDF();
     
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setUseSignature(false);
        mail.setToAddresses(new String[] { c.Email });
        mail.setSubject(this.subject);
        mail.setHtmlBody(this.body);
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach }); 
     
        // Send the email
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Email with Parts Invoice was sent to '+c.Email));
        
        // Record Activity
        Task t = new Task( Subject='Emailed Parts Invoice to '+c.Email,
                           ActivityDate=Date.today(),
                           WhatId=invoiceRecord.Id,
                           Status='Completed');
        insert t;             
                           
        PageReference sq = Page.PartsInvoice;
        sq.getParameters().put('id', string.valueOf(invoiceRecord.Id));
        return sq;
     
    }
   
    // <name>AttachPDF</name>
    /**
     * attach parts invoice pdf to email
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT
     */
    public Messaging.EmailFileAttachment AttachPDF() {
                
        PageReference pdf = new PageReference('/apex/PartsInvoicePDF');
        // add parent id to the parameters for standardcontroller
        pdf.getParameters().put('id', string.valueOf(invoiceRecord.Id));
     
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
        attach.setFileName(invoiceRecord.Name+'-PartsInvoice.pdf');
        attach.setInline(false);
        attach.Body = body;
        
        return attach;
    }
    
    // <name>closeInvoice</name>

    /**
     * sets status to invoiced
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT
     */
    public PageReference closeInvoice() {
        
        invoiceRecord.dealer__Invoice_Date_Time__c = DateTime.now();
        invoiceRecord.dealer__Status__c = 'Invoiced';
        update invoiceRecord;
        
        return Page.PartsInvoice;
    }

    public PageReference voidInvoice() {
    
        try{
            List<dealer__Parts_Invoice_Line__c> lines = [Select id, Name, Part__c, Quantity_Sold__c, Parts_Invoice__c, Parts_Invoice__r.Name 
                                                     From dealer__Parts_Invoice_Line__c 
                                                     Where dealer__Parts_Invoice__c =: invoiceRecord.id Limit 100];
        
            if(!lines.isEmpty()){
                PartInvoiceAPI.removeInvoiceLine(lines);
            }
            
            invoiceRecord.dealer__Status__c = 'Void';
            update invoiceRecord;
            
        }catch(Exception e){
            throw new PartsInvoiceException(e.getMessage());
        }
        
        return Page.PartsInvoice;
    }
    
    // <name>reopenInvoice</name>
    /**
     * sets status back to open and invoice datetime to null
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT
     */
    public PageReference reopenInvoice() {
        invoiceRecord.dealer__Invoice_Date_Time__c = null;
        invoiceRecord.dealer__Status__c = 'Open';
        update invoiceRecord;
        return Page.PartsInvoice;
    }

    // <name>casheirInvoice</name>
    /**
     * handles cashiering the invoice
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceEXT
     */           
    public PageReference cashierInvoice() { 
        PageReference cashier = Page.CashierPayments;
        cashier.setRedirect(true);
        cashier.getParameters().put('id',invoiceRecord.id);
        cashier.getParameters().put('department', 'parts');
        return cashier;
    }
    
    // <name>createInvoicefromRO</name>
    /**
     * Called to create a blank invoice related to the Repair Order it was called from
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceOnSRO
     */   
    public PageReference createInvoicefromRO() {
        if(roId!=null && roData.dealer__Parts_Invoice__c==null) { 
            System.debug('Creating Parts Invoice associated with '+roId+' '+roData.Name);
            
            // Create Target Invoice
            // Incrimental ID Numbering not dependent on object
            // Get record type ID
            RecordType rt = [Select Id from RecordType where DeveloperName = 'Repair_Order' limit 1];
            
            dealer__Parts_Invoice__c pi = new dealer__Parts_Invoice__c(
                Location__c = roData.Company__c,
                dealer__Customer_Contact__c=roData.dealer__Customer_Contact__c,
                Name=roData.Name, 
                dealer__Service_Repair_Order__c=roId,
                dealer__Counterman__c=CounterMan,
                dealer__Invoice_Number__c='RO'+roData.RO_Number__c
            );
            
            insert pi;
            
            roData.dealer__Parts_Invoice__c=pi.Id;
            update roData;
            
            // Redirect User
            PageReference invc = Page.ServiceJobLineParts;
            invc.setRedirect(true);
            invc.getParameters().put('jid', this.jobLineId);
            invc.getParameters().put('rid', this.roData.Id);
            invc.getParameters().put('id', pi.Id);
            
            return invc;
            
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Parts Invoice for '+roData.Name+' already exists.'));
            return null;
        }
    }
    
    //<name>directView</name>
    /**
     * Direct user to appropriate page, based if the record is tied to a service repair order or not
     * @test PartPhysicalInventoryUILayer.testPartsInvoiceOnSRO
     */
    public PageReference directView() {

        // Add Record Type Return Direct View
        if(invoiceRecord.RecordType.DeveloperName=='Counter_Return') {
            PageReference invc = Page.PartsReturnToVendor;
            invc.getParameters().put('id', invoiceRecord.Id);
            invc.setRedirect(true);
            return invc;            
        }

        if(invoiceRecord.Service_Repair_Order__c!=null) {
            PageReference invc = Page.ServiceJobLineParts;
            invc.getParameters().put('rid', invoiceRecord.Service_Repair_Order__c);
            invc.getParameters().put('id', invoiceRecord.Id);
            invc.setRedirect(true);
            return invc;
        } else {
            return null;
        }
    }
               
   public class PartsInvoiceException extends Exception {}
}