/**
 * DealerTrackCreditApplicationHandler 
 * @description
 */
public class DealerTrackCreditApplicationHandler 
{	


	/**
	 * @param app
	 * @return LeadResponse
	 * @description creates a DealerTrack lead from a credit app object.
	 */
	public static DealerTrack_Lead_API.LeadResponse CreateLeadFromApp(Id appId, Id dealId, String providerId)
	{
		CreditAppDto dto = populateDto(appId, dealId, providerId);
		DealerTrack_Lead.Lead lead = CreateDealerTrackLead(dto);

		return DealerTrack_Lead_API.CreateLead(lead);
	}

	public static CreditAppDto populateDto(Id appId, Id dealId, String providerId){
		CreditAppDto dto = new CreditAppDto();
		dto.providerId = providerId;
		dto.app = (Credit_Application__c)Utility.queryAllfields('dealer__Credit_Application__c', appId);
		dto.EnumProperties = createEnumPropertiesFromApp(dto.app);
		dto.deal = new Deal__c();
		dto.vehicle = new Vehicle_Inventory__c();
	
		dto.sup = dto.app.Sales_up__c == null ? new Sales_Up__c() : [Select Id, dealer__Car_Deal__c FROM Sales_Up__c WHERE Id =: dto.app.dealer__Sales_Up__c];

		if(dealId != null){
			dto.deal = (Deal__c)Utility.queryAllfields('dealer__Deal__c', dealId);
			System.assert(dto.deal.Id != null, 'Supplied Deal Id is not valid.');
			Trade_In__c [] trades = [SELECT Make__c, Model__c, Year__c FROM Trade_In__c WHERE Car_Deal__c =: dealId];
			dto.trade = trades.size() > 0 ? trades[0] : new Trade_In__c();
			if(dto.deal.Vehicle__c != null){
				dto.vehicle = (Vehicle_Inventory__c)Utility.queryAllFields('dealer__Vehicle_Inventory__c', dto.deal.Vehicle__c);
			}
		}
		return dto;
	}

	public static DealerTrackEnumProperties createEnumPropertiesFromApp(Credit_Application__c app)
	{
		DealerTrackEnums enums = new DealerTrackEnums();
		DealerTrackEnumProperties p = new DealerTrackEnumProperties();
		p.LeadType = enums.LeadType.get(app.ApplicationType__c) != null ? enums.LeadType.get(app.ApplicationType__c) : 'Individual';
		p.FinanceMethod = 'Retail';
		p.ApplicantState = app.CurrentAddressState__c;
		p.ApplicantPreviousState = app.PreviousAddressState__c;
		p.HousingStatus =  enums.HousingStatus.get(app.ResidenceType__c) != null ? enums.HousingStatus.get(app.ResidenceType__c) : 'Other';
		p.EmploymentStatus = enums.EmploymentStatus.get(app.EmploymentStatus__c) != null ? enums.EmploymentStatus.get(app.EmploymentStatus__c) : 'Other' ; // Employed, Unemployed, Retired, ActiveMilitary, RetiredMilitary, SelfEmployed, Student, Other
		p.PresentEmployerState = app.PresentEmployerState__c;
		p.PreviousEmployerState = app.PreviousEmployerState__c;
		p.CoAppRelationship = enums.CoAppRelationship.get(app.CoAppRelationship__c) != null ? enums.CoAppRelationship.get(app.CoAppRelationship__c) : 'Other'; // CivilUnion, RegDomPr, Spouse, Relative, Other
		p.CoApplicantState = app.CoAppCurrentAddressState__c;
		p.CoAppPreviousState = app.CoAppPreviousAddressState__c;
		p.CoAppHousingStatus = enums.HousingStatus.get(app.CoAppResidenceType__c) != null ? enums.HousingStatus.get(app.CoAppResidenceType__c) : 'Other'; //  Mortgage, Rent, Family, OwnOutright, Military, Other
		p.CoAppEmploymentStatus = enums.EmploymentStatus.get(app.CoAppEmploymentStatus__c) != null ? enums.EmploymentStatus.get(app.CoAppEmploymentStatus__c) : 'Other' ; // Employed, Unemployed, Retired, ActiveMilitary, RetiredMilitary, SelfEmployed, Student, Other
		p.CoAppPresentEmployerState = app.CoAppPresentEmployerState__c;
		p.CoAppPreviousEmployerState = app.CoAppPreviousEmployerState__c;
		return p;
	}

