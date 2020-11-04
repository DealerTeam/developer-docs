@isTest
public class DealerTrack_Lead_API_TC 
{
    @isTest static void CreateLeadApiTest() 
    {
    
        Test.setMock(HttpCalloutMock.class, new DealerTrackCreateLeadServiceMock());
        
        Test.startTest();
	        DealerTrack_Lead.Lead lead = new DealerTrack_Lead.Lead();
	        lead.PartnerId = 'DTM';
		    lead.PartnerDealerId = '100025';
		    lead.FinanceMethod = 'Retail'; // Enum - Retail Lease
		    // Applicant must be either primary or business, not both.			
			PopulateApplicant(lead.Primary_Applicant);
			PopulateCoApplicant(lead.Co_Applicant);
			PopulateFinancedVehicle(lead.FinancedVehicle);
			PopulateTradeInVehicle(lead.TradeInVehicle);
			PopulateLoan(lead.Loan);
			PopulateCustomerNotes(lead.Customer_Notes);
			PopulateCustomFields(lead.Custom_Fields);
	        DealerTrack_Lead_API.LeadResponse response = DealerTrack_Lead_API.CreateLead(lead);
        Test.stopTest();        
        
        system.assertEquals(response.LeadReferenceNumber, '160000000006682934');
        system.assertEquals(response.LeadDetailUrl, 'https://www.qa.dealertrack.com/Leads35/LeadDetail.aspx?leadReferenceId=160000000006439660');
       
    }
    
    @isTest static void UpdateLeadApiTest() 
    {
    
        Test.setMock(HttpCalloutMock.class, new DealerTrackUpdateLeadServiceMock());
        
        Test.startTest();
	        DealerTrack_Lead.UpdateLead lead = new DealerTrack_Lead.UpdateLead();
	        lead.PartnerId = 'DTM';
		    lead.PartnerDealerId = '100025';
		    lead.FinanceMethod = 'Retail'; // Enum - Retail Lease
		    lead.LeadReferenceNumber = '160000000006439660';
		    // Business Applicant only. No other info to test null members			
			PopulateBusinessApplicant(lead.Business_Applicant);
	        String UpdateDate = DealerTrack_Lead_API.UpdateLead(lead).LeadUpdateDate;
        Test.stopTest();        
        
        system.assertEquals(UpdateDate, '2017-01-19T17:02:04');
       
    } 
    
    @isTest static void GetLeadApiTest() 
    {
    
        Test.setMock(HttpCalloutMock.class, new DealerTrackGetLeadServiceMock());
        
        Test.startTest();
			DealerTrack_Lead.ExistingLead lead = new DealerTrack_Lead.ExistingLead();			
			lead.PartnerId = 'DTM';
			lead.PartnerDealerId = '100025';
			lead.LastName = 'Johnson';
			lead.LeadReferenceNumber = '160000000006439660';			
			String LeadReferenceNumber = DealerTrack_Lead_API.GetLead(lead).LeadReferenceNumber;
		Test.stopTest(); 
			
		system.assertEquals(LeadReferenceNumber, '160000000006439660');
       
    }  
   
	public class DealerTrackCreateLeadServiceMock implements HttpCalloutMock
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
	
	public class DealerTrackUpdateLeadServiceMock implements HttpCalloutMock
	{
	
	    public HTTPResponse respond(HTTPRequest request) 
	    {
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{"LeadReferenceNumber":"160000000006439660","LeadDetailUrl":"https://www.qa.dealertrack.com/Leads35/LeadDetail.aspx?leadReferenceId=160000000006439660","LeadUpdateDate":"2017-01-19T17:02:04"}');

            response.setStatusCode(200);
            return response;
	    }
	        
	}
	
	public class DealerTrackGetLeadServiceMock implements HttpCalloutMock
	{
	
	    public HTTPResponse respond(HTTPRequest request) 
	    {
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{"LeadReferenceNumber":"160000000006439660","LeadDetailUrl":"https://www.qa.dealertrack.com/Leads35/LeadDetail.aspx?leadReferenceId=160000000006439660","LeadUpdateDate":"2017-01-19T17:02:04"}');

            response.setStatusCode(200);
            return response;
	    }
	        
	}
	
