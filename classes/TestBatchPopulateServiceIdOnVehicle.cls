/**
* TestBatchPopulateServiceIdOnVehicle - Test class for BatchPopulateServiceIdOnVehicleInventory class
*
**
* Date            |Developer            |Work#
* Notes
* --
* 2016.10.14      |Abhishek Goel         |W-000572 
* Test class for BatchPopulateServiceIdOnVehicleInventory class
**/
@isTest
private class TestBatchPopulateServiceIdOnVehicle {
	
	static testMethod void test_batchVI1() {

		dealer__Vehicle_Inventory__c objveh = new dealer__Vehicle_Inventory__c(dealer__Make__c = 'TMake', dealer__Model__c = 'TModel', dealer__Stock_Number__c= 'TStock1', dealer__VIN__c = '1C4RDJDG0EC973121', dealer__Year__c = '2016');
		insert objVeh;

		objveh.dealer__Service_Vehicle__c = null;
		update objVeh;

		Test.StartTest();
			BatchPopulateServiceIdOnVehicleInventory objBatch = new BatchPopulateServiceIdOnVehicleInventory();
			ID batchprocessid = Database.executeBatch(objBatch);
		Test.StopTest();

		dealer__Vehicle_Inventory__c objRes = [Select id, name, dealer__Service_Vehicle__c from dealer__Vehicle_Inventory__c where id =:objVeh.id];
		system.debug('Batch updated dealer__Service_Vehicle__c >>'+objRes.dealer__Service_Vehicle__c);
	}
	
}