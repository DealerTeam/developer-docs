public with sharing class ExternalMediaController {
    
    @AuraEnabled(cacheable=true)
    public static string getMedia(String recordId){
        List<ExternalMedia__c> media = new List<ExternalMedia__c>();
        for(ExternalMedia__c m : [SELECT Id, Name, FileName__c, Appraisal__c, ThumbnailUUID__c, UUID__c,  URL__c FROM ExternalMedia__c WHERE Appraisal__c =: recordId Order By CreatedDate]){
            media.add(m);
        }
        return JSON.serialize(media);
    }
    @AuraEnabled
    public static string uploadMedia(String base64, Boolean publiclyAccessible){

        //We will want to add other file type functionality in the future
        String baseUrl = (!Utility.isSandbox()) ? Utility.DMSConfiguration('DMSSyncEndpoint') : Utility.DMSConfiguration('DMSSyncEndpointSandbox');
        
        String url = baseUrl+'/inventorymedia/requests/storemedia';
        String contentType = base64.substringbetween('data:',';');
        
        base64 = base64.remove('data:'+contentType+';base64,');
        
        String body = '{"fileName": "'+utility.generateGuid()+'", "contentType": "'+contentType+'", "base64": "'+base64+'", "public":'+publiclyAccessible+'"}';
    	return EnterpriseControllerAPI.CallOut(url, body);
    }

    @AuraEnabled
    public static string saveMedia(String recordId, String response, String fileName){
        s3Response res = (s3Response)Json.deserialize(response,s3Response.class);
        ExternalMedia__c em = new ExternalMedia__c(Appraisal__c = recordId, UUID__c = res.image.Key != null ? res.image.Key : res.file.Key, ThumbnailUUID__c = res.thumb.Key == null ? res.file.Key : res.thumb.Key);
        if(fileName != null) em.FileName__c = fileName;
        insert em;
        return JSON.serialize(em);
    }

    public class s3Response{
        @AuraEnabled
        public s3File image;
        @AuraEnabled
        public s3File thumb;
        @AuraEnabled
        public s3File file;
    }

    public class s3File{
        @AuraEnabled
        public String ETag;
        @AuraEnabled
        public String ServerSideEncryption;
        @AuraEnabled
        public String VersionId;
        @AuraEnabled
        public String Location;
        @AuraEnabled
        public String Key;
        @AuraEnabled
        public String Bucket;
    }    

    @AuraEnabled
    public static string retrieveMedia(String fileName){
        String url = 'https://hemi-sandbox.herokuapp.com/s3/retrieve';
        String body = '{"key":"'+fileName+'"}';
    	return EnterpriseControllerAPI.CallOut(url, body);
    }
    @AuraEnabled
    public static string deleteMedia(String mediaId){
        //need to delete from AWS server
        delete [select id from ExternalMedia__c WHERE Id =: mediaId];
        return null;
    }
}