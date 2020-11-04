@isTest
private class DealerTrackCreditAppExtTC 
{
	static DealerTrackCreditApplicationExt creditApp;
    
	@isTest static void TestExtPassOne() 
	{
        Test.setMock(HttpCalloutMock.class, new DealerTrackLeadServiceMock());
        
        Test.startTest();
            dealer__Credit_Application__c app = getGoodCreditAppOne();
            ApexPages.currentPage().getParameters().put('Id', app.Id);
            creditApp = new DealerTrackCreditApplicationExt(new ApexPages.StandardController(app));
			creditApp.creditapp = app;
			creditApp.Dto.EnumProperties.LeadType = 'Personal';
			string enums = JSON.serialize(creditApp.Enums);
            DoExtCreateCallOut();
			DoExtUpdateCallOut();
        Test.stopTest();
	}

	@isTest static void TestExtPassTwo() 
	{
        Test.setMock(HttpCalloutMock.class, new DealerTrackLeadServiceMock());
        
        Test.startTest();
            dealer__Credit_Application__c app = getGoodCreditAppTwo();
            ApexPages.currentPage().getParameters().put('Id', app.Id);
            creditApp = new DealerTrackCreditApplicationExt(new ApexPages.StandardController(app));
			creditApp.creditapp = app;
			creditApp.Dto.EnumProperties.LeadType = 'Personal';
			string enums = JSON.serialize(creditApp.Enums);
            DoExtCreateCallOut();
        Test.stopTest();
	}
	
	@isTest static void TestExtFail() 
	{
        Test.setMock(HttpCalloutMock.class, new DealerTrackLeadServiceMock());
        
        Test.startTest();
            dealer__Credit_Application__c app = getBadCreditApp();
            ApexPages.currentPage().getParameters().put('Id', app.Id);
            creditApp = new DealerTrackCreditApplicationExt(new ApexPages.StandardController(app));
			creditApp.Dto.EnumProperties.LeadType = 'Business';
            DoExtCreateCallOut();
			DoExtUpdateCallOut();
        Test.stopTest();
	}

    @Future(callout = true)
    static void DoExtCreateCallOut()
    {
       creditApp.createLead();
    }

    @Future(callout = true)
    static void DoExtUpdateCallOut()
    {
       creditApp.updateLead();
    }

    static dealer__Credit_Application__c getGoodCreditAppOne()
    {
        dealer__Dealer_Location__c objLocation = new dealer__Dealer_Location__c(Name = 'Test Location', dealer__City__c = 'City', dealer__Company_Number__c = '561', dealer__Postal_Code__c = 'Code', dealer__State__c = 'ST',
         DealerTrackPartnerDealerId__c = '1234');
		insert objLocation;	
        Sales_Up__c sup = (Sales_Up__c)TestFactory.createSObject(new Sales_Up__c(Store_Location__c = objLocation.Id), true);

        dealer__Credit_Application__c app = new dealer__Credit_Application__c();
        app.Sales_Up__c = sup.Id;
        app.First_Name__c = 'Fred';
        app.Last_Name__c = 'Flintstone';
        app.Social_Security_Number__c = '000000000';
        app.BirthDate__c = Date.parse('12/17/1968');
		app.Current_Address_Street__c = '1234 main st.';
		app.Current_Address_City__c = 'Bedrock';
		app.Current_Address_State__c = 'CA';
		app.Current_Address_Zip__c = '92028';
		app.Present_Employer_Street__c = '1234 main st.';
		app.Previous_Employer_1_Street__c = '1234 main st.';
		app.Current_Address_Duration_Years__c = 1.0;
		app.Current_Address_Duration_Months__c = 2.0;
		app.Co_App_Present_Employer_Street__c = '1234 main st.';
		app.Co_App_Previous_Employer_1_Street__c = '1234 main st.';
        app.Store_Location__c = objLocation.Id;
        app.DealerTrack_DTO__c = '{"LeadType" : "Business"}';
        app.Dealer_Track_Lead_Reference_Number__c = '12345';

        insert app;

        return app;
    }

    static dealer__Credit_Application__c getGoodCreditAppTwo()
    {
        dealer__Dealer_Location__c objLocation = new dealer__Dealer_Location__c(Name = 'Test Location', dealer__City__c = 'City', dealer__Company_Number__c = '561', dealer__Postal_Code__c = 'Code', dealer__State__c = 'ST',
         DealerTrackPartnerDealerId__c = '1234');
		insert objLocation;	
        Sales_Up__c sup = (Sales_Up__c)TestFactory.createSObject(new Sales_Up__c(Store_Location__c = objLocation.Id), true);

        dealer__Credit_Application__c app = new dealer__Credit_Application__c();
        app.Sales_Up__c = sup.Id;
        app.First_Name__c = 'Fred';
        app.Last_Name__c = 'Flintstone';
        app.Social_Security_Number__c = '000000000';
        app.BirthDate__c = Date.parse('12/17/1968');
		app.Current_Address_Street__c = '1234 main st.';
		app.Current_Address_City__c = 'Bedrock';
		app.Current_Address_State__c = 'CA';
		app.Current_Address_Zip__c = '92028';
		app.Present_Employer_Street__c = '1234 main st.';
		app.Previous_Employer_1_Street__c = '1234 main st.';
		app.Current_Address_Duration_Years__c = 1.0;
		app.Current_Address_Duration_Months__c = 2.0;
		app.Co_App_Present_Employer_Street__c = '1234 main st.';
		app.Co_App_Previous_Employer_1_Street__c = '1234 main st.';
        app.Store_Location__c = objLocation.Id;

        insert app;

        return app;
    }

    static dealer__Credit_Application__c getBadCreditApp()
    {
        dealer__Dealer_Location__c objLocation = new dealer__Dealer_Location__c(Name = 'Test Location', dealer__City__c = 'City', dealer__Company_Number__c = '561', dealer__Postal_Code__c = 'Code', dealer__State__c = 'ST',
         DealerTrackPartnerDealerId__c = '1234');
		insert objLocation;	
        Sales_Up__c sup = (Sales_Up__c)TestFactory.createSObject(new Sales_Up__c(Store_Location__c = objLocation.Id), true);

        dealer__Credit_Application__c app = new dealer__Credit_Application__c();
        app.Sales_up__c = sup.id;
        app.First_Name__c = null;
        app.Last_Name__c = null;
        app.Social_Security_Number__c = null;
        app.BirthDate__c = null;
		app.Current_Address_Street__c = null;
		app.Current_Address_City__c = null;
		app.Co_App_First_Name__c = 'Wilma';
		app.Co_App_Last_Name__c = null;
		app.Current_Address_State__c = 'California';
		app.Co_App_Current_Address_State__c = 'California';
		app.Current_Address_Zip__c = null;
        app.Store_Location__c = null;

        insert app;

        return app;
    }

	public class DealerTrackLeadServiceMock implements HttpCalloutMock
	{
	
	    public HTTPResponse respond(HTTPRequest request) 
	    {
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{"LeadReferenceNumber":"160000000006682934","LeadDetailUrl":"https://www.qa.dealertrack.com/Leads35/LeadDetail.aspx?leadReferenceId=160000000006439660"}');

            response.setStatusCode(200);
            return response;
	    }
	        
	}	
	
}