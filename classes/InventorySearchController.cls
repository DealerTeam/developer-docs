public class InventorySearchController {

    @AuraEnabled
    public static List<sObject> searchInventory(String objectName, List<Object> searchParameters, String searchFields, Integer offset) {
       //String serJSON = JSON.serialize(searchParameters);
       
        List<SObject> returnList = new List<SObject>();
        String searchQuery = 'SELECT ' + searchFields + ' FROM ' + objectName;
        String whereField = '';

        for(object o : searchParameters){
           String ser = JSON.serialize(o);
            Map<String, Object> param = (Map<String, Object>)JSON.deserializeUntyped(ser);
            if(whereField == ''){
                whereField = ' WHERE ' + param.get('field') + ' LIKE \'%' + param.get('value') + '%\'';
            }
            else{
                whereField += ' AND ' + param.get('field') + ' LIKE \'%' + param.get('value') + '%\'';
            }
       }
        if(objectName == 'dealer__Vehicle_Inventory__c'){
            if(whereField == ''){
                whereField = ' WHERE dealer__In_Stock__c = true';
            }
            else{
                whereField += ' AND dealer__In_Stock__c = true';
            }
        }

        searchQuery += whereField;

        Integer size = 10000;
        Integer qLimit = 1;
        if(offset == null){
            if(Limits.getLimitQueryRows() - Limits.getQueryRows() > size){
                    qLimit = size;
                
            } else if (Limits.getLimitQueryRows() - Limits.getQueryRows() > qLimit){      
                qLimit = Limits.getLimitQueryRows() - Limits.getQueryRows();
            }
            searchQuery += ' LIMIT: qLimit';
        }
        else{
            qLimit = 10;
            searchQuery += ' LIMIT: qLimit OFFSET: offset';
        }
        
        System.debug(searchQuery);
        returnList = Database.query(searchQuery);

        return returnList;
    }
}