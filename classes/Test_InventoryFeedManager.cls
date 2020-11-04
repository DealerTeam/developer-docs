@isTest
private class Test_InventoryFeedManager {
	
	@TestSetup
	static void insertTestData() {

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

        		List<dealer__Vehicle_Inventory__c> invList = new List<dealer__Vehicle_Inventory__c>();
        		dealer__Vehicle_Inventory__c inv1 = new dealer__Vehicle_Inventory__c(
                                        Name='test',
                                        dealer__VIN__c='3GNEK12Z15G244588',
                                        dealer__Make__c='Chevrolet',
                                        dealer__Model__c='1500',
                                        dealer__Stock_Number__c='VT100',
                                        dealer__Year__c='2012',
                                        dealer__In_Stock__c=true
                                    );
        		invList.add(inv1);
        		dealer__Vehicle_Inventory__c inv2 = new dealer__Vehicle_Inventory__c(
                                        Name='test',
                                        dealer__VIN__c='3GNEK12Z15G244589',
                                        dealer__Make__c='Chevrolet',
                                        dealer__Model__c='2500',
                                        dealer__Stock_Number__c='VT101',
                                        dealer__Year__c='2014',
                                        dealer__In_Stock__c=true
                                    ); 
				invList.add(inv2);

        		insert invList;

        		// Create a few images
        		insert new dealer__Inventory_Images__c(
        						dealer__Vehicle_Inventory__c=inv1.Id,
        						dealer__Image_URL__c='http://mockURL.com',
        						dealer__Height__c=50,
        						dealer__Width__c=50,
        						dealer__UUID__c='a123123131231313212',
        						dealer__MIME_Type__c='image/png'
        				);

        		// Create the options

    	}

	}


	static testmethod void testInvFeed() {
		User u = [Select Id from User WHERE Username='testuser128@testorgx.com' limit 1];
		System.runAs(u) {

			InvFeed invFeedC = new InvFeed();

			// Load Feed Table
			invFeedC.loadFeedTable();


			// Set some items to include
			List<dealer__InventoryFeed__c> feedItems = new List<dealer__InventoryFeed__c>();
			for(dealer__InventoryFeed__c f : [Select Id from dealer__InventoryFeed__c ]) {
				f.dealer__Include__c=true;
				feedItems.add(f);
			}

			update feedItems;

			String feedOutPut = invFeedC.getDisplayFeed();

			Test.setCurrentPageReference(new PageReference('Page.InvWebFeed'));
			System.currentPageReference().getParameters().put('vin', '3GNEK12Z15G244588');
			invFeedC = new invFeed();
			feedOutPut = invFeedC.getDisplayFeed();

			// test the remotes
			dealer__InventoryFeed__c f1 = [Select Id from dealer__InventoryFeed__c limit 1];
			InvFeed.saveInclude(f1.Id);
			InvFeed.saveLabel(f1.Id+':MyNewLabel');
		}
	}

	@isTest
	static void testInvFeedXml() {
		User u = [Select Id from User WHERE Username='testuser128@testorgx.com' limit 1];
		System.runAs(u) {

			InvFeed invFeedC = new InvFeed();

			// Load Feed Table
			invFeedC.loadFeedTable();


			// Set some items to include

			String feedOutPut = invFeedC.getDisplayFeed();

			Test.setCurrentPageReference(new PageReference('Page.InvWebFeed?xmloutput=true'));
			invFeedC = new invFeed();
			feedOutPut = invFeedC.getDisplayFeed();
		}
	}
}