public with sharing class PartsOrderCreation {
    
    /*
        Currently not in production, the code addition caused the package to fail upon upload.
    */
    
    public PartsOrderCreation() {}
    
    public List<dealer__Stock_Order__c> CurrentOrders {get;set;}
    
    // Associated Stock Orders
    public void lookupCurrentOrders() {
        CurrentOrders = [Select Id, dealer__Manufacturer__c, dealer__Date_Ordered__c from dealer__Stock_Order__c where dealer__Date_Ordered__c = TODAY limit 1000];
    }
    
    // Populate Parts Order Line into parent invoice
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
        System.debug('OrderNumber ('+orderNumber+'); PartID ('+partId+'); InvoiceId ('+invoiceId+'); RequestedBy ('+requestedBy+'); InvoiceLine ('+invoiceLineId+');');
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
   
}