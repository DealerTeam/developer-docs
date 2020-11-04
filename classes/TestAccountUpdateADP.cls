@isTest
private class TestAccountUpdateADP {
	
	@testSetup static void testSetup() { 
        TestClassUtil tu = new TestClassUtil();
        tu.insertDMSSettings();

        dealer__DMS_Settings__c objDMS = [Select id, name, dealer__DMSName__c from dealer__DMS_Settings__c where Name = 'ActiveSettings'];
        objDMS.dealer__DMSName__c = 'ADP';
        update objDMS;

        // Create the location
        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
    
        // Create the user
        Profile prof = [select id from profile where name='system Administrator'];
        User usr = new User(alias = 'usr', email='us.name@vmail.com',
                  emailencodingkey='UTF-8', lastname='lstname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='testuser128@testorgx.com',
                  Division='DT1');
        insert usr; 

        // create technician record
        User tch = new User(alias = 'tech', email='technician@blank.org',
                  emailencodingkey='UTF-8', lastname='techlastname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='tech@blackhole.org',
                  dealer__Technician__c=true,
                  Division='DT1');

        insert tch;         

        tu.insertAccount();
    }

    static testmethod void testRoTransports(){

		Account objAcc = [Select id, name, Type from account limit 1];
		objAcc.name = 'TestUpdate';
		update objAcc;
	}
	
}