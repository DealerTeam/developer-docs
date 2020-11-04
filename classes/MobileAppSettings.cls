/**
 * MobileAppSettings
 * @description
 */
public with sharing class MobileAppSettings {
    
    /**
     * @description
     */
    public String ProfileId{get;set;}
    
    /**
     * Schema.SObjectField> 
     * @description
     */ 
    public Map<String, Schema.SObjectField> fieldMap = new Map<String, Schema.SObjectField>();
    
    /**
     * List<String> 
     * @description
     */
    List<String> ObjectList = new List<String>();
    
    /**
     * List<dealer__MobileAppSettings__c> 
     * @description
     */
    List<dealer__MobileAppSettings__c> MobileAppSettingsList = new List<dealer__MobileAppSettings__c>();
    
    /**
     * MobileAppSettings 
     * @description
     */
    public MobileAppSettings()
    {
        //ObjectList.add('Deal__c');
        //ObjectList.add('Sales_Up__c');
        //ObjectList.add('Contact');
        ObjectList.add('Task');
        //ObjectList.add('Sales_Appointment__c');
    }
    
    /**
     * Cancel 
     * @return PageReference
     * @description
     */
    public PageReference Cancel()
    {
        Schema.DescribeSObjectResult result = MobileAppSettings__c.sObjectType.getDescribe();
        PageReference cancelPage = New PageReference('/' + result.getKeyPrefix() + '/o');
        cancelPage.setRedirect(true); 
        return cancelPage;
    }
    
    /**
     * Submit 
     * @return void
     * @description
     */
    public void Submit()
    {
        for(Integer i=0;i<ObjectList.size();i++){
            fieldMap = Schema.getGlobalDescribe().get(ObjectList[i]).getDescribe().fields.getMap();
            List<SelectOption> fieldsName =new List<SelectOption>();
            for(Schema.SObjectField sfield : fieldMap.Values())
            {
                MobileAppSettings__c MobileAppSetting = new MobileAppSettings__c();
                schema.describefieldresult dfield = sfield.getDescribe();
                MobileAppSetting.Object_name__c = ObjectList[i];
                MobileAppSetting.Field_Name__c = dfield.getName();
                MobileAppSetting.Field_Label__c = dfield.getLabel();
                MobileAppSetting.Profile_Id__c = ProfileId;
                MobileAppSettingsList.add(MobileAppSetting);
            }
        }
        if(MobileAppSettingsList.size() > 0){
            insert MobileAppSettingsList;
            
        }
        Cancel();
    }   
}