@isTest
private class IdentityApiTestClass implements TestInterfaces.ITest
{
	@testSetup public static void SetupData() {}

	@isTest static void test_method_one() 
	{
		Test.setMock(HttpCalloutMock.class, new IdentityApiMock());
		Test.StartTest();
			List<IdentityApi.caller> callerObject = IdentityApi.callerIdentification('555-555-1212');
		Test.StopTest();

		for(IdentityApi.caller call: callerObject)
		{
			system.assertEquals(call.line_type, 'mobile');
			system.assertEquals(call.is_connected, true);
			system.assertEquals(call.is_valid, true);
			system.assertEquals(call.do_not_call, true);
			system.assertEquals(call.Salutation, 'some string');
			system.assertEquals(call.FirstName, 'some string');
			system.assertEquals(call.MiddleName, 'some string');
			system.assertEquals(call.LastName, 'some string');
			system.assertEquals(call.Suffix, 'some string');
			system.assertEquals(call.PersonMailingStreet, 'some string');
			system.assertEquals(call.PersonMailingCity, 'some string');
			system.assertEquals(call.PersonMailingState, 'some string');
			system.assertEquals(call.PersonMailingPostalCode, 'some string');
			system.assertEquals(call.PersonMailingCountry, 'some string');
		}
	}


	public class IdentityApiMock implements HttpCalloutMock
	{
	
	    public HTTPResponse respond(HTTPRequest request) 
	    {
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody('[{"line_type":"mobile","is_connected":true,"is_valid":true,"do_not_call":true,"Salutation":"some string","FirstName":"some string","MiddleName":"some string","LastName":"some string","Suffix":"some string","PersonMailingStreet":"some string","PersonMailingCity":"some string","PersonMailingState":"some string","PersonMailingPostalCode":"some string","PersonMailingCountry":"some string"}]');

            response.setStatusCode(200);
            return response;
	    }
	        
	}
	
}