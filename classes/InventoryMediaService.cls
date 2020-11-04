@RestResource(urlMapping='/VehicleInventory/Media/*')
global with sharing class InventoryMediaService {
 
    @HttpPost
    global static void storeMedia(List<Image> images){

        // Instance of Class
        String serverResult = '';
        InventoryMediaService ims = new InventoryMediaService();

        // Stock# Or parent record ID
        RestRequest req = RestContext.request;

        // Preflight Images
        for(Image i : images) {
            if(i.imageUrl==null||i.imageUrl=='') {
                ims.errorResponse('Invalid Request, imageUrl is required');
            }
        }   

        String vehRequested = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Vehicle_Inventory__c vehicle = new Vehicle_Inventory__c();

        //Ensure a stock number was provided
        if(vehRequested==null||vehRequested=='') {
            ims.errorResponse('Invalid request, Stock# is required');
        }else{  
            //Ensure a Vehicle Inventory record exists for the stock number provided
            try{
                vehicle = [SELECT Id FROM Vehicle_Inventory__c WHERE Stock_Number__c =: vehRequested];
            } catch(QueryException e){
                ims.errorResponse('Stock number provided does not match a Vehicle Inventory record');
                throw new EnterpriseControllerAPI.APIException('Stock number provided does not match a Vehicle Inventory record');
            }
            
            try {
                serverResult = InventoryMediaAPI.uploadInventoryMedia(JSON.serialize(images));
                InventoryMediaAPI.ResponseWrapper response = (InventoryMediaAPI.ResponseWrapper)JSON.deserialize(serverResult,InventoryMediaAPI.ResponseWrapper.class);
            
                if(response.Results.size() > 0){
                   
                    List<Image> newImages = new List<Image>();
                    for(Inventory_Images__c ii : InventoryMediaAPI.createInventoryMedia(vehicle, response.Results)){
                        Image i = new Image();
                        i.imageUrl = ii.Image_URL__c;
                        i.imageMeta = ii;
                        newImages.add(i); 
                    }
                    sendResponse(new uploadResults(newImages, response));
                }

                if(response.Errors.size() > 0){
                    ims.errorResponse('The following images failed to process: '+String.join(response.Errors,','));
                }

            } Catch(JSONException e){
                throw new JSONException(e.getMessage());
            }Catch(Exception e) {
                throw new EnterpriseControllerAPI.APIException(e.getmessage());
            }
        }
    } 

    /**
     * getMedia - Returns the associated images with a specific vehicle inventory record
     *
     */
    @HttpGet
    global static List<Image> getImages(){
        
        InventoryMediaService ims = new InventoryMediaService();
        RestRequest req = RestContext.request;
        
        String vehRequested = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        if(vehRequested==null||vehRequested=='') {
            ims.errorResponse('Invalid request, Stock# is required');
            return null;
        } else {
            return InventoryMediaApi.getInventoryMedia(vehRequested);
        }
    }

    global class Image {
        public Inventory_Images__c imageMeta { get; set; }
        public String imageData { get; set; }
        public String imageUrl { get; set; }
    }  

    global class UploadResults{
        public List<Image> images {get; set;}
        public InventoryMediaAPI.ResponseWrapper uploadResults {get;set;}

        public UploadResults(List<Image> images, InventoryMediaAPI.ResponseWrapper uploadResults ){
            this.images = images;
            this.uploadResults = uploadResults;
        }
    }

    private static void sendResponse(UploadResults response){
        RestContext.response.addHeader('Content-Type', 'application/json');
        RestContext.response.responseBody = Blob.valueOf(JSON.serializePretty(response));
        RestContext.response.statusCode = 200;
    }

    private void ErrorResponse(String errorMessage){
        RestContext.response.addHeader('Content-Type', 'application/json');
        RestContext.response.responseBody = Blob.valueOf('{ "error" : "' + errorMessage + '" }');
        RestContext.response.statusCode = 500;
    }

}