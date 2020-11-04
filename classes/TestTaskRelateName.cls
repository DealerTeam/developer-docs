@isTest
private class TestTaskRelateName {
    @testSetup static void setup(){
        System.debug('TestTaskRelateName: setup');
        dealer__Dealer_Location__c loc = new dealer__Dealer_Location__c( 
            Name = 'Test Location',
            dealer__Company_Number__c = 'CN2',//comp num
            dealer__City__c ='test city',//city
            dealer__State__c = 'TS',//state
            dealer__Postal_Code__c  = 'test zip'//postal code
        );
        insert loc;
        
        dealer__Sales_Up__c s = new dealer__Sales_Up__c(
            Name = 'TestName12345',
            dealer__FirstName__c = 'TestFirstName',
            dealer__LastName__c = 'TestingLastName',
            dealer__Company_Number__c = 'CN2',
            dealer__Store_Location__c = loc.Id
        );
        insert s;

    }

	@isTest static void testOpenTask() {
        System.debug('TestTaskRelateName: testOpenTask');
        Test.startTest();

        dealer__Sales_Up__c x = [Select Id,dealer__Related_Tasks__c, dealer__Incomplete_Tasks__c from dealer__Sales_Up__c where dealer__LastName__c = 'TestingLastName' limit 1];

        Task t = new Task(
            WhatId = x.Id,
            Subject = 'Testing123',
            Status = 'Not Started',
            ActivityDate = Date.today()
        );
       
        insert t;

        Task tt = [Select Id, dealer__Date_Completed__c, ActivityDate from Task where Subject = 'Testing123' limit 1];
        
        x = [Select Id,dealer__Related_Tasks__c, dealer__Incomplete_Tasks__c, dealer__NextActivityDate__c from dealer__Sales_Up__c where dealer__LastName__c = 'TestingLastName' limit 1];
		
		System.assertEquals(1, x.dealer__Related_Tasks__c);
		System.assertEquals(true, x.dealer__Incomplete_Tasks__c);
        System.assertEquals(null, tt.dealer__Date_Completed__c);
        System.assertEquals(tt.ActivityDate, x.dealer__NextActivityDate__c);
        Test.stopTest();
	}

	@isTest static void testClosedTask() {
        System.debug('TestTaskRelateName: testClosedTask');
        Test.startTest();
        dealer__Sales_Up__c x = [Select Id,dealer__Related_Tasks__c, dealer__Incomplete_Tasks__c, dealer__NextActivityDate__c from dealer__Sales_Up__c where dealer__LastName__c = 'TestingLastName' limit 1];
		
		Task t = new Task(
			WhatId = x.Id,
			Subject = 'Testing456',
			Status = 'Completed',
            ActivityDate = Date.today()
		);
		
		insert t;
        
        Task tt = [Select Id, dealer__Date_Completed__c, ActivityDate from Task where Subject = 'Testing456' limit 1];
        
        x = [Select Id,dealer__Related_Tasks__c, dealer__Incomplete_Tasks__c, dealer__NextActivityDate__c from dealer__Sales_Up__c where dealer__LastName__c = 'TestingLastName' limit 1];
		
		System.assertEquals(1, x.dealer__Related_Tasks__c);
		System.assertEquals(false, x.dealer__Incomplete_Tasks__c);
        System.assertNotEquals(null, tt.dealer__Date_Completed__c);
        System.assertEquals(null, x.dealer__NextActivityDate__c);
        Test.stopTest();
	}
    
    @isTest static void testTwoTasks() {
        System.debug('TestTaskRelateName: testTwoTasks');
        Test.startTest();

        dealer__Sales_Up__c x = [Select Id,dealer__Related_Tasks__c, dealer__Incomplete_Tasks__c from dealer__Sales_Up__c where dealer__LastName__c = 'TestingLastName' limit 1];
		
		Task t = new Task(
			WhatId = x.Id,
			Subject = 'Test',
			Status = 'Completed',
            ActivityDate = Date.today() + 10
		);
        
        Task t2 = new Task(
			WhatId = x.Id,
			Subject = 'Test2',
			Status = 'Not Started',
            ActivityDate = Date.today() +5
		);
		
		List<Task> tasklist = new List<Task>();
        tasklist.add(t);
        tasklist.add(t2);
        
        insert tasklist;
        
        List<Task> tasks = [Select Id from Task where WhatId =:x.Id ];
        
        x = [Select Id,dealer__Related_Tasks__c, dealer__Incomplete_Tasks__c, dealer__NextActivityDate__c from dealer__Sales_Up__c where dealer__LastName__c = 'TestingLastName' limit 1];
		
		System.assertEquals(2, x.dealer__Related_Tasks__c);
		System.assertEquals(true, x.dealer__Incomplete_Tasks__c);
        System.debug('2 tasks NAD: '+x.dealer__NextActivityDate__c);

        t2.ActivityDate = Date.today() +1;
        update t2;
        x = [Select Id,dealer__Related_Tasks__c, dealer__Incomplete_Tasks__c, dealer__NextActivityDate__c from dealer__Sales_Up__c where dealer__LastName__c = 'TestingLastName' limit 1];
        System.assertEquals(Date.today() + 1, x.NextActivityDate__c, 'NextActivityDate was not updated with task.');

        Test.stopTest();
	}

    @isTest static void testCloseTaskWithOtherOpen(){
        dealer__Sales_Up__c x = [Select Id, dealer__NextActivityDate__c 
        FROM dealer__Sales_Up__c WHERE dealer__LastName__c = 'TestingLastName' limit 1];
        List<Task> tasks = new List<Task>();
        Task t = new Task(
            WhatId = x.Id,
            Subject = 'Test',
            Status = 'Open',
            ActivityDate = Date.today().addDays(-45)
        );
        tasks.add(t);

        Task t2 = new Task(
            WhatId = x.Id,
            Subject = 'Test',
            Status = 'Open',
            ActivityDate = Date.today().addDays(45)
        );
        tasks.add(t2);

        Task t3 = new Task(
            WhatId = x.Id,
            Subject = 'Test',
            Status = 'Not Started',
            ActivityDate = Date.today().addDays(5)
        );
        tasks.add(t3);

        Task t4 = new Task(
            WhatId = x.Id,
            Subject = 'Test',
            Status = 'Banana',
            ActivityDate = Date.today().addDays(-5)
        );
        tasks.add(t4);

        insert tasks;

        x = [Select Id, dealer__NextActivityDate__c 
        FROM dealer__Sales_Up__c WHERE dealer__LastName__c = 'TestingLastName' limit 1];

        System.assertEquals(t3.ActivityDate, x.dealer__NextActivityDate__c);

        t.Status = 'Completed';
        update t;

        x = [Select Id, dealer__NextActivityDate__c 
        FROM dealer__Sales_Up__c WHERE dealer__LastName__c = 'TestingLastName' limit 1];

        System.assertEquals(t3.ActivityDate, x.dealer__NextActivityDate__c);

        delete t3;

        x = [Select Id, dealer__NextActivityDate__c 
        FROM dealer__Sales_Up__c WHERE dealer__LastName__c = 'TestingLastName' limit 1];

        System.assertEquals(t2.ActivityDate, x.dealer__NextActivityDate__c);        

    }
	
}