	public static DealerTrack_Lead.Lead CreateDealerTrackLead(CreditAppDto dto)
	{
		DealerTrack_Lead.Lead lead = new DealerTrack_Lead.Lead();
		lead.PartnerId = 'DTM';
	    lead.PartnerDealerId = dto.app.Store_Location__r.DealerTrackPartnerDealerId__c;			
	    lead.FinanceMethod = dto.EnumProperties.FinanceMethod; // Enum - Retail Lease
	   
	    // Applicant must be either primary or business, not both.
	    if(dto.EnumProperties.LeadType == 'Business')
		   PopulateBusinessApplicant(lead.Business_Applicant, dto);
	    else		
	 	   PopulateApplicant(lead.Primary_Applicant, dto);

		PopulateCoApplicant(lead.Co_Applicant, dto);
		
		if(dto.vehicle != null && dto.vehicle.Id != null)
			PopulateFinancedVehicle(lead.FinancedVehicle, dto);
		
		if(dto.trade != null && dto.trade.Id != null)
			PopulateTradeInVehicle(lead.TradeInVehicle, dto);
		
		if(dto.deal != null && dto.deal.Id != null)
			PopulateLoan(lead.Loan, dto);
		
	    // PopulateCustomerNotes(lead.Customer_Notes, dto);
	    // PopulateCustomFields(lead.Custom_Fields, dto);
	   
	    DealerTrack_Lead_API.LeadResponse response = DealerTrack_Lead_API.CreateLead(lead);
	    dto.app.Dealer_Track_Lead_Reference_Number__c = response.LeadReferenceNumber;
	    dto.app.Dealer_Track_Lead_Detail_Url__c = response.LeadDetailUrl;
	    // save picklist settings to creditapp object;
	    dto.app.DealerTrack_DTO__c = JSON.serialize(dto.EnumProperties);
		update dto.app;  
		
		return lead;
	}

    /**
	 * CreateDealerTrackLead 
	 * @param  Dtos 
	 * @return void
	 * @description Takes a list of Data Transfer Objects. future(callout=true).
	 */
	public static void CreateDealerTrackLead(List<CreditAppDto> Dtos)
    {                 	   	   	
	     for(CreditAppDto dto : Dtos)
	     {	  	     	
	     	DealerTrack_Lead.Lead lead = new DealerTrack_Lead.Lead();
	     	lead.PartnerId = 'DTM';
		    lead.PartnerDealerId = dto.app.Store_Location__r.DealerTrackPartnerDealerId__c;			
		    lead.FinanceMethod = dto.EnumProperties.FinanceMethod; // Enum - Retail Lease
		    
		    // Applicant must be either primary or business, not both.
			if(dto.EnumProperties.LeadType == 'Business')
				PopulateBusinessApplicant(lead.Business_Applicant, dto);
			else		
				PopulateApplicant(lead.Primary_Applicant, dto);

			PopulateCoApplicant(lead.Co_Applicant, dto);
			// PopulateFinancedVehicle(lead.FinancedVehicle, dto);
			// PopulateTradeInVehicle(lead.TradeInVehicle, dto);
			// PopulateLoan(lead.Loan, dto);
			// PopulateCustomerNotes(lead.Customer_Notes, dto);
			// PopulateCustomFields(lead.Custom_Fields, dto);
			
			DealerTrack_Lead_API.LeadResponse response = DealerTrack_Lead_API.CreateLead(lead);
			dto.app.Dealer_Track_Lead_Reference_Number__c = response.LeadReferenceNumber;
			dto.app.Dealer_Track_Lead_Detail_Url__c = response.LeadDetailUrl;
			// save picklist settings to creditapp object;
			dto.app.DealerTrack_DTO__c = JSON.serialize(dto.EnumProperties);
			update dto.app;  	
	     }   	
    }
    
