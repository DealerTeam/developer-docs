@isTest
private class DealerTradeServiceLayerTest {

    @TestSetup
    static void initTestData()
    {
        TestClassUtil util = new TestClassUtil();
        util.insertDMSSettings();

        Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
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

    @isTest 
    static void testDealerTrade_EXT()
    {
        Dealer_Location__c location = [SELECT Id FROM Dealer_Location__c LIMIT 1];
        Dealer_Trade__c obj = (Dealer_Trade__c)TestFactory.createSObject(new Dealer_Trade__c(Store_Location__c=location.Id), true);

        // Test the controller extension
        ApexPages.StandardController sc = new ApexPages.StandardController(obj);
        DealerTrade_EXT ext = new DealerTrade_EXT(sc);

        // Test Get Logo
        ext.getInvoiceLogo();

        // Test getters
        Dealer_Trade__c dealertrade = ext.dt;
        String createdbyname = ext.createdBy;
        String lastmodifiedby = ext.modifiedBy;

        System.assert(dealertrade.Id != null, 'DealerTrade Record does not exist');
    }

}