    static void PopulateApplicant(DealerTrack_Applicant applicant)
    {
    	// Base applicant properties
		applicant.FirstName = 'Kevin';
		applicant.MiddleInitial = 'P';
		applicant.LastName = 'Johnson';
		applicant.Suffix = 'JR'; // Enum - I II III IV JR SR
		applicant.EmailAddress = 'kevin.johnson@gmail.com';
		applicant.SSN = '489-76-5227'; // 489765227 or 489-76-5227
		applicant.DateOfBirth = '1979-11-21';		
		applicant.DriverLicenseNumber = '459131739';
		applicant.DriverLicenseState = 'NY';		
		applicant.HomePhone = '516-734-1234'; // 5167341234 or 516-734-1234
		applicant.CellPhone = '7187341234'; // 7187341234 or 718-734-1234
		applicant.AddressLine1 = '1234 ABC Street';
		applicant.AddressLine2 = 'Apt#324';
		applicant.City = 'Garden City';
		applicant.State = 'NY';
		applicant.ZipCode = '11530';
		applicant.HousingStatus = 'Rent'; // Enum - Mortgage Rent Family Other OwnOutright Military
		applicant.MortgageOrRent = '850'; // Can be between 0 and 99999.
		applicant.TotalMonthsAtAddress = '128'; // Should be between 0 and 1199.
		
		applicant.PreviousAddressLine1 = '1 North Avenue';
		applicant.PreviousAddressLine2 = 'Apt 324';
		applicant.PreviousCity = 'Garden City';
		applicant.PreviousState = 'NY';
		applicant.PreviousZipCode = '11530';
		applicant.TotalMonthsAtPreviousAddress = '128';		
		applicant.TotalMonthsEmployed = '23'; // Should be between 0 and 1199.
		applicant.MonthlyIncome = '20000'; // Can be between 0 and 99999.
		applicant.OtherMonthlyIncome = '700'; // if any - Can be between 1 and 99999.
		applicant.OtherIncomeSource = 'Alimony'; // Source of other monthly income, if any	
		applicant.EmploymentStatus = 'Employed'; // Enum - Employed Unemployed Retired ActiveMilitary RetiredMilitary Other SelfEmployed Student
		applicant.EmployedBy = 'ABC Corp';
		applicant.BusinessPhone = '5167341234'; // 5167341234 or 516-734-1234	
		applicant.Occupation = 'Salesperson';
		
		DealerTrack_Applicant.AddressType a = new DealerTrack_Applicant.AddressType();
		
		a.AddressLine1 = '1234 ABC Street';
		a.AddressLine2 = 'Apt#324';
		a.City = 'Garden City';
		a.State = 'NY';
		a.ZipCode = '11530';
		
		applicant.EmployerAddress = new List<DealerTrack_Applicant.AddressType>{ a }; // AddressType
		applicant.PreviousEmploymentStatus = 'Employed'; // See EmploymentStatus
		applicant.PreviousEmployedBy = 'ABC Corp';
		applicant.PreviousBusinessPhone = '5167341234'; // 5167341234 or 516-734-1234
		applicant.PreviousOccupation = 'Salesperson';
		applicant.PreviousEmployerAddress = new List<DealerTrack_Applicant.AddressType>{ a }; // AddressType
		applicant.PreviousTotalMonthsEmployed = '110'; // Should be between 0 and 1199.
		applicant.PreferredLanguage = 'English';
		applicant.PreferredContactMethod = 'Email'; // Enum - BusinessPhone HomePhone CellPhone Email
    }
    
  	static void PopulateCoApplicant(DealerTrack_Applicant.CoApplicant applicant)
	{
		applicant.Relationship = 'Spouse'; // Enum - CivilUnion RegDomPr Spouse Relative Other
		// populate the base properties
		PopulateApplicant(applicant);
	}
	
	static void PopulateBusinessApplicant(DealerTrack_Applicant.BusinessApplicant applicant)
	{
		applicant.BusinessTaxId = '111111111'; // string(9)
		// BusinessName Required
		applicant.BusinessName = 'Acme';
		applicant.BusinessEstablishedDate = '08/01/2004';
		applicant.StateOfIncorporation = 'NY';
		applicant.BusinessPhoneNo = '5167341234';
		
		DealerTrack_Applicant.FinancialStatementType f = new DealerTrack_Applicant.FinancialStatementType();
		
		f.type_desc = 'cpa_audited'; // Enum - cpa_audited cpa_reviewed cpa_compiled income_tax borrower_prepared none 
		f.type_code = 'CA';		
		
		applicant.FinancialStatement = new List<DealerTrack_Applicant.FinancialStatementType>{ f } ; // financial statement type
		applicant.YearsInBusiness = '100';
		applicant.NumberOfEmployees = '500';
		applicant.BankName = 'Some Bank';
		applicant.BankAccountNo = '4589662312'; // string(15)
		applicant.BankContactName = 'Some Contact';
		applicant.BankContactPhoneNo = '516-734-1234';
		// populate the base properties
		PopulateApplicant(applicant);
	}
	
