public with sharing class SevenHundredCreditApplicationHandler 
{
	static User currentUser { get; set; }
    static List<String> fields = new List<String>(dealer__Credit_Application__c.SObjectType.getDescribe().fields.getMap().keySet());
	static String soql = 'SELECT ' + String.join(fields, ',') + ', Store_Location__r.SevenHundredCredit_Acount_Name__c, ' +
						 'Store_Location__r.SevenHundredCredit_Password__c, Store_Location__r.SevenHundredCredit_Affiliate_Username__c, ' +
						 'Store_Location__r.SevenHundredCredit_Affiliate_User_Id__c from dealer__Credit_Application__c WHERE Id IN :ids';
	
	public static InquiryResult CreateInquiry(Set<Id> ids, String product, List<string> bureaus)
	{
		currentUser =[Select Name from User where Id=:userinfo.getuserId()];
		string runBy = string.ValueOf(DateTime.Now().format()) + ' by ' + currentUser.Name;
		InquiryResult result = new InquiryResult();

		for(Credit_Application__c app : Database.query(soql))
		{
			SevenHundredCreditInquiry.Inquiry inquiry = new SevenHundredCreditInquiry.Inquiry();			
			
		    PopulateProperties(inquiry.Properties, app, product, bureaus);
			PopulatePrimaryApplicant(inquiry.PrimaryApplicant, app);
			PopulateCoApplicant(inquiry.CoApplicant, app);
			//PopulateVehicle(inquiry.Vehicle, app);

	        SevenHundredCreditAPI.InquiryResponse response = SevenHundredCreditAPI.CreateInquiry(inquiry);

			if(response.Error != null)
			{
				result.success = false;
				result.messages.add(response.Error);
			}			
	        
	        // product type is also in the response object (as below) in case we want to remove product from method signature
	        if(response.Product == 'CREDIT')
			{
				// Enum - TU, XPN, EFX - Example: "TU:XPN:EFX"
				Set<String> bureauSet = new Set<String>(bureaus);

				if(bureauSet.contains('TU'))
				{
					app.TransUnion_Credit_Report_Url__c = response.IframeUrl;
					app.TransUnion_Credit_Score__c = response.ApplicantTransUnionScore;
					app.Co_App_TransUnion_Credit_Score__c = response.CoApplicantTransUnionScore;
					app.TransUnion_Credit_Report_Run_Time__c = runBy;
				}
					
				if(bureauSet.contains('XPN'))
				{
					app.Experian_Credit_Report_Url__c = response.IframeUrl;
					app.Experian_Credit_Score__c = response.ApplicantExperianScore;
					app.Co_App_Experian_Credit_Score__c = response.CoApplicantExperianScore;
					app.Experian_Credit_Report_Run_Time__c = runBy;
				}					

				if(bureauSet.contains('EFX'))
				{
					app.Equifax_Credit_Report_Url__c = response.IframeUrl;
					app.Equifax_Credit_Score__c = response.ApplicantEquifaxScore;
					app.Co_App_Equifax_Credit_Score__c = response.CoApplicantEquifaxScore;
					app.Equifax_Credit_Report_Run_Time__c = runBy;
				}
					
			}
	        	
	        if(response.Product == 'OFAC')
			{
				app.OFAC_Report_Url__c = response.IframeUrl;
				app.OFAC_Report_Run_Time__c = runBy;
			}
	        	
	        	
	        if(response.Product == 'REDFLAG')
			{
				app.Red_Flag_Report_Url__c = response.IframeUrl;
				app.Red_Flag_Report_Run_Time__c = runBy;
			}
	        	
	        	
	        update app;
		}

		return result;
	}

	public class InquiryResult
	{
		public boolean success = true;
		public List<string> messages = new List<string>();
	}
	
	static void PopulatePrimaryApplicant(SevenHundredCreditApplicant.PrimaryApplicant applicant, Credit_Application__c app)
	{
		applicant.NAME = app.First_Name__c + ' ' + app.Last_Name__c;
		applicant.SSN = app.Social_Security_Number__c;
		applicant.ADDRESS = app.Current_Address_Street__c;
		applicant.CITY = app.Current_Address_City__c;
		applicant.STATE = app.Current_Address_State__c;
		applicant.ZIP = app.Current_Address_Zip__c;
		applicant.DOB = FormatDate(app.BirthDate__c);
		applicant.EMAIL = app.Email_Address__c;
		applicant.PREVADDRESS = app.Previous_Address_1_Street__c;
		applicant.PREVCITY = app.Previous_Address_1_City__c;
		applicant.PREVSTATE = app.Previous_Address_1_State__c;
		applicant.PREVZIP = app.Previous_Address_1_Zip__c;
		applicant.EMPLOYER = app.Present_Employer__c;
		applicant.POSITION = app.Occupation_Or_Rank__c;
		applicant.WPHONE = app.Present_Employer_Phone__c;
		applicant.MOBILE = app.Mobile_Phone__c;
		applicant.YEARS = string.valueOf(app.Present_Employer_Duration_Years__c);
		applicant.TYPEOFBUSINESS = app.Occupation_Or_Rank__c;
		applicant.MINCOME = string.valueOf(app.Applicants_Gross_Monthly_Income__c);
		applicant.OTHERINCOME = string.valueOf(app.Other_Monthly_Income__c);
		applicant.OTHERINCOMEEXPLN = app.Other_Monthly_Income_Source__c;
		applicant.MONTHS = string.valueOf(app.Present_Employer_Duration_Months__c);
	}
	
	static void PopulateCoApplicant(SevenHundredCreditApplicant.CoApplicant applicant, Credit_Application__c app)
	{
		applicant.SPOUSE = app.Co_App_First_Name__c + ' ' + app.Co_App_Last_Name__c;
		applicant.SPOUSESSN = app.Co_App_Social_Security_Number__c;
		//applicant.SPOUSEAGE = '';
		applicant.SPOUSEDOB = FormatDate(app.Co_App_Date_of_Birth__c);
		applicant.SPOUSEADDRESS = app.Co_App_Current_Address_Street__c;
		applicant.SPOUSECITY = app.Co_App_Current_Address_City__c;
		applicant.SPOUSESTATE = app.Co_App_Current_Address_State__c;
		applicant.SPOUSEZIP = app.Co_App_Current_Address_Zip__c;   		
	}
	
	// static void PopulateVehicle(SevenHundredCreditVehicle vehicle, Credit_Application__c app)
	// {
	// 	vehicle.NVINNUMBER = '4567891234';
	// 	vehicle.YEAR = '2017';
	// 	vehicle.NMAKE = 'Toyota';
	// 	vehicle.MODEL = 'Tundra';
	// 	vehicle.STOCKNUMBER = '878';		
	// }
	
	static void PopulateProperties(SevenHundredCreditInquiry.InquiryBaseProperties props, Credit_Application__c app, String product, List<string> bureaus)
	{
		props.ACCOUNT = app.Store_Location__r.SevenHundredCredit_Acount_Name__c;
		props.PASSWD = app.Store_Location__r.SevenHundredCredit_Password__c;
		props.PRODUCT = product; // Enum - CREDIT, OFAC, IDCHECK, REDFLAG ,PRESCR, SAVEONLY 
		// Either BUREAU or MULTIBUR will be sent, not both
		//props.BUREAU = 'TU'; // Enum - TU, XPN, EFX - Example: "EFX"
		props.MULTIBUR = String.join(bureaus, ':'); // Enum - TU, XPN, EFX - Example: "TU:XPN:EFX"
		props.A_USER_NAME = app.Store_Location__r.SevenHundredCredit_Affiliate_Username__c;
		props.A_USER_ID = app.Store_Location__r.SevenHundredCredit_Affiliate_User_Id__c;
		props.APP_MODIFIED = ''; // "Y"
	}

	// 700Credit accepted date format
    static String FormatDate(Date d)
	{
		if(d != null)
		{
			Datetime dt = Datetime.newInstance(d.year(), d.month(), d.day());
			return dt.format('MM/d/YYYY');
		}
		else
		{
			return '';
		}
	}
}