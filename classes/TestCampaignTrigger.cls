@isTest
private class TestCampaignTrigger {
	static testmethod void TestCampaignTrigger1() {
		Account a = new Account(Name='TestAccount');
		insert a;

		dealer__Deal__c d = new dealer__Deal__c();
		d.Name='Test';
		d.dealer__Buyer__c = a.Id;
		d.dealer__Deal_ID__c = 'A90090';
		d.dealer__VIN__c = '1234567891010101';
		insert d;

		dealer__Campaign__c c = new dealer__Campaign__c();
		c.Name  = 'Test';
		c.dealer__StartDate__c=Date.today();
		c.dealer__EndDate__c=Date.today();
		insert c;

		dealer__CampaignMember__c cev = new dealer__CampaignMember__c();
		cev.dealer__Sales_Campaign__c = c.Id;
		cev.dealer__Previously_Purchased_VIN__c = '1234567891010101';
		insert cev;
	}
}