	static void PopulateVehicle(DealerTrack_Vehicle vehicle)
	{
		// Base vehicle properties
		vehicle.Year = '2001'; // Number(4)
		vehicle.Make = 'Acura'; // String(30)
		vehicle.Model = 'CL'; // String(50)
		vehicle.Trim = '2D CPE3.2L'; // String(50)
		vehicle.VIN = '2HE2323L232333217'; // String(17)
		vehicle.Mileage = '20'; // Number(6)
		vehicle.ChromeStyleId = '324486'; // String(10)    
		vehicle.TransmissionType = 'Manual'; // Enum - Manual Automatic
		vehicle.InteriorColor = 'Grey'; // String(18)
		vehicle.ExteriorColor = 'Silver'; // String(18)
		DealerTrack_Vehicle.UrlListType picUrl = new DealerTrack_Vehicle.UrlListType();
		picUrl.Url = 'http://www.somesite.com/somepic.jpg';
		vehicle.UrlForMoreInformation = new List<DealerTrack_Vehicle.UrlListType>{ picUrl };
	}
	
	static void PopulateFinancedVehicle(DealerTrack_Vehicle.FinancedVehicle vehicle)
	{
		vehicle.VehicleCondition = 'New'; // Enum - New Used Demo
		vehicle.CertifiedUsed = 'Y'; // Enum/Optional - Y N
		vehicle.StockNumber  = '87618746'; // String(8)
		vehicle.EngineType  = '3.7L V6'; // String(50)
		// populate the base properties
		PopulateVehicle(vehicle);		
	}
	
	static void PopulateTradeInVehicle(DealerTrack_Vehicle.TradeInVehicle vehicle)
	{
		vehicle.LienHolder  = 'Honda Leasing'; // String(30)
		vehicle.TradeInPaid  = 'Yes'; // Enum - Yes No
		vehicle.AppraisalDate  = '2015-15-21'; // Date
		vehicle.AppraisalValue  = '10750'; // Number(6)
		vehicle.AppraisalSource  = 'TradeDriver'; // String(20)
		vehicle.AmountOwed  = '2500'; // Number(6)
		// populate the base properties
		PopulateVehicle(vehicle);		
	}
	
	static void PopulateLoan(DealerTrack_Loan loan)
	{
		loan.CashSellingPrice = '15230'; // Number(11)
		loan.SalesTax = '1200'; // Number(6)
		loan.Title = '1200'; // Number(11)
		loan.CashDown = '1200'; // Number(6)
		loan.Rebate = '350'; // Number(6)
		loan.CreditLifeIns = '350'; // Number(6)
		loan.Term = '60'; // Number(2)
		loan.AcquisitionFees = '500'; // Number(6)
		loan.InvoiceAmount = '14567'; // Number(11)
		loan.Warranty = '350'; // Number(11)
		loan.MSRP = '16320'; // Number(11)
		loan.RequestedAPR = '5'; // Number
		loan.AmountRequesting  = '7400'; // Number(6)
		loan.EstimatedPayment = '250'; // Number(6)
		loan.MonthlyPayment = '355'; // Number(6)
		loan.CreditType = 'Prime'; // Enum - Prime SubPrime
		loan.ApplicantType = 'Joint'; // Enum - Individual Joint
		loan.UnpaidBalance = '600'; // Number(11)
		loan.AccHealthInsurance = '300'; // Number(6)
		loan.OtherFinanceFees = '378'; // Number(6)
		loan.Gap = '20'; // Number(6)
		loan.OtherFees = '200'; // Number(6)
		loan.WholesaleBookSource = 'NADA'; // Enum - BlackBook NADA GoldBook Galves KelleyBlueBook Other
		loan.WholesaleCondition = 'Clean'; // Enum - NA ExtraClean Clean Average Rough
		loan.WholesaleValueType = 'Trade'; // Enum - NA Wholesale Trade Loan
		loan.WholesaleValue = '3500'; // Number(6)
		loan.NetTrade = '3300'; // Number(11)
		loan.CustomerNegotiatedPrice = '25000'; // Number(6)
		loan.DealerNegotiatedPrice  = '25000'; // Number(6)	
	}
	
	static void PopulateCustomerNotes(DealerTrack_Lead.CustomerNotes notes)
	{
		notes.Title = 'Some Title'; // String(50)
		notes.Content = 'Some Content'; // String(500)
	}
	
	static void PopulateCustomFields(DealerTrack_Lead.CustomFields field)
	{
		field.Name = 'Some Name'; // String(20)
		field.Value = 'Some Value'; // String(20)
	}
  
}