@isTest
private class InventoryHoldDomainLayer {
    @TestSetup
    static void testData(){
        TestClassUtil tu = new TestClassUtil();
        tu.insertVehicleInventory();
        
    }

    @isTest
    static void testPreventMultipleHolds(){
        Vehicle_inventory__c vi = [SELECT Id FROM Vehicle_Inventory__c LIMIT 1];
        vi.Status_Code__c = 'In Stock';
        update vi;

        InventoryHoldType__c holdType = new InventoryHoldType__c(Name = 'Sales Hold');
        insert holdType;

        InventoryHold__c hold = new InventoryHold__c();
        hold.VehicleInventory__c = vi.Id;
        hold.Active__c = true;
        hold.Type__c = holdType.Id;
        hold.ReturnToPriorStatus__c = true;
        insert hold;

        try{
                
            InventoryHold__c hold1 = new InventoryHold__c();
            hold1.VehicleInventory__c = vi.Id;
            hold1.Type__c = holdType.Id;
            insert hold1;
        }
        catch(Exception e){
            Boolean expectedException = e.getMessage().contains('Cannot create multiple holds') ? true : false;
            System.AssertEquals(expectedException, true);
        }

        hold.Active__c = false;
        update hold;
    }    
}