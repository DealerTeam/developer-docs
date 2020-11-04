@IsTest
public with sharing class QuickSearchControlTest {
    
    @isTest static void testQuickSearch(){
    	
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standtu', Email='standardusrtest@testorguyu.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, Division='DT1',
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduseruy@testorguyu.com');
        insert u;
        
        dealer__Dealer_Location__c l = new dealer__Dealer_Location__c(Name = 'Test Location', dealer__Company_Number__c = 'DT1',
                                                                     dealer__Street__c	= 'Street', dealer__City__c = 'New York',
                                                                     dealer__State__c	= 'NY', dealer__Postal_Code__c = '11216',
                                                                     dealer__Tax_Misc__c = 'All');
        insert l;
        
        dealer__Dealer_Location_User__c locUser = new dealer__Dealer_Location_User__c(dealer__Dealer_Location__c=l.Id, dealer__User__c=u.Id);
        insert locUser;
        
        Id [] fixedSearchResults = new Id[]{l.Id};
        Test.setFixedSearchResults(fixedSearchResults);
        
        String searchKeyWord = 'Test';
        String ObjectName = 'dealer__Dealer_Location__c';
        
        List<dealer__Dealer_Location__c> results;
        Test.startTest();
        System.runAs(u){
        	 results = QuickSearchControl.fetchLookUpValues(searchKeyWord, ObjectName);
    	}
        Test.stopTest();
        
        system.assertEquals('Test Location', results[0].Name);
        
    }

}