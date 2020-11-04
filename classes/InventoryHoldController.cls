public class InventoryHoldController {
    /**
     * getRelatedIds returns specific lookup values based on the object page hosting the component
     * @param  refId refId the id of the record hosting the component
     * @return  InventoryHold__c Hold object with lookup fields populated as needed
     */
    @AuraEnabled(cacheable=true)
    public static InventoryHold__c getRelatedIds(Id refId) {
        String objectName = refId.getSObjectType().getDescribe().getName();
        InventoryHold__c hold = new InventoryHold__c();
        system.debug(objectName);
        if(objectName == 'dealer__Deal__c'){
            Deal__c deal = [SELECT Id, Vehicle__c FROM Deal__c where Id =: refId];
            hold.Deal__c = refId;
            hold.VehicleInventory__c = deal.Vehicle__c;
            return hold;
        }
        if(objectName == 'dealer__Vehicle_Inventory__c'){
            hold.VehicleInventory__c = refId;
            return hold;

        }

        return null;
    }

    /**
     * getActiveHolds Gets any holds for the vehicle
     * @param  vId The id to check against active holds
     * @notes will need updated to accept other objects such as equipment
     * @return  List<InventoryHold__c> any active holds for the given id
     */
    @AuraEnabled
    public static List<InventoryHold__c> getActiveHolds(Id vId){
        Set<Id> vIds= new Set<Id>();
        vIds.add(vId);
        List<InventoryHold__c> holds = VehicleInventoryAPI.getActiveHolds(vIds);
        return holds;
    }

    /**
     * getDefaultValues Compares the object and hold type for a custom setting record to populate default values
     * @param  holdType   The name of the hold
     * @param  holdObject Api name of the object to be held
     * @return  InventoryHold__c Hold object with default values populated from the custom setting
     */
    @AuraEnabled
    public static InventoryHold__c getDefaultValues(Id holdType, String holdObject){
        InventoryHold__c hold = VehicleInventoryAPI.selectHoldDefaults(holdType, holdObject);
        return hold;
    }

    /**
     * checkTypes Checks to verify InventoryHoldType__c records exists, surfaces an error in LWC if not
     * @return  returns InventoryHoldType__c records or null if none exist
     */
    @AuraEnabled
    public static List<InventoryHoldType__c> checkTypes(){
        List<InventoryHoldType__c> types = [SELECT Id FROM InventoryHoldType__c];

        if(types.size() > 0){
            return types;
        }
        else{
            return null;
        }
    }

    /**
     * manageSettings Checks if user has permission to edit InventoryHoldType__c fields
     * @return  Boolean true if user can update Name field, otherwise false
     */
    @AuraEnabled(cacheable=true)
    public static Boolean manageSettings(){
        Map < String, String > fieldNames = new Map < String, String > ();
        Map < String, Schema.SObjectField > m = Schema.SObjectType.dealer__InventoryHoldType__c.fields.getMap();
        if(m.get('Name').getDescribe().isUpdateable()){
            return true;
        }
        else{
            return false;
        }
    }


}