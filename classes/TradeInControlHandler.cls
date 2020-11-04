public class TradeInControlHandler {
    /**
     * setName Handles populating the Name from Year Make and Model of the trade in record
     * @param  triggerNew triggerNew description
     */
    public static void setName(List<Trade_In__c> triggerNew){
        for(Trade_In__c t : triggerNew){
            if(t.Name == null){
                t.Name = t.Year__c != null ? t.Year__c + ' ': '';
                t.Name += t.Make__c != null ? t.Make__c + ' ': '';
                t.Name += t.Model__c != null ? t.Model__c : ''; 
            }
        }
    }
    public static void createServiceVehicleFromTrade(List<dealer__Trade_In__c> newTrade) {
        Map<String,dealer__Service_Vehicle__c> mapVehIdServiceVehicle = new Map<String,dealer__Service_Vehicle__c>();
        Set<string> setSVId = new Set<string>();
        Map<String, dealer__Service_Vehicle__c> svExistingData = new Map<String, dealer__Service_Vehicle__c>();
  	    List<Id> numService = new List<Id>();

        // Create a holding set for vins to check for duplicates often found in DataLoader uploading.
        Set<String> vinCheck = new Set<String>();       

        // Get List of Service vehicles that match the records to compare new and old values, prevent recursion
        //Get all VIN Numbers
        for(dealer__Trade_In__c inventoryItem : newTrade) {
            if(inventoryItem.dealer__VIN__c!=null && inventoryItem.dealer__VIN__c!=''){    
                setSVId.add(inventoryItem.dealer__VIN__c.trim());  
            }

        }

        if(setSVId.size() > 0){
            //Get Service Vehicle and associated VI
            for(dealer__Service_Vehicle__c svExisting : [SELECT id, dealer__Sales_Inventory__c, dealer__VIN__c, 
                                dealer__Stock_Number__c, dealer__Year__c, dealer__Make__c,
                                dealer__Carline__c, dealer__Licence__c, dealer__Key_1__c, 
                                dealer__Transmission_Type__c, dealer__Engine_Description__c, 
                                dealer__Drive_Type__c, dealer__Last_Odometer__c, dealer__Ext_Color__c,
                                dealer__Package_Code__c, dealer__Trim_Level__c, dealer__Int_Color__c,
                                (SELECT id, name, dealer__VIN__c FROM Trade_Ins__r ORDER BY createddate desc LIMIT 1)   
                                FROM dealer__Service_Vehicle__c WHERE dealer__VIN__c IN:setSVId]) {

                svExistingData.put(svExisting.dealer__VIN__c, svExisting);
                numService.add(svExisting.Id);                       
            
            }
        }
        

        for(dealer__Trade_In__c inventoryItem : newTrade) {
            // Set the Vehicle Name based on the following criteria.  Name = (Last6) Year Make Model
            String vehicleName = '';

            if(inventoryItem.dealer__VIN__c!= null) {
                vehicleName = '(' + inventoryItem.dealer__VIN__c.right(6) + ') ' + inventoryItem.dealer__Year__c + ' ' + inventoryItem.dealer__Make__c + ' ' + inventoryItem.dealer__Model__c; 
                
                

                boolean svExists = svExistingData.get(inventoryItem.dealer__VIN__c) == null ? false : true;
                //W-001685 Create service if is not created when updating.
                //If Service Vehicle has not been created, create now.
                if(!svExists && !vinCheck.contains(inventoryItem.dealer__VIN__c)) {

                    mapVehIdServiceVehicle.put(inventoryItem.dealer__VIN__c, new dealer__Service_Vehicle__c(
                                        Name = vehicleName,
                                        dealer__VIN__c = inventoryItem.dealer__VIN__c,
                                        dealer__Stock_Number__c = inventoryItem.dealer__Stock_Number__c,
                                        dealer__Year__c = inventoryItem.dealer__Year__c,
                                        dealer__Make__c = inventoryItem.dealer__Make__c,
                                        dealer__Carline__c = inventoryItem.dealer__Model__c,
                                        dealer__Last_Odometer__c = inventoryItem.dealer__Odometer_at_Trade_In__c,
                                        dealer__Trim_Level__c = inventoryItem.dealer__Trim_Level__c
                                    ) 
                    );

                    vinCheck.add(inventoryItem.dealer__VIN__c);        
                }
                

                //else
                else if(svExistingData.get(inventoryItem.dealer__VIN__c) != null && 
                    (svExistingData.get(inventoryItem.dealer__VIN__c).dealer__VIN__c != inventoryItem.dealer__VIN__c || 
                    svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Stock_Number__c != inventoryItem.dealer__Stock_Number__c ||
                    svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Year__c != inventoryItem.dealer__Year__c ||
                    svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Make__c != inventoryItem.dealer__Make__c ||
                    svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Carline__c != inventoryItem.dealer__Model__c ||
                    svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Last_Odometer__c != inventoryItem.dealer__Odometer_at_Trade_In__c ||
                    svExistingData.get(inventoryItem.dealer__VIN__c).dealer__Trim_Level__c != inventoryItem.dealer__Trim_Level__c))
                {

                    mapVehIdServiceVehicle.put(inventoryItem.dealer__VIN__c, new dealer__Service_Vehicle__c(
                                        Name = vehicleName,
                                        dealer__VIN__c = inventoryItem.dealer__VIN__c,
                                        dealer__Stock_Number__c = inventoryItem.dealer__Stock_Number__c,
                                        dealer__Year__c = inventoryItem.dealer__Year__c,
                                        dealer__Make__c = inventoryItem.dealer__Make__c,
                                        dealer__Carline__c = inventoryItem.dealer__Model__c,
                                        dealer__Last_Odometer__c = inventoryItem.dealer__Odometer_at_Trade_In__c,
                                        dealer__Trim_Level__c = inventoryItem.dealer__Trim_Level__c
                                    ) 
                    );  
                }
            } 
        }
        //Upsert Service Vehicle
        if(mapVehIdServiceVehicle.size() > 0 ) {
            upsert mapVehIdServiceVehicle.values() dealer__VIN__c; 
        } 

        List<dealer__Trade_In__c>  listVehicleToUpdate= new List<dealer__Trade_In__c> ();

        for(dealer__Trade_In__c trade : newTrade){
            if(mapVehIdServiceVehicle.get(trade.dealer__VIN__c) != null && mapVehIdServiceVehicle.get(trade.dealer__VIN__c).Id != null){
                trade.dealer__Service_Vehicle__c = mapVehIdServiceVehicle.get(trade.dealer__VIN__c).Id;
            }
        }
        
    }
}