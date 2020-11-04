public with sharing class SalesCloudController {

    // @AuraEnabled
    // public List<dealer__SalesCloudConnectorMapping__mdt> picklistOptions;

    @AuraEnabled(cacheable=true)
    public static string getIconUrl(String objectName){
        if(objectName == 'Opportunity'){
            //handles getting correct image on Opportunity tab
            objectName = 'dealer__Sales_Up__c';
        }
        return DealerMetadata.getObjectTabUrl(objectName);
    }

    @AuraEnabled(cacheable=true)
    public static dealer__DMS_Settings__c getConnectorStatus(){
        dealer__DMS_Settings__c dms = [SELECT Id, dealer__SalesCloudConnector__c FROM dealer__DMS_Settings__c WHERE Name = 'ActiveSettings' LIMIT 1];
        return dms;
    }

    @AuraEnabled
    public static void updateSettings(string dmsId, boolean status){
        dealer__DMS_Settings__c dms = new dealer__DMS_Settings__c(id=dmsId, dealer__SalesCloudConnector__c= status);
        update dms;
    }
    
    public class fieldWrapper {
        @AuraEnabled
        public String fieldLabel {get;set;}
        @AuraEnabled
        public String sourceId {get;set;}
        @AuraEnabled
        public String targetField {get;set;}
        @AuraEnabled
        public String targetId {get;set;}
        @AuraEnabled
        public String role {get;set;}
        @AuraEnabled
        public List<picklistWrapper> options{get;set;}
        
        public fieldWrapper(){

        }
        
        public fieldWrapper(String label, String Id) {
            fieldLabel = label;
            sourceId = Id;
            targetField = '';
            targetId = null;
            role = null;
            options = null;
        }
    }

    public class picklistWrapper {
        @AuraEnabled
        public String label {get;set;}
        @AuraEnabled
        public String value {get;set;}
        
        public picklistWrapper(String fLabel, String Name) {
            label = fLabel;
            value = Name;
        }
    }



    @AuraEnabled(cacheable=true)
    public static List<fieldWrapper> getFields(String selectedObject) {
        List<dealer__SalesCloudConnectorMapping__mdt> sc = [SELECT Id, dealer__SourceObject__c, dealer__SourceField__c, dealer__MappedObject__c, dealer__MappedField__c
                                        FROM dealer__SalesCloudConnectorMapping__mdt
                                        ];
        
        
        //get target object
        string targetObject;

        switch on selectedObject{
            when 'dealer__Sales_Up__c', 'dealer__Deal__c' {
                targetObject = 'Opportunity';
            }
            when 'Opportunity'{
                targetObject = 'dealer__Sales_Up__c';
            }
        }

        Map<string, dealer__SalesCloudConnectorMapping__mdt> scMap = new Map<string, dealer__SalesCloudConnectorMapping__mdt>();
        Map<string, dealer__SalesCloudConnectorMapping__mdt> targetMap = new Map<string, dealer__SalesCloudConnectorMapping__mdt>();
        List<fieldWrapper> returnList = new List<fieldWrapper>();

        for(dealer__SalesCloudConnectorMapping__mdt scObject : sc){
            scMap.put(scObject.dealer__SourceField__c, scObject);
            targetMap.put(scObject.dealer__MappedField__c, scObject);
        }

        List<FieldDefinition> fieldDef = [SELECT EntityDefinitionId, QualifiedApiName, Label, DurableId, DataType FROM FieldDefinition WHERE DurableId =:scMap.keySet() AND EntityDefinition.QualifiedApiName=:selectedObject];
        List<FieldDefinition> targetFieldDef = [SELECT EntityDefinitionId, QualifiedApiName, Label, DurableId FROM FieldDefinition WHERE DurableId =:targetMap.keySet()];
        List<FieldDefinition> picklistFieldDef = [SELECT QualifiedApiName, Label, DataType FROM FieldDefinition WHERE EntityDefinition.QualifiedApiName =:targetObject AND DurableId NOT IN: targetMap.keySet()];
        Map<string, fieldWrapper> selMap = new Map<string, fieldWrapper>();

        //Iterate through source fields
        for(FieldDefinition field : fieldDef){
            List<picklistWrapper> availableFields = new List<picklistWrapper>();
                
            fieldWrapper sel = new fieldWrapper(field.Label, field.DurableId);
            selMap.put(sel.sourceId, sel);

            //Get available picklist options for the field
            for(FieldDefinition picklistField : picklistFieldDef) {

                if(picklistField.DataType == field.DataType){
                    String frLabel = picklistField.label;
                    String frName = picklistField.QualifiedApiName;
                    picklistWrapper plWrap = new picklistWrapper(frLabel, frName);
                    if(!availableFields.contains(plWrap)){
                        availableFields.add(plWrap);
                    }
                }
            }
            selMap.get(sel.sourceId).options = availableFields;
            
        }
        //Iterate through target fields
        for(FieldDefinition field : targetFieldDef){
            string mapId = targetMap.get(field.DurableId).dealer__SourceField__c;
            try{
                selMap.get(mapId).targetField = field.Label;
                selMap.get(mapId).targetId = field.DurableId;
            }
            catch(System.NullPointerException e){

            }
        
        }

        returnList.addAll(selMap.values());
        
        if(!returnList.isEmpty()) {
                return returnList;
            }
        
        return null;
        }

    @AuraEnabled
    public static void saveMappings(String selectedObject, List<fieldWrapper> mappedFields){

        //get target object
        string targetObject;

        switch on selectedObject{
            when 'dealer__Sales_Up__c', 'dealer__Deal__c' {
                targetObject = 'Opportunity';
            }
            when 'Opportunity'{
                targetObject = 'dealer__Sales_Up__c';
            }
        }

        List<dealer__SalesCloudConnectorMapping__mdt> mdList = [SELECT Id, DeveloperName, MasterLabel, dealer__SourceObject__c, SourceObject__r.DeveloperName, dealer__SourceField__c, dealer__MappedObject__c, dealer__MappedField__c
                                        FROM dealer__SalesCloudConnectorMapping__mdt
                                        ];
        Map<string, dealer__SalesCloudConnectorMapping__mdt> scMap = new Map<string, dealer__SalesCloudConnectorMapping__mdt>();
        
        for(dealer__SalesCloudConnectorMapping__mdt md : mdList){
            scMap.put(md.SourceField__c, md);
        }

        
        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();

            if(selectedObject == 'Account' || selectedObject == 'Contact'){
               for(fieldWrapper field: mappedFields){

                    Metadata.CustomMetadata customMetadata = new Metadata.CustomMetadata();
            
                    Metadata.CustomMetadataValue roleField = new Metadata.CustomMetadataValue();
                    roleField.field = 'dealer__Role__c';

                    Metadata.CustomMetadataValue targetFieldField = new Metadata.CustomMetadataValue();
                    targetFieldField.field = 'dealer__MappedField__c';

                    scMap.get(field.sourceId).Role__c = field.targetField;
                    customMetadata.fullName = 'dealer__SalesCloudConnectorMapping.' + scMap.get(field.sourceId).DeveloperName;
                    customMetadata.label = scMap.get(field.sourceId).MasterLabel;
                    roleField.value = scMap.get(field.sourceId).Role__c;
                    customMetadata.values.add(roleField);
                    mdContainer.addMetadata(customMetadata);
                } 
            }
            else{
                for(fieldWrapper field: mappedFields){

                    Metadata.CustomMetadata customMetadata = new Metadata.CustomMetadata();
            
                    Metadata.CustomMetadataValue targetObjectField = new Metadata.CustomMetadataValue();
                    targetObjectField.field = 'dealer__MappedObject__c';

                    Metadata.CustomMetadataValue targetFieldField = new Metadata.CustomMetadataValue();
                    targetFieldField.field = 'dealer__MappedField__c';

                    scMap.get(field.sourceId).MappedObject__c = targetObject;
                    scMap.get(field.sourceId).MappedField__c = field.targetField;
                    customMetadata.fullName = 'dealer__SalesCloudConnectorMapping.' + scMap.get(field.sourceId).DeveloperName;
                    customMetadata.label = scMap.get(field.sourceId).MasterLabel;
                    targetObjectField.value = scMap.get(field.sourceId).MappedObject__c;
                    customMetadata.values.add(targetObjectField);
                    targetFieldField.value = scMap.get(field.sourceId).MappedField__c;
                    customMetadata.values.add(targetFieldField);
                    mdContainer.addMetadata(customMetadata);
                }
            }

        dealerMetadata.MyCallback callback = new dealerMetadata.MyCallback();
        if(!Test.isRunningTest()){
            Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, callback);
        }


    }

    @AuraEnabled(cacheable=true)
    public static List<fieldWrapper> getRoles(String selectedObject) {

        Map<string, dealer__SalesCloudConnectorMapping__mdt> scMap = new Map<string, dealer__SalesCloudConnectorMapping__mdt>();
        List<String> assignedRoles = new List<String>();
        List<fieldWrapper> returnList = new List<fieldWrapper>();

        //Get custom field mapping metadata records
        List<dealer__SalesCloudConnectorMapping__mdt> sc = [SELECT Id, dealer__SourceObject__c, dealer__SourceField__c, dealer__MappedObject__c, dealer__MappedField__c, Role__c
                                        FROM dealer__SalesCloudConnectorMapping__mdt
                                        ];

        for(dealer__SalesCloudConnectorMapping__mdt scObject : sc){
            scMap.put(scObject.dealer__SourceField__c, scObject);
            assignedRoles.add(scObject.Role__c);
        }

        //Field def of source fields
        List<FieldDefinition> fieldDef = [SELECT EntityDefinition.Label, EntityDefinitionId, QualifiedApiName, Label, DurableId, DataType FROM FieldDefinition WHERE DurableId =:scMap.keySet()];
        Map<string, fieldWrapper> selMap = new Map<string, fieldWrapper>();

        //Get all picklist options for Partner Roles and Contact Roles
        List<picklistWrapper> picklistValues = getRolePickList(selectedObject);        

        //Iterate through source fields
        for(FieldDefinition field : fieldDef){
            List<picklistWrapper> availableFields = new List<picklistWrapper>();

            if(field.DataType == 'Lookup(' +selectedObject + ')'){    
                //Create fieldWrapper object with <Object - Field> as source label 
                fieldWrapper sel = new fieldWrapper(field.EntityDefinition.Label + ' - ' + field.Label, field.DurableId);
                sel.role = scMap.get(field.DurableId).Role__c;
                system.debug(sel);
                selMap.put(sel.sourceId, sel);

                //Filter out picklist options that are assigned
                for(picklistWrapper plv : picklistValues){
                    if(!assignedRoles.contains(plv.label)){
                        availableFields.add(plv);
                    }
                }
                selMap.get(sel.sourceId).options = availableFields; 
            }   
        }

        returnList.addAll(selMap.values());
        
        if(!returnList.isEmpty()) {
                return returnList;
            }
        
        return null;
        }

    /**
     * Private method to handle getting the picklist values available to Partner Roles & Opp Contact Roles
     *
     */
    private static List<picklistWrapper> getRolePickList(String obj){
    
        if(obj == 'Account'){
            List<picklistWrapper> availableFields = new List<picklistWrapper>();
            Schema.DescribeFieldResult fieldResult = Partner.Role.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
                
            for( Schema.PicklistEntry pickListVal : ple){
                String frLabel = picklistVal.getLabel();
                String frName = picklistVal.getValue();
                picklistWrapper plWrap = new picklistWrapper(frLabel, frName);
                availableFields.add(plWrap);
            }

            return availableFields;
        }

        if(obj == 'Contact'){
            List<picklistWrapper> availableFields = new List<picklistWrapper>();
            Schema.DescribeFieldResult fieldResult = OpportunityContactRole.Role.getDescribe();
            List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
                
            for( Schema.PicklistEntry pickListVal : ple){
                String frLabel = picklistVal.getLabel();
                String frName = picklistVal.getValue();
                picklistWrapper plWrap = new picklistWrapper(frLabel, frName);
                availableFields.add(plWrap);
            }

            return availableFields;    
        }
        return null;
    }

}