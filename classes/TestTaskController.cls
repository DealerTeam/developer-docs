@isTest
private class TestTaskController {

    static testMethod void save()
    {
        Account a = new Account(Name='Test Account');
        insert a;
        Task t = new Task( Subject='Task for Testing',
                           ActivityDate=Date.today(),
                           WhatId=a.Id,
                           Status='Completed');
        insert t;
        ApexPages.StandardController sc = new ApexPages.StandardController(t);
        TaskController c = new TaskController(sc);
        t = (Task) sc.getRecord();
        t.Subject = 'TaskControllerTestModified';
        PageReference pr = c.save();
        System.assertEquals(null,pr);
        t = [Select Id, Subject from Task where Id = :t.Id limit 1];
        System.assertEquals(t.Subject,'TaskControllerTestModified');
    }


    static testMethod void getIsRelatedToAccountTrue()
    {
        Account a = new Account(Name='Test Account');
        insert a;
        Task t = new Task( Subject='Task for Testing',
                           ActivityDate=Date.today(),
                           WhatId=a.Id,
                           Status='Completed');
        insert t;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(t);
        TaskController c = new TaskController(sc);
        System.assert(c.getIsRelatedToAccount());
    }

    static testMethod void getIsRelatedToAccountFalse()
    {
        Account a = new Account(Name='Test Account');
        insert a;
        dealer__Service_Estimate__c se = new dealer__Service_Estimate__c();
        insert se;
        Task t = new Task( Subject='Task for Testing',
                           ActivityDate=Date.today(),
                           WhatId=se.Id,
                           Status='Completed');
        insert t;
        ApexPages.StandardController sc = new ApexPages.StandardController(t);
        TaskController c = new TaskController(sc);
        System.assert(!c.getIsRelatedToAccount());
    }

    static testMethod void getIsRelatedToDealerInventoryFalse()
    {
        Account a = new Account(Name='Test Account');
        insert a;
        Task t = new Task( Subject='Task for Testing',
                           ActivityDate=Date.today(),
                           WhatId=a.Id,
                           Status='Completed');
        insert t;
        ApexPages.StandardController sc = new ApexPages.StandardController(t);
        TaskController c = new TaskController(sc);
        System.assert(!c.getIsRelatedToDealerInventory());
    }


    static testMethod void getPhone_Contact()
    {
        Contact c = new Contact(FirstName='Joe', LastName='Test', Phone='5302321234');
        insert c;
        Task t = new Task( Subject='Task for Testing',
                           ActivityDate=Date.today(),
                           WhoId=c.Id,
                           Status='Completed');
        ApexPages.StandardController sc = new ApexPages.StandardController(t);
        TaskController ctl = new TaskController(sc);
        System.assertEquals(c.Phone,ctl.getPhone());
    }


    static testMethod void getEmail_Contact()
    {
        Contact c = new Contact(FirstName='Joe', LastName='Test', Phone='5302321234', Email='test@blackhole.org');
        insert c;
        Task t = new Task( Subject='Task for Testing',
                           ActivityDate=Date.today(),
                           WhoId=c.Id,
                           Status='Completed');
        ApexPages.StandardController sc = new ApexPages.StandardController(t);
        TaskController ctl = new TaskController(sc);
        System.assertEquals(c.Email,ctl.getEmail());
    }

}