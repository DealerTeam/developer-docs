/**
 * DealerMetadata
 * @description
 */
public with sharing class DealerMetadata {
    public static Map<String, DMSConfig__mdt> configMap {get;set;}

    @AuraEnabled(cacheable=true)
    public static Map<String, fieldResult> getAllFieldSchema(String objectApiName){
        Map<String,SChema.SObjectField> objFieldMap = Schema.getGlobalDescribe().get(objectApiName).getDescribe().fields.getMap();
        
        List<String> fields = new List<String>();
        for(String field : objFieldMap.keySet()){
            fields.add(field);
        }
        return getFieldSchema(objectApiName, fields);
    }

    @AuraEnabled
    public static Map<String, fieldResult> getFieldSchema(String objectApiName, List<String> fieldApiNames) {
        Map<String,SChema.SObjectField> objFieldMap = Schema.getGlobalDescribe().get(objectApiName).getDescribe().fields.getMap();
        Map<String, fieldResult> fieldMap = new Map<String, fieldResult>();
        
        for(String fieldName : fieldApiNames){
            
            FieldResult result = new FieldResult();
            result.objectApiName = objectApiName;
            result.fieldApiName = objFieldMap.get(fieldName).getDescribe().getName();
            result.label = objFieldMap.get(fieldName).getDescribe().getLabel();
            result.required = !objFieldMap.get(fieldName).getDescribe().isNillable();
            result.accessible = objFieldMap.get(fieldName).getDescribe().isAccessible();
            result.type = objFieldMap.get(fieldName).getDescribe().getType().name().toupperCase();
            result.relatedTo = result.type == 'REFERENCE' ? objFieldMap.get(fieldName).getDescribe().getReferenceTo()[0].getDescribe().getName() : '';
            
            result.isCheckbox = result.type == 'BOOLEAN' ? true : false;
            result.isCurrency = result.type == 'CURRENCY' ? true : false;
            result.isDouble   = result.type == 'Double' ? true : false;
            result.isRelated  = result.type == 'REFERENCE' ? true : false;
            result.isPicklist = result.type == 'PICKLIST' ? true : false;
            result.isDate     = result.type == 'DATE' ? true : false;
            result.isDateTime = result.type == 'DATETIME' ? true : false;

            result.isText = !result.isCheckbox && !result.isCurrency && !result.isDouble 
                            && !result.isRelated && !result.isPicklist && !result.isDate
                            && !result.isDateTime ? true : false;
            result.useCustomInput = result.isText || result.isDouble || result.isCurrency ? true : false;

            fieldMap.put(objFieldMap.get(fieldName).getDescribe().getName(), result);
        }
        return fieldMap;
    }

    @AuraEnabled
    public static List<SObject> getRecord(String objectApiName, List<String> fields, String recordId){
        String query = 'SELECT '+String.join(fields, ', ')+' FROM '+objectApiName+' WHERE Id =:recordId';
        SObject [] r = Database.query(query);
        return r;
    }

    public class fieldResult{
       
        @AuraEnabled public String objectApiName;
        @AuraEnabled public String fieldApiName;
        @AuraEnabled public String label;
        @AuraEnabled public Boolean required;
        @AuraEnabled public Boolean accessible;
        @AuraEnabled public String type;
        @AuraEnabled public Boolean useCustomInput;
        @AuraEnabled public String relatedTo;

        @AuraEnabled public Boolean isCheckbox;
        @AuraEnabled public Boolean isCurrency;
        @AuraEnabled public Boolean isDouble;
        @AuraEnabled public Boolean isRelated;
        @AuraEnabled public Boolean isPicklist;
        @AuraEnabled public Boolean isText;
        @AuraEnabled public Boolean isDate;
        @AuraEnabled public Boolean isDateTime;
        
        public fieldResult(){}
    }

    @AuraEnabled(cacheable=true)
    public static recordTypeWrapper getRecordTypes(String sObjectName) {
        List<Id> rtIds = new List<Id>();
        Map<Id,RecordTypeInfo> rtInfoMap = new Map<Id,RecordTypeInfo>();

        schema.sObjectType sObjType = ((SObject) Type.forName(sObjectName).newInstance()).getSObjectType();

        for (RecordTypeInfo rti: sObjType.getDescribe().getRecordTypeInfos()) {
            if (rti.isAvailable() && rti.isActive()) {
                rtInfoMap.put(rti.recordTypeId, rti);
            }
        }

        //initialize variables for wrapper
        RecordType defaultRT = new RecordType();
        List<RecordType> rTypes = new List<RecordType>();

        for(RecordType rt : [SELECT Id, IsActive, Name, Description FROM RecordType WHERE sObjectType =: sObjectName]){
            if(rtInfoMap.get(rt.Id) != null && rtInfoMap.get(rt.Id).isDefaultRecordTypeMapping()){
                defaultRT = rt;  
                rTypes.add(rt);     
            } else if(rtInfoMap.get(rt.Id) != null) {
                rTypes.add(rt);
            }
        }
        return new recordTypeWrapper(defaultRT,rTypes);
    }

    public class recordTypeWrapper{
       @AuraEnabled public RecordType defaultType {get;set;}
       @AuraEnabled Public List<RecordType> types {get;set;}

        public recordTypeWrapper(RecordType defaultType, List<RecordType> types){
            this.defaultType = defaultType;
            this.types = types;
        }
    }

    /**
     * getAllRequiredFields 
     * @param  obj        
     * @param  layoutName 
     * @return Map < String, Boolean >
     * @description
     */ 
    public static Map < String, Boolean > getAllRequiredFields(Schema.DescribeSObjectResult obj, String layoutName) 
    {
        Map < String, Boolean > returnMap = new Map < String, Boolean > ();
       
        if (layoutName != null) {
            Map < String, Boolean > requiredLayoutFields = getLayoutRequiredFields(layoutName);
            if (requiredLayoutFields != null) {
                for (String fieldName: requiredLayoutFields.keySet()) {
                    if (returnMap.get(fieldName) == null) {
                        returnMap.put(fieldName, requiredLayoutFields.get(fieldName));
                    }
                }
            }
        }
        if (obj != null) {
            Map < String, Boolean > requiredObjectFields = getObjectRequiredFields(obj);
            if (requiredObjectFields != null) {
                 for (String fieldName: requiredObjectFields.keySet()) {
                    if (returnMap.get(fieldName) == null) {
                        returnMap.put(fieldName, requiredObjectFields.get(fieldName));
                    }
                }
            }
        }
        for(string field: returnMap.keySet()){
        }
        return returnMap;
    }
    
    /**
     * getLayoutRequiredFields 
     * @param  layoutName 
     * @return  Map < String, Boolean > 
     * @description        
     */ 
    public static Map < String, Boolean > getLayoutRequiredFields(String layoutName) 
    {

        List < Metadata.Metadata > layouts =
            Metadata.Operations.retrieve(Metadata.MetadataType.Layout,
                new List < String > {
                    layoutName
                });
        Map < String, Boolean > requiredLayoutFieldMap = new Map < String, Boolean > ();
        if(layouts.size() > 0){
            Metadata.Layout layoutMd = (Metadata.Layout) layouts.get(0);
            List < Metadata.LayoutSection > layoutSections = layoutMd.layoutSections;

            for (Metadata.LayoutSection section: layoutSections) {
                List < Metadata.layoutColumn > layoutColumns = section.layoutColumns;
                for (MetaData.LayoutColumn column: layoutColumns) {
                    if (column.layoutItems != null) {
                        for (MetaData.layoutItem item: column.layoutItems) {
                            if (String.valueOf(item.behavior) == 'Required') {
                                //forcefully adding namespace to avoid potential issues
                                String fieldName = String.valueOf(item.field).toLowerCase().replace('dealer__', '');
                                fieldName = 'dealer__'+fieldName;
                                requiredLayoutFieldMap.put(fieldName, true);
                            } 
                        }
                    }
                }
            }
        }
        
        return requiredLayoutFieldMap;
    }
    
    /**
     * getObjectRequiredFields 
     * @param  obj 
     * @return  Map < String, Boolean >
     */
    public static Map < String, Boolean > getObjectRequiredFields(Schema.DescribeSObjectResult obj) 
    {

        Map < String, Boolean > requiredFields = new Map < String, Boolean > ();
        Map < String, Schema.SObjectField > fieldMap = obj.fields.getMap();
        for (String field: fieldMap.keySet()) {
          
        	//forcefully adding namespace to avoid potential issues
            String fieldName = String.valueOf(fieldMap.get(field)).toLowerCase().replace('dealer__', '');
            fieldName = 'dealer__'+fieldName;

            Boolean required = fieldMap.get(field).getDescribe().isNillable() == true || fieldMap.get(field).getDescribe().calculated == true ? false : true;
            if(required == true )  requiredFields.put(fieldName, required);
        }
        return requiredFields;
    }

    /**
     * getSobjectPicklistValues 
     * @param  sObecjtName 
     * @param  fieldName   
     * @return  List<String> 
     * @description       
     */
    public static List<String> getSobjectPicklistValues(String sObecjtName, String fieldName)
    {
        List<String> lstPickvals=new List<String>();
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(sObecjtName);

        Sobject Object_name = targetType.newSObject();
        Schema.sObjectType sobject_type = Object_name.getSObjectType();
        Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe();
        Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap();

        List<Schema.PicklistEntry> pick_list_values = field_map.get(fieldName).getDescribe().getPickListValues();
        for (Schema.PicklistEntry a : pick_list_values) { 
            lstPickvals.add(a.getValue());
        }

        return lstPickvals;
   }    

    @AuraEnabled  (cacheable=true)
    public static Map < String, String > getFieldLabels(String objectName) {
        
        Map < String, String > fieldLabels = new Map < String, String > ();
        
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType objschema = schemaMap.get(objectName);
        Map<String, Schema.SObjectField> fieldMap = objschema.getDescribe().fields.getMap();
        
        
        for (String fieldName: fieldMap.keySet()) {
        	
            fieldLabels.put(fieldName, fieldMap.get(fieldName).getDescribe().getLabel());
        }
        return fieldLabels;
    }

    public static String getAssignedPageLayoutAPIName(String objectName){
        String customObjectId = objectId(objectName);
        String query = 'SELECT Layout.Name,Layout.TableEnumOrId,Layout.FullName FROM ProfileLayout WHERE ProfileId = \'' + UserInfo.getProfileId() + '\' AND Layout.TableEnumOrId = \''+customObjectId+'\' ';
        String body = getHttpResponseBody(query);
        return getHttpResponseBody(query).subStringBetween('"FullName":"','"');
    }
    public static String objectId(String objectName){
        String query = 'SELECT Id FROM CustomObject WHERE DeveloperName = \'' + objectName + '\'';
        String body = getHttpResponseBody(query);
        return body.subStringBetween('"Id":"','"');
    }
    public static String getObjectTabUrl(String objectName){
        List<Schema.DescribeTabSetResult> tabSetDesc = Schema.describeTabs();
        List<Schema.DescribeTabResult> tabDesc = new List<Schema.DescribeTabResult>();
        List<Schema.DescribeIconResult> iconDesc = new List<Schema.DescribeIconResult>();

        Schema.SObjectType objDescribe = Schema.getGlobalDescribe().get(objectName);
        String objLabel = (String)objDescribe.getDescribe().getLabel();

        for(Schema.DescribeTabSetResult tsr : tabSetDesc) {
        tabDesc.addAll(tsr.getTabs());
        }
        Map<String,Schema.DescribeTabResult> tabMap = new Map<String,Schema.DescribeTabResult>();
        for(Schema.DescribeTabResult tr : tabDesc) {
            if( objectName == tr.getSobjectName() ) {
                if(tabMap.get(tr.getSobjectName()) == null)
                    tabMap.put(tr.getSobjectName(),tr);
            }
        }
        string URL = null;
        if(tabMap.get(objectName) != null){
            URL = tabMap.get(objectName).getIcons()[0].getURL();
        }
        // return null;
        return URL;
    }
    public static String getHttpResponseBody(String query){
        String endpoint = Url.getSalesforceBaseUrl().toExternalForm()+'/services/data/v41.0/tooling/query/?q='+ EncodingUtil.urlEncode(query, 'UTF-8');
        Http h = new Http();
        HttpRequest hr = new HttpRequest();
        hr.setHeader('Authorization', 'Bearer ' +  UserInfo.getSessionId());
        hr.setEndpoint(endPoint);
        hr.setMethod('GET');
        HttpResponse response = h.send(hr);
        return response.getBody();
    }

    public class MyCallback implements Metadata.DeployCallback {
        public void handleResult(Metadata.DeployResult result,
                                Metadata.DeployCallbackContext context) {
            if (result.status == Metadata.DeployStatus.Succeeded) {
                // Deployment was successful
            } else {
                // Deployment was not successful
            }
        }
    }

    /**
    * getConfigValue
    * @description Checks values of a given config and return subscriber entered value if one exists otherwise returns package default. Will throw error if no config is found.
    * @param  configName DeveloperName of the config to get a value for.
    * @return String - Config value for the given config, null if it is not enabled.
    */
    public static String getConfigValue(String configName)
    {
        if(configMap == null){
            configMap = new Map<String, DMSConfig__mdt>();
            List<DMSConfig__mdt> configList = [SELECT Id, DeveloperName, Value__c, DefaultValue__c, Enabled__c FROM DMSConfig__mdt];

            for(DMSConfig__mdt config : configList){
                configMap.put(config.DeveloperName, config);
            }
        }

        if(configMap.get(configName) == null){
            throw new DealerMetadataException('Configuration not found for ' +configName);
        }

        //Priority goes to DefaultValue__c which is the subscriber custom value, if none use packaged Value__c
        if(configMap.get(configName).Enabled__c){
            return configMap.get(configName).DefaultValue__c != null ? configMap.get(configName).DefaultValue__c : configMap.get(configName).Value__c;
        }

        return null;


    }

    public class DMSConfigValue{
		public boolean enabled;
		public String value;
		public DMSConfigValue(String configName){
            DMSConfig__mdt c = dmsConfiguration().get(configName);
            if(c == null){
                //throw error
                this.enabled = false;
                this.value = '';
            } else {
                this.enabled = c.Enabled__c;
                this.value = c.DefaultValue__c != null ? c.DefaultValue__c : c.Value__c;
            }
		}
	}

	private static Map<String, DMSConfig__mdt> dmsConfiguration()
	{
		Map<String, DMSConfig__mdt> dmsConfiguration = new Map<String, DMSConfig__mdt>();
        for(DMSConfig__mdt dmsC : [SELECT Description__c, Enabled__c, DefaultValue__c, QualifiedApiName, Value__c,
                                            NamespacePrefix, DeveloperName, Id 
                                        FROM DMSConfig__mdt]) {
            

            dmsConfiguration.put(dmsC.DeveloperName, dmsC);

		}
		return dmsConfiguration;
    }
    

    public class DealerMetadataException extends Exception{}
}