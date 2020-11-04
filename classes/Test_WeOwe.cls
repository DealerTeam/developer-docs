@isTest
private class Test_WeOwe{
	static testmethod void testWeOweTrigger() {

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
        insert VI;
		
		dealer__Deal__c Deal = new dealer__Deal__c();
    	Deal.dealer__Broker__c = accRec.Id;
    	Deal.dealer__Buyer_Contact__c = conRec.Id;
    	Deal.dealer__Co_Buyer_Contact__c = conRec.Id;
    	Deal.dealer__Co_Buyer__c = accRec.Id;
    	Deal.dealer__Deal_ID__c = 'SAT272727';
    	Deal.dealer__Licence__c = 'SAT2727';
    	Deal.dealer__Vehicle__c = VI.Id;
    	Deal.Name = '12342';
    	insert Deal;
		
        dealer__We_Owe__c w = new dealer__We_Owe__c();
        w.dealer__Code__c = 'TEST';
        w.dealer__Cost__c = 100;
        w.dealer__Description__c = 'Floor Mats';
        w.dealer__RetailPrice__c = 125;
        w.dealer__Parts_Department_Reviewed__c = true;
        w.dealer__Car_Deal__c = Deal.Id;
        insert w;   

        }
    }
}