public with sharing class DynamicRecordController {
    /**
    * @Method      : getFieldSet
    * @Description : Processes inputs to return information about a related record.      
    * @return      : dynamicWrapper holding data in the dynamicWrapper inner class   
    * @Param       : recordId - Id of the record referencing the related record
    * @param       : fieldName - API name of the target field to display related data
    * @param       : fieldSetName - API name of a field set on target object that controls which fields are displayed
    */
    @AuraEnabled
    public static dynamicWrapper getFieldSet(Id recordId, String fieldName, String fieldSetName)
    {
        dynamicWrapper fw = getObjectRef(recordId, fieldName);
        if(fw.objType != null){
            fw.fields = getFieldSetMembers(fw.objType, fieldSetName);
            if(fw.recordId != null){
                fw.recordData = Utility.queryAllFields(fw.objType, fw.recordId);
            }
            return fw;
        }
    return null;
    }

    /**
    * @method      : getObjectRef
    * @description : Gets target object type and record Id of the provided lookup field on record
    * @param       : recordId Id of record referencing the related record
    * @param       : fieldName - API name of the target field to display related data
    * @return      : dynamicWrapper with recordId and objType
    */
    private static dynamicWrapper getObjectRef(Id recordId, String fieldName)
    {
        dynamicWrapper wrapper = new dynamicWrapper();
        Schema.SObjectType sObjectType = recordId.getSObjectType();
        String sObjectName = sObjectType.getDescribe().getName();

        // Allows recordId to be passed as a field name to evaluate field sets on the root record
        if(fieldName == 'recordId'){
            wrapper.objType = sObjectName;
            wrapper.recordId = recordId;
            return wrapper;
        }
        String refObj;
        Schema.SObjectType t = Schema.getGlobalDescribe().get(sObjectName);
 
        Schema.DescribeSObjectResult r = t.getDescribe();
        try{
            Schema.DescribeFieldResult f = r.fields.getMap().get(fieldName).getDescribe();
        
            for(Schema.SObjectType reference : f.getReferenceTo()) {
                refObj = reference.getDescribe().getName();
                    System.debug('Lookup reference object name: ' + refObj);
                wrapper.objType = refObj;
            }
        }
        catch(NullPointerException e){
            throw new AuraHandledException('Error evaluating field type. Please ensure Lookup Field Name is a valid field.');
        }

        String query = 'SELECT Id, ' + fieldName + ' FROM ' + sObjectName + ' WHERE ID = \'' + recordId + '\'';
        sObject obj = Database.query(query);
        wrapper.recordId = (String)obj.get(fieldName);
        return wrapper;

    }
    /**
    * @method      : getFieldSetMembers
    * @description : Gets fields from a provided field set and returns as a wrapper with the api name and required status from field set
    * @param       : objRef object API name that contains the field set
    * @param       : setName - API name of the field set to retrieve values
    * @return      : List<SalesUpController.fieldSetWrapper> Field names and required status from the field set
    */
    private static List<SalesUpController.fieldSetWrapper> getFieldSetMembers(String objRef, String setName)
    {
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(objRef);
        try{
            List<Schema.FieldSetMember> fields = objType.getDescribe().fieldSets.getMap().get(setName).getFields();
            List<SalesUpController.fieldSetWrapper> setFields = new List<SalesUpController.fieldSetWrapper>();
            for(Schema.FieldSetMember field : fields){
                SalesUpController.fieldSetWrapper fw = new SalesUpController.fieldSetWrapper();
                fw.fieldName = field.getFieldPath();
                fw.required = field.getRequired();
                setFields.add(fw);
            }
            return setFields;
        }
        catch(NullPointerException e){
            throw new AuraHandledException('Error evaluating field set. Please ensure Field Set Name is a valid field set.');
        }
        
    }

    /**
    * @description Wrapper class that holds information needed to display fields on LWC
    */
    public class dynamicWrapper{
        //recordId of the related record
        @AuraEnabled
        public String recordId;

        //API Name of the related record's object type
        @AuraEnabled
        public String objType;

        //Field API names and required status from a field set
        @AuraEnabled
        public List<SalesUpController.fieldSetWrapper> fields;

        //Queried data for the record
        @AuraEnabled
        public sObject recordData;
            
        
    }
}