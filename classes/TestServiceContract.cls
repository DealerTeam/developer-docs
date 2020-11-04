@isTest
private class TestServiceContract {
    static testMethod void myUnitTest() {

       dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation(TestClassUtil.generateRandomString(3), TestClassUtil.generateRandomString(8)); // DT1, DealerTeam Motors
    
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

            TestClassUtil util = new TestClassUtil();

            util.insertDMSSettings();

            dealer__Service_Contract__c s = new dealer__Service_Contract__c();
            s.dealer__Deductable__c = 10;
            s.dealer__Start_Date__c = System.today();
            s.dealer__Car_Deal__c = util.insertCarDeal();
            
            insert s;
            
        }
    }
    
    @isTest static void testServiceContractWithDealLocation() {

        TestClassUtil util = new TestClassUtil();                            
        dealer__Deal__c cd = util.insertCarDealWithLocation();
        
        dealer__Service_Contract__c s = new dealer__Service_Contract__c();           
        s.dealer__Car_Deal__c = cd.Id; 
        
        Test.startTest();
        insert s;
        Test.stopTest();   
        
        List<dealer__Service_Contract__c> serviceContractList = [Select Id, dealer__Location__c, dealer__Car_Deal__r.dealer__Store_Location__c FROM dealer__Service_Contract__c WHERE id =: s.Id];
        System.assertEquals(serviceContractList[0].dealer__Location__c, serviceContractList[0].dealer__Car_Deal__r.dealer__Store_Location__c);
        
    }

}