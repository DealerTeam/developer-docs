@isTest
private class Test_HelperClasses
{

	@isTest
	static void testDMSSettings()
	{
		PageReference dmsSettings = Page.SetupDefaultDMSSettings;
		Test.setCurrentPage(dmsSettings);
		Test.startTest();
		
		DMSSettings controller = new DMSSettings();
		
		System.assertEquals(controller.dms, null);
		controller.barnumber='ADP-12345';
		controller.epanumber='EPA-12345';
		controller.defaultTaxRate=Decimal.valueOf('9.99');
		controller.internalLaborRate=Decimal.valueOf('100.12');
		controller.warrantyLaborRate=Decimal.valueOf('115.99');
		controller.laborRate=Decimal.valueOf('125.05');
		controller.partsInvoiceNumber=Decimal.valueOf('4000');
		controller.partsQuoteNumber=Decimal.valueOf('5000');
		controller.serviceInvoiceNumber=Decimal.valueOf('6000');
		controller.printEstimate=false;
		controller.printTechTimes=false;
		controller.serviceTaxIfPartsSoldOnly=true;
		controller.serviceTaxLabor=true;
		controller.dmsIntegrationMode=false;
		controller.serviceLineTotalTrigger=true;
		controller.cashierAutoClose=true;
		controller.leadsAutoAssignManager=true;
		controller.closedDealStatusCodes='A,U,SOLD,CLOSED';
		controller.dmsName='DealerTrack';
		controller.dealNumber = 1;
		controller.deal_days = 0;
		controller.deal_rate = 0;
		controller.deal_term = 0;
		controller.deal_docfee = 85;
		controller.deal_payments = 12;
		controller.assignStockNumber=false;
		controller.assignStockNumberBySequence=false;
		controller.assignStockNumberByDate=false;
		controller.stocknumberindex=100;
		controller.serviceAppointmentNumber=2000;
		controller.dealControlsSalesUp=false;
		controller.linkedEvent=false;

		// Rental Settings
		controller.rentalMiles 		= 	150;
		controller.rentalFuelRate 	= 	9;
		controller.rentalMilesFee 	=	0.55;
		controller.rentalReFuelFee 	=	20;
		
		controller.save();

		controller.assignStockNumberByDate = true;
		controller.assignStockNumberBook = false;

		controller.save();
		
		controller.assignStockNumberByDate = false;

		controller.save();
		// Update Test
		
		DMSSettings cpi = new DMSSettings();
		System.assertNotEquals(cpi,null);
		cpi.printEstimate=true;
		cpi.printTechTimes=true;
		cpi.laborRate=Decimal.valueOf('99.95');
		
		cpi.save();

		Test.stopTest();
	}

	@isTest
   	static void testCustomObjects() {
   		
   		CustomObjects cO = new CustomObjects();
   		
   			Contact c = new Contact(
				FirstName='James',
				LastName='Rowland',
				AccountId=null,
				Birthdate=date.parse('01/01/1970'),
				Email='none@blackhole.org',
				Salutation='Mr.',
				Phone='5302221234',
				MailingStreet='555 Cypress Ave',
				MailingCity='Redding',
				MailingState='CA',
				MailingPostalCode='96001'
			);
				
		insert c;
	
		Schema.SObjectType objType	=	CustomObjects.getObjectType(c.Id);
		System.assertEquals(objType.getDescribe().getName(), 'Contact');
   	}

   	@isTest
    static void testMultiselectController() {
        MultiselectController c = new MultiselectController();
        
        c.leftOptions = new List<SelectOption>();
        c.rightOptions = new List<SelectOption>();

        c.leftOptionsHidden = 'A&a&b&b&C&c';
        c.rightOptionsHidden = '';
        
        System.assertEquals(c.leftOptions.size(), 3);
        System.assertEquals(c.rightOptions.size(), 0);
    }

    @isTest
	static void testPatternMatcher() {
		System.assert(PatternMatcher.validate_Email('test@test.com'), true);
		PatternMatcher pm = new PatternMatcher();
		Boolean failed = PatternMatcher.validate_Email('test_test.com');
	}  

