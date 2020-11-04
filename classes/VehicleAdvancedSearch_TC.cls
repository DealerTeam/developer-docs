@isTest
private class VehicleAdvancedSearch_TC{
	
	Static testmethod Void UnitMilestone(){

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

	    dealer__DMS_Settings__c DMS = new dealer__DMS_Settings__c(
	    	Name = 'ActiveSettings', 
	    	dealer__Service_Current_Invoice_Number__c=100001,
	    	dealer__Parts_Current_Invoice_Number__c=100001, 
	    	dealer__Parts_Current_Quote_Number__c=100001, 
	    	dealer__Default_Tax_Rate__c = 7,
	    	dealer__Vehicle_Search_Default_Status__c='Ready for Sale'
	    );
	    insert DMS;

		dealer__Vehicle_Inventory__c dvi = new dealer__Vehicle_Inventory__c();
		dvi.dealer__VIN__c ='12';
		dvi.dealer__Engine_Description__c ='Test';
		dvi.Conversion_Cost__c=1; 
		dvi.dealer__Make__c ='Test';
		dvi.dealer__Model__c='test';
		dvi.dealer__Stock_Number__c='12';
		dvi.dealer__Year__c='2014';
		insert dvi;

		Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
		 User u = new User();
		 u.Alias = 'standt';
		 u.Email='testabc@gmail.com';
		 u.EmailEncodingKey='UTF-8';
		 u.LastName='Testing';
		 u.LanguageLocaleKey='en_US';
		 u.LocaleSidKey='en_US';
		 u.ProfileId = p.Id;
		 u.TimeZoneSidKey='America/Los_Angeles';
		 u.UserName='tesa00@gmail.com';
		 u.Dealership_Location__c ='Test';
		//u.service_manager__c  ='Test';
		 u.Division ='12365';
		 insert u;
		 
		dealer__Dealer_Location__c ddl = new dealer__Dealer_Location__c();
		ddl.Name ='Test';
		ddl.dealer__City__c ='Test';
		ddl.dealer__Postal_Code__c='301352';
		ddl.dealer__State__c='Te';
		ddl.dealer__Company_Number__c='12365';
		ddl.dealer__Service_Director__c =u.id;
		ddl.Name='Test';
		//ddl.Region__c='Test';
		insert ddl;

		// DR1a
		PageReference searchPage = Page.VehicleSearchAdvanced;
		searchPage.getParameters().put('year', '2014');
		searchPage.getParameters().put('make', 'Test');
		searchPage.getParameters().put('model', 'test');
		searchPage.getParameters().put('debug', 'true');
		searchPage.getParameters().put('proposalId', '1234567');
		Test.setCurrentPage(searchPage);
		// / DR1a

		VehicleAdvancedSearch vas = new VehicleAdvancedSearch();

		vas.getQueryString();
		vas.buildQuery();
		vas.doSearch();
		vas.returnToDeal();
		vas.getVehResult();
		vas.getYears();
		vas.getMakes();
		vas.getModels(); 
		vas.getTrims();
		vas.getRecordTypes();
		vas.getInteriors(); 
		vas.getVehTypes(); 
		//vas.getRegions();
		vas.getBranchLocations();
		vas.getStatusCodes();
		vas.getRampTypes();
		vas.getRampOperationItems();
		vas.getConversions();
		vas.getConversionModels();
		vas.getRampLocations();   
		vas.getnewUsedOthers();   

		// DR1b
		vas.reset();

		searchPage.getParameters().put('year', '2014');
		searchPage.getParameters().put('make', 'Test');
		searchPage.getParameters().put('model', 'test');

		vas.vehType = 'Used';
		vas.recordType = 'Used';
		vas.newUsedOther = 'Used';
		vas.minPrice = '0';
		vas.maxPrice = '100000';
		vas.trim = 'test';
		vas.extColor = 'test';
		vas.intColor = 'test';
		vas.interior = 'test';
		vas.minOdometer = 'test';
		vas.maxOdometer = 'test';
		vas.convMfg = 'test';
		vas.convModel = 'test';
		vas.rampType = 'test';
		vas.rampOperation = 'test';
		vas.rampLoc = 'test';
		vas.kneel = 'Yes';
		vas.minConv = 'test';
		vas.maxConv = 'test';
		vas.minChassis = 'test';
		vas.maxChassis = 'test';
		vas.maxChassis = 'test';
		vas.status = 'test';
		vas.buildQuery();

		vas.status = 'All';
		vas.kneel = 'No';
		vas.buildQuery();

		vas.stockNum = '12365';
		vas.buildQuery();
		// /DR1b
		// 

		}

	}
}