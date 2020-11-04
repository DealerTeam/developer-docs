@isTest 
public class SevenHundredCreditApiTestClass 
{
    @isTest static void CreateInquiryApiTest() 
    {
    
        Test.setMock(HttpCalloutMock.class, new CreateInquiryServiceMock());
        
        Test.startTest();
			SevenHundredCreditInquiry.Inquiry inquiry = new SevenHundredCreditInquiry.Inquiry();			
			
		    PopulateProperties(inquiry.Properties);
			PopulatePrimaryApplicant(inquiry.PrimaryApplicant);
			PopulateCoApplicant(inquiry.CoApplicant);
			PopulateVehicle(inquiry.Vehicle);

	        SevenHundredCreditAPI.InquiryResponse response = SevenHundredCreditAPI.CreateInquiry(inquiry);
        Test.stopTest();        
        
        system.assertEquals(response.TransId, '700D000393564');
        system.assertEquals(response.Token, '700D5ec3cfb1-de6c-48d6-a22e-47a9b231de0e');
        system.assertEquals(response.IframeUrl, 'https://www.700creditsolution.com/xmlgatewayiframe.aspx?url=1234-de6c-5678-a22e-47a9b231de0e&amp;user=iframeps');
        system.assertEquals(response.Tier, '1');
        system.assertEquals(response.ResultCode, 'X');
        system.assertEquals(response.ResultDescription, 'No Hit');
        system.assertEquals(response.Product, 'CREDIT');
       
    }
    
	public class CreateInquiryServiceMock implements HttpCalloutMock
	{
	
	    public HTTPResponse respond(HTTPRequest request) 
	    {
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{"Product":"CREDIT","TransId":"700D000393564","Token":"700D5ec3cfb1-de6c-48d6-a22e-47a9b231de0e","IframeUrl":"https://www.700creditsolution.com/xmlgatewayiframe.aspx?url=1234-de6c-5678-a22e-47a9b231de0e&amp;user=iframeps","Tier":"1","ResultCode":"X","ResultDescription":"No Hit","Score":"720"}');

            response.setStatusCode(200);
            return response;
	    }
	        
	}
	
	static void PopulatePrimaryApplicant(SevenHundredCreditApplicant.PrimaryApplicant applicant)
	{
		applicant.NAME = 'John Q Smith';
		applicant.SSN = '587-94-9876';
		applicant.ADDRESS = '1234 Anywhere St.';
		applicant.CITY = 'San Diego';
		applicant.STATE = 'CA';
		applicant.ZIP = '92111';
		applicant.DOB = '12/17/68';
		applicant.EMAIL = 'johnsmith@gmail.com';
		applicant.PREVADDRESS = '1234 Anywhere St.';
		applicant.PREVCITY = 'San Diego';
		applicant.PREVSTATE = 'CA';
		applicant.PREVZIP = '92111';
		applicant.EMPLOYER = 'DealerTeam';
		applicant.POSITION = 'Developer';
		applicant.WPHONE = '530-555-1212';
		applicant.MOBILE = '530-555-1212';
		applicant.YEARS = '10';
		applicant.TYPEOFBUSINESS = 'Software';
		applicant.MINCOME = '4000';
		applicant.OTHERINCOME = '0';
		applicant.OTHERINCOMEEXPLN = 'N/A';
		applicant.MONTHS = '10'; 
	}
	
	static void PopulateCoApplicant(SevenHundredCreditApplicant.CoApplicant applicant)
	{
		applicant.SPOUSE = 'Tina J Smith';
		applicant.SPOUSESSN = '537-92-9778';
		applicant.SPOUSEAGE = '32';
		applicant.SPOUSEDOB = '11/07/1985';
		applicant.SPOUSEADDRESS = '1234 Anywhere St.';
		applicant.SPOUSECITY = 'San Diego';
		applicant.SPOUSESTATE = 'CA';
		applicant.SPOUSEZIP = '92111';   		
	}
	
	static void PopulateVehicle(SevenHundredCreditVehicle vehicle)
	{
		vehicle.NVINNUMBER = '4567891234';
		vehicle.YEAR = '2017';
		vehicle.NMAKE = 'Toyota';
		vehicle.MODEL = 'Tundra';
		vehicle.STOCKNUMBER = '878';		
	}
	
	static void PopulateProperties(SevenHundredCreditInquiry.InquiryBaseProperties props)
	{
		props.ACCOUNT = 'dt';
		props.PASSWD = 'somepass';
		props.PRODUCT = 'CREDIT'; // Enum - CREDIT, OFAC, IDCHECK, REDFLAG ,PRESCR, SAVEONLY 
		// Either BUREAU or MULTIBUR will be sent, not both, but populated here for testing
		props.BUREAU = 'TU'; // Enum - TU, XPN, EFX
		props.MULTIBUR = 'TU:XPN:EFX'; // Enum - TU, XPN, EFX
		props.A_USER_NAME = 'SomeUser';
		props.A_USER_ID = '1234';
		props.APP_MODIFIED = 'Y';
	}
}