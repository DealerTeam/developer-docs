@isTest
public class TestFactoryExamples implements TestInterfaces.ITest
{
	// @testSetup will place any inserted objects into the context of the test class
	@testSetup public static void SetupData()
	{
		// Create 200 accounts with default data and insert them into db/context
		TestFactory.createSObjectList(new Account(Description = 'Test Factory Account'), 200, true);
		// Create 200 credit applications and insert them into db/context
		Sales_Up__c sup = (Sales_Up__c)TestFactory.createSObject(new Sales_Up__c(), true);
		TestFactory.createSObjectList(new Credit_Application__c(Sales_up__c = sup.Id, First_Name__c = 'Fred'), 200, true);
	}

	@isTest static void TestOne()
	{
		test.startTest();				
			// Assert that the Description fields contains the proper value.
			for(Account a : [SELECT Name, Description FROM Account])
			{
				System.assertEquals('Test Factory Account', a.Description);
			}		
		test.stopTest();
	}

	@isTest static void TestTwo()
	{
		test.startTest();				
			// Assert that the First_Name fields contains the proper value.
			for(Credit_Application__c app : [SELECT First_Name__c, Last_Name__c FROM Credit_Application__c])
			{
				System.assertEquals('Fred', app.First_Name__c);
			}		
		test.stopTest();
	}

	@isTest static void TestThree()
	{
		test.startTest();

			Account[] aList = (Account[])TestFactory.createSObjectList(new Account(), 200);
			System.assertEquals(200, aList.size());

			// We've already inserted 200 rows in the SetupData context. Insert 200 more in test context. 1 more account for dealer location
			insert aList;

			integer count = database.countQuery('select count() from account');
			System.assertEquals(400, count);

		test.stopTest();

	}

	@isTest static void TestFour()
	{
		test.startTest();

			Credit_Application__c[] appList = (Credit_Application__c[])TestFactory.createSObjectList(new Credit_Application__c(), 200);
			System.assertEquals(200, appList.size());
            Sales_Up__c sup = (Sales_Up__c)TestFactory.createSObject(new Sales_Up__c(), true);
			for(Credit_Application__c app : appList){
				app.Sales_Up__c = sup.Id;
			}
			// We've already inserted 200 rows in the SetupData context. Insert 200 more in test context.
			insert appList;

			integer count = database.countQuery('select count() from Credit_Application__c');
			System.assertEquals(400, count);

		test.stopTest();
	}

	@isTest static void TestFive()
	{
		test.startTest();
		    TestFactory.createSObject(new DMS_Settings__c(Name = 'ActiveSettings', Service_Current_Invoice_Number__c = 30093, Service_Job_Line_Number__c = 8, Parts_Current_Invoice_Number__c = 50115, Parts_Current_Quote_Number__c = 20028, Default_Tax_Rate__c = 7.75, Service_Appointment_Sequence_Number__c = 2000, Deal_Status_Controls_Sales_Up_Status__c = true), true);
			Account a = (Account)TestFactory.createSObject(new Account(), true);
			Contact c = (Contact)TestFactory.createSObject(new Contact(), true);
			
			Service_Vehicle__c veh = (Service_Vehicle__c)TestFactory.createSObject(new Service_Vehicle__c(), true);
			Service_Repair_Order__c sro = (Service_Repair_Order__c)TestFactory.createSObject(new Service_Repair_Order__c(dealer__Customer__c = a.Id, Customer_Contact__c = c.Id, Vehicle__c = veh.Id), true);
			StandardOpCode__c opc = (StandardOpCode__c)TestFactory.createSObject(new StandardOpCode__c(), true);


			Service_Job__c sj = (Service_Job__c)TestFactory.createSObject(new Service_Job__c(Service_Repair_Order__c = sro.Id, Standard_Operation_Code__c = opc.Id), true);

			integer count = database.countQuery('select count() from DMS_Settings__c');
			System.assertEquals(1, count);

		test.stopTest();
	}
}