    /**
	 * UpdateDealerTrackLead 
	 * @param  Dtos 
	 * @return void
	 * @description Takes a list of Data Transfer Objects. @future(callout=true).
	 */
	public static void UpdateDealerTrackLead(List<CreditAppDto> Dtos)
    {	         	
	     for(CreditAppDto dto : Dtos)
	     {		     		     	     	
	     	DealerTrack_Lead.UpdateLead lead = new DealerTrack_Lead.UpdateLead();
	     	lead.PartnerId = 'DTM';
		    lead.PartnerDealerId = dto.app.Store_Location__r.DealerTrackPartnerDealerId__c;		    			
		    lead.FinanceMethod = dto.EnumProperties.FinanceMethod; // Enum - Retail Lease
		    
		    // Applicant must be either primary or business, not both.
			if(dto.EnumProperties.LeadType == 'Business')
				PopulateBusinessApplicant(lead.Business_Applicant, dto);
			else		
				PopulateApplicant(lead.Primary_Applicant, dto);


			PopulateCoApplicant(lead.Co_Applicant, dto);
			// PopulateFinancedVehicle(lead.FinancedVehicle, dto);
			// PopulateTradeInVehicle(lead.TradeInVehicle, dto);
			// PopulateLoan(lead.Loan, dto);
			// PopulateCustomerNotes(lead.Customer_Notes, dto);
			// PopulateCustomFields(lead.Custom_Fields, dto);
			
            // Reference Number Required
			lead.LeadReferenceNumber = dto.app.Dealer_Track_Lead_Reference_Number__c;
			
			DealerTrack_Lead_API.LeadResponse response = DealerTrack_Lead_API.UpdateLead(lead);
			dto.app.Dealer_Track_Updated_Date__c = response.LeadUpdateDate;
			dto.app.Dealer_Track_Lead_Detail_Url__c = response.LeadDetailUrl;
			// save picklist settings to creditapp object;
			dto.app.DealerTrack_DTO__c = JSON.serialize(dto.EnumProperties);	
			update dto.app;
	     }
    }

