public with sharing class InventoryMediaAPI {
    public InventoryMediaAPI() {}
    
    public static string uploadInventoryMedia(String imageBody){
        String orgId = UserInfo.getOrganizationId();
        Boolean isSandbox = Utility.isSandbox();
        
        String baseUrl = (!isSandbox) ? Utility.DMSConfiguration('DMSSyncEndpoint') : Utility.DMSConfiguration('DMSSyncEndpointSandbox');
        String url = baseUrl+'/inventorymedia/requests/storemedia';

        return EnterpriseControllerAPI.CallOut(url, JSON.serialize(new UploadWrapper(orgId, isSandbox, imageBody)), 30000);
        
    }

    public static List<Inventory_Images__c> createInventoryMedia(Vehicle_Inventory__c vehicle, List<File> uploadResults){
        // loop upload Results , generate inventory media records as applicable
        List<Inventory_Images__c> images = new List<Inventory_Images__c>();
        for(File result : uploadResults){
            Inventory_Images__c imageMeta = result.imageMeta != null ? result.imageMeta : new Inventory_Images__c();
            images.add(new Inventory_Images__c(
                Vehicle_Inventory__c = vehicle.Id,
                Publish__c = imageMeta.Publish__c != null ? imageMeta.Publish__c : true,
                AcquisitionSource__c = imageMeta.AcquisitionSource__c != null ? imageMeta.AcquisitionSource__c : '',
                Image_URL__c = result.Location,
                PrimaryDisplayURL__c = result.Location,
                Thumbnail_URL__c = result.ThumbLocation,
                Image_Name__c = result.Key,
                UUID__c = result.Key.substringBefore('.'),
                Width__c = result.MainWidth,
                Height__c = result.MainHeight,
                MIME_Type__c = result.Mime,
                CDNURL__c = 'https://invcdn.dealerteam.com/'+result.Key,
                CDNThumbnailURL__c = 'https://invcdn.dealerteam.com/'+result.Key.substringBefore('.')+'_thumb.'+result.Key.substringAfter('.')
            ));
        }
        insert images;
        return images;
    }

    public static List<InventoryMediaService.Image> getInventoryMedia(String stockNumber){
        List<InventoryMediaService.Image> images = new List<InventoryMediaService.Image>();

        for(Inventory_Images__c ii : [SELECT Vehicle_Inventory__c, Vehicle_Inventory__r.Stock_Number__c, CDNThumbnailURL__c, CDNURL__c, 
                                            Height__c, Image_Name__c, Image_URL__c, MIME_Type__c, 
                                            Photographer__c, PrimaryDisplayFilename__c, PrimaryDisplayURL__c, 
                                            Publish__c, Sequence_Number__c, Thumbnail_URL__c, 
                                            Thumbnail__c, UUID__c, Width__c, Name, Id, CreatedById, CreatedDate, 
                                            LastModifiedDate, LastModifiedById 
                                        FROM Inventory_Images__c 
                                        WHERE Vehicle_Inventory__c =:stockNumber
                                        OR Vehicle_Inventory__r.Stock_Number__c =:stockNumber
                                        ORDER BY Sequence_Number__c ASC]) {


            InventoryMediaService.Image i = new InventoryMediaService.Image();
            i.imageUrl = ii.Image_URL__c;
            i.imageMeta = ii;
            images.add(i);
        }

        return images;
    }

    /**
     * processExternalMediaUpload makes call to middleware endpoint to retrieve external csv with image urls to upload. Can be called from schedulable.
     */
    @future(callout=true)
    public static void processExternalMediaUpload()
    {

        //get endpoint
        String calloutUrl = !Utility.isSandbox() ? Utility.DMSConfiguration('DMSSyncEndpoint') : Utility.DMSConfiguration('DMSSyncEndpointSandbox');
        //attach endpoint
        calloutUrl += '/media/upload';
        //get instance url
        String instanceUrl = URL.getSalesforceBaseUrl().toExternalForm();
        //get session id
        String sessionId = UserInfo.getSessionId();
        InventoryMediaAPI.calloutWrapper reqWrapper = new InventoryMediaAPI.calloutWrapper();
        reqWrapper.url = instanceUrl;
        reqWrapper.sessionId = sessionId;

        String resp = Test.isRunningTest() ? '' : EnterpriseControllerAPI.CallOut(calloutUrl, JSON.serialize(reqWrapper));

        if(Test.isRunningTest()) {
            return;  // Need to stub out mock framework
        }
        

    }

    public class calloutWrapper{
        String sessionId;
        String url;
    }

    public class UploadWrapper{
        String orgId;
        Boolean isSandbox;
        String imageBody;

        Decimal maxWidth;
        Decimal thumbWidth;

        public UploadWrapper(String orgId, Boolean isSandbox, String imageBody){

            this.orgId = orgId;
            this.isSandbox = isSandbox;
            this.imageBody = imageBody;

            CRMSettings__c crm = CRMSettings__c.getOrgDefaults();
            this.maxWidth = crm.Inventory_Media_Max_Size__c != null && crm.Inventory_Media_Max_Size__c > 0 ? crm.Inventory_Media_Max_Size__c : 2000;
            this.thumbWidth = crm.Inventory_Media_Thumbnail_Width__c != null && crm.Inventory_Media_Thumbnail_Width__c > 0 ? crm.Inventory_Media_Thumbnail_Width__c : 150;

        }
    }

    public class ResponseWrapper {
        public List<File> Results;
        public List<String> Errors;
    }

    public class File{
        public Inventory_Images__c imageMeta;
        public String ETag;
        public String VersionId;
        public String Location;
        public String Key;
        public Decimal MainWidth;
        public Decimal MainHeight;
        public String Mime;
        public String Bucket; 
        public String ThumbLocation;
        public Decimal ThumbWidth;
        public Decimal ThumbHeight;
    }  
}