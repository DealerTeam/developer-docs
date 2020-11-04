/**
 * LocationControlHandler
 * @description Handler for LocationControl trigger
 */ 
public class LocationControlHandler {
    
    /**
     * handleAccounts 
     * @param  locationList 
     * @return void
     * @description Stores dealer__Dealer_Location__c related IDs
     */
    public void handleAccounts(List<dealer__Dealer_Location__c> locationList)
    {
        
        Set<String> externalIds = new Set<String>(); //Stores location company number Ids
        for(dealer__Dealer_Location__c loc : locationList) {
            externalIds.add(loc.dealer__Company_Number__c);
        }
        
        Map<String, Account> existingAccounts = new Map<String, Account>();
        for(Account a : [Select Id, dealer__External_ID__c 
                          from Account where dealer__External_ID__c IN: externalIds ]) {
            existingAccounts.put(a.dealer__External_ID__c, a);
        }
        
        // Iterate the records and identify if we need to insert or update any accounts
        List<Account> accountInserts = new List<Account>();
        for(dealer__Dealer_Location__c loc : locationList) {

            // Check if an External ID of the company number already exists.
            if(existingAccounts.get(loc.dealer__Company_Number__c)!=null && loc.dealer__Location_Account__c==null) {
                loc.dealer__Location_Account__c=existingAccounts.get(loc.dealer__Company_Number__c).Id;
            }

            // If no account exists, prepare the account to insert
            if(loc.dealer__Location_Account__c==null && existingAccounts.get(loc.dealer__Company_Number__c)==null) {
                accountInserts.add(new Account(
                    Name=loc.Name,
                    BillingStreet=loc.dealer__Street__c,
                    BillingCity=loc.dealer__City__c,
                    BillingState=loc.dealer__State__c,
                    BillingPostalCode=loc.dealer__Postal_Code__c,
                    dealer__External_ID__c=loc.dealer__Company_Number__c,
                    Phone=loc.dealer__Main_Phone__c,
                    Website=loc.dealer__Website__c
                    )
                );
            }
        }

        // If we have records to insert, perform insert and associate with the location
        if(!accountInserts.isEmpty()) {
            try {
                insert accountInserts;
                } Catch(DmlException e) {
                    Trigger.new[0].addError(e.getMessage());
                }

            // Create Map based on External ID of Location
            Map<String, Account> mappedAccounts = new Map<String, Account>();
            for(Account a : accountInserts) {
                mappedAccounts.put(a.dealer__External_ID__c, a);
            }

            // Associate the Account Record with the Location
            for(dealer__Dealer_Location__c loc : locationList) {
                if(mappedAccounts.get(loc.dealer__Company_Number__c)!=null && loc.dealer__Location_Account__c==null) {
                    loc.dealer__Location_Account__c=mappedAccounts.get(loc.dealer__Company_Number__c).Id;
                }
            }            
        }  
    }
    
    /**
     * handleLogo 
     * @param  locationList 
     * @return void
     * @description
     */
    public void handleLogo(List<dealer__Dealer_Location__c> locationList)
    {
        
        Set<String> logoNames = new Set<String>();
        for(Dealer_Location__c loc: locationList){
            if(loc.Logo_Name__c != null){
                logoNames.add(loc.Logo_Name__c);
            }
        }

        Map <String, Document> resourceMap = new Map <String, Document>();
        for (Document d: [SELECT Id, DeveloperName FROM Document WHERE DeveloperName IN:logoNames]) {
            resourceMap.put(d.DeveloperName, d);
        }

        for (Dealer_Location__c loc: locationList) {
            if (String.isBlank(loc.Logo_Name__c)) {
                loc.Logo_Name__c = 'InvoiceLogo';
            } else if (resourceMap.get(loc.Logo_Name__c) != null) {
                loc.Logo_Name__c = resourceMap.get(loc.Logo_Name__c).DeveloperName;
            } 
        }
    }
}