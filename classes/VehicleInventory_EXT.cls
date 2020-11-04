public with sharing class VehicleInventory_EXT {
    
    public ApexPages.standardController m_stdController; 
    public dealer__Vehicle_Inventory__c inv;


    public VehicleInventory_EXT(ApexPages.standardController stdController) {
        m_stdController = stdController;
        Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__Vehicle_Inventory__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet(); 
        af.addAll(fieldnames);
        af.add('RecordType.Name');
        if(!Test.isRunningTest()) {       
            stdController.addFields(af);
        }
        
        inv =   (dealer__Vehicle_Inventory__c)stdController.getRecord();
    }

    public  Vehicle_Inventory__c getVehicle() {
        return inv;
    }

    public List<Inventory_Images__c> getInventoryMedia() {
        return [SELECT Vehicle_Inventory__c, CDNThumbnailURL__c, CDNURL__c, 
            	Height__c, Image_Name__c, Image_URL__c, MIME_Type__c, 
            	Photographer__c, PrimaryDisplayURL__c, Publish__c, Sequence_Number__c, 
            	Thumbnail_URL__c, Thumbnail__c, UUID__c, Width__c, Name, Id, 
            	CreatedById, CreatedDate, LastModifiedById, LastModifiedDate 
            FROM Inventory_Images__c
            WHERE Vehicle_Inventory__c =:inv.Id
            ORDER BY Sequence_Number__c ASC];
    }
    
    public dealer__Dealer_Location__c getLocation() {
        return [SELECT Id, dealer__Logo_Name__c, dealer__Postal_Code__c, dealer__State__c,
                dealer__City__c
                FROM dealer__Dealer_Location__c
               	WHERE Id =: inv.Store_Location__c];
    }
    
    public String getLogo() {

      String url = '';
            try{
        //Check inv.Store_Location__c != null
                url = DealershipLocationAPI.formLogoURL(inv.Store_Location__c);
            }catch(Exception e){
                e.getMessage();
            }
    return url;
    }
    
    public List<Equipment__c> getEquipment() {
        List<Equipment__c> equipment = new List<Equipment__c>();
        equipment = [SELECT Confirmed_By__c, Confirmed_Date_Time__c, Confirmed__c,
                     Data_Source__c, Description__c, Equipment_Master__c, 
                     Featured__c, Notes__c, Publish__c, Serial__c, 
                     Service_Vehicle__c, Name, Id 
                     FROM Equipment__c
                     WHERE Service_Vehicle__r.Sales_Inventory__c =:inv.Id
                     ORDER BY Featured__c ASC];
        return equipment;
    }
    

    public List<Inventory_Images__c> getVehicleMedia(){
        
        String imageList = ApexPages.currentPage().getParameters().get('imagelist');
        if(imageList == null){
            return new List<Inventory_Images__c>();
        }
        List<String> imgStringArray = imagelist.split(',');
        Set<Id> imageIdList = new Set<Id>();

        for(String i : imgStringArray){
            imageIdList.add((Id)i);
        }
       
        return [SELECT Vehicle_Inventory__c, CDNThumbnailURL__c, CDNURL__c, 
                Height__c, Image_Name__c, Image_URL__c, MIME_Type__c, 
                Photographer__c, PrimaryDisplayURL__c, Publish__c, Sequence_Number__c, 
                Thumbnail_URL__c, Thumbnail__c, UUID__c, Width__c, Name, Id, 
                CreatedById, CreatedDate, LastModifiedById, LastModifiedDate 
                FROM Inventory_Images__c    
                WHERE Id IN: imageIdList];
    } 

    @AuraEnabled public static Vehicle_Inventory__c getVehicleInfo(Id recordId) {
        return [SELECT Name, Id, Year__c, Make__c, Model__c, Invoice_Price__c,
                Mileage__c, City_MPG__c, Highway_MPG__c, Trim_Level__c, Body_Type__c,
                Body_Style__c, License__c, License_EXP__c, In_Stock__c, Stock_Number__c
                FROM Vehicle_Inventory__c 
                WHERE Id =:recordId];
    }

    @AuraEnabled public static List<Inventory_Images__c> getInventoryImages(Id recordId) {
        return [SELECT  Vehicle_Inventory__c, CDNThumbnailURL__c, CDNURL__c, 
                Height__c, Image_Name__c, Image_URL__c, MIME_Type__c, 
                Photographer__c, PrimaryDisplayURL__c, Publish__c, Sequence_Number__c, 
                Thumbnail_URL__c, Thumbnail__c, UUID__c, Width__c, Name, Id, 
                CreatedById, CreatedDate, LastModifiedById, LastModifiedDate 
            FROM Inventory_Images__c
            WHERE Vehicle_Inventory__c =:recordId
            ORDER BY Sequence_Number__c ASC];
    }
    
    
    public Boolean getHasActivityHistories() {
        return inv.ActivityHistories.size() > 0;
    }
    
    public Boolean getHasServiceEstimates() {
        return inv.dealer__Service_Estimates__r.size() > 0;
    }
    
    public Boolean getHasStatusCodeHistory() {
        return inv.dealer__Vehicle_Inventory_Status_Code_History__r.size() > 0;
    }
    
}