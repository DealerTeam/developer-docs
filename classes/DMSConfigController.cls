/**
 * DMSConfigController
 * @description
 */
public with sharing class DMSConfigController {
    
    /**
     * @description
     */
    public class DMSWrapper {
        @AuraEnabled
        public dealer__DMSApplication__mdt dmsApp {get;set;}
        @AuraEnabled
        public List<dealer__DMSFeature__mdt> dmsFeature {get;set;}
        
        public DMSWrapper(){
            dmsFeature = new List<dealer__DMSFeature__mdt>();
        }
        
    }

    /**
     * getDMSApplications 
     * @return List<DMSWrapper>
     * @description
     */ 
    @AuraEnabled(cacheable=true)
    public static List<DMSWrapper> getDMSApplications()
    {
        List<dealer__DMSApplication__mdt> dmsApps = [SELECT Id, DeveloperName, MasterLabel FROM dealer__DMSApplication__mdt ORDER BY MasterLabel ASC];
        List<dealer__DMSFeature__mdt> dmsFeatures = [SELECT Id, DeveloperName, MasterLabel, dealer__DMSApplication__c FROM dealer__DMSFeature__mdt ORDER BY MasterLabel ASC];

        List<DMSWrapper> returnWrapper = new List<DMSWrapper>();
        for(dealer__DMSApplication__mdt app : dmsApps){
            DMSWrapper wrap = new DMSWrapper();
            wrap.dmsApp = app;
            for(dealer__DMSFeature__mdt feature : dmsFeatures){
                if(feature.dealer__DMSApplication__c == app.Id){
                    wrap.dmsFeature.add(feature);
                }
            }
            if(wrap.dmsApp != null){
                returnWrapper.add(wrap);
            }
        }
        return returnWrapper;
    }

    /**
     * getDMSFeature 
     * @param  featureId 
     * @return dealer__DMSFeature__mdt
     * @description
     */ 
    @AuraEnabled
    public static dealer__DMSFeature__mdt getDMSFeature(Id featureId)
    {
        dealer__DMSFeature__mdt dmsFeature = [SELECT Id, DeveloperName, MasterLabel FROM dealer__DMSFeature__mdt WHERE Id =: featureID LIMIT 1];
        return dmsFeature;
    }

    /**
     * getDMSSettings 
     * @param  featureId 
     * @return List<dealer__DMSConfig__mdt>
     * @description
     */
    @AuraEnabled
    public static List<dealer__DMSConfig__mdt> getDMSSettings(Id featureId)
    {
        List<dealer__DMSConfig__mdt> dmsConfigs = new List<dealer__DMSConfig__mdt>();
        if(featureId != null){
            dmsConfigs = [SELECT Id, dealer__Enabled__c, DeveloperName, MasterLabel, dealer__Value__c, dealer__DefaultValue__c, dealer__Description__c, dealer__HelpURL__c, dealer__ConfigurationApplication__c FROM dealer__DMSConfig__mdt WHERE dealer__DMSFeature__c =: featureId];
        }

        return dmsConfigs;
    }

    /**
     * updateSettings 
     * @param  setting 
     * @return void
     * @description
     */
    @AuraEnabled
    public static void updateSettings(dealer__DMSConfig__mdt setting)
    {
        system.debug(setting);
        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
        Metadata.CustomMetadata customMetadata = new Metadata.CustomMetadata();

            
        if(setting.dealer__Enabled__c != null || setting.dealer__DefaultValue__c != null){
            
            dealer__DMSConfig__mdt existingMDT = [SELECT Id, QualifiedApiName, MasterLabel FROM dealer__DMSConfig__mdt WHERE Id =: setting.Id];
             
            customMetadata.fullName = 'dealer__DMSConfig.' + existingMDT.QualifiedApiName;
            customMetadata.label = existingMDT.MasterLabel;

            Metadata.CustomMetadataValue enabled = new Metadata.CustomMetadataValue();
            enabled.field = 'dealer__Enabled__c';

            Metadata.CustomMetadataValue defaultVal = new Metadata.CustomMetadataValue();
            defaultVal.field = 'dealer__DefaultValue__c';
            
            if(setting.dealer__Enabled__c != null){
                    system.debug(setting.dealer__Enabled__c);
                    enabled.value = setting.dealer__Enabled__c;
                    customMetadata.values.add(enabled);
                }
            if(setting.dealer__DefaultValue__c != null){
                system.debug(setting.dealer__DefaultValue__c);
                defaultVal.value = setting.dealer__DefaultValue__c;
                customMetadata.values.add(defaultVal);
            }

            
            mdContainer.addMetadata(customMetadata);
            dealerMetadata.MyCallback callback = new dealerMetadata.MyCallback();
            if(!Test.isRunningTest()){
                Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, callback);
            }
        }    
    }
}