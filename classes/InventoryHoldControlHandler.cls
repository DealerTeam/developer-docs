public class InventoryHoldControlHandler {
    /**
     * enforceActiveHolds used to prevent placing a hold on a record that already has an active hold
     * @param  triggerNew List of InventoryHold__c records being inserted or updated
     */
    public void enforceActiveHolds(List<InventoryHold__c> triggerNew) {
        Set<Id> vIds = new Set<Id>();

        for(InventoryHold__c hold : triggerNew){
            if(hold.VehicleInventory__c != null && hold.Active__c == true){
                if(!vIds.contains(hold.VehicleInventory__c)){
                    vIds.add(hold.VehicleInventory__c);
                } else{
                    //if a second hold is being created for a vehicle in the same DML, throw error
                    throw new InventoryHoldControlHandlerException('Cannot create multiple holds for the same vehicle: ' + hold.VehicleInventory__c);
                }
            }
        }
        if(vIds.size() > 0){
            List<InventoryHold__c> holdList = VehicleInventoryAPI.getActiveHolds(vIds);
            for(InventoryHold__c hold : holdList){
                for(InventoryHold__c thisHold : triggerNew){
                    if(thisHold.Id != hold.Id && thisHold.Active__c == true){
                        throw new InventoryHoldControlHandlerException('An active hold exists for vehicle inventory: ' + hold.Id);
                    }
                }
            }
        }
    }
    /**
     * setNotificationId sets id of customnotificationtype to be used in holds processing flow
     * @param  triggerNew triggerNew description
     */
    public void setNotificationId(List<InventoryHold__c> triggerNew){
        boolean updateNotification = false;
        for(InventoryHold__c hold : triggerNew){
            if(hold.CustomNotificationId__c == null){
                updateNotification = true;
            }
        }
        if(updateNotification == true){
            List<CustomNotificationType> notifId = [SELECT Id FROM customnotificationtype WHERE DeveloperName = 'InventoryHolds' LIMIT 1];
            if(notifId.size() > 0){
                for(InventoryHold__c hold : triggerNew){
                    hold.CustomNotificationId__c = notifId[0].Id;
                }
            }
            
        }
        
    }

    /**
     * updateVehicleInventory updates hold related fields on the vehicle inventory when active hold is created
     * @param  triggerNew list of InventoryHold__c records being inserted
     */
    public void updateVehicleInventory(List<InventoryHold__c> triggerNew){
        List<Vehicle_Inventory__c> viList = new List<Vehicle_Inventory__c>();
        Set<Id> typeIds = new Set<Id>();
        for(InventoryHold__c hold : triggerNew){
            typeIds.add(hold.Type__c);
        }
        Map<Id, InventoryHoldType__c> typeMap = new Map<Id, InventoryHoldType__c>([SELECT Id, Name FROM InventoryHoldType__c WHERE Id IN: typeIds]);
        for(InventoryHold__c hold : triggerNew){
            if(hold.Active__c == true && hold.VehicleInventory__c != null){
                Vehicle_Inventory__c veh = new Vehicle_Inventory__c(Id = hold.VehicleInventory__c, Hold__c = hold.Id);
                if(hold.HoldStatus__c != null){
                    veh.Status_Code__c = hold.HoldStatus__c;
                }
                if(typeMap.get(hold.Type__c) != null){
                    veh.HoldStatus__c = typeMap.get(hold.Type__c).Name;
                }
                viList.add(veh);
            }
        }

        if(viList.size() > 0){
            update viList;
        }
    }

    /**
     * setPriorStatus Sets the PriorStatus__c field with status from vehicle inventory if returnToPriorStatus__c is true
     * @param  triggerNew List<InventoryHold__c> being inserted
     */
    public void setPriorStatus(List<InventoryHold__c> triggerNew){
        List<InventoryHold__c> updateList = new List<InventoryHold__c>();
        Set<Id> vIds = new Set<Id>();
        for(InventoryHold__c hold : triggerNew){
            if(hold.Active__c == true && hold.ReturnToPriorStatus__c == true && hold.VehicleInventory__c != null){
                updateList.add(hold);
                vIds.add(hold.VehicleInventory__c);
            }
        }

        //Update PriorStatus__c with status code from related vehicle inventory
        if(vIds.size() > 0){
            Map<Id, Vehicle_Inventory__c> viMap = new Map<Id, Vehicle_Inventory__c>([SELECT Id, Status_Code__c FROM Vehicle_Inventory__c WHERE Id IN: vIds]);
            for(InventoryHold__c hold : updateList){
                hold.PriorStatus__c = viMap.get(hold.VehicleInventory__c) != null ? viMap.get(hold.VehicleInventory__c).Status_Code__c : '';
            }
        }
    }

    /**
     * returnToPriorStatus Returns vehicle to its status prior to being placed on hold and removes hold related details from fields
     * @param  triggerNew    triggerNew description
     * @param  triggerOldMap triggerOldMap description
     */
    public void returnToPriorStatus(List<InventoryHold__c> triggerNew, Map<Id, InventoryHold__c> triggerOldMap){
        List<Vehicle_Inventory__c> viList = new List<Vehicle_Inventory__c>();

        //Get holds that are becoming inactive
        for(InventoryHold__c hold : triggerNew){
            if(hold.Active__c == false && triggerOldMap.get(hold.Id) != null && triggerOldMap.get(hold.Id).Active__c == true && hold.VehicleInventory__c != null){
                //Update vehicle status with the prior status from the hold and remove hold status                
                if(hold.ReturnToPriorStatus__c == true && hold.PriorStatus__c != null){
                    Vehicle_Inventory__c vi = new Vehicle_Inventory__c(Id = hold.VehicleInventory__c, Status_Code__c = hold.PriorStatus__c, Hold__c = null, HoldStatus__c = null);
                    viList.add(vi);
                }
                //Update vehicle status with the default post-hold status if returnToPriorStatus is false
                else if(hold.ReturnToPriorStatus__c == false && hold.DefaultStatus__c != null){
                    Vehicle_Inventory__c vi = new Vehicle_Inventory__c(Id = hold.VehicleInventory__c, Status_Code__c = hold.DefaultStatus__c, Hold__c = null, HoldStatus__c = null);
                    viList.add(vi);
                }
            }
        }

        if(viList.size() > 0){
            try{
                update viList;
            }catch(Exception e){
                    throw new InventoryHoldControlHandlerException('Error returning vehicle to prior status: ' + e.getMessage());
            }
        }
    }

    public class InventoryHoldControlHandlerException extends Exception {}
}