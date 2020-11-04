public with sharing class recordFormController {
    @AuraEnabled        
    public static SObject getToggle(String obj, String f, String rId) {
        if(obj != null && f != null){
            String query = 'SELECT ' + f + ' FROM ' + obj + ' WHERE Id = \'' + rid + '\'';
            SObject s = Database.query(query);
            system.debug(s);

            return s;
        }
        
        return null;
    }

    @AuraEnabled
    public static void updateToggle(SObject updateObj){
        system.debug(updateObj);
        update updateObj;
    }

    @AuraEnabled
    public static sObject recordName(String recordId, String objectName){
        String query = 'SELECT Id, dealer__Buyer__r.Name, dealer__Co_Buyer__r.Name FROM ' + objectName + ' WHERE Id = \'' + recordId  + '\'';
        List<sObject> records = Database.query(query);

        if(records.size() > 0){
            return records[0];
        }
         return null;
    }
}