public class EquipmentInventoryControlHandler {
    /**
     * updatePricingFromMaster Refreshes pricing on Equipment Inventory when Equipment Master is changed
     * @param  triggerNew    triggerNew description
     * @param  triggerOldMap triggerOldMap description
     */ 
    public static void updatePricingFromMaster(List<EquipmentInventory__c> triggerNew, Map<Id, EquipmentInventory__c> triggerOldMap) {
        Set<Id> masterIds = new Set<Id>();
        List<EquipmentInventory__c> updatedInventory = new List<EquipmentInventory__c>();
        for(EquipmentInventory__c ei : triggerNew){
            if(ei.EquipmentMaster__c != triggerOldMap.get(ei.Id).EquipmentMaster__c){
                if(ei.EquipmentMaster__c != null){
                    masterIds.add(ei.EquipmentMaster__c);
                    updatedInventory.add(ei);
                }
                else{
                    ei.Cost__c = 0;
                    ei.RetailPrice__c = 0;
                }
            }
        }

        if(masterIds.size() > 0){
            Map<Id, Equipment_Master__c> masterMap = new Map<Id, Equipment_Master__c>([SELECT Id, TaxRateType__c, Cost__c, RetailPrice__c FROM Equipment_Master__c WHERE Id IN: masterIds]);

            for(EquipmentInventory__c ei : updatedInventory){
                if(masterMap.get(ei.EquipmentMaster__c) != null){
                    ei.TaxRateType__c = masterMap.get(ei.EquipmentMaster__c).TaxRateType__c;
                    ei.Cost__c = masterMap.get(ei.EquipmentMaster__c).Cost__c != null ? masterMap.get(ei.EquipmentMaster__c).Cost__c : 0;
                    ei.RetailPrice__c = masterMap.get(ei.EquipmentMaster__c).RetailPrice__c != null ? masterMap.get(ei.EquipmentMaster__c).RetailPrice__c : 0;
                }
            }
        }
    }

    /**
     * updateRelatedDeal Pushes pricing changes to any related deals and throw error if those deals are closed
     * @param  triggerNew    triggerNew description
     * @param  triggerOldMap triggerOldMap description
     */
    public static void updateRelatedDeal(List<EquipmentInventory__c> triggerNew, Map<Id, EquipmentInventory__c> triggerOldMap){
        Set<Id> eiIds = new Set<Id>();
        List<EquipmentInventory__c> changedEquipment = new List<EquipmentInventory__c>();
        Map<Id, List<Deal__c>> dealMap = new Map<Id, List<Deal__c>>();
        List<Deal__c> dealsToUpdate = new List<Deal__c>();
        for(EquipmentInventory__c ei : triggerNew){
            if(ei.Cost__c != triggerOldMap.get(ei.Id).Cost__c || ei.RetailPrice__c != triggerOldMap.get(ei.Id).RetailPrice__c){
                eiIds.add(ei.Id);
                changedEquipment.add(ei);
            }
        }

        if(eiIds.size() > 0){
            List<Deal__c> dealList = [SELECT Id, EquipmentInventoryCost__c, EquipmentInventoryPrice__c, EquipmentInventory__c, Disposition__c FROM Deal__c WHERE EquipmentInventory__c != null AND EquipmentInventory__c IN: eiIds];
            for(Deal__C d : dealList){
                if(dealMap.get(d.EquipmentInventory__c) == null){
                    dealMap.put(d.EquipmentInventory__c, new List<Deal__c>());
                }
                dealMap.get(d.EquipmentInventory__c).add(d);
            }

            for(EquipmentInventory__c e : changedEquipment){
                if(dealMap.get(e.Id) != null && dealMap.get(e.Id).size() > 0){
                    List<Deal__c> relatedDeals = dealMap.get(e.Id);
                    for(Deal__c d: relatedDeals){
                        if(e.Cost__c != d.EquipmentInventoryCost__c || e.RetailPrice__c != d.EquipmentInventoryPrice__c){
                            if(d.Disposition__c != 'Accepted' && d.Disposition__c != 'Won'){
                                d.EquipmentInventoryCost__c = e.Cost__c;
                                d.EquipmentInventoryPrice__c = e.RetailPrice__c;
                                dealsToUpdate.add(d);
                            }
                            else{
                                e.addError(new EquipmentInventoryControlHandlerException('You are attempting to update equipment inventory pricing related to a closed deal. Pricing may not be updated on deals with a Disposition status of \"Accpeted\" or \"Won\"'));
                            }
                        }
                    }
                    
                    
                }
            }
            if(dealsToUpdate.size() > 0){
                try{
                    update dealsToUpdate;
                }
                catch(Exception e){
                    throw new EquipmentInventoryControlHandlerException('Error updating equipment inventory pricing on deal: ' + e.getMessage());
                }
            }
        }
    }
    
    public class EquipmentInventoryControlHandlerException extends Exception{}
}