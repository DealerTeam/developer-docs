@isTest
private class TestContactUpdateADP {
	
@testSetup static void testDataInit() {

		TestClassUtil util = new TestClassUtil();
        dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        if(dms == null){
            util.insertDMSSettings();   
        }

        dealer__DMS_Settings__c objDMS = [Select id, name, dealer__DMSName__c from dealer__DMS_Settings__c where Name = 'ActiveSettings'];
        objDMS.dealer__DMSName__c = 'ADP';
        update objDMS;

        util.insertContact();
    }

	public static  testmethod void MyunitTest(){

		TestClassUtil util = new TestClassUtil();
		Test.startTest();      
		//
		Contact objCon = [Select id, Firstname, Lastname, email, homePhone from contact limit 1];
		objCon.email = 'test@abc.com';
		update objCon;
		Test.stopTest();
	}
}