@isTest
private class TestMergedPDFController {
	
	@testSetup static void testDataInit() {
        TestClassUtil util = new TestClassUtil();
        dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        if(dms == null){
            util.insertDMSSettings();   
        }

        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
        Profile prof = [select id from profile where name='system Administrator'];
        User usr = new User(alias = 'usr', email='us.name@vmail.com',
                  emailencodingkey='UTF-8', lastname='lstname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='testuser128@testorgx.com',
                  Division='DT1');
        insert usr; 


    }

    static testMethod void myUnitTest1() {
    	TestClassUtil util = new TestClassUtil();
        dealer__Deal__c deal = new dealer__Deal__c();
        deal.dealer__Deal_ID__c = '123123123123123000';
        deal.dealer__Buyer_Contact__c = util.insertContact();
        insert deal ;
    	ApexPages.StandardController controller =  new ApexPages.StandardController(deal);
    	MergedPDFController obj = new MergedPDFController(controller);
    }

    static testMethod void myUnitTest2() {
    	TestClassUtil util = new TestClassUtil();
        dealer__Deal__c deal = new dealer__Deal__c();
        deal.dealer__Deal_ID__c = '123123123123123000';
        deal.dealer__Buyer_Contact__c = util.insertContact();
        insert deal ;

        Test.setCurrentPageReference(new PageReference('Page.MergedPDF')); 
		System.currentPageReference().getParameters().put('pageNames', 'MergedPDF');

    	ApexPages.StandardController controller =  new ApexPages.StandardController(deal);
    	MergedPDFController obj = new MergedPDFController(controller);
    }
	
}