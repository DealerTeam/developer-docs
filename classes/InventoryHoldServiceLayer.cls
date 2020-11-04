@isTest
private class InventoryHoldServiceLayer {
    @TestSetup
    static void testData(){
        InventoryHoldType__c type = new InventoryHoldType__c();
        type.HoldDuration__c = 10;
        type.HoldStatus__c = 'On Hold';
        type.ReturnToPriorStatus__c = true;
        type.SObjectType__c = 'dealer__Vehicle_Inventory__c';
        insert type;

        dealer__Vehicle_Inventory__c vehInv = (dealer__Vehicle_Inventory__c)TestFactory.createSObject(new dealer__Vehicle_Inventory__c( Name = 'Test Vehicle Inventory',
            dealer__Model__c = '2014',dealer__Stock_Number__c = '2014',dealer__VIN__c = '100',dealer__Company_Number__c = 'Location 1',
            dealer__Year__c = '2014',dealer__Make__c = '2014' ), true);
    }
    @isTest
    public static void testSelectHoldDefaults() {
        InventoryHoldType__c holdType = [SELECT Id FROM InventoryHoldType__c LIMIT 1];

        InventoryHold__c hold = InventoryHoldController.getDefaultValues(holdType.Id, 'dealer__Vehicle_Inventory__c');
        System.assertEquals(true, hold.ReturnToPriorStatus__c, 'getDefaultValues did not return expected values.');
    }

    @isTest
    public static void testRelatedIds(){
        Vehicle_Inventory__c vi = [SELECT Id FROM Vehicle_Inventory__c LIMIT 1];
        InventoryHold__c hold = InventoryHoldController.getRelatedIds(vi.Id);
        List<InventoryHold__c> holds = InventoryHoldController.getActiveHolds(vi.Id);
        InventoryHoldController.checkTypes();
        InventoryHoldController.manageSettings();

        System.assertEquals(vi.Id, hold.VehicleInventory__c, 'getRelatedIds did not attach vehicle record to hold');
    }
}