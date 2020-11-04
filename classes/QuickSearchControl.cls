public with sharing class QuickSearchControl {
    
    @AuraEnabled
    public static List <sObject> fetchLookUpValues(String searchKeyWord, String ObjectName) {

        String searchquery = '';

        List < sObject > objectResults = new List < sObject > ();
        List < List < SObject >> searchList = new List < List < SObject >>();

        if (ObjectName == 'dealer__Dealer_Location__c') {
      
            Set<Id> locationIds = getUserLocations();
            
            if(locationIds.size() > 0){
                searchquery = 'FIND \'' + searchKeyWord + '*\' IN ALL FIELDS RETURNING ' + ObjectName + ' (id, name, dealer__Company_Number__c, dealer__City__c, dealer__State__c, dealer__Postal_Code__c WHERE Id=:locationIds)';
                system.debug('searchquery ' + searchquery);
            }
        } else {       
            searchquery = 'FIND \'' + searchKeyWord + '*\' IN ALL FIELDS RETURNING ' + ObjectName + ' (id,name)';
        }

        searchList = search.query(searchquery);
                
        return searchList[0];

    }
    
    
    private static Set<Id> getUserLocations(){
        
        Integer size = 10000;
        Integer qLimit = 1;
        if(Limits.getLimitQueryRows() - Limits.getQueryRows() > size){
                qLimit = size;
            
        } else if (Limits.getLimitQueryRows() - Limits.getQueryRows() > qLimit){      
              qLimit = Limits.getLimitQueryRows() - Limits.getQueryRows();
        }

        List<Dealer_Location_User__c> availableLocations = [select Id, Dealer_Location__c from Dealer_Location_User__c 
                                                            where User__c=:UserInfo.getUserId() limit: qLimit];
        
        Set<Id> dealershipLocationIds = new Set<Id>();
        if(availableLocations.size() > 0){
            for(Dealer_Location_User__c dl : availableLocations) {
                dealershipLocationIds.add(dl.Dealer_Location__c);
            }
        }
		
        return dealershipLocationIds;
	}
}