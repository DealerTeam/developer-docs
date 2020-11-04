@isTest
private class TestLMSSalesUpEvents {
	
	@testSetup static void testSetup() {
        TestClassUtil tu = new TestClassUtil();

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
        	dealer__CRMSettings__c crm = dealer__CRMSettings__c.getOrgDefaults();
	        if(crm==new dealer__CRMSettings__c()) {
	            crm =  new dealer__CRMSettings__c(
	                            setupOwnerId = System.UserInfo.getOrganizationId()
	                        );
	            crm.dealer__UrbanScience_Active__c = true;
	            insert crm;
	    	}
    }

    dealer__Sales_Up__c SU = new dealer__Sales_Up__c();
        SU.Name = 'Test SalesUP';
        SU.dealer__Buyer_Contact__c = tu.insertContact();
        //SU.dealer__Co_Buyer_Contact__c = insertContact();
        SU.dealer__Desired_Stock_Num__c = tu.insertVehicleInventory();
        SU.dealer__Make__c = 'Telsa';
        SU.dealer__FirstName__c = 'TestFirstName';
        SU.dealer__LastName__c = 'SalesSetup';
        SU.dealer__Lead_Origination_Service__c='Urban Science';
        SU.dealer__LMS_ID__c = '123456789000001';
        SU.dealer__Sold__c = false;
        SU.dealer__Demo__c = false;
        insert SU;
}

    static testMethod void SalesUpCreateTest() {

    	TestClassUtil tu = new TestClassUtil();

    	dealer__Sales_Up__c SU = new dealer__Sales_Up__c();
        SU.Name = 'Test SalesUP';
        SU.dealer__Buyer_Contact__c = tu.insertContact();
        //SU.dealer__Co_Buyer_Contact__c = insertContact();
        SU.dealer__Desired_Stock_Num__c = tu.insertVehicleInventory();
        SU.dealer__Make__c = 'Telsa';
        SU.dealer__FirstName__c = 'TestFirstName';
        SU.dealer__LastName__c = 'LastName';
        SU.dealer__Lead_Origination_Service__c='Urban Science';
        SU.dealer__LMS_ID__c = '123456789000000';
        insert SU;

    }

    static testMethod void SalesUpUpdateTest() {

        dealer__Sales_Up__c objSup = [Select id,dealer__LastName__c from dealer__Sales_Up__c limit 1];
        objSup.dealer__LastName__c = 'SupLast';
        objSup.dealer__Sold__c = true;
        objSup.dealer__Demo__c = true;
        update objSup;

    }
	
}