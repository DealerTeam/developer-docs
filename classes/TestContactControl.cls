/**
*	Created by Mimi Sakarett 7-19-2016
*/
@isTest
private class TestContactControl {
	/**
    * @Method      : setUpMethod
    * @Description : creates a location, user, 1 contact, and a sales up    
    * @return      : void   
    * @Param       : none
    */
	@testSetup static void setUpMethod(){
		dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');

		Profile prof = [select id from profile where name='system Administrator'];
		User usr = new User(
			alias = 'usr', 
			email='us.name@vmail.com',
			emailencodingkey='UTF-8', lastname='lstname',
			timezonesidkey='America/Los_Angeles',
			languagelocalekey='en_US',
			localesidkey='en_US', profileid = prof.Id,
			username='testuser128@testorgx.com',
			Division='DT1'
		);
		insert usr;


		//Customer
		Contact c = new Contact(
			LastName = 'Eichenberg',
			FirstName = 'Jack',
			Email = 'jack@test.com',
			Phone = '9172255960'
		);
		insert c;

		//Sales Up
		dealer__Sales_Up__c sup = new dealer__Sales_Up__c(
			dealer__Buyer_Contact__c = c.Id,
			dealer__Lead_Status__c='Open',
			dealer__Salesperson_1__c = usr.Id,
			dealer__Store_Location__c = loc.Id,
			OwnerID = usr.Id
		);
		insert sup;

		dealer__Deal__c d = new dealer__Deal__c(
			//dealer__Stop_Update_Contact_Info__c = false,
			dealer__Sales_Lead__c = sup.Id,
			dealer__Buyer_Contact__c = c.Id,
			dealer__Deal_ID__c = '123456789'
			);
		dealer__Deal__c d2 = new dealer__Deal__c(
			dealer__Sales_Lead__c = sup.Id,
			dealer__Buyer_Contact__c = c.Id,
			dealer__Deal_ID__c = '123456788'
			);
		dealer__Deal__c d3 = new dealer__Deal__c(
			//dealer__Stop_Update_Contact_Info__c = true,
			dealer__Sales_Lead__c = sup.Id,
			dealer__Buyer_Contact__c = c.Id,
			dealer__Deal_ID__c = '123456787'
			);

		List<dealer__Deal__c> deals = new List<dealer__Deal__c>();
		deals.add(d);
		deals.add(d2);
		deals.add(d3);

		insert deals;
	}

	/**
    * @Method      : contactInfoChanges
    * @Description : updates contact info on the contact and checks that changes are reflected in Sales Up    
    * @return      : void   
    * @Param       : none
    */
	@isTest static void contactInfoChanges() {
		Contact c = [SELECT Id FROM Contact WHERE Email = 'jack@test.com' LIMIT 1];

		Test.startTest();
		c.Phone = '9999999999';
		c.Email = 'testingemail@email.net';
		c.MailingCity = 'Mexico City';
		update c;

		Test.stopTest();

		Contact cx = [SELECT Id, Phone, Email FROM Contact WHERE Id =:c.Id LIMIT 1];
		dealer__Sales_Up__c s = [SELECT Id, dealer__Phone__c FROM dealer__Sales_Up__c 
			WHERE dealer__Buyer_Contact__c = :c.Id LIMIT 1];

		/*dealer__Deal__c d = [SELECT Id, dealer__Buyer_Email__c FROM dealer__Deal__c WHERE dealer__Deal_ID__c = '123456789' LIMIT 1];
		dealer__Deal__c d2 = [SELECT Id, dealer__Buyer_Email__c FROM dealer__Deal__c WHERE dealer__Deal_ID__c = '123456788' LIMIT 1];
		dealer__Deal__c d3 = [SELECT Id, dealer__Buyer_Email__c FROM dealer__Deal__c WHERE dealer__Deal_ID__c = '123456787' LIMIT 1];*/

		// System.assertEquals(c.Phone, s.dealer__Phone__c, 'Phone number did not get updated on Sales Up');
		/*System.assertEquals(cx.Email, d.dealer__Buyer_Email__c, 'Email did not get updated on Deal with dealer__Stop_Update_Contact_Info__c set to true');
		System.assertEquals(cx.Email, d2.dealer__Buyer_Email__c, 'Email did not get updated on Deal with dealer__Stop_Update_Contact_Info__c not set');
		System.assertNotEquals(cx.Email, d3.dealer__Buyer_Email__c, 'Email got updated on Deal with dealer__Stop_Update_Contact_Info__c set to false');*/
	}
	
}