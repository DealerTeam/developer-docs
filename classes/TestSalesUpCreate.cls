/**
*	Created by Mimi Sakarett 7-18-2016
*/

@isTest
private class TestSalesUpCreate {

	/**
    * @Method      : setUpMethod
    * @Description : creates a location, user, 2 accounts, 2 contacts, and a sales up    
    * @return      : void   
    * @Param       : none
    */
	@testSetup static void setUpMethod() {
		dealer__CRMSettings__c crm = dealer__CRMSettings__c.getInstance();
		if(crm == null){ 
			crm = new dealer__CRMSettings__c();
		}
		crm.dealer__Record_Owner_Match_Salesperson__c = true;
		upsert crm;

		dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');

		Profile prof = [select id from profile where name='system Administrator'];
		
		User usr = new User(alias = 'usr', email='us.name@vmail.com',
                  emailencodingkey='UTF-8', lastname='lstname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='testuser128@testorgx.com',
                  Division='DT1');


        // create a second user for testing purposes 
        User usr2 = new User(alias = 'usr', email='user2@example.com',
                  emailencodingkey='UTF-8', lastname='two',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='user2@example.com.tesClass',
                  Division='DT1');


		List<User> users = new List<User>();
		users.add(usr);
		users.add(usr2);

		insert users;


		//Account and cobuyer account
		Account a = new Account(
			FirstName     =   'Jack',
			LastName      =   'Eichenberg',
			PersonEmail   =   'jack@test.com',
			Phone  = '9172255960',
			PersonMobilePhone = '5555555555',
			PersonMailingStreet = '2 Tudor City Place',
			PersonMailingCity = 'New York',
			PersonMailingState = 'NY',
			PersonMailingPostalCode = '10017'
		);
		Account a2 = new Account(
			FirstName     =   'Rosa',
			LastName      =   'Chilowsky',
			PersonEmail   =   'rosabanana@test.com',
			Phone  = '9177448343'
		);
		Account a3 = new Account(
			FirstName     =   'Peter',
			LastName      =   'Brannigan',
			PersonEmail   =   'pbrann@nick.net',
			Phone  = '9199199119'
		);

		List<Account> accts = new List<Account>{a, a2, a3};
		insert accts;

		//Customer
		Contact c = new Contact(
			LastName = 'Eichenberg',
			FirstName = 'Jack',
			Email = 'jack@test.com',
			Phone = '9172255960'
		);
		Contact c2 = new Contact(
			LastName = 'Chilowsky',
			FirstName = 'Rosa',
			Email = 'rosabanana@test.com',
			Phone = '9177448343'
		);

		List<Contact> conts = new List<Contact>();
		conts.add(c);
		conts.add(c2);
		insert conts;



		//Sales Up
		dealer__Sales_Up__c sup = new dealer__Sales_Up__c(
			dealer__Color_Preference_Int__c = 'purple',
			dealer__Customer_Account__c = a.Id,
			dealer__Phone__c = null,
			dealer__Buyer_Contact__c = c.Id,
			dealer__Salesperson_1__c = usr.Id,
			dealer__Store_Location__c = loc.Id,
			OwnerID = usr.Id
		);
		

		//Sales Up
		dealer__Sales_Up__c sup2 = new dealer__Sales_Up__c(
			dealer__Color_Preference_Int__c = 'green',
			dealer__Customer_Account__c = null,
			dealer__Phone__c = null,
			dealer__Buyer_Contact__c = c2.Id,
			dealer__Salesperson_1__c = usr.Id,
			dealer__Store_Location__c = loc.Id,
			OwnerID = usr.Id
		);
		List<dealer__Sales_Up__c> sups = new List<dealer__Sales_Up__c>{sup, sup2};
		insert sups;
	}

	
	/**
    * @Method      : testBackwardContactInfoUpdate
    * @Description : Updates a Sales Up and checks that the Account and Contact are also updated           
    * @return      : void   
    * @Param       : none
    */
	@isTest static void testBackwardContactInfoUpdate() {
		dealer__Sales_Up__c s = [SELECT Id, dealer__Phone__c, dealer__Customer_Account__c FROM dealer__Sales_Up__c WHERE dealer__Color_Preference_Int__c = 'purple' LIMIT 1];
		dealer__Sales_Up__c s2 = [SELECT Id, dealer__Phone__c, dealer__Buyer_Contact__c FROM dealer__Sales_Up__c WHERE dealer__Color_Preference_Int__c = 'green' LIMIT 1];
		
		Contact c = [SELECT Phone FROM Contact WHERE Id =:s2.dealer__Buyer_Contact__c LIMIT 1];
		Account a = [SELECT Phone FROM Account WHERE Id =:s.dealer__Customer_Account__c LIMIT 1];
		
		System.assertEquals(a.Phone, s.dealer__Phone__c);
		System.assertEquals(c.Phone, s2.dealer__Phone__c);

		s.dealer__Phone__c = '5555555555';
		s.dealer__Email__c = 'newemailaddress@website.com';
		update s;

		dealer__Sales_Up__c sx = [SELECT Id, dealer__Phone__c, dealer__Email__c,
			dealer__Customer_Account__c, dealer__Buyer_Contact__c 
			FROM dealer__Sales_Up__c WHERE dealer__Email__c='newemailaddress@website.com' LIMIT 1];

		Account ax = [SELECT Id, PersonEmail, Phone, PersonMobilePhone, PersonHomePhone FROM Account 
		WHERE Id =:sx.dealer__Customer_Account__c LIMIT 1];
		Contact cx = [SELECT Id, Email, Phone, MobilePhone, HomePhone FROM Contact 
		WHERE Id =:sx.dealer__Buyer_Contact__c LIMIT 1];

		System.assertEquals(sx.dealer__Email__c, cx.Email, 'Contact Email not matching');
		System.assertEquals(sx.dealer__Email__c, ax.PersonEmail, 'Account Email not matching');
		System.assertEquals(sx.dealer__Phone__c, cx.Phone, 'Contact Phone number not matching');
		System.assertEquals(sx.dealer__Phone__c, ax.Phone, 'Account Phone number not matching');

	}

