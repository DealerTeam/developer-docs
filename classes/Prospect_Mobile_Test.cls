@isTest
private class Prospect_Mobile_Test {
	
	@testSetup 
	static void setupData() {

		Account accRec = new Account();
		accRec.Name = 'Test Account';
		accRec.Type = 'Customer - Direct';
		insert accRec;

		Contact conRec = new Contact();
		conRec.AccountId = accRec.Id;
		conRec.LastName = 'TestContact';
		conRec.FirstName = 'testFirstName';
		conRec.Email = 'nicki.allen@me.com';
		conRec.HomePhone = '8099306664';
		conRec.MobilePhone = '8099306664';
		insert conRec;

		// Select users for the test.
		List<User> users = [SELECT Id FROM User WHERE IsActive = true LIMIT 2];
		Id User1Id = users[0].Id;
		Id User2Id = users[1].Id;

		dealer__Sales_Up__c sup = new dealer__Sales_Up__c();
		sup.Name = 'Test Up';
		sup.OwnerId = user1Id;
		sup.dealer__FirstName__c= 'John';
		sup.dealer__LastName__c='Smith';
		sup.dealer__Salesperson_1__c=User1Id;
		insert sup;   

	}

	@isTest 
	static void testSup() {
 		//dealer__Sales_Up__c sup = [SELECT Id, Name, dealer__Customer_Account__c, dealer__FirstName__c, dealer__LastName__c, dealer__Email__c, dealer__Phone__c, dealer__Mobile__c FROM dealer__Sales_Up__c LIMIT 1];
 		//Prospect_Mobile.upsertProspect(sup);

		dealer__Sales_Up__c newsup = new dealer__Sales_Up__c();
		newsup.Name = 'Test Up';
		newsup.dealer__FirstName__c = 'John';
		newsup.dealer__LastName__c= 'Smith';
		newsup.dealer__Mobile__c='5305555765';
		newsup.dealer__Email__c='test@emailtest.com';
		newsup.dealer__Phone__c='5305555765';
		//newsup.dealer__Desired_Stock_Num__c=User1Id;

		dealer__Sales_Up__c sup2 = new dealer__Sales_Up__c();
		sup2.Name = 'Test Up';
		sup2.dealer__FirstName__c = 'John';
		sup2.dealer__LastName__c= 'Smith';
		sup2.dealer__Mobile__c='5305555765';
		sup2.dealer__Email__c='test@emailtest.com';
		sup2.dealer__Phone__c='5305555765';

 		Prospect_Mobile.upsertUpOverride(sup2);

 		Prospect_Mobile.upsertProspect(newsup); // Duplicate for dupe catching. if dupe catching is enabled
 		Prospect_Mobile.upsertProSkip(sup2);

	}
	
}