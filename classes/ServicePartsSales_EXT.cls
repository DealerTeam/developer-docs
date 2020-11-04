public with sharing class ServicePartsSales_EXT {
    
    private final dealer__Service_Job__c serviceJob;
    
    public ServicePartsSales_EXT (ApexPages.StandardController controller) {
        List<String> af = new List<String>();
        if(!Test.isRunningTest()) {
            af.add('dealer__Repair_Order__c');
            af.add('dealer__Service_Repair_Order__c');
            //af.add();
            controller.addFields(af);
        }
        serviceJob = (dealer__Service_Job__c)controller.getRecord();
    }
    
    public String CounterManName {
        get {
            return UserInfo.getName();
        }
    }
    
    public Id CounterMan { 
        get {
            return UserInfo.getUserId();
        }
    }
    
   //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////   REMOTE ACTIONS  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /*
    |
    |   getInventory: return inventory item specific details based on part number    
    |
    */
    @RemoteAction
    public static dealer__Parts_Inventory__c getInventory(String inventorySearch) {
    
        Integer slength = inventorySearch.length();
        // inventorySearch = '%'+String.escapeSingleQuotes(inventorySearch)+'%';
        
        if(slength>=3) {   
        dealer__Parts_Inventory__c Inventory = [SELECT Id, Name, dealer__Bin__c, dealer__Source__c, dealer__Part_No__c, dealer__Comments__c, dealer__List__c, dealer__Cost__c,
                                         dealer__Description__c, dealer__Pack_QTY__c, dealer__On_Hand__c, dealer__On_Order__c, dealer__Core__c, dealer__MFG__c
                                         FROM dealer__Parts_Inventory__c
                                         WHERE Name = :inventorySearch
                                         LIMIT 10];
        return Inventory;
        } else {
           return null;
        }
    }  
    
    @RemoteAction
    public static List<dealer__Parts_Invoice_Line__c> loadPartsInvoiceLines(String masterRecordId){
        return [Select Id, Name, dealer__Core__c, dealer__Cost__c, dealer__List__c, dealer__Part_Description__c, dealer__Bin__c, dealer__Currently_Available__c,
                                                    dealer__Part_Number__c, dealer__Part__c, dealer__Quantity_Sold__c, dealer__Extended_Price__c, dealer__Price__c,
                                                    dealer__Source__c, dealer__Sold_Via__c, dealer__Parts_Invoice__c
                                                    From dealer__Parts_Invoice_Line__c where dealer__Job_Line__c = :masterRecordId limit 100];                                                   
    }  
    
    @RemoteAction
    public static dealer__Parts_Invoice_Line__c InvoiceAddPartLine(String xmlString) {
        
        Dom.Document doc    =   new Dom.Document();
        doc.load(xmlString);
    
        Dom.XMLNode invoice =   doc.getRootElement();
        String invoiceId    =   invoice.getChildElement('InvoiceId', null).getText();
        String partId       =   invoice.getChildElement('Id', null).getText();
        String locId        =   invoice.getChildElement('LocId',null).getText();
        
        if(invoiceId == null || partId == null) {
            // return false;
            // Add Expection Statement
        }
        
        List<dealer__Parts_Invoice__c> invoiceRecord = [Select Id from dealer__Parts_Invoice__c where dealer__Service_Repair_Order__c = :invoice.getChildElement('RepairOrderId', null).getText() limit 1];
        dealer__Parts_Invoice__c invoiceContainer;
        // Parts Invoices are created for all Service Repair Orders that have a parts sale on them.
        if(invoiceRecord.size() <= 0) {
            // Get approrpiate record type
            RecordType rt = [Select Id from RecordType where DeveloperName = 'Repair_Order' limit 1];
            // We need to create a parts invoice and link it to the Repair Order
            dealer__Parts_Invoice__c newInvoice = new dealer__Parts_Invoice__c(
                                                                                Name=invoice.getChildElement('InvoiceName', null).getText(),
                                                                                dealer__Service_Repair_Order__c=invoice.getChildElement('RepairOrderId', null).getText(),
                                                                                dealer__Customer_Contact__c=invoice.getChildElement('customerId', null).getText(),
                                                                                dealer__Invoice_Number__c='PI'+invoice.getChildElement('InvoiceNumber', null).getText(),
                                                                                dealer__Counterman__c=invoice.getChildElement('counterman', null).getText(),
                                                                                RecordTypeId=rt.Id
                                                                            );
            if(locId != null){
                newInvoice.Location__c = locId;
            }                                  

            insert newInvoice;  
            invoiceContainer = newInvoice;
            
            // Update Service Repair Order with new Parts Invoice
            dealer__Service_Repair_Order__c ro = [select Id from dealer__Service_Repair_Order__c where Id = :invoice.getChildElement('RepairOrderId', null).getText() limit 1];
            ro.dealer__Parts_Invoice__c = newInvoice.Id;
            update ro;
                                                            
        } else {
            invoiceContainer = invoiceRecord[0];
        }
        
        
        
        
        // Add partno to invoice
        dealer__Parts_Invoice_Line__c pi = new dealer__Parts_Invoice_Line__c();   
        
             pi.Name = invoice.getChildElement('InvoiceName', null).getText()+'-'+invoice.getChildElement('LineNumber', null).getText();
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
             pi.dealer__Quantity_Ordered__c = decimal.valueOf(invoice.getChildElement('dealer__Quantity_Ordered__c',null).getText());
             pi.dealer__MFG__c = invoice.getChildElement('dealer__MFG__c',null).getText();
             pi.dealer__Source__c = invoice.getChildElement('dealer__Source__c',null).getText();
             pi.dealer__Sold_Via__c = invoice.getChildElement('dealer__Sold_Via__c',null).getText();
             pi.dealer__Order_Type__c= invoice.getChildElement('dealer__Order_Type__c', null).getText();
             pi.dealer__Job_Line__c = invoice.getChildElement('LineId', null).getText();
             pi.dealer__Service_Repair_Order__c = invoice.getChildElement('RepairOrderId', null).getText();
             pi.dealer__Parts_Invoice__c = invoiceContainer.Id;
        
        System.debug(pi);
             
        insert pi;   
        
        if(Limits.getQueries() < 90) {                        
        return [Select Id, dealer__List__c, dealer__Price__c, dealer__Core__c, dealer__Cost__c, dealer__Bin__c, dealer__Counterman__c, dealer__Part__r.dealer__On_Hand__c,
                dealer__Part_Number__c, dealer__Part_Description__c, dealer__Quantity_Sold__c, dealer__Net_Price__c, dealer__Extended_Price__c, dealer__Gross_Margin__c,
                dealer__Source__c, dealer__MFG__c, dealer__Currently_Available__c, dealer__Sold_Via__c, dealer__Order_Type__c
                From dealer__Parts_Invoice_Line__c 
                Where Id = :pi.Id limit 1];
       } else {
        return new dealer__Parts_Invoice_Line__c();
       } 
        
    }    
}