@isTest
private class TestCreditReportController implements TestInterfaces.ITest
{
	@testSetup public static void SetupData(){}
	
    @isTest static void TestCreateCreditInquiry()
    {
        Test.setMock(HttpCalloutMock.class, new CreateInquiryServiceMock('CREDIT', true));
        
        Test.startTest();
            Dealer_Location__c loc = (Dealer_Location__c)TestFactory.createSObject(new Dealer_Location__c(), true);
            Sales_Up__c sup = (Sales_Up__c)TestFactory.createSObject(new Sales_Up__c(Store_Location__c = loc.Id), true);
            Credit_Application__c app = (Credit_Application__c)TestFactory.createSObject(new Credit_Application__c(Sales_Up__c = sup.Id), true);
			DoCallOut(app.Id);
        Test.stopTest();  
    }

    @isTest static void TestCreateCreditInquiryTwo()
    {
        Test.setMock(HttpCalloutMock.class, new CreateInquiryServiceMock('CREDIT', false));
        
        Test.startTest();
            Dealer_Location__c loc = (Dealer_Location__c)TestFactory.createSObject(new Dealer_Location__c(), true);
            Sales_Up__c sup = (Sales_Up__c)TestFactory.createSObject(new Sales_Up__c(Store_Location__c = loc.Id), true);
            Credit_Application__c app = (Credit_Application__c)TestFactory.createSObject(new Credit_Application__c(Sales_Up__c = sup.Id), true);
			DoCallOut(app.Id);
        Test.stopTest();  
    }

	@Future(callout = true)
	static void DoCallOut(string appId)
	{
		CreditReportController.RunSevenHundredCreditReport(appId, 'CREDIT', new List<string> {'TU'});
	}

    public class CreateInquiryServiceMock implements HttpCalloutMock
	{
        string product;
		boolean success;
        public CreateInquiryServiceMock (string param, boolean suc)
        {
            product = param;
			success = suc;
        }
	
	    public HTTPResponse respond(HTTPRequest request) 
	    {
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');

			if(success)
            	response.setBody('{"Product":"' + product + '","TransId":"700D000393564","Token":"700D5ec3cfb1-de6c-48d6-a22e-47a9b231de0e","IframeUrl":"https://www.700creditsolution.com/xmlgatewayiframe.aspx?url=1234-de6c-5678-a22e-47a9b231de0e&amp;user=iframeps","Tier":"1","ResultCode":"X","ResultDescription":"No Hit","Score":"720"}');
			else
				response.setBody('{"Product":"' + product + '","TransId":"700D000393564","Error":"Threw Exception","Token":"700D5ec3cfb1-de6c-48d6-a22e-47a9b231de0e","IframeUrl":"https://www.700creditsolution.com/xmlgatewayiframe.aspx?url=1234-de6c-5678-a22e-47a9b231de0e&amp;user=iframeps","Tier":"1","ResultCode":"X","ResultDescription":"No Hit","Score":"720"}');

            response.setStatusCode(200);
            return response;
	    }
	        
	}
	
}