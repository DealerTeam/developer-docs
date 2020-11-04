@isTest
public with sharing class SevenHundredCreditApplicationHandlerTC
{
    @isTest static void TestCreateCreditInquiry()
    {
        Test.setMock(HttpCalloutMock.class, new CreateInquiryServiceMock('CREDIT'));
        
        Test.startTest();
            dealer__Credit_Application__c app = getCreditApp();
            DoCallOut(app.Id, 'CREDIT');
        Test.stopTest();  
    }

    @isTest static void TestCreateOfacInquiry()
    {
        Test.setMock(HttpCalloutMock.class, new CreateInquiryServiceMock('OFAC'));
        
        Test.startTest();
            dealer__Credit_Application__c app = getCreditApp();
            DoCallOut(app.Id, 'OFAC');
        Test.stopTest();  
    }

    @isTest static void TestCreateRedFlagInquiry()
    {
        Test.setMock(HttpCalloutMock.class, new CreateInquiryServiceMock('REDFLAG'));
        
        Test.startTest();
            dealer__Credit_Application__c app = getCreditApp();
            DoCallOut(app.Id, 'REDFLAG');
        Test.stopTest();  
    }
    
    @Future(callout = true)
    static void DoCallOut(Id appId, string product)
    {
        SevenHundredCreditApplicationHandler.CreateInquiry(new Set<Id> { appId }, product, new List<string> {'TU'});
    }

    static dealer__Credit_Application__c getCreditApp()
    {
        dealer__Dealer_Location__c objLocation = new dealer__Dealer_Location__c(Name = 'Test Location', dealer__City__c = 'City', dealer__Company_Number__c = '561', dealer__Postal_Code__c = 'Code', dealer__State__c = 'ST',
         SevenHundredCredit_Acount_Name__c = 'Name', SevenHundredCredit_Password__c = '1234');
        insert objLocation;	
        Sales_Up__c sup = (Sales_Up__c)TestFactory.createSObject(new Sales_Up__c(Store_Location__c = objLocation.Id), true);


        dealer__Credit_Application__c app = new dealer__Credit_Application__c();
        app.Sales_Up__c = sup.Id;
        app.First_Name__c = 'Fred';
        app.Last_Name__c = 'Flintstone';
        app.Social_Security_Number__c = '000000000';
        app.BirthDate__c = Date.parse('12/17/1968');
		app.Current_Address_Street__c = '123 main st.';
		app.Current_Address_City__c = 'Bedrock';
		app.Current_Address_State__c = 'CA';
		app.Current_Address_Zip__c = '92028';
        app.Store_Location__c = objLocation.Id;

        insert app;

        return app;
    }

    public class CreateInquiryServiceMock implements HttpCalloutMock
	{
        string product;
        public CreateInquiryServiceMock (string param)
        {
            product = param;
        }
	
	    public HTTPResponse respond(HTTPRequest request) 
	    {
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{"Product":"' + product + '","TransId":"700D000393564","Token":"700D5ec3cfb1-de6c-48d6-a22e-47a9b231de0e","IframeUrl":"https://www.700creditsolution.com/xmlgatewayiframe.aspx?url=1234-de6c-5678-a22e-47a9b231de0e&amp;user=iframeps","Tier":"1","ResultCode":"X","ResultDescription":"No Hit","Score":"720"}');

            response.setStatusCode(200);
            return response;
	    }
	        
	}
}