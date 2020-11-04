@isTest
private class TestVehicleInventoryAPI Implements TestInterfaces.ITest {
	
	@testSetup public static void SetupData(){

		TestClassUtil util = new TestClassUtil();
        dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        if(dms == null){
            util.insertDMSSettings();   
        }
	}

	@isTest static void testStockNumberBookEntry() 
	{
		VehicleInventoryAPI.StockNumberBookEntry snbe = new VehicleInventoryAPI.StockNumberBookEntry(new Stock_Number_Book__c());
		snbe.customStockNumber = '12345';
	}
	
	@isTest static void testSelectAll() {
		Dealer_Location__c loc = (Dealer_Location__c)TestFactory.createSObject(new Dealer_Location__c(), true);
		Vehicle_Inventory__c veh = (Vehicle_Inventory__c)TestFactory.createSObject(new Vehicle_Inventory__c(), true);		
		List<Vehicle_Inventory__c> vehicles = [SELECT Id FROM Vehicle_Inventory__c LIMIT 1];
		
		// Positive Result
		VehicleInventoryAPI.selectAllFields(vehicles[0].Id);
	}	

	@isTest
	static void testStockNumberByDate(){
		DMS_Settings__c dms = [SELECT Id, Stock_Number_Current_Index__c FROM DMS_Settings__c WHERE Name = 'ActiveSettings' LIMIT 1];
		Vehicle_Inventory__c vi = (Vehicle_Inventory__c)TestFactory.createSObject(new Vehicle_Inventory__c(), true);

		VehicleInventoryAPI.getStockNumberByDate(vi, dms);

		//Test that casting to integer is working
		dms.Stock_Number_Current_Index__c = 4.0;
		update dms;
		String stockNum = VehicleInventoryAPI.getStockNumberByDate(vi, dms);
		System.assertEquals('5', stockNum.right(1), 'stock number was set as expected');

	}

	@isTest
	static void testGetStockByVIN(){
		DMS_Settings__c dms = [SELECT Id, Stock_Number_Current_Index__c, Stock_Number_Length__c FROM DMS_Settings__c WHERE Name = 'ActiveSettings' LIMIT 1];
		Vehicle_Inventory__c vi = (Vehicle_Inventory__c)TestFactory.createSObject(new Vehicle_Inventory__c(), true);

		String stockNum = VehicleInventoryAPI.getStockByLastOfVIN(vi, dms);
	}

	static testMethod void testBatchMigrateVehicleEquipment() {

		dealer__Vehicle_Inventory__c objveh = new dealer__Vehicle_Inventory__c(dealer__Make__c = 'TMake', dealer__Model__c = 'TModel', dealer__Stock_Number__c= 'TStock1', dealer__VIN__c = '1C4RDJDG0EC973121', dealer__Year__c = '2016');
		insert objVeh;

		Service_Vehicle__c sv = [SELECT Id FROM Service_Vehicle__c WHERE Sales_Inventory__c =: objVeh.Id];

		List<Service_Vehicle_Equipment__c> svEquip = new List<Service_Vehicle_Equipment__c>();
		List<Vehicle_Equipment__c> sEquip = new List<Vehicle_Equipment__c>();
		for(Integer i = 0; i < 100 ; i++){
			svEquip.add(new Service_Vehicle_Equipment__c(Service_vehicle__c = sv.Id, Description__c = 'desc'+i, Category__c='cat'+i, Equipped__c = true, Option_Id__c='opt-'+i, Order_code__c = 'oc-'+i));
			sEquip.add(new Vehicle_Equipment__c(Vehicle_Inventory__c = objVeh.Id, Description__c = 'desc'+i, Category__c='cat'+i, Equipped__c = true, Option_Id__c='opt-'+i, Order_code__c = 'oc-'+i));
		}
		insert svEquip;
		insert sEquip;

		Test.StartTest();
		BatchMigrateVehicleEquipment migBatch = new BatchMigrateVehicleEquipment();
		ID batchprocessid = Database.executeBatch(migBatch, 100); // 200
		Test.StopTest();

	}

	static testMethod void testBatchDeleteEquipment() {

		dealer__Vehicle_Inventory__c objveh = new dealer__Vehicle_Inventory__c(dealer__Make__c = 'TMake', dealer__Model__c = 'TModel', dealer__Stock_Number__c= 'TStock1', dealer__VIN__c = '1C4RDJDG0EC973121', dealer__Year__c = '2016');
		insert objVeh;

		Service_Vehicle__c sv = [SELECT Id FROM Service_Vehicle__c WHERE Sales_Inventory__c =: objVeh.Id];

		List<Service_Vehicle_Equipment__c> svEquip = new List<Service_Vehicle_Equipment__c>();
		List<Vehicle_Equipment__c> sEquip = new List<Vehicle_Equipment__c>();
		for(Integer i = 0; i < 100 ; i++){
			svEquip.add(new Service_Vehicle_Equipment__c(Service_vehicle__c = sv.Id, Description__c = 'desc'+i, Category__c='cat'+i, Equipped__c = true, Option_Id__c='opt-'+i, Order_code__c = 'oc-'+i));
			sEquip.add(new Vehicle_Equipment__c(Vehicle_Inventory__c = objVeh.Id, Description__c = 'desc'+i, Category__c='cat'+i, Equipped__c = true, Option_Id__c='opt-'+i, Order_code__c = 'oc-'+i));
		}
		insert svEquip;
		insert sEquip;

		Test.StartTest();
		BatchDeleteVehicleEquipment delBatch = new BatchDeleteVehicleEquipment();
		ID batchprocessid = Database.executeBatch(delBatch, 100); // 200
		Test.StopTest();

	}
}