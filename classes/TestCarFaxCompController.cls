@isTest
private class TestCarFaxCompController implements TestInterfaces.ITest
{
	@testSetup public static void SetupData()
	{
		TestFactory.createSObject(new Service_Vehicle__c(vin__c='19UUA66266A024110'), true);
	}
    @isTest static void testGetVehicleVin(){
        //Create test vehicles
        TestFactory.createSObject(new Vehicle_Inventory__c(vin__c='JF2GPBCC0EH318965'), true);
        TestFactory.createSObject(new Service_Vehicle__c(vin__c='5N1AT2ML4FC754694'), true);
        
        //get the id of each (soql query)
        Vehicle_Inventory__c vehInv = [select id, vin__c from vehicle_Inventory__c where Vin__c ='JF2GPBCC0EH318965'];
        Service_Vehicle__c sv =  [select id, vin__c from service_vehicle__c where Vin__c ='5N1AT2ML4FC754694'];

        String vehInvVin = CarFaxCompController.GetVehicleVin(vehInv.Id);
            System.assert(vehInv.Vin__c == vehInvVin, 'Vehicle Inventory returned wrong vin number.' );
        
        String svVin = CarFaxCompController.GetVehicleVin(sv.Id);
            System.assert(sv.Vin__c == svVin, 'Service Vehicle\'s returned wrong vin number.' );

    }

	static testMethod void testBatch() {
		Dealer_Location__c loc = TestClassUtil.insertDealerLocation('RD1', 'Redding Motorcar Company');
        loc.CarFax_Username__c = 'test';
        loc.CarFax_Password__c = 'test';
        update loc;
        
		dealer__Vehicle_Inventory__c objveh = new dealer__Vehicle_Inventory__c(Store_Location__c = loc.Id, In_Stock__c = true, dealer__Make__c = 'TMake', dealer__Model__c = 'TModel', dealer__Stock_Number__c= 'TStock1', dealer__VIN__c = '1C4RDJDG0EC973121', dealer__Year__c = '2016');
		insert objVeh;

		Test.StartTest();
		// BatchMigrateVehicleEquipment migBatch = new BatchMigrateVehicleEquipment();
        // ID batchprocessid = Database.executeBatch(migBatch, 100); // 200
        SchedulableContext sc = null;
        SchedulableCarFaxHistoryReport tsc = new SchedulableCarFaxHistoryReport();
        tsc.execute(sc);
		Test.StopTest();

	}
	
    @isTest static void TestGoodVin()
    {
        Test.setMock(HttpCalloutMock.class, new CreateInquiryServiceMock(true));
        
        Test.startTest();
			DoCallOut('19UUA66266A024110');
        Test.stopTest();  
    }

    @isTest static void TestBadVin()
    {
        Test.setMock(HttpCalloutMock.class, new CreateInquiryServiceMock(false));
        
        Test.startTest();
			DoCallOut('22UU444446A024110');
        Test.stopTest();  
    }

	@isTest static void TestErrors()
    {
        Test.setMock(HttpCalloutMock.class, new CreateInquiryServiceMock(false));
        
        Test.startTest();
			DoCallOut('19UUA66266A024110');
        Test.stopTest();  
    }

    @isTest static void TestAura()
    {
        Profile prof = [select id from profile where name='system Administrator'];
        User u = (User)TestFactory.createSObject(new User(alias = 'usr', email='us.name@vmail.com',
                  emailencodingkey='UTF-8', lastname='lstname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='testuser128@testorgx.com',
                  Division='DT1'), true);
        TestFactory.createSObject(new Dealer_Location__c(Carfax_Username__c='uname', Carfax_Password__c='pass', Company_Number__c='DT1'), true);
        system.runAs(u)
        {
                Test.setMock(HttpCalloutMock.class, new CreateInquiryServiceMock(true));
                
                Test.startTest();
                    DoCallOutTwo('19UUA66266A024110');
                Test.stopTest(); 
        }
    }

    @isTest static void TestAuraTwo()
    {
        Profile prof = [select id from profile where name='system Administrator'];
        User u = (User)TestFactory.createSObject(new User(alias = 'usr', email='us.name@vmail.com',
                  emailencodingkey='UTF-8', lastname='lstname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='testuser128@testorgx.com',
                  Division='DT1'), true);
        TestFactory.createSObject(new Dealer_Location__c(Carfax_Username__c='uname', Carfax_Password__c='pass', Company_Number__c='DT1'), true);
        system.runAs(u)
        {
                Test.setMock(HttpCalloutMock.class, new CreateInquiryServiceMock(true));

                Test.startTest();
                    DoCallOutTwo('194UA66266A024110');
                Test.stopTest();  
        }
    }


	@Future(callout = true)
	static void DoCallOut(string vin)
	{
		CarFaxReportHandler.CreateRequest(new Set<string>{ vin }, 'uname', 'password', 'VHR');
	}

	@Future(callout = true)
	static void DoCallOutTwo(string vin)
	{
		CarFaxCompController.RunCarFaxReport(vin, 'VHR');
	}

    public class CreateInquiryServiceMock implements HttpCalloutMock
	{
		boolean success;
        public CreateInquiryServiceMock (boolean suc)
        {
			success = suc;
        }
	
	    public HTTPResponse respond(HTTPRequest request) 
	    {
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');

			if(success)
            	response.setBody('{"AccidentCount":"0","AccidentIndicator":"false","BrandedTitleIndicator":"false","DamageIndicator":"false","FrameDamageIndicator":"false","MajorProblemIndicator":"false","VehicleHistoryReportUrl":null,"NumberOfOwners":"3","ServiceRecordCount":"4"}');
			else
				response.setBody('{"Errors":["Bad Errors"],"AccidentCount":"0","AccidentIndicator":"false","BrandedTitleIndicator":"false","DamageIndicator":"false","FrameDamageIndicator":"false","MajorProblemIndicator":"false","VehicleHistoryReportUrl":null,"NumberOfOwners":"3","ServiceRecordCount":"4"}');

            response.setStatusCode(200);
            return response;
	    }
	        
	}
	
}