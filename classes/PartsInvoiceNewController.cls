public with sharing class PartsInvoiceNewController {
    
    public PartsInvoiceNewController() {}
    
    @AuraEnabled(Cacheable=true)
    public static Parts_Invoice__c getDefaultInvoice() {

        User u = 
            [SELECT Id, Division 
            FROM User 
            WHERE Id=: UserInfo.getUserId() 
            LIMIT 1];
        
        List<Dealer_Location__c> listLoc = 
            [SELECT Id 
            FROM Dealer_Location__c 
            WHERE Company_Number__c =: u.Division 
            LIMIT 1];
        
        Id locId;
        if (listLoc != null && listLoc.size() > 0) {
            locId = listLoc[0].Id;
        } else {
            throw new AuraHandledException('User has no Division. Please contact your system administrator');
        }        
        
        List<Parts_Service_Pricing_Strategy__c> priceStrats = 
            [SELECT Id 
            FROM Parts_Service_Pricing_Strategy__c
            WHERE Default__c = true
            ORDER BY Default__c DESC, 
                dealer__Order__c ASC 
            LIMIT 1];

        Parts_Invoice__c pi = new Parts_Invoice__c();
        pi.Location__c = locId;
        pi.Counterman__c = UserInfo.getUserId();
        pi.Wholesale_Pricing_Strategy__c = (priceStrats.size() > 0) ? priceStrats[0].Id : null;
        return pi;
    }

    @AuraEnabled(Cacheable=true)
    public static List<Contact> getBusinessContacts(Id accountId) {
        List<Contact> contacts = [
            SELECT Name, FirstName, LastName 
            FROM Contact 
            WHERE AccountId =:accountId 
                AND isPersonAccount = false 
            LIMIT 100
        ];
        return contacts;
    }
}