	/**
    * @Method      : testAccountChange
    * @Description : Changes the Account associated with a Sales Up, checks to make sure contact info is updated          
    * @return      : void   
    * @Param       : none
    */
	@isTest static void testAccountChange() {
		dealer__Sales_Up__c s = [SELECT dealer__Customer_Account__c FROM dealer__Sales_Up__c WHERE dealer__Color_Preference_Int__c = 'purple' LIMIT 1];
		Account a = [SELECT Id, Phone FROM Account WHERE Phone  = '9199199119' LIMIT 1];

		s.dealer__Customer_Account__c = a.Id;
		update s;

		dealer__Sales_Up__c sx = [SELECT dealer__Phone__c, dealer__Email__c, dealer__FirstName__c, dealer__Customer_Account__c FROM dealer__Sales_Up__c WHERE dealer__Color_Preference_Int__c = 'purple' LIMIT 1];


		System.assertEquals(a.Phone, sx.dealer__Phone__c, 'Sales Up phone not updated when Account changed');

	}

	/**
    * @Method      : testContactChange
    * @Description : Changes the Contact associated with a Sales Up, checks to make sure contact info is updated          
    * @return      : void   
    * @Param       : none
    */
	@isTest static void testContactChange() {
		dealer__Sales_Up__c s = [SELECT dealer__Buyer_Contact__c FROM dealer__Sales_Up__c WHERE dealer__Color_Preference_Int__c = 'green' LIMIT 1];
		Contact c = [SELECT Id, Phone FROM Contact WHERE Phone  = '9172255960' LIMIT 1];

		s.dealer__Buyer_Contact__c = c.Id;
		update s;

		dealer__Sales_Up__c sx = [SELECT dealer__Phone__c FROM dealer__Sales_Up__c WHERE dealer__Color_Preference_Int__c = 'purple' LIMIT 1];


		System.assertEquals(c.Phone, sx.dealer__Phone__c, 'Sales Up phone not updated when Account changed');

	}

	/**
    * @Method      : testOwnerUpdate
    * @Description : Changes the SP1 and checks to ensure that the Owner also changed         
    * @return      : void   
    * @Param       : none
    */
	@isTest static void testOwnerUpdate(){
		User u1 = [SELECT Id FROM User WHERE username='user2@example.com.tesClass' LIMIT 1];
		dealer__Sales_Up__c s = [SELECT Id FROM dealer__Sales_Up__c WHERE dealer__Color_Preference_Int__c = 'purple' LIMIT 1];
		s.dealer__Salesperson_1__c = u1.Id;
		update s;

		dealer__Sales_Up__c sx = [SELECT Id, OwnerID FROM dealer__Sales_Up__c WHERE dealer__Color_Preference_Int__c = 'purple' LIMIT 1];
		System.assertEquals(u1.Id, sx.OwnerID);
	}
}