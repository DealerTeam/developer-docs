@isTest
private class DynamicRecordUILayer {
    @TestSetup
    static void makeData()
	{
        TestClassUtil tcu = new TestClassUtil();
		tcu.insertDMSSettings();
		Dealer_Location__c loc = TestClassUtil.insertDealerLocation('RD1', 'Redding Motorcar Company');
		
		// Insert Account
		Account a = new Account(FirstName='TestFirst', LastName='TestLast', Tax_Id__c='{"TAXID":"test","TAXZONE","TEST"}');
		Account b = new Account(FirstName='TestFirst1', LastName='TestLast1');
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
        insert Deal;
    }

	/**
    * @Method      : testGetters
    * @Description : Provides a record Id, lookup field and field set on that lookup object to get data           
    * @return      : void   
    * @Param       : none
    */
    @isTest
    static void testGetters()
	{
        Deal__c d = [SELECT Id, Sales_Lead__c FROM Deal__c LIMIT 1];
        DynamicRecordController.dynamicWrapper dw = DynamicRecordController.getFieldSet(d.Id, 'dealer__Sales_Lead__c', 'dealer__NewRecordFieldSet');

		system.assertEquals(dw.RecordId, d.Sales_Lead__c, 'getFieldSet did not return expected Id of related record.');
    }
}