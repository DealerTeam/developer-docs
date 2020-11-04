@isTest
private class SalesUpShare_TC {
    
    @testSetup static void testDataInit() {
        TestClassUtil util = new TestClassUtil();
        dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        if(dms == null){
            util.insertDMSSettings();   
        }

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

        // create a second user for testing purposes 
        User usr2 = new User(alias = 'usr', email='user2@example.com',
                  emailencodingkey='UTF-8', lastname='two',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='user2@example.com.tesClass',
                  Division='DT1');
        insert usr2; 

    }

   // Test for the manualShareRead method
   static testMethod void testManualShareReadWrite(){
      // Select users for the test.
      List<User> users = [SELECT Id FROM User WHERE IsActive = true LIMIT 2];
      Id User1Id = users[0].Id;
      Id User2Id = users[1].Id;
   
      // Create new job.
      dealer__Sales_Up__c j = new dealer__Sales_Up__c();
      j.Name = 'Test Up';
      j.OwnerId = user1Id;
      j.dealer__FirstName__c= 'John';
      j.dealer__LastName__c='Smith';
      j.dealer__Salesperson_1__c=User1Id;
      insert j;    
      
      System.debug(j);
                
      // Insert manual share for user who is not record owner.
      // Throwing and assertion error that appears to be a false positive - JVK 3/16/2016
      System.assertEquals(SalesUpShare.manualShareReadWrite(j.Id, user2Id), true);
      
     
      // Query job sharing records.
      List<dealer__Sales_Up__Share> jShrs = [SELECT Id, UserOrGroupId, AccessLevel, RowCause FROM dealer__Sales_Up__share WHERE ParentId = :j.Id AND UserOrGroupId= :user2Id];
      
      // Test for only one manual share on job.
      System.assertEquals(jShrs.size(), 1, 'Set the object\'s sharing model to Private.');
      
      // Test attributes of manual share.
      System.assertEquals(jShrs[0].AccessLevel, 'Edit');
      System.assertEquals(jShrs[0].RowCause, 'Manual');
      System.assertEquals(jShrs[0].UserOrGroupId, user2Id);
      
      // Test invalid job Id.
      delete j;   
      // Insert manual share for deleted job id.
      system.debug('the value is'+SalesUpShare.manualShareReadWrite(j.Id, user2Id)); 
      System.assertEquals(SalesUpShare.manualShareReadWrite(j.Id, user2Id), false);
   }  
}