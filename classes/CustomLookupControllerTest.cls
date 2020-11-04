@isTest
private class CustomLookupControllerTest {
@isTest static void testCustomLookup()
	{	
		dealer__Dealer_Location__c loc1 = dealer.TestClassUtil.insertDealerLocation(TestClassutil.generateRandomString(3), TestClassutil.generateRandomString(8));
		id[] fixedResults = new id[]{loc1.Id};
        test.setFixedSearchResults(fixedResults);
        List<CustomLookupController.Result> results = CustomLookupController.getResults('dealer__Dealer_Location__c','Redding');
        system.assertEquals(1,results.size());
        List<CustomLookupController.Result> preLoadedRecord = CustomLookupController.getPreLoadedRecord('dealer__Dealer_Location__c',loc1.Id);
        system.assertEquals(1,preLoadedRecord.size());
        String iconURL = CustomLookupController.getIconURL('dealer__Dealer_Location__c');
	}
}