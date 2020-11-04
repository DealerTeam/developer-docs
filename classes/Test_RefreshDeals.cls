@isTest (seeAllData=true)
private class Test_RefreshDeals {
	
	@isTest static void testRD() {

        //Set up the Mock Http Response stuff
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());


       

        dealer__Deal__c deal = new dealer__Deal__c(
        										OwnerID=userinfo.getUserId(),
        										dealer__Deal_ID__c='9999999999',
        										dealer__Company_Number__c='AD1'
        									);


        //Create a 'set' of deal records to pass to StandardSetController
        List<dealer__Deal__c> dealSet = new List<dealer__Deal__c>();
        dealSet.add(deal);

        //Create the Standard Set Controller
        ApexPages.StandardSetController sc = new ApexPages.StandardSetController(dealSet);
        sc.setSelected(dealSet);

        RefreshDeals rd = new RefreshDeals(sc);

        System.assertEquals(1, rd.ssc.getResultSize());

        PageReference result = rd.SyncDeals();

        System.assertNotEquals(null, result);
        
        
	}

    @isTest static void testRDNoDeals(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        List<dealer__Deal__c> dealSet = new List<dealer__Deal__c>();

        //Create the Standard Set Controller
        ApexPages.StandardSetController sc = new ApexPages.StandardSetController(dealSet);
        sc.setSelected(dealSet);

        RefreshDeals rd = new RefreshDeals(sc);

        System.assertEquals(0, rd.ssc.getResultSize());

        PageReference result = rd.SyncDeals();

        System.assertEquals(null, result);

    }
}