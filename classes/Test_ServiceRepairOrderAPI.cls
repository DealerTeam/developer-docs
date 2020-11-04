@isTest
private class Test_ServiceRepairOrderAPI {

	@testSetup static void setTestData() {
		// We need a Deal with AfterMarket Lines to test this class
		TestClassUtil util = new TestClassUtil();
        dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        if(dms == null){ util.insertDMSSettings(); }

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
		
        Parts_Service_Pricing_Strategy__c ps = new Parts_Service_Pricing_Strategy__c();
        ps.Method__c = 'Jobber';
        ps.Active__c = true;
        ps.Description__c = 'test';
        ps.Default__c = true;
        ps.dealer__Parts_Variable_Amount__c = 10;
        ps.dealer__Formula_Operand__c = '+';
        insert ps;  

        dealer__Dealer_Location_User__c locU = new dealer__Dealer_Location_User__c();
        locU.dealer__Dealer_Location__c = Loc.id;
        locU.dealer__User__c = usr.id;
        insert locU;

		// Insert an Example RO
		Id roId = util.insertServiceRepairOrder();

		// Create the Deal
		Id dealId = util.insertCarDeal();
		Id kitId = util.insertPartsKit();

		// Create a Part For Record
		Parts_Master__c partMaster = TestClassUtil.insertPartsMaster();
		Parts_Inventory__c part = TestClassUtil.insertPartInventory(partMaster.Id, loc.Id);

		
		// Add Aftermarket Items, including parts kits
		List<After_Market__c> amItems = new List<After_Market__c>();
		amItems.add(new After_Market__c(
				Car_Deal__c=dealId,
				Name='Kit 1a',
				Parts_Kit__c=kitId,
				Labor_Sale__c=100,
				Description__c='Labor component of the kit sale line'
			)
		);

		amItems.add(new After_Market__c(
				Car_Deal__c=dealId,
				Parts_Kit__c=kitId,
				Name='Kit 1a',
				Part__c=part.Id,
				Sale_Price__c=90,
				Description__c='Part component of the kit sale line'
			)
		);

		amItems.add(new After_Market__c(
				Car_Deal__c=dealId,
				Name='Labor', 
				Description__c='Labor only sale',
				Labor_Sale__c=109,
				Sale_Price__c=200
			)
		);		

		amItems.add(new After_Market__c(
				Car_Deal__c=dealId,
				Name='Sublet', 
				Description__c='Sublet only sale',
				Sale_Price__c=200
			)
		);		

		amItems.add(new After_Market__c(
				Car_Deal__c=dealId,
				Name='EZ Lock Part', 
				Description__c='Part only sale',
				Part__c=part.Id,
				Sale_Price__c=200
			)
		);	

		amItems.add(new After_Market__c(
				Car_Deal__c=dealId,
				Name='EZ Lock Part', 
				Description__c='Part only sale',
				Part__c=part.Id,
				Sale_Price__c=200
			)
		);

		amItems.add(new After_Market__c(
				Car_Deal__c=dealId,
				Name='EZ Lock Part', 
				Description__c='Part only sale',
				Part__c=part.Id,
				Sale_Price__c=200
			)
		);	

		amItems.add(new After_Market__c(
				Car_Deal__c=dealId,
				Name='EZ Lock Part', 
				Description__c='Part only sale',
				Part__c=part.Id,
				Sale_Price__c=200
			)
		);					


		amItems.add(new After_Market__c(
				Car_Deal__c=dealId,
				Name='EZ Lock Part', 
				Description__c='Part only sale',
				Part__c=part.Id,
				Sale_Price__c=200
			)
		);					


		amItems.add(new After_Market__c(
				Car_Deal__c=dealId,
				Name='EZ Lock Part', 
				Description__c='Part only sale',
				Part__c=part.Id,
				Sale_Price__c=200
			)
		);					
												
		


		insert amItems;

	}

	@isTest static void testCreateDeliveryRO() {
		Dealer_Location__c loc = [SELECT Id from Dealer_Location__c LIMIT 1];
		Deal__c deal = [SELECT Id, dealer__Store_Location__c, Vehicle__c, Buyer__c, Mileage__c FROM Deal__c LIMIT 1];
		deal.Store_Location__c=loc.Id;

		Test.startTest();
			ServiceRepairOrderAPI.createRepairOrderFromDeal(deal);

			// Assertions
			dealer__Parts_Invoice_Line__c[] invLines = [SELECT Id, Name FROM dealer__Parts_Invoice_Line__c];
			System.debug(invLines);
			System.assert(invLines.size()==7);
		Test.stopTest();
	}

	@isTest static void testRemotes() {

		Service_Repair_Order__c sro = [SELECT Id, Name FROM Service_Repair_Order__c LIMIT 1];
		ServiceRepairOrderAPI.findRecent();
		ServiceRepairOrderAPI.findRoByName(sro.Name);
		ServiceRepairOrderAPI.findById(sro.Id);
	}
}