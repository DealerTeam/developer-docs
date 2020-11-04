/**
* TestBatchUpdateEquippedField - Test class for BatchUpdateEquippedField class
*
**
* Date            |Developer            |Work#
* Notes
* --
* 2016.10.27      |Abhishek Goel         |W-000622
* Test class for BatchUpdateEquippedField class
**/

@isTest
private class TestBatchUpdateEquippedField {
	
	static testMethod void test_batchVI1() {

		dealer__Custom_Equipment__c objCE = new dealer__Custom_Equipment__c(dealer__equiped__c = true, dealer__name__c='TCequip');
		insert objCE;

		Test.StartTest();
			String q3 = 'select id, name, dealer__equiped__c, dealer__equipped__c from dealer__Custom_Equipment__c';
            String e3 = 'dealer__Custom_Equipment__c';
            String f3 = 'dealer__equiped__c';
            String v3 = 'dealer__equipped__c';
            Id batchInstanceId3 = Database.executeBatch(new BatchUpdateEquippedField(q3,e3,f3,v3), 1000); 
        Test.StopTest();

		dealer__Custom_Equipment__c objRes = [select id, name, dealer__equiped__c, dealer__name__c, dealer__equipped__c from dealer__Custom_Equipment__c where id =:objCE.id];
		system.debug('Batch updated dealer__Custom_Equipment__c >>'+objRes.dealer__equipped__c);
	}
	
}