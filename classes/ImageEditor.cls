public class ImageEditor{
    
    public Boolean userHasAccess {get; set;}
    public Boolean userCanPublish {get; set;}

    public Vehicle_Inventory__c vehicle;
    public Id recordId;

    public CRMSettings__c crm {get;set;}
    public Decimal thumbWidth {get;set;}


    public List<media> mList {get; set;}

    public ImageEditor() {
        recordId = ApexPages.currentPage().getParameters().get('id');

        // Determine is user has acess to image objects
       userHasAccess = Schema.sObjectType.dealer__Inventory_Images__c.isUpdateable();
       userCanPublish = Schema.sObjectType.dealer__Inventory_Images__c.fields.dealer__Publish__c.isUpdateable();
       
        // Get org default settings, instantiate a new object if none is returned.
        // crm = CRMSettings__c.getOrgDefaults();
        
        List<CRMSettings__c> crmSettings = [SELECT Id, IsDeleted, Name, SetupOwnerId, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, Auto_Link_Buyer_Record__c, Complete_Sales_Steps_upon_Sale__c, Default_SalesPerson1__c, Desk_Log_Deal_Status__c, Desk_Log_Deal_Types__c, DisablePersonAccounts__c, Duplicate_Check_Statuses__c, Email_Inbound_Activities_Remain_Open__c, Enable_Price_Change_Alert__c, ILM_Duplicate_Time_Period__c, ILM_No_Duplicates__c, Inv_Match_Alert__c, InventoryMediaDisplayHeight__c, InventoryMediaDisplayWidth__c, Inventory_Media_Crop_Ratio__c, Inventory_Media_Force_Crop__c, Inventory_Media_Max_Size__c, Inventory_Media_Publish_Default__c, Inventory_Media_Thumbnail_Height__c, Inventory_Media_Thumbnail_Width__c, MPI_Email_Advisor__c, MPI_Generate_PDF_Status__c, MPI_Print_Footer__c, MPI_Print_Link_Pre_Printed_Form__c, MPI_Print_Preview_Full_Color__c, MPI_Upsell_OpCode__c, MPI_ePrint__c, Native_or_Non_Native_Dupe_Catching__c, PreventDuplicateADF__c, Record_Owner_Match_Salesperson__c, Rewards_Discount_Code__c, Rewards_Expiration_Months__c, Rewards_FreeService_OpCodes__c, Rewards_Free_Service_Interval__c, Rewards_Number_Length__c, Rewards_OilChange_OpCodes__c, Rewards_Percentage__c, Rewards_Program_Enabled__c, Sales_Up_Record_Prefix__c, UrbanScience_Active__c, Vehicle_Location_Match_User_Location__c FROM CRMSettings__c LIMIT 1];
        crm = crmSettings.size() == 1 ? crmSettings[0] : new CRMSettings__c();
       
        if (crm.Inventory_Media_Max_Size__c == null) {
            crm.Inventory_Media_Max_Size__c = 2000;
        }
        if (crm.Inventory_Media_Publish_Default__c == null) {
            crm.Inventory_Media_Publish_Default__c = true;
        }

        if(crm.InventoryMediaDisplayWidth__c==null) {
            crm.InventoryMediaDisplayWidth__c=750;
        }
        if(crm.Inventory_Media_Thumbnail_Width__c == null){
            crm.Inventory_Media_Thumbnail_Width__c=400;
        }

    }
    
    public class media {
        public Id id;
        public Id imgId;
        public String uuid;
        public Decimal sequence;
        public Decimal order;
        public Decimal height;
        public Decimal width;
        public Boolean pubstat;
        public String mimetype;
        public String thumbnailUrl;
        public String name;
        public String url;
        public String primarydisplay;
        public String primarydisplayURL;
        
        public media(Inventory_Images__c i) { 

            this.uuid     =   i.UUID__c;
            this.id           =   i.Vehicle_Inventory__c;
            this.imgId        =   i.id;
            this.thumbnailUrl =   i.Thumbnail_URL__c;
            this.name         =   i.Image_Name__c;
            this.order        =   i.Sequence_Number__c;
            this.pubstat      =   i.Publish__c;
            this.url          =   i.Image_URL__c;
            this.primarydisplayURL = i.PrimaryDisplayURL__c;
            this.primarydisplay = i.PrimaryDisplayFilename__c;
        }

    }

    public PageReference retrieveMediaList() {
        dealer__Inventory_Images__c[] img = [SELECT Id, Name, Height__c, Width__c, Image_URL__c, MIME_Type__c, Photographer__c,
                Sequence_Number__c , Thumbnail__c , Thumbnail_URL__c ,UUID__c ,Vehicle_Inventory__c,
                Publish__c, Image_Name__c, PrimaryDisplayURL__c, PrimaryDisplayFilename__c
                FROM Inventory_Images__c 
                WHERE Vehicle_Inventory__c =:recordId 
                ORDER BY Sequence_Number__c asc
                LIMIT 1000];

        List<dealer__Inventory_Images__c> upImg = new List<dealer__Inventory_Images__c>();

        List<media> m = new List<media>();
        for(dealer__Inventory_Images__c im : img) {

            // Create a UUID if one doesnt exist
            if( im.dealer__UUID__c == null || im.dealer__UUID__c == '' ) {
                im.dealer__UUID__c = NewGuid();
                upImg.add( im ); // Add image to list to update later.
            }

            m.add( new media(im) );

        }

        // If images existed without UUID
        if ( !upImg.isEmpty() ) {
            update upImg;
        }  

        mList = m;

        return null;
    }

    /*
     *  Alwasy returned as JSON String
     * 
    */
    public String getvehicleImages() {
          
        return JSON.serialize( mList );

    }

    public dealer__Vehicle_Inventory__c getVehicle() {
        dealer__Vehicle_Inventory__c[] vehicles = [Select Id, Name, dealer__Interior_Color__c, dealer__Exterior_Color__c, dealer__Engine_Description__c, dealer__Transmission_Type__c from dealer__Vehicle_Inventory__c where Id =:recordId limit 1];
        if(vehicles.size()==1) {
            vehicle=vehicles[0];
        } else {
            vehicle=new dealer__Vehicle_Inventory__c();
        }
        
        return vehicle;
    }

    /*
     * Vehicle Details as prepared by GET Variables passedd
     * 
     */
    @RemoteAction
    public static boolean deleteInventoryMedia(String uuid) {
        dealer__Inventory_Images__c[] ii = [Select Id from dealer__Inventory_Images__c where dealer__UUID__c =:uuid limit 1];
        if(ii.size()==1) {
            delete ii;
            return true;
        } else {
            return false;
        }
    }
    
    /**
    * 2017-03-07    |Jarrett Kuljis     |W-000966
    * Add support for new fields to track the CND URL, default Cache Header of 7 Days also set on all records.
    */
    @RemoteAction
    public static Map<String,Object> addInventoryMedia(String jsonItem) {
        
        //
        Map<String,Object> returnObj = new Map<String,Object>();

        media m = (media)JSON.deserialize(jsonItem, media.class);
        Inventory_Images__c imgObject = new Inventory_Images__c(
            Vehicle_Inventory__c=m.id,
            UUID__c=m.uuid,
            Thumbnail_URL__c='https://s3.amazonaws.com/vehicle-images/'+m.thumbnailUrl,
            Sequence_Number__c=m.order,
            Publish__c=m.pubstat,
            Height__c=m.height,
            Width__c=m.width,
            MIME_Type__c=m.mimetype,
            Image_URL__c='https://s3.amazonaws.com/vehicle-images/'+m.name,
            Image_Name__c=m.name,
            CDNURL__c='https://invcdn.dealerteam.com/'+m.primarydisplay,
            CDNThumbnailURL__c='https://invcdn.dealerteam.com/'+m.thumbnailUrl,
            PrimaryDisplayURL__c=m.primarydisplayURL,
            PrimaryDisplayFilename__c=m.primarydisplay
        );
    
        try {
            upsert imgObject dealer__UUID__c;
            returnObj.put('vehImg', imgObject);
            returnObj.put('success', true);
        } catch (DmlException e) {
            returnObj.put('error', e);
            returnObj.put('success', false);
        }

        return returnObj;
    }
    
    @RemoteAction
    public static boolean setOrder(String jsonItem) {
        
        list<media> m = (list<media>)JSON.deserialize(jsonItem, list<media>.class);
        List<dealer__Inventory_Images__c> mL = new List<dealer__Inventory_Images__c>();
        
        for(media mone : m) {
            mL.add(new dealer__Inventory_Images__c(
                dealer__UUID__c=mone.uuid,
                dealer__Sequence_Number__c=mone.order
            ));
        }
        
        if(mL.size()>=1) {
            upsert mL dealer__UUID__c;
            return true;
        } else {
            return false;
        }
        
        return false;
    } 
    
    @RemoteAction
    public static boolean setPublished(string uuid) {

        Boolean userCanPublish = Schema.sObjectType.dealer__Inventory_Images__c.fields.dealer__Publish__c.isUpdateable();

        if(!userCanPublish) {
            return false;
        }

        dealer__Inventory_Images__c[] inv = [select Id, dealer__Publish__c from dealer__Inventory_Images__c where dealer__UUID__c =:uuid limit 1];
        
        if(inv.size()==0) {
            return false;
        }
        
        if(inv[0].dealer__Publish__c == true) {
            inv[0].dealer__Publish__c = false;
        } else {
            inv[0].dealer__Publish__c = true;
        }
        
        try {
            update inv;
            return true;
        } catch (DmlException e) {
            System.debug('Update Error: ' + e.getMessage());
            return false;
        }
        return false;
    }

    @RemoteAction
    public static boolean publishAll(string vid) {

        Boolean userCanPublish = Schema.sObjectType.dealer__Inventory_Images__c.fields.dealer__Publish__c.isUpdateable();

        if(!userCanPublish) {
            return false;
        }

        dealer__Inventory_Images__c[] img = [SELECT Id, dealer__Publish__c FROM dealer__Inventory_Images__c where dealer__Vehicle_Inventory__c =:vid limit 200];
        // Make sure somthing was returned
        if(img.size()==0) {
            return false;
        }

        // Set all returned vehicle images to published.
        for(dealer__Inventory_Images__c vi : img){
            vi.dealer__Publish__c = true;
        }
        
        try {
            update img;
            return true;
        } catch (DmlException e) {
            System.debug('Update Error: ' + e.getMessage());
            return false;
        }
        return false;
    }

    private String kHexChars = '0123456789abcdef';
    public String NewGuid() {

        String returnValue = '';
        Integer nextByte = 0;

        for (Integer i=0; i<16; i++) {

            if (i==4 || i==6 || i==8 || i==10) 
                returnValue += '-';

            nextByte = (Math.round(Math.random() * 255)-128) & 255;

            if (i==6) {
                nextByte = nextByte & 15;
                nextByte = nextByte | (4 << 4);
            }

            if (i==8) {
                nextByte = nextByte & 63;
                nextByte = nextByte | 128;
            }

            returnValue += getCharAtIndex(kHexChars, nextByte >> 4);
            returnValue += getCharAtIndex(kHexChars, nextByte & 15);
        }

        return returnValue;
    }

    private String getCharAtIndex(String str, Integer index) {

        if (str == null) return null;

        if (str.length() <= 0) return str;    

        if (index == str.length()) return null;    

        return str.substring(index, index+1);
    }

}