	/**
	 * PopulateApplicant 
	 * @param  applicant 
	 * @param  dto 
	 * @return void
	 * @description
	 */    
    static void PopulateApplicant(DealerTrack_Applicant applicant, CreditAppDto dto)
    {
    	// Base applicant properties
		applicant.FirstName = dto.app.First_Name__c;
		applicant.MiddleInitial = applicant.MiddleInitial != null && applicant.MiddleInitial.length() > 0 ? dto.app.Middle_Name__c.subString(0, 1) : '';
		applicant.LastName = dto.app.Last_Name__c;
		applicant.EmailAddress = dto.app.Email_Address__c;
		applicant.SSN = dto.app.Social_Security_Number__c; // 489765227 or 489-76-5227
		applicant.DateOfBirth = ToString(dto.app.BirthDate__c);
		applicant.DriverLicenseNumber = dto.app.Driver_License_No__c;
		//applicant.DriverLicenseState = 'NY';		
		applicant.HomePhone = dto.app.Home_Phone__c; // 5167341234 or 516-734-1234
		applicant.CellPhone = dto.app.Mobile_Phone__c; // 7187341234 or 718-734-1234
		applicant.AddressLine1 = dto.app.Current_Address_Street__c;
		//applicant.AddressLine2 = 'Apt#324';
		applicant.City = dto.app.Current_Address_City__c;
		applicant.State = dto.EnumProperties.ApplicantState;
		applicant.ZipCode = dto.app.Current_Address_Zip__c;
		applicant.HousingStatus = dto.EnumProperties.HousingStatus; // Enum - Mortgage Rent Family Other OwnOutright Military
		applicant.MortgageOrRent = ToString(dto.app.Home_Payment__c); // Can be between 0 and 99999.
		applicant.TotalMonthsAtAddress = calculateMonths(dto.app.Current_Address_Duration_Years__c, dto.app.Current_Address_Duration_Months__c); // Should be between 0 and 1199.
		
		applicant.PreviousAddressLine1 = dto.app.Previous_Address_1_Street__c;
		//applicant.PreviousAddressLine2 = 'Apt 324';
		applicant.PreviousCity = dto.app.Previous_Address_1_City__c;
		applicant.PreviousState = dto.EnumProperties.ApplicantPreviousState;
		applicant.PreviousZipCode = dto.app.Previous_Address_1_Zip__c;
		applicant.TotalMonthsAtPreviousAddress = calculateMonths(dto.app.Previous_Address_1_Duration_Years__c, dto.app.Previous_Address_1_Duration_Months__c);		
		applicant.TotalMonthsEmployed = calculateMonths(dto.app.Present_Employer_Duration_Years__c, dto.app.Present_Employer_Duration_Months__c); // Should be between 0 and 1199.
		applicant.MonthlyIncome = ToString(dto.app.Applicants_Gross_Monthly_Income__c); // Can be between 0 and 99999.
		applicant.OtherMonthlyIncome = ToString(dto.app.Other_Monthly_Income__c); // if any - Can be between 1 and 99999.
		applicant.OtherIncomeSource = dto.app.Other_Monthly_Income_Source__c; // Source of other monthly income, if any	
		applicant.EmploymentStatus = dto.EnumProperties.EmploymentStatus; // Enum - Employed Unemployed Retired ActiveMilitary RetiredMilitary Other SelfEmployed Student
		applicant.EmployedBy = dto.app.Present_Employer__c;
		applicant.BusinessPhone = dto.app.Present_Employer_Phone__c; // 5167341234 or 516-734-1234	
		applicant.Occupation = dto.app.Occupation_Or_Rank__c;
		
		if(dto.app.Present_Employer_Street__c != null)
		{
			DealerTrack_Applicant.AddressType presEA = new DealerTrack_Applicant.AddressType();		
			presEA.AddressLine1 = dto.app.Present_Employer_Street__c;
			//presEA.AddressLine2 = 'Apt#324';
			presEA.City = dto.app.Present_Employer_City__c;
			presEA.State = dto.EnumProperties.PresentEmployerState;
			presEA.ZipCode = dto.app.Present_Employer_Zip__c;		
			applicant.EmployerAddress = new List<DealerTrack_Applicant.AddressType>{ presEA }; // AddressType
		}
		
		applicant.PreviousEmploymentStatus = dto.app.Previous_Occupation_or_Rank_1__c; // See EmploymentStatus
		applicant.PreviousEmployedBy = dto.app.Previous_Employer_1__c;
		applicant.PreviousBusinessPhone = dto.app.Previous_Employer_1_Phone__c; // 5167341234 or 516-734-1234
		applicant.PreviousOccupation = dto.app.Previous_Occupation_or_Rank_1__c;
		
		if(dto.app.Previous_Employer_1_Street__c != null)
		{
			DealerTrack_Applicant.AddressType prevEA = new DealerTrack_Applicant.AddressType();		
			prevEA.AddressLine1 = dto.app.Previous_Employer_1_Street__c;
			//prevEA.AddressLine2 = 'Apt#324';
			prevEA.City = dto.app.Previous_Employer_1_City__c;
			prevEA.State = dto.EnumProperties.PreviousEmployerState;
			prevEA.ZipCode = dto.app.Previous_Employer_1_Zip__c;		
			applicant.PreviousEmployerAddress = new List<DealerTrack_Applicant.AddressType>{ prevEA }; // AddressType
		}
				
		applicant.PreviousTotalMonthsEmployed = calculateMonths(dto.app.Previous_Employer_1_Duration_Years__c, dto.app.Previous_Employer_1_Duration_Months__c); // Should be between 0 and 1199.
		//applicant.PreferredLanguage = 'English';
		//applicant.PreferredContactMethod = 'Email'; // Enum - BusinessPhone HomePhone CellPhone Email
    }
    
