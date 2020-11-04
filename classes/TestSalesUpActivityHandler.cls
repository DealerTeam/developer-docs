@isTest
private class TestSalesUpActivityHandler implements TestInterfaces.ITest
{

	@testSetup public static void SetupData(){
		//Insert dms settings needed for linked sales appointments
        TestClassUtil util = new TestClassUtil();
        dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        if(dms == null){
            util.insertDMSSettings();   
        }
        dms = [SELECT Id, dealer__SalesAppointmentLinkedEvent__c FROM dealer__DMS_Settings__c WHERE Name = 'ActiveSettings' LIMIT 1];
        dms.dealer__SalesAppointmentLinkedEvent__c = true;
        update dms;
	}
	
	@isTest static void testTaskOne() 
	{
		Sales_Up__c sup = (Sales_Up__c)TestFactory.createSObject(new Sales_Up__c(), true);
		Task t = (Task)TestFactory.createSObject(new Task(WhatId = sup.Id, ActivityDate = system.Today()), true);
	}
	
	@isTest static void testTaskTwo() 
	{
		Sales_Up__c sup = (Sales_Up__c)TestFactory.createSObject(new Sales_Up__c(), true);
		Task t = (Task)TestFactory.createSObject(new Task(WhatId = sup.Id, ActivityDate = system.Today()), true);
		t.Status = 'Completed';
		update t;
	}

	@isTest static void testEventOne()
	{
		Sales_Up__c sup = (Sales_Up__c)TestFactory.createSObject(new Sales_Up__c(), true);
		Event e = (Event)TestFactory.createSObject(new Event(WhatId = sup.Id, StartDateTime = system.Today() +7, ActivityDateTime = system.Today() +7), true);
	}

	@isTest static void testEventTwo()
	{
		Sales_Up__c sup = (Sales_Up__c)TestFactory.createSObject(new Sales_Up__c(), true);
		Event e = (Event)TestFactory.createSObject(new Event(WhatId = sup.Id, StartDateTime = system.Today() -7, ActivityDateTime = system.Today() -7, DurationInMinutes = 60), true);
	}

	@isTest static void testDMLException()
	{
		try 
		{
			SalesUpActivityHandler.updateSups(new List<Sales_Up__c>{ new Sales_Up__c() });
		} 
		catch (Exception e) 
		{
			String message = e.getMessage();
			System.assert(e.getMessage().contains('MISSING_ARGUMENT'), e.getMessage());
		}
	}

   @isTest static void testSchedulable() 
   {

		Test.startTest();

			// Schedule the test job
			String CRON_EXP = '0 0 0 3 9 ? 2022';
			String jobId = System.schedule('testScheduledApex',CRON_EXP, new ScheduledSalesUpActivities());

			// Get the information from the CronTrigger API object
			CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];

			// Verify the expressions are the same
			System.assertEquals(CRON_EXP, ct.CronExpression);

			// Verify the job has not run
			System.assertEquals(0, ct.TimesTriggered);

			// Verify the next time the job will run
			System.assertEquals('2022-09-03 00:00:00', String.valueOf(ct.NextFireTime));

		Test.stopTest();

   }
	
}