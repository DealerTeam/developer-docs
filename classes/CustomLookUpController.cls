/**
 * CustomLookUpController
 * @description
 */
public class CustomLookUpController {

    /**
     * getResults 
     * @param  ObjectName 
     * @param  value     
     * @return List<Result> 
     * @description          
     */ 
    @AuraEnabled
    public static List<Result> getResults(String ObjectName, String value) 
    {
        //get fields from object dynamically.
        SObjectType objectType = Schema.getGlobalDescribe().get(ObjectName);
        List<SobjectField> fieldList = objectType.getDescribe().fields.getMap().values();

        //When called from within an org where Dteam is installed if the customer creates a custom field with the same API name  as one of our fields there will be overlap
        //because when this is called from within namespaced code the dealer__ prefix is not included.
        Set<String> fieldsSet = new Set<String>();
        String fieldsToQuery = '';
        for(Integer i = 0; i < fieldList.size(); i++){
            String fieldName = String.valueOf(fieldList[i]);
            fieldName = fieldName.split('dealer__').size() == 1 ? fieldName : fieldName.replace('dealer__','');
            if(!fieldsSet.contains(fieldName)){ // Prevent overlap With customer api names No need at this time to include custom fields.
                if(i == 0){
                    fieldsToQuery += '('+fieldName;
                } else {
                    fieldsToQuery += ', '+fieldName;
                    if(i == fieldList.size() - 1)
                        fieldsToQuery += ')';
                }
                fieldsSet.add(fieldName);
            }
        }
        String searchquery = 'FIND \'' + value + '* \'IN ALL FIELDS RETURNING ' + ObjectName +' '+ fieldsToQuery;
        List<Result> results = new List<Result>();
        //Loop SOSL results
        for(sObject so : search.query(searchquery)[0]){
            Result result = new Result(Name(so,ObjectName), Description(so,ObjectName), so);
            results.add(result);
        }
        return results;
    }

    /**
     * getPreLoadedRecord 
     * @param  ObjectName 
     * @param  recordId   
     * @return   List<Result>      
     * @description   
     */
    @AuraEnabled
    public static List<Result> getPreLoadedRecord(String ObjectName, String recordId)
    {
        SObjectType objectType = Schema.getGlobalDescribe().get(ObjectName);
        List<SobjectField> fieldList = objectType.getDescribe().fields.getMap().values();

        Set<String> fieldsSet = new Set<String>();
        //build SOSL
        String query = 'SELECT ';
        for(Integer i = 0; i < fieldList.size(); i++){
            String fieldName = String.valueOf(fieldList[i]);
            fieldName = fieldName.split('dealer__').size() == 1 ? fieldName : fieldName.replace('dealer__','');
            if(!fieldsSet.contains(fieldName)){ // Prevent overlap With customer api names No need at this time to include custom fields.
                if(i == 0){
                    query += String.valueOf(fieldName);
                } else {
                    query += ', '+String.valueOf(fieldName);
                    if(i == fieldList.size() - 1)
                        query +=' FROM '+ObjectName+' WHERE Id = \''+recordId+'\'';
                }
                fieldsSet.add(fieldName);
            }
        }
        List<Result> results = new List<Result>();
        //Loop SOSL results
        for(sObject so : Database.query(query)){
            Result result = new Result(Name(so,ObjectName), Description(so,ObjectName), so);
            results.add(result);
        }
        return results;
    }

    /**
     * getIconUrl 
     * @param  objectName 
     * @return  String
     * @description
     */ 
    @AuraEnabled
    public static String getIconUrl(String objectName)
    {
       return DealerMetadata.getObjectTabUrl(objectName);
    }

    /**
     * Name 
     * @param  obj        
     * @param  ObjectName 
     * @return  String   
     * @description      
     */
    public static String Name(sObject obj, String ObjectName)
    {
        string name;
        if(objectName == 'dealer__Equipment_Master__c'){
            name = String.valueOf(obj.get('dealer__Name__c'));
        } else {
            //More Objects here
            name = String.valueOf(obj.get('Name'));
        }
        return name;
    }

    /**
     * Description 
     * @param  obj       
     * @param  ObjectName 
     * @return  String
     */
    public static String Description(sObject obj, String ObjectName)
    {
        string description;
        if(objectName == 'dealer__Equipment_Master__c'){
            description = String.valueOf(obj.get('dealer__Description__c'));
        } else if(objectName == 'dealer__Rental_Rates__c'){
            description = 'Daily Rate: '+String.valueOf(obj.get('dealer__Daily_Rate__c'))+' Weekly Rate: '+String.valueOf(obj.get('dealer__Weekly_Rate__c'));
        } else {
            //More Objects here
            description = String.valueOf(obj.get('Name'));
        }
        return description;
    }

    /**
     * Result
     * @description Wrapper class to allow custom descriptions
     */
    public class Result 
    {
        @AuraEnabled
        public String name {get;set;}
        @AuraEnabled
        public String description {get;set;}
        @AuraEnabled
        public sObject record {get;set;}
        
        public Result(String nameT, String descriptionT, sObject recordT) {
            name = nameT;
            description = descriptionT;
            record = recordT;
        }
    }
}