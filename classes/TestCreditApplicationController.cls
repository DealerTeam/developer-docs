@isTest
private class TestCreditApplicationController implements TestInterfaces.ITest
{
	@testSetup public static void SetupData(){}
//
	@isTest static void testSave() 
	{
		Sales_Up__c sup = (Sales_Up__c)TestFactory.createSObject(new Sales_Up__c(), true);
		Credit_Application__c app = (Credit_Application__c)TestFactory.createSObject(new Credit_Application__c(Sales_Up__c = sup.Id), true);
		CreditApplicationController.saveRecord(app);
		
	}
	
	@isTest static void testSave2() 
	{
		Sales_Up__c sup = (Sales_Up__c)TestFactory.createSObject(new Sales_Up__c(), true);
		Credit_Application__c app = (Credit_Application__c)TestFactory.createSObject(new Credit_Application__c(Sales_Up__c = sup.Id), false);
		CreditApplicationController.saveRecord(app);
	}

	@isTest static void testGetApplication() 
	{
		Sales_Up__c sup = (Sales_Up__c)TestFactory.createSObject(new Sales_Up__c(), true);
		Dealer_Location__c loc = (Dealer_Location__c)TestFactory.createSObject(new Dealer_Location__c(), true);

		Credit_Application__c app = (Credit_Application__c)TestFactory.createSObject(new Credit_Application__c(Sales_Up__c = sup.Id, dealer__Store_Location__c = loc.Id), true);

		CreditApplicationController.getApplication(app.Id);
	}

	@isTest static void testCreditApplicationController(){
		
		Test.startTest();
		Dealer_Location__c loc = (Dealer_Location__c)TestFactory.createSObject(new Dealer_Location__c(), true);
        Sales_Up__c sup = (Sales_Up__c)TestFactory.createSObject(new Sales_Up__c(Store_Location__c = loc.Id), true);
        Deal__c deal = (Deal__c)TestFactory.createSObject(new deal__c(Deal_ID__c = '1'), true);
		Deal__c deal2 = (Deal__c)TestFactory.createSObject(new deal__c(Deal_ID__c = '2'), true);

		sup.Car_Deal__c = deal.Id;
		update sup;

		deal.Sales_Lead__c = sup.Id;
		update deal;

		deal2.Sales_Lead__c = sup.Id;
		update deal2;

		Credit_Application__c app = (Credit_Application__c)TestFactory.createSObject(new Credit_Application__c(Sales_Up__c = sup.Id), true);
		DealerLocationServices__c dls = new DealerLocationServices__c(
			ServiceProviderId__c='asda',
			ServiceProvider__c='RouteOne',
			Location__c=loc.Id,
			Description__c = 'desc.'
		);
		insert dls;

		LookupSearchLocationServices lookup = new LookupSearchLocationServices();
		lookup.search('asda', new List<String>());
		lookup.getRecent();
		lookup.geSelectionById(dls.Id);

		CreditApplicationController.primaryDeal(app.Id);
		CreditApplicationController.getRelatedDeals(app.Id);
		CreditApplicationController.getServiceProviders(app.Id);

		Test.stopTest();

		CreditApplicationController.submitApplication('RouteOne', app.Id, deal.Id, 'asdfa');
		CreditApplicationController.submitApplication('DealerTrack', app.Id, deal.Id, 'asdfa');
		CreditApplicationController.getApplicationType(app.Id);
		CreditApplicationController.getRelatedApps(deal.Id);
		CreditApplicationController.createAppFromSalesUp(sup.Id);
		CreditApplicationController.getSalesUp(sup.Id);
		CreditApplicationController.getServiceProvidersDeal(deal.Id);
		
		//Should be 2 once dealertrack pans out
		System.assertEquals(1, CreditApplicationController.getPreviousSubmissions(app.Id).size());
	}
	
}