	@isTest
	static void teststringtoDateTime()
	{
		datetime testDate = Utility.stringToDateTime('10/14/1972 12:32 PM');
		System.debug(testDate);
	}

	@isTest
	static void testUtility() {
		dealer__Sales_Up__c supBlank = new dealer__Sales_Up__c(dealer__FirstName__c='John', dealer__LastName__c='Frankston', dealer__Trade_VIN__c='1N4AL21E49N510178');
		insert supBlank;
		Id i = Utility.findContactId('dealer__Sales_Up__c', supBlank.Id);
		// Test format phone
		String s = dealer.Utility.formatPhoneTen('5309909099');
		String n = dealer.Utility.formatPhoneTen('1');
	}
	
	@isTest
	static void testSchemaTools() {
		Utility.GetKeyPrefix('003E000000gGzk6');
	}  

	@isTest
	static void testDMSSettupExposedMethods() {

        DMSSettings controller = new DMSSettings();
        controller.barnumber='ADP-1234';
        controller.epanumber='EPA-1234';
        controller.defaultTaxRate=Decimal.valueOf('9.99');
        controller.internalLaborRate=Decimal.valueOf('100.12');
        controller.warrantyLaborRate=Decimal.valueOf('115.99');
        controller.laborRate=Decimal.valueOf('125.05');
        controller.partsInvoiceNumber=Decimal.valueOf('4000');
        controller.partsQuoteNumber=Decimal.valueOf('5000');
        controller.serviceInvoiceNumber=Decimal.valueOf('6000');
        controller.printEstimate=false;
        controller.printTechTimes=false;
        controller.serviceTaxIfPartsSoldOnly=true;
        controller.serviceTaxLabor=true;
        controller.dmsIntegrationMode=false;
        controller.serviceLineTotalTrigger=true;
        controller.cashierAutoClose=true;
        controller.leadsAutoAssignManager=true;
        controller.closedDealStatusCodes='A,U';
        controller.dealNumber=1000;
        controller.assignStockNumber = false;
        controller.assignStockNumberBySequence = false;
		controller.assignStockNumberByDate=false;
        controller.serviceAppointmentNumber = 2000;
        controller.dealControlsSalesUp=false;
		controller.linkedEvent=false;
        controller.save();
            		
		Integer i_one = dealer.Utility.nextDealNumber();
		Integer i_two = dealer.Utility.nextDealNumber();

		System.debug(i_one);
		System.debug(i_two);

		System.assert(i_two > i_one);
	}

	@isTest
	static void testResetSchedule(){
		DMSSettings controller = new DMSSettings();
        controller.barnumber='ADP-1234';
        controller.epanumber='EPA-1234';
        controller.defaultTaxRate=Decimal.valueOf('9.99');
        controller.internalLaborRate=Decimal.valueOf('100.12');
        controller.warrantyLaborRate=Decimal.valueOf('115.99');
        controller.laborRate=Decimal.valueOf('125.05');
        controller.partsInvoiceNumber=Decimal.valueOf('4000');
        controller.partsQuoteNumber=Decimal.valueOf('5000');
        controller.serviceInvoiceNumber=Decimal.valueOf('6000');
        controller.printEstimate=false;
        controller.printTechTimes=false;
        controller.serviceTaxIfPartsSoldOnly=true;
        controller.serviceTaxLabor=true;
        controller.dmsIntegrationMode=false;
        controller.serviceLineTotalTrigger=true;
        controller.cashierAutoClose=true;
        controller.leadsAutoAssignManager=true;
        controller.closedDealStatusCodes='A,U';
        controller.dealNumber=1000;
        controller.assignStockNumber = false;
        controller.assignStockNumberBySequence = false;
		controller.assignStockNumberByDate=false;
        controller.serviceAppointmentNumber = 2000;
        controller.dealControlsSalesUp=false;
		controller.linkedEvent=false;
        controller.save();


		Test.startTest();

		resetStockNumber resetStock = new resetStockNumber();
		String sched = '0 1 0 1 * ? *';
		String jobId = System.schedule('Reset Stock Number Index', sched, resetStock);
		Test.stopTest();
	}
}