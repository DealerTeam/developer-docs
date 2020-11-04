@isTest
private class TestDealPrintController {
    @testSetup static void initTestData() {
		TestClassUtil tcu = new TestClassUtil();
		tcu.insertDMSSettings();
		Dealer_Location__c loc = TestClassUtil.insertDealerLocation('RD1', 'Redding Motorcar Company');
		loc.Deal_Fees__c ='[    {       "feeName":"Fee1",       "feeDescription":"asdflasdf",       "feeDefaultAmount":5,       "feeDefaultOnDeals":true,       "feeTaxable":true     },     {       "feeName":"Fee2",       "feeDescription":"asdflasdf",       "feeDefaultAmount":5,       "feeDefaultOnDeals":true,       "feeTaxable":true,       "bullshit":false     } ]';
		loc.dealer__Main_Phone__c = '1234567891';
        upsert loc;
		// Insert Account
		Account a = new Account(FirstName='Jarrett', LastName='Kuljis', Tax_Id__c='{"TAXID":"test","TAXZONE","TEST"}');
		Account b = new Account(FirstName='Morgan', LastName='Kuljis', Phone = '1234567899');
		List<Account> accounts = new List<Account>{ a, b };
		insert accounts;

		Contact c = [SELECT Id, AccountId FROM Contact WHERE AccountId=:a.Id Limit 1];

		// Create a vehicle inventory record
		Vehicle_Inventory__c VI = new Vehicle_Inventory__c();
			VI.Name = 'Test Vehicle Inventory';
			VI.Model__c = 'Civic';
			VI.Stock_Number__c = dealer.TestClassUtil.generateRandomString(8);
			VI.VIN__c = '5TDYK3DCXBS075856';
			VI.Company_Number__c = 'RD1';
			VI.Store_Location__c = loc.Id;
			VI.Year__c = '2014';
			VI.Make__c = 'Honda';
			VI.In_Stock__c = true;
		insert VI;

		// Create a Sales Up
        Sales_Up__c SU = new Sales_Up__c();     
			SU.Name = 'Test SalesUP';
			SU.Buyer_Contact__c = c.Id;
			SU.Customer_Account__c=a.Id;
			SU.Desired_Stock_Num__c = VI.Id;
			SU.Make__c = 'Honda';
		insert SU;		

		// Create a Deal
        Deal__c Deal = new Deal__c();
			Deal.Buyer__c = a.Id;
			Deal.Co_Buyer__c = b.Id;
			Deal.Buyer_Contact__c = c.Id;
			Deal.Store_Location__c = loc.Id;
			Deal.Deal_ID__c = '12345';
			Deal.Licence__c = '100';
			Deal.Vehicle__c = VI.Id;
			Deal.Name = '12342';
			Deal.Sales_Lead__c=SU.Id;
			Deal.Service_Vehicle__c=[SELECT Id FROM Service_Vehicle__c].Id;	
			Deal.Deal_Date__c=Date.today();
			Deal.Delivery_Date__c=Date.today();
        	Deal.dealer__Deferred_1_Payee__c= b.Id;
			Deal.dealer__Buyer_Mobile_Phone__c='1234567899';
			Deal.dealer__Buyer_Home_Phone__c='1234567899';
        insert Deal;

		// Create a Trade Record
		Service_Vehicle__c svTrade = new Service_Vehicle__c();
			svTrade.Year__c='2009';
			svTrade.Make__c='Peugeot';
			svTrade.Carline__c='208 GTI';
			svTrade.VIN__c='5FNRL5H90BB042364';
		insert svTrade;

		Trade_In__c trade = new Trade_In__c();
			trade.Car_Deal__c=Deal.Id;
			trade.Appraisal_Date__c=Date.today();
			trade.Year__c='2009';
			trade.Make__c='Peugeot';
			trade.Model__c='208 GTI';
			trade.VIN__c='5FNRL5H90BB042364';
			trade.Trade_Allowance__c=900;
			trade.Odometer_at_Trade_In__c=129089;
			trade.Service_Vehicle__c=svTrade.Id;
		insert trade;

	}
   @isTest static void TestDealPrintController(){
	   Test.startTest();
       Deal__c deal = [SELECT Id From Deal__c limit 1];
       ApexPages.currentPage().getParameters().put('Id', deal.Id);
       DealPrintController controller = new DealPrintController(new ApexPages.StandardController(deal));
	   Test.stopTest();
   }
   @isTest static void TestDealPrintCustomController(){
	   Test.startTest();
       Deal__c deal = [SELECT Id, dealer__Buyer_Home_Phone__c, dealer__Buyer_Mobile_Phone__c From Deal__c limit 1];
	   String Phone = deal.dealer__Buyer_Home_Phone__c;
	   String Cell = deal.dealer__Buyer_Mobile_Phone__c;
	   String newPhone;
	   String newCell;
       ApexPages.currentPage().getParameters().put('Id', deal.Id);
       DealPrintCustomController controller = new DealPrintCustomController(new ApexPages.StandardController(deal));
	   newPhone = Utility.formatPhoneTen(Phone);
	   newCell = Utility.formatPhoneTen(Cell);

	   system.assertEquals(controller.custPhone,newPhone); 
	   system.assertEquals(controller.custCell,newCell); 
		Test.stopTest();
   }
}