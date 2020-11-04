/**
* TestDeskLogService - Test class for DeskLogService class
*
**
* Date            |Developer            |Work#
* Notes
* --
* 2016.11.03      |Abhishek Goel         |W-000514
* Test class for DeskLogService class
**/
@isTest
private class TestDeskLogService {
	
	@testSetup static void setUpMethod() {

		dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');

		Profile prof = [select id from profile where name='system Administrator'];
		User usr = new User(
			alias = 'usr', 
			email='us.name@vmail.com',
			emailencodingkey='UTF-8', lastname='usr',
			timezonesidkey='America/Los_Angeles',
			languagelocalekey='en_US',
			localesidkey='en_US', profileid = prof.Id,
			username='testuser128@testorgx.com',
			Division='DT1'
		);
		insert usr;

		User usr2 = new User(
			alias = 'usr2', 
			email='us.name@vmai2.com',
			emailencodingkey='UTF-8', lastname='usr2',
			timezonesidkey='America/Los_Angeles',
			languagelocalekey='en_US',
			localesidkey='en_US', profileid = prof.Id,
			username='testuser222@testorg.com',
			Division='DT1'
		);
		insert usr2;
		
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
		
		insert a;

		//Sales Up
		dealer__Sales_Up__c sup = new dealer__Sales_Up__c(
			dealer__Customer_Account__c = a.id,
			dealer__Lead_Status__c='Open',
			dealer__Salesperson_1__c = usr.Id,
			dealer__Salesperson_2__c = usr2.id,
			dealer__F_I_Manager__c = usr2.id,
			dealer__Store_Location__c = loc.Id,
			dealer__Lead_Type__c = 'Phone',
			OwnerID = usr.Id
		);
		insert sup;

		dealer__Deal__c d = new dealer__Deal__c(
			//dealer__Stop_Update_Contact_Info__c = false,
			dealer__Sales_Lead__c = sup.Id,
			dealer__Buyer__c = a.id,
			dealer__Deal_ID__c = '123456789',
			dealer__Deal_Type__c = 'X',
			dealer__Deal_Date__c = system.today()
			);
		insert d;	

		dealer__Deal__c d2 = new dealer__Deal__c(
			//dealer__Stop_Update_Contact_Info__c = false,
			dealer__Buyer__c = a.id,
			dealer__Deal_ID__c = '123456700',
			dealer__Deal_Type__c = 'F',
			dealer__Deal_Date__c = system.today()
			);
		insert d2;
	}

	static testmethod void validateDeskLogService(){
		
		dealer__Dealer_Location__c loc = [Select id, name from dealer__Dealer_Location__c limit 1];
		User usr = [Select id, name from User where lastname = 'usr'];
		User usr2 = [Select id, name from User where lastname = 'usr2'];
		dealer__Sales_Up__c sup = [Select id, name from dealer__Sales_Up__c limit 1];
		dealer__Deal__c deal = [Select id, name from dealer__Deal__c where dealer__Deal_Type__c = 'X' limit 1];

		DeskLogService.searchContext objDesk = new DeskLogService.searchContext();

		objDesk.fromDate = system.today();
		objDesk.toDate= system.today();
		
		objDesk.leadType = new List<String>();
		objDesk.leadType.add('Phone');
		
		objDesk.dealType = new List<String>();
		objDesk.dealType.add('X');

		objDesk.location = new List<String>();
		objDesk.location.add(loc.id);

		objDesk.salesperson1 = new List<String>();
		objDesk.salesperson1.add(usr.Id);

		objDesk.salesperson2 = new List<String>();
		objDesk.salesperson2.add(usr2.Id);

		objDesk.deskManager = new List<String>();
		objDesk.deskManager.add(usr2.Id);

		objDesk.financeManager = new List<String>();
		objDesk.financeManager.add(usr2.Id);

		system.debug('Search result >>'	+ DeskLogService.search(objDesk));
		List<DeskLogService.DeskLogEntry> entries = new List<dealer.DeskLogService.DeskLogEntry>();
		entries = DeskLogService.search(objDesk);
		
		system.assertNotEquals(entries, null);

		if(entries.size() > 0)
		{
			system.debug('entries.salesup.id'+ entries[0].salesup.id);
			system.debug('sup.id'+sup.id);
			system.debug('entries.dealer__Deal__c.id'+ entries[0].primaryDeal.id);
			system.debug('deal.id'+deal.id);
			system.assertEquals(entries[0].salesup.id, sup.id);
			system.assertEquals(entries[0].primaryDeal.id, deal.id);			
		}

	}
	
}