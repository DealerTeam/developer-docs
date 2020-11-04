@isTest 
private class TestLMS {
    static testmethod void testLMSNotify() {
        
       TestClassUtil TCU = new TestClassUtil();

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

	        TCU.insertSalesup();
	        
	        LMS l = new LMS();
	        
	        Test.startTest();
	            
	            dealer__Sales_Up__c[] sups = [select Id from dealer__Sales_Up__c limit 1];  
	            LMS.notifyUrbanScience('vehicleDemoed', sups[0].Id);
	            
	        Test.stopTest();
	    }
    }
}