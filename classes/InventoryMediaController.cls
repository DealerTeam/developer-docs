public with sharing class InventoryMediaController {
    /**
    * @method getRelatedVehicleId
    * @description queries the record of rootId with the relatedField returned
    * @param  rootId Id of the record to query
    * @param  relatedField field that can traverse many levels 
    * @return sObject holding the field with a vehicleId
    */ 
    @AuraEnabled
    public static sObject getRelatedVehicleId(Id rootId, String relatedField)
    {
        if(relatedField != null && relatedField.length() > 0){
        
            String objType = utility.getKeyPrefix(rootId);

            String query = 'SELECT Id, ' + relatedField + ' FROM ' +objType + ' WHERE Id =: rootId';
            List<sObject> rootRecord = database.query(query);

            return rootRecord[0];            
            
        }
        
        return null;
    }

    /**
    * @method getImages
    * @description returns list all inventory images for a vehicle
    * @param  recordId     The vehicle inventory Id
    * @return List<Inventory_Images__c> all images for the vehicle
    */ 
    @AuraEnabled
    public static List<Inventory_Images__c> getImages(Id recordId)
    {
        List<Inventory_Images__c> images = [SELECT Vehicle_Inventory__c, Vehicle_Inventory__r.Stock_Number__c, CDNThumbnailURL__c, CDNURL__c, 
                                            Height__c, Image_Name__c, Image_URL__c, MIME_Type__c, 
                                            Photographer__c, PrimaryDisplayFilename__c, PrimaryDisplayURL__c, 
                                            Publish__c, Sequence_Number__c, Thumbnail_URL__c, 
                                            Thumbnail__c, UUID__c, Width__c, Name, Id, CreatedById, CreatedDate, 
                                            LastModifiedDate, LastModifiedById 
                                        FROM Inventory_Images__c 
                                        WHERE Vehicle_Inventory__c =:recordId
                                        ORDER BY Sequence_Number__c ASC];
        return images;
    }
}
