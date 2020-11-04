@isTest
private class testBatchRemoveInStore{
    static testMethod void test_batchRemoveInStore() {

       dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
    
       Profile prof = [select id from profile where name='system Administrator'];
       User usr = new User(alias = 'usr', email='us.name@vmail.com',
                  emailencodingkey='UTF-8', lastname='lstname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US', 
                  localesidkey='en_US', profileid = prof.Id,
                  username='testuser128@testorgx.com',
                  Division='DT1');
                  insert usr;
                  
        System.runAs(usr){  

        Account accRec = new Account();
        accRec.Name = 'Test Account';
        accRec.Type = 'Customer - Direct';
        accRec.dealer__Vendor__c = true;
        insert accRec;
        
        Contact conRec = new Contact();
        conRec.AccountId = accRec.Id;
        conRec.LastName = 'TestContact';
        conRec.FirstName = 'testFirstName';
        conRec.Email = 'nicki.allen@me.com';
        conRec.HomePhone = '8099306664';
        conRec.MobilePhone = '8099306664';
        insert conRec;
        
        dealer__Vehicle_Inventory__c VI = new dealer__Vehicle_Inventory__c();
        VI.Name = 'Test Vehicle Inventory';
        VI.dealer__Model__c = '2014';
        VI.dealer__Stock_Number__c = 'UniqueStock27272';
        VI.dealer__VIN__c = '100';
        VI.dealer__Company_Number__c = 'Location 1';
        VI.dealer__Year__c = '2014';
        VI.dealer__Make__c = '2014';
        VI.In_Stock__c = true;
        insert VI;
        
        dealer__Sales_Up__c up = new dealer__Sales_Up__c();
        up.Name = 'Test SalesUP';
        up.dealer__Buyer_Contact__c = conRec.Id;
        up.dealer__Desired_Stock_Num__c = VI.id;
        up.dealer__Make__c = 'Telsa';
        up.dealer__FirstName__c = 'TestFirstName';
        up.dealer__LastName__c = 'LastName';
        insert up;
        //return SU.id;
        
        up.dealer__In_Store__c = true;  
        //batchRemoveInStoreExec bs = new batchRemoveInStoreExec(); 
        batchRemoveInStore bremove = new batchRemoveInStore('dealer__Sales_Up__c');
        List<dealer__Sales_Up__c> soup = [select dealer__In_Store__c from dealer__Sales_Up__c];
        Database.BatchableContext bc;
        bremove.execute(bc, soup);
        ID batchprocessID = Database.executeBatch(bremove, 1);

        }
        
    }
    static testmethod void test_batchScheduledEvent() {
        Test.startTest();
        String jobId = System.schedule('batchRemoveInStoreExecTest','0 0 0 3 9 ? 2022', new batchRemoveInStoreExec());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals('0 0 0 3 9 ? 2022', ct.CronExpression);  
        Test.stopTest();  
    }
}