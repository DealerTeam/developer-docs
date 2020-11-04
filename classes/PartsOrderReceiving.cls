public with sharing class PartsOrderReceiving {
    
    public dealer__Stock_Order__c so {get;set;}
    public list<dealer__Parts_Order__c> orderLines {get;set;}
    public list<dealer__Parts_Inventory__c> pqUpdate {
        get {
            return new List<dealer__Parts_Inventory__c>();
        }set;
    }
    
    public PartsOrderReceiving() {
        
        Id id = ApexPages.currentPage().getParameters().get('id');
        if(id!=null) {
        so = [Select Id, Name, dealer__Status__c, dealer__Packing_Slip__c, dealer__Manufacturer__c, dealer__Date_Ordered__c,dealer__Date_of_Arrival__c
                    From dealer__Stock_Order__c
                    where Id = :id 
                    limit 1];
                    
        orderLines = [Select Id, dealer__Parts_Inventory__c, dealer__Parts_Inventory__r.dealer__Description__c,
                            dealer__Parts_Inventory__r.dealer__On_Hand__c, dealer__Received__c, dealer__Parts_Inventory__r.dealer__On_Back_Order__c,
                             dealer__Parts_Invoice__c, dealer__Quantity_Ordered__c, dealer__Back_Ordered__c, dealer__Depot__c, dealer__Line_Posted__c
                            from dealer__Parts_Order__c 
                            where dealer__Order__c = :id
                            limit 1000];    
                            
        }                           
    }
    /**
     * Requires stock order to have a date of arrival and packing slip or error is thrown
     * @function saveOrderReceipt
     * @test PartOrderingServiceLayer.testPartsOrderReceiving
     */
    public PageReference saveOrderReceipt() {
        if(so.dealer__Date_of_Arrival__c==null || so.dealer__Packing_Slip__c==null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Required fields must be entered'));
            return null;
        }
        
        update so;
        
        for(dealer__Parts_Order__c ul : orderLines) {
            if((ul.dealer__Received__c>0 && ul.dealer__Received__c != null) && ul.dealer__Line_Posted__c == null) {
                Decimal newOnHand = ul.dealer__Parts_Inventory__r.dealer__On_Hand__c + ul.dealer__Received__c;
                System.debug(newOnHand+' '+ul.dealer__Parts_Inventory__r.dealer__Description__c);
                pqUpdate.add(new dealer__Parts_Inventory__c(Id=ul.dealer__Parts_Inventory__c, 
                                                            dealer__On_Hand__c=newOnHand
                                                            ));
            }
            if(ul.dealer__Back_Ordered__c>0 && ul.dealer__Back_Ordered__c != null) {
                Decimal newOnBackOrder = ul.dealer__Parts_Inventory__r.dealer__On_Back_Order__c + ul.dealer__Back_Ordered__c;
                pqUpdate.add(new dealer__Parts_Inventory__c(Id=ul.dealer__Parts_Inventory__c, dealer__On_Back_Order__c = newOnBackOrder));
            }                   
        }
        
        if(pqUpdate.size()>0) {
            update pqUpdate;
        }
        
        // Mark as posted
        update orderLines;
        
        
        return null;
    }
    
}