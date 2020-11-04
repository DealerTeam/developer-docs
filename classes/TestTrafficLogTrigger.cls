@isTest 
private class TestTrafficLogTrigger {
    static testmethod void testTrafficTrigger() {

          
       Profile prof = [select id from profile where name='system Administrator'];
        User u = new User(alias = 'usr', email='us.name@vmail.com',
                  emailencodingkey='UTF-8', lastname='lstname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='testuser128@testorgx.com',
                  Division='DT1');
                  insert u;

        System.runAs(u) {

            dealer__Traffic_Log__c t = new dealer__Traffic_Log__c();
            t.dealer__Fresh_Call__c=true;
            t.dealer__Company_Number__c='AD1';
            t.Name='JohnDoe';
            
            insert t;
        
            t.dealer__Salesperson_1__c=u.Id;
            update t;
            
            t.dealer__Salesperson_2__c=u.Id;
            update t;
        }
        //System.assertEquals(t.OwnerId, t.dealer__Salesperson_1__c);
    }
}