	/**
	 * PopulateCoApplicant 
	 * @param  applicant 
	 * @param  dto    
	 * @return void
	 * @description
	 */ 
  	static void PopulateCoApplicant(DealerTrack_Applicant.CoApplicant applicant, CreditAppDto dto)
	{
		applicant.Relationship = dto.EnumProperties.CoAppRelationship; // Enum - CivilUnion RegDomPr Spouse Relative Other
		
		// populate the base properties
		// Sigh! would like to be able to pass in derived object to PopulateApplicant method
		applicant.FirstName = dto.app.Co_App_First_Name__c;
		applicant.MiddleInitial = applicant.MiddleInitial != null && applicant.MiddleInitial.length() > 0 ? dto.app.Co_App_Middle_Name__c.subString(0, 1) : '';
		applicant.LastName = dto.app.Co_App_Last_Name__c;
		//applicant.Suffix = 'JR'; // Enum - I II III IV JR SR
		applicant.EmailAddress = dto.app.Co_App_Email_Address__c;
		applicant.SSN = dto.app.Co_App_Social_Security_Number__c; // 489765227 or 489-76-5227
		applicant.DateOfBirth = ToString(dto.app.Co_App_Date_of_Birth__c);
		applicant.DriverLicenseNumber = dto.app.Co_App_Driver_License_Number__c;
		//applicant.DriverLicenseState = 'NY';		
		applicant.HomePhone = dto.app.Co_App_Phone__c; // 5167341234 or 516-734-1234
		applicant.CellPhone = dto.app.Co_App_Mobile_Phone__c; // 7187341234 or 718-734-1234
		applicant.AddressLine1 = dto.app.Co_App_Current_Address_Street__c;
		//applicant.AddressLine2 = 'Apt#324';
		applicant.City = dto.app.Co_App_Current_Address_City__c;
		applicant.State = dto.EnumProperties.CoApplicantState;
		applicant.ZipCode = dto.app.Co_App_Current_Address_Zip__c;
		applicant.HousingStatus = dto.EnumProperties.CoAppHousingStatus; // Enum - Mortgage Rent Family Other OwnOutright Military
		//applicant.MortgageOrRent = ToString(dto.app.Co_App_Home_Payment__c); // Can be between 0 and 99999.
		applicant.TotalMonthsAtAddress = calculateMonths(dto.app.Co_App_Address_Duration_Years__c, dto.app.Co_App_Address_Duration_Months__c); // Should be between 0 and 1199.
		
		applicant.PreviousAddressLine1 = dto.app.Co_App_Previous_Address_1_Street__c;
		//applicant.PreviousAddressLine2 = 'Apt 324';
		applicant.PreviousCity = dto.app.Co_App_Previous_Address_1_City__c;
		applicant.PreviousState = dto.EnumProperties.CoAppPreviousState;
		applicant.PreviousZipCode = dto.app.Co_App_Prev_Address_1_Zip__c;
		applicant.TotalMonthsAtPreviousAddress = calculateMonths(dto.app.Co_App_Prev_Address_1_Duration_Years__c, dto.app.Co_App_Prev_Address_1_Duration_Months__c);		
		applicant.TotalMonthsEmployed = calculateMonths(dto.app.Co_App_Present_Employer_Duration_Years__c, dto.app.Co_App_Present_Employer_Duration_Month__c); // Should be between 0 and 1199.
		applicant.MonthlyIncome = ToString(dto.app.Co_App_Gross_Monthly_Income__c); // Can be between 0 and 99999.
		applicant.OtherMonthlyIncome = ToString(dto.app.Co_App_Other_Monthly_Income__c); // if any - Can be between 1 and 99999.
		applicant.OtherIncomeSource = dto.app.Co_App_Other_Monthly_Income_Source__c; // Source of other monthly income, if any	
		applicant.EmploymentStatus = dto.EnumProperties.CoAppEmploymentStatus; // Enum - Employed Unemployed Retired ActiveMilitary RetiredMilitary Other SelfEmployed Student
		applicant.EmployedBy = dto.app.Co_App_Present_Employer__c;
		applicant.BusinessPhone = dto.app.Co_App_Present_Employer_Phone__c; // 5167341234 or 516-734-1234	
		applicant.Occupation = dto.app.Co_App_Occupation_Or_Rank__c;
		
		if(dto.app.Co_App_Present_Employer_Street__c != null)
		{
			DealerTrack_Applicant.AddressType presEA = new DealerTrack_Applicant.AddressType();		
			presEA.AddressLine1 = dto.app.Co_App_Present_Employer_Street__c;
			//presEA.AddressLine2 = 'Apt#324';
			presEA.City = dto.app.Co_App_Present_Employer_City__c;
			presEA.State = dto.EnumProperties.CoAppPresentEmployerState;
			presEA.ZipCode = dto.app.Co_App_Present_Employer_Zip__c;		
			applicant.EmployerAddress = new List<DealerTrack_Applicant.AddressType>{ presEA }; // AddressType
		}
		
		applicant.PreviousEmploymentStatus = dto.app.Co_App_Previous_Occupation_or_Rank_1__c; // See EmploymentStatus
		applicant.PreviousEmployedBy = dto.app.Co_App_Previous_Employer_1__c;
		applicant.PreviousBusinessPhone = dto.app.Co_App_Previous_Employer_1_Phone__c; // 5167341234 or 516-734-1234
		applicant.PreviousOccupation = dto.app.Co_App_Previous_Occupation_or_Rank_1__c;
		
		if(dto.app.Co_App_Previous_Employer_1_Street__c != null)
		{
			DealerTrack_Applicant.AddressType prevEA = new DealerTrack_Applicant.AddressType();		
			prevEA.AddressLine1 = dto.app.Co_App_Previous_Employer_1_Street__c;
			//prevEA.AddressLine2 = 'Apt#324';
			prevEA.City = dto.app.Co_App_Previous_Employer_1_City__c;
			prevEA.State = dto.EnumProperties.CoAppPreviousEmployerState;
			prevEA.ZipCode = dto.app.Co_App_Previous_Employer_1_Zip__c;		
			applicant.PreviousEmployerAddress = new List<DealerTrack_Applicant.AddressType>{ prevEA }; // AddressType
		}
				
		applicant.PreviousTotalMonthsEmployed = calculateMonths(dto.app.Co_App_Previous_Employer_2_Duration_Y__c, dto.app.Co_App_Previous_Employer_2_Duration_M__c); // Should be between 0 and 1199.
		//applicant.PreferredLanguage = 'English';
		//applicant.PreferredContactMethod = 'Email'; // Enum - BusinessPhone HomePhone CellPhone Email
	}
	
	/**
	 * PopulateBusinessApplicant 
	 * @param  applicant 
	 * @param  dto      
	 * @return void
	 * @description
	 */
	static void PopulateBusinessApplicant(DealerTrack_Applicant.BusinessApplicant applicant, CreditAppDto dto)
	{
		applicant.BusinessTaxId = dto.app.Business_Tax_ID__c; // string(9)
		// BusinessName Required
		applicant.BusinessName = dto.app.Business_Name__c;
		applicant.BusinessEstablishedDate = ToString(dto.app.Business_Established__c);
		applicant.StateOfIncorporation = dto.app.Business_State__c;
		applicant.BusinessPhoneNo = dto.app.Business_Phone__c;
		
		// DealerTrack_Applicant.FinancialStatementType f = new DealerTrack_Applicant.FinancialStatementType();
		
		// f.type_desc = 'cpa_audited'; // Enum - cpa_audited cpa_reviewed cpa_compiled income_tax borrower_prepared none 
		// f.type_code = 'CA';		
		
		// applicant.FinancialStatement = new List<DealerTrack_Applicant.FinancialStatementType>{ f } ; // financial statement type
		// applicant.YearsInBusiness = '100';
		// applicant.NumberOfEmployees = '500';
		// applicant.BankName = 'Some Bank';
		// applicant.BankAccountNo = '4589662312'; // string(15)
		// applicant.BankContactName = 'Some Contact';
		// applicant.BankContactPhoneNo = '516-734-1234';
		// populate the base properties
		PopulateApplicant(applicant, dto);
	}
	
	static void PopulateVehicle(DealerTrack_Vehicle vehicle, CreditAppDto dto)
	{
		// Base vehicle properties
		if(dto.vehicle != null && dto.vehicle.Id != null){
			Vehicle_Inventory__c veh = dto.vehicle;
			vehicle.Year = veh.Year__c; // Number(4)
			vehicle.Make = veh.Make__c; // String(30)
			vehicle.Model = veh.Model__c; // String(50)
			vehicle.Trim = veh.Trim_Level__c; // String(50)
			vehicle.VIN = veh.VIN__c; // String(17)
			vehicle.Mileage = String.valueOf(veh.Mileage__c); // Number(6)
			vehicle.ChromeStyleId = veh.Style_Id__c; // String(10)    
			// vehicle.TransmissionType = 'Manual'; // Enum - Manual Automatic
			vehicle.InteriorColor = veh.Interior_Color__c; // String(18)
			vehicle.ExteriorColor = veh.Exterior_Color__c; // String(18)
			DealerTrack_Vehicle.UrlListType picUrl = new DealerTrack_Vehicle.UrlListType();
			picUrl.Url = veh.Body_Company_Website__c;
			vehicle.UrlForMoreInformation = new List<DealerTrack_Vehicle.UrlListType>{ picUrl };
		}

	}
	static void PopulateTradeVehicle(DealerTrack_Vehicle vehicle, CreditAppDto dto){
		if(dto.trade != null && dto.trade.Id != null){
			Trade_In__c veh = dto.trade;
			vehicle.Year = veh.Year__c; // Number(4)
			vehicle.Make = veh.Make__c; // String(30)
			vehicle.Model = veh.Model__c; // String(50)
			vehicle.Trim = veh.Trim_Level__c; // String(50)
			vehicle.VIN = veh.VIN__c; // String(17)
			vehicle.Mileage = String.valueOf(veh.Odometer_at_Trade_In__c); // Number(6)
		}
	}
	
	static void PopulateFinancedVehicle(DealerTrack_Vehicle.FinancedVehicle vehicle, CreditAppDto dto)
	{

		vehicle.VehicleCondition = dto.vehicle.New_Used_Other__c == 'New' ? 'New' : 'Used';
		vehicle.CertifiedUsed = dto.vehicle.Certified_Pre_Owned__c ? 'True': 'False';
		vehicle.StockNumber  = dto.vehicle.Stock_Number__c;
		vehicle.EngineType  = dto.vehicle.Engine_Description__c;
		PopulateVehicle(vehicle, dto);		
	}
	
	static void PopulateTradeInVehicle(DealerTrack_Vehicle.TradeInVehicle vehicle, CreditAppDto dto)
	{
		if(dto.trade != null && dto.trade.Id != null){
			Trade_In__c trade = dto.trade;
			
			vehicle.LienHolder  = 'Honda Leasing'; // String(30)
			vehicle.TradeInPaid  = trade.Pay_Off_Amount__c == 0 ? 'Yes' : 'No'; // Enum - Yes No
			vehicle.AppraisalDate  = trade.Appraisal_Date__c != null ? String.valueOf(trade.Appraisal_Date__c) : ''; // Date
			vehicle.AppraisalValue  = String.valueOf(trade.ACV__c != null ? trade.ACV__c : 0); // Number(6)
			// vehicle.AppraisalSource  = 'TradeDriver'; // String(20)
			vehicle.AmountOwed  = String.valueOf(trade.Pay_Off_Amount__c != null ? trade.Pay_Off_Amount__c : 0); // Number(6)
			// populate the base properties
			PopulateTradeVehicle(vehicle, dto);		
		}

	}
	
	static void PopulateLoan(DealerTrack_Loan loan, CreditAppDto dto)
	{
		if(dto.deal != null && dto.deal.Id != null){
			Deal__c deal = dto.deal;
			loan.CashSellingPrice = String.valueOf(deal.Out_the_Door__c); // Number(11)
			loan.SalesTax =  String.valueOf(deal.Total_Tax__c); // Number(6)
			// loan.Title = '1200'; // Number(11)
			loan.CashDown = String.valueOf(deal.Total_Cash_Down__c); // Number(6)
			loan.Rebate =  String.valueOf(deal.Rebate__c); // Number(6)
			// loan.CreditLifeIns = '350'; // Number(6)
			loan.Term = String.valueOf(deal.Term__c); // Number(2)
			// loan.AcquisitionFees = '500'; // Number(6)
			loan.InvoiceAmount = String.valueOf(deal.Due_Upon_Delivery__c); // Number(11)
			loan.Warranty = String.valueOf(deal.Total_Service_Contracts_Premium__c); // Number(11)
			loan.MSRP = String.valueOf(dto.vehicle != null && dto.vehicle.Id != null ? (dto.vehicle.MSRP__c != null ? dto.vehicle.MSRP__c : 0) : 0); // Number(11)
			loan.RequestedAPR = String.valueOf(deal.Rate__c); // Number
			loan.AmountRequesting  = String.valueOf(deal.Due_Upon_Delivery__c); // Number(6)
			loan.EstimatedPayment = String.valueOf(deal.Monthly_Pymt__c); // Number(6)
			loan.MonthlyPayment = String.valueOf(deal.Monthly_Pymt__c); // Number(6)
			// loan.CreditType = 'Prime'; // Enum - Prime SubPrime
			loan.ApplicantType = dto.app.ApplicationType__c.contains('Co-Applicant') ? 'Joint' :'Individual'; // Enum - Individual Joint
			loan.UnpaidBalance = String.valueOf(deal.Trade_Payoff__c); // Number(11)
			// loan.AccHealthInsurance = '300'; // Number(6)
			// loan.OtherFinanceFees = '378'; // Number(6)
			// loan.Gap = '20'; // Number(6)
			loan.OtherFees = String.valueOf(deal.Total_Fees__c); // Number(6)
			// loan.WholesaleBookSource = 'NADA'; // Enum - BlackBook NADA GoldBook Galves KelleyBlueBook Other
			// loan.WholesaleCondition = 'Clean'; // Enum - NA ExtraClean Clean Average Rough
			// loan.WholesaleValueType = 'Trade'; // Enum - NA Wholesale Trade Loan
			// loan.WholesaleValue = '3500'; // Number(6)
			loan.NetTrade = String.valueOf(deal.Trade_Net__c); // Number(11)
			// loan.CustomerNegotiatedPrice = '25000'; // Number(6)
			// loan.DealerNegotiatedPrice  = '25000'; // Number(6)	
		}

	}
	
	// static void PopulateCustomerNotes(DealerTrack_Lead.CustomerNotes notes, CreditAppDto dto)
	// {
	// 	notes.Title = 'Some Title'; // String(50)
	// 	notes.Content = 'Some Content'; // String(500)
	// }
	
	// static void PopulateCustomFields(DealerTrack_Lead.CustomFields field, CreditAppDto dto)
	// {
	// 	field.Name = 'Some Name'; // String(20)
	// 	field.Value = 'Some Value'; // String(20)
	// }

	/**
	 * CalculateMonths 
	 * @param  years  
	 * @param  months 
	 * @return string
	 * @description
	 */ 
	static string CalculateMonths(decimal years, decimal months)
	{
		decimal total = 0;
		if(years != null)
			total += years * 12;

		if(months != null)
			total += months;
		
		return string.valueof(total.intValue());
	}

	/**
	 * ToString 
	 * @param  input 
	 * @return string
	 * @description
	 */
	static string ToString(object input)
	{
		if(input != null)
			return string.valueof(input);
		else
			return null;
	}

	/**
	 * @description
	 */
	public class CreditAppDto
	{
        public String providerId {get; set;}
        public Credit_Application__c app {get; set;}
        public Sales_Up__c sup {get; set;}
        public Deal__c deal {get; set;}
        public Vehicle_Inventory__c vehicle {get; set;}
        public Trade_In__c trade{get; set;}

		// DealerTrack specific enums or properties that don't line up with credit application object fields
		public DealerTrackEnumProperties EnumProperties { get; set; }

	}
}