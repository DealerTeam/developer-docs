public class TestFactoryFieldData 
{
	// When we create a list of SObjects, we need to map the "Name" field if other than "Name"
	public static Map<String, String> nameFieldMap = new Map<String, String> 
	{
		'Contact' => 'LastName',
		'Case' => 'Subject'
	};

	// To specify defaults for objects, use the naming convention [ObjectName]Defaults.
	// For custom objects, omit the __c from the Object Name
	// Let's keep these in alphabetical order so they are easy to find
	
	public class AccountDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Billing_Email__c' => 'test@gmail.com',
				'Name' => 'Name',
				'Tax_ID__c' => 'Text: 64'
			};
		}
	}

	public class After_MarketDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Cost__c' => 9.99,
				'Description__c' => 'Text Area Test',
				'Hours__c' => 1,
				'Kit_Notes__c' => 'Text Area Test',
				'Labor_Cost__c' => 9.99,
				'Labor_Hourly_Cost__c' => 9.99,
				'Labor_Hourly_Sale__c' => 9.99,
				'Labor_Hours__c' => 1,
				'Labor_Sale__c' => 9.99,
				'List_Price__c' => 9.99,
				'Order__c' => 1,
				'Part_Cost__c' => 9.99,
				'Parts_Sale__c' => 9.99,
				'Quantity__c' => 1,
				'Sale_Price__c' => 9.99,
				'Sales_Tax__c' => 9.99,
				'Tax_Rate__c' => 10
			};
		}
	}

	public class Appraisal_VehicleDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Body_Type__c' => 'Text: 25',
				'Interior_Color__c' => 'Text: 48',
				'Make__c' => 'Text: 48',
				'Model__c' => 'Text: 64',
				'Trim_Level__c' => 'Text: 128',
				'VIN__c' => '1FTFW1EVXAFA39102',
				'Year__c' => '4'
			};
		}
	}

	public class AppraisalDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'ACV_Actual_Cash_Value__c' => 9.99,
				'Anticipated_Retail_Price__c' => 9.99,
				'Appraisal_Date__c' => Date.newInstance(1968, 12, 17),
				'Appraised_Value_SYS__c' => 9.99,
				'Appraised_Value__c' => 9.99,
				'Asking_Price__c' => 9.99,
				'Auction_Fee__c' => 9.99,
				'Black_Book_Finance_Advance__c' => 9.99,
				'Black_Book_Retail__c' => 9.99,
				'Black_Book_Wholesale__c' => 9.99,
				'Certification__c' => 9.99,
				'Expected_Costs__c' => 9.99,
				'KBB_Private_Party__c' => 9.99,
				'KBB_Trade_In__c' => 9.99,
				'MMR_Retail__c' => 9.99,
				'MMR_Wholesale__c' => 9.99,
				'NADA_Loan__c' => 9.99,
				'NADA_Retail__c' => 9.99,
				'NADA_Trade_In__c' => 9.99,
				'Profit_Objective__c' => 9.99,
				'Reconditioning__c' => 9.99,
				'Transportation__c' => 9.99,
				'Vehicle_Notes__c' => '<html>',
				'vAuto_Adj_Cost_to_Market__c' => 10,
				'vAuto_Adj_of_Market__c' => 10,
				'vAuto_Like_Mine__c' => 'Text: 255',
				'vAuto_Market_Days_Supply__c' => 1,
				'vAuto_Price_Rank__c' => 9.99,
				'vRank__c' => 1
			};
		}
	}

	public class CampaignMemberDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Certificate__c' => 'Text: 255',
				'Contact_Details__c' => 'Long Text Area Test',
				'Make__c' => 'Text: 40',
				'Model__c' => 'Text: 80',
				'Offer_or_Incentive__c' => 'Text Area Test',
				'Previously_Purchased_VIN__c' => '1FTFW1EVXAFA39102',
				'Year__c' => '4'
			};
		}
	}

	public class CampaignDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Description__c' => 'Long Text Area Test',
				'EndDate__c' => Date.newInstance(1968, 12, 17),
				'StartDate__c' => Date.newInstance(1968, 12, 17)
			};
		}
	}

	public class CaseDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Subject' => 'Name'
			};
		}
	}

	public class CasheringDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Amount__c' => 9.99,
				'Close_Date__c' => Date.newInstance(1968, 12, 17),
				'Credit_Card_Authorization_Code__c' => 'Text: 48',
				'Payment_Method__c' => 'Text: 25',
				'Payment_Receipt_Details__c' => 'Long Text Area Test'
			};
		}
	}

	public class CDM_SettingsDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'DealerID__c' => 1,
				'Password__c' => 'Text: 48',
				'Username__c' => 'Text: 48'
			};
		}
	}

	public class Chart_of_AccountsDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Description__c' => 'Text: 64'
			};
		}
	}

	public class Commission_TierDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Commission_Rate__c' => 10,
				'Unit_Count_High__c' => 1,
				'Unit_Count_Low__c' => 1,
				'FlatRate__c' => 200,
				'Floor__c' => 200
			};
		}
	}

	public class CommissionDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Amount__c' => 9.99,
				'Payable_Date__c' => Date.newInstance(1968, 12, 17)
			};
		}
	}

	public class ContactDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'LastName' => 'Name',
				'Drivers_License_Expiration_Date__c' => Date.newInstance(1968, 12, 17),
				'Drivers_License_Number__c' => 'Text: 15',
				'Drivers_License_State__c' => 'CA',
				'Issue_Date__c' => Date.newInstance(1968, 12, 17),
				'Rewards_Search_Text__c' => 'Text: 64'
			};
		}
	}

	public class Credit_ApplicationDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Age_Of_Dependent_1__c' => 1,
				'Age_Of_Dependent_2__c' => 1,
				'Age_Of_Dependent_3__c' => 1,
				'Age_Of_Home__c' => 1,
				'Applicant_Support__c' => 9.99,
				'Applicants_Gross_Monthly_Income__c' => 9.99,
				'Bank_Account_1_Balance__c' => 9.99,
				'Bank_Account_1_Branch_Address__c' => '1234 Main St.',
				'Bank_Account_1_Reference__c' => 'Text: 255',
				'Bank_Account_1__c' => 'Text: 30',
				'Bank_Account_2_Balance__c' => 9.99,
				'Bank_Account_2_Branch_Address__c' => '1234 Main St.',
				'Bank_Account_2_Reference__c' => 'Text: 255',
				'Bank_Account_2__c' => 'Text: 30',
				'BirthDate__c' => Date.newInstance(1968, 12, 17),
				'Business_City__c' => 'Redding',
				'Business_Established__c' => Date.newInstance(1968, 12, 17),
				'Business_Name__c' => 'Text: 255',
				'Business_Phone__c' => '530-555-1212',
				'Business_State__c' => 'CA',
				'Business_Street__c' => '1234 Main St.',
				'Business_Tax_ID__c' => 'Text: 255',
				'Business_Type__c' => 'Text: 255',
				'Business_Zip_Code__c' => '96001',
				'Co_App_Address_Duration_Months__c' => 1,
				'Co_App_Address_Duration_Years__c' => 1,
				'Co_App_Age_of_Dependent_1__c' => 1,
				'Co_App_Age_of_Dependent_2__c' => 1,
				'Co_App_Age_of_Dependent_3__c' => 1,
				'Co_App_Current_Address_City__c' => 'Redding',
				'Co_App_Current_Address_State__c' => 'CA',
				'Co_App_Current_Address_Street__c' => '1234 Main St.',
				'Co_App_Current_Address_Zip__c' => '96001',
				'Co_App_Date_of_Birth__c' => Date.newInstance(1968, 12, 17),
				'Co_App_Driver_License_Number__c' => 'Text: 100',
				'Co_App_Email_Address_2__c' => 'test@gmail.com',
				'Co_App_Email_Address__c' => 'test@gmail.com',
				'Co_App_First_Name__c' => 'Text: 100',
				'Co_App_Gross_Monthly_Income__c' => 9.99,
				'Co_App_Home_Payment__c' => 9.99,
				'Co_App_Last_Name__c' => 'Text: 100',
				'Co_App_Middle_Name__c' => 'Text: 100',
				'Co_App_Mobile_Phone__c' => '530-555-1212',
				'Co_App_Nearest_Relative_del__c' => 'Text: 255',
				'Co_App_Occupation_Or_Rank__c' => 'Text: 255',
				'Co_App_Other_Monthly_Income_Source__c' => 'Text: 255',
				'Co_App_Other_Monthly_Income__c' => 9.99,
				'Co_App_Phone__c' => '530-555-1212',
				'Co_App_Present_Employer_City__c' => 'Redding',
				'Co_App_Present_Employer_Duration_Month__c' => 1,
				'Co_App_Present_Employer_Duration_Years__c' => 1,
				'Co_App_Present_Employer_Phone__c' => '530-555-1212',
				'Co_App_Present_Employer_State__c' => 'CA',
				'Co_App_Present_Employer_Street__c' => '1234 Main St.',
				'Co_App_Present_Employer_Zip__c' => '96001',
				'Co_App_Present_Employer__c' => 'Text: 255',
				'Co_App_Prev_Addr_1_Community_Duration_M__c' => 1,
				'Co_App_Prev_Addr_1_Community_Duration_Y__c' => 1,
				'Co_App_Prev_Addr_2_Community_Duration_M__c' => 1,
				'Co_App_Prev_Addr_2_Community_Duration_Y__c' => 1,
				'Co_App_Prev_Address_1_Duration_Months__c' => 1,
				'Co_App_Prev_Address_1_Duration_Years__c' => 1,
				'Co_App_Prev_Address_1_State__c' => 'CA',
				'Co_App_Prev_Address_1_Zip__c' => '96001',
				'Co_App_Prev_Address_2_Duration_Months__c' => 1,
				'Co_App_Prev_Address_2_Duration_Years__c' => 1,
				'Co_App_Prev_Address_2_State__c' => 'CA',
				'Co_App_Prev_Address_2_Zip__c' => '96001',
				'Co_App_Previous_Address_1_City__c' => 'Redding',
				'Co_App_Previous_Address_1_Street__c' => '1234 Main St.',
				'Co_App_Previous_Address_2_City__c' => 'Redding',
				'Co_App_Previous_Address_2_Street__c' => '1234 Main St.',
				'Co_App_Previous_Employer2_Street__c' => '1234 Main St.',
				'Co_App_Previous_Employer_1_City__c' => 'Redding',
				'Co_App_Previous_Employer_1_Duration_M__c' => 1,
				'Co_App_Previous_Employer_1_Duration_Y__c' => 1,
				'Co_App_Previous_Employer_1_Phone__c' => '530-555-1212',
				'Co_App_Previous_Employer_1_State__c' => 'CA',
				'Co_App_Previous_Employer_1_Street__c' => '1234 Main St.',
				'Co_App_Previous_Employer_1_Zip__c' => '96001',
				'Co_App_Previous_Employer_1__c' => 'Text: 255',
				'Co_App_Previous_Employer_2_City__c' => 'Redding',
				'Co_App_Previous_Employer_2_Duration_M__c' => 1,
				'Co_App_Previous_Employer_2_Duration_Y__c' => 1,
				'Co_App_Previous_Employer_2_Phone__c' => '530-555-1212',
				'Co_App_Previous_Employer_2_State__c' => 'CA',
				'Co_App_Previous_Employer_2_Zip__c' => '96001',
				'Co_App_Previous_Employer_2__c' => 'Text: 255',
				'Co_App_Previous_Occupation_or_Rank_1__c' => 'Text: 255',
				'Co_App_Realationship_to_Applicant__c' => 'Text: 100',
				'Co_App_Relative_City__c' => 'Redding',
				'Co_App_Relative_Phone__c' => '530-555-1212',
				'Co_App_Relative_Relationship_to_Co_App__c' => 'Text: 100',
				'Co_App_Relative_State__c' => 'CA',
				'Co_App_Relative_Street__c' => '1234 Main St.',
				'Co_App_Relative_Zip__c' => '96001',
				'Co_App_Social_Security_Number__c' => 'Text: 100',
				'Co_Applicant_Support__c' => 9.99,
				'Credit_Account_1_Balance__c' => 9.99,
				'Credit_Account_1_City__c' => 'Redding',
				'Credit_Account_1_Date_Closed__c' => Date.newInstance(1968, 12, 17),
				'Credit_Account_1_Limit__c' => 9.99,
				'Credit_Account_1_Monthly_Payment__c' => 9.99,
				'Credit_Account_1_State__c' => 'CA',
				'Credit_Account_1_Street__c' => '1234 Main St.',
				'Credit_Account_1_Type__c' => 'Text: 100',
				'Credit_Account_1_Zip__c' => '96001',
				'Credit_Account_2_Balance__c' => 9.99,
				'Credit_Account_2_City__c' => 'Redding',
				'Credit_Account_2_Date_Closed__c' => Date.newInstance(1968, 12, 17),
				'Credit_Account_2_Limit__c' => 9.99,
				'Credit_Account_2_Monthly_Payment__c' => 9.99,
				'Credit_Account_2_State__c' => 'CA',
				'Credit_Account_2_Street__c' => '1234 Main St.',
				'Credit_Account_2_Type__c' => 'Text: 100',
				'Credit_Account_2_Zip__c' => '96001',
				'Credit_Account_3_Balance__c' => 9.99,
				'Credit_Account_3_City__c' => 'Redding',
				'Credit_Account_3_Date_Closed__c' => Date.newInstance(1968, 12, 17),
				'Credit_Account_3_Limit__c' => 9.99,
				'Credit_Account_3_Monthly_Payment__c' => 9.99,
				'Credit_Account_3_State__c' => 'CA',
				'Credit_Account_3_Street__c' => '1234 Main St.',
				'Credit_Account_3_Type__c' => 'Text: 100',
				'Credit_Account_3_Zip__c' => '96001',
				'Credit_Account_4_Balance__c' => 'Text: 10',
				'Credit_Account_4_City__c' => 'Redding',
				'Credit_Account_4_Date_Closed__c' => Date.newInstance(1968, 12, 17),
				'Credit_Account_4_Limit__c' => 9.99,
				'Credit_Account_4_Monthly_Payment__c' => 9.99,
				'Credit_Account_4_State__c' => 'CA',
				'Credit_Account_4_Street__c' => '1234 Main St.',
				'Credit_Account_4_Type__c' => 'Text: 100',
				'Credit_Account_4_Zip__c' => '96001',
				'Credit_Account_No1__c' => 'Text: 50',
				'Credit_Account_No2__c' => 'Text: 50',
				'Credit_Account_No3__c' => 'Text: 50',
				'Credit_Account_No4__c' => 'Text: 50',
				'Credit_Report_Url__c' => 'http://www.google.com',
				'Current_Address_City__c' => 'Redding',
				'Current_Address_Duration_Months__c' => 1,
				'Current_Address_Duration_Years__c' => 1,
				'Current_Address_State__c' => 'CA',
				'Current_Address_Street__c' => '1234 Main St.',
				'Current_Address_Zip__c' => '96001',
				'Current_Home_Purchase_Price__c' => 9.99,
				'Date_Home_Purchaged__c' => Date.newInstance(1968, 12, 17),
				'DealerTrack_DTO__c' => 'Long Text Area Test',
				'Dealer_Track_Lead_Detail_Url__c' => 'http://www.google.com',
				'Dealer_Track_Lead_Reference_Number__c' => 'Text: 100',
				'Dealer_Track_Updated_Date__c' => 'Text: 100',
				'Driver_License_No__c' => 'Text: 100',
				'Email_Address_2__c' => 'test@gmail.com',
				'Email_Address__c' => 'test@gmail.com',
				'First_Name__c' => 'Text: 100',
				'Home_Payment__c' => 9.99,
				'Home_Phone__c' => '530-555-1212',
				'Landlord_Account_Number__c' => 'Text: 50',
				'Landlord_Address__c' => '1234 Main St.',
				'Landlord_Or_Mortgage_Holder__c' => 'Text: 100',
				'Last_Name__c' => 'Text: 100',
				'Market_Value__c' => 9.99,
				'Middle_Name__c' => 'Text: 100',
				'Mobile_Phone__c' => '530-555-1212',
				'Mortgage_Balance__c' => 9.99,
				'Nearest_Relative__c' => 'Text: 255',
				'OFAC_Report_Url__c' => 'http://www.google.com',
				'Occupation_Or_Rank__c' => 'Text: 255',
				'Other_Monthly_Income_Source__c' => 'Text: 255',
				'Other_Monthly_Income__c' => 9.99,
				'Personal_Reference_1_City__c' => 'Redding',
				'Personal_Reference_1_Phone__c' => '530-555-1212',
				'Personal_Reference_1_State__c' => 'CA',
				'Personal_Reference_1_Street__c' => '1234 Main St.',
				'Personal_Reference_1_Zip__c' => '96001',
				'Personal_Reference_1__c' => 'Text: 100',
				'Personal_Reference_2_City__c' => 'Redding',
				'Personal_Reference_2_Phone__c' => '530-555-1212',
				'Personal_Reference_2_State__c' => 'CA',
				'Personal_Reference_2_Street__c' => '1234 Main St.',
				'Personal_Reference_2_Zip__c' => '96001',
				'Personal_Reference_2__c' => 'Text: 100',
				'Present_Employer_City__c' => 'Redding',
				'Present_Employer_Duration_Months__c' => 1,
				'Present_Employer_Duration_Years__c' => 1,
				'Present_Employer_Phone__c' => '530-555-1212',
				'Present_Employer_State__c' => 'CA',
				'Present_Employer_Street__c' => '1234 Main St.',
				'Present_Employer_Zip__c' => '96001',
				'Present_Employer__c' => 'Text: 255',
				'Prev_Address_1_Duration_in_Community_M__c' => 1,
				'Prev_Address_1_Duration_in_Community_Y__c' => 1,
				'Prev_Address_2_Duration_in_Community_M__c' => 1,
				'Prev_Address_2_Duration_in_Community_Y__c' => 1,
				'Previous_Address_1_City__c' => 'Redding',
				'Previous_Address_1_Duration_Months__c' => 1,
				'Previous_Address_1_Duration_Years__c' => 1,
				'Previous_Address_1_State__c' => 'CA',
				'Previous_Address_1_Street__c' => '1234 Main St.',
				'Previous_Address_1_Zip__c' => '96001',
				'Previous_Address_2_City__c' => 'Redding',
				'Previous_Address_2_Duration_Months__c' => 1,
				'Previous_Address_2_Duration_Years__c' => 1,
				'Previous_Address_2_State__c' => 'CA',
				'Previous_Address_2_Street__c' => '1234 Main St.',
				'Previous_Address_2_Zip__c' => '96001',
				'Previous_Employer_1_City__c' => 'Redding',
				'Previous_Employer_1_Duration_Months__c' => 1,
				'Previous_Employer_1_Duration_Years__c' => 1,
				'Previous_Employer_1_Phone__c' => '530-555-1212',
				'Previous_Employer_1_State__c' => 'CA',
				'Previous_Employer_1_Street__c' => '1234 Main St.',
				'Previous_Employer_1_Zip__c' => '96001',
				'Previous_Employer_1__c' => 'Text: 255',
				'Previous_Employer_2_City__c' => 'Redding',
				'Previous_Employer_2_Duration_Months__c' => 1,
				'Previous_Employer_2_Duration_Years__c' => 1,
				'Previous_Employer_2_Phone__c' => '530-555-1212',
				'Previous_Employer_2_State__c' => 'CA',
				'Previous_Employer_2_Street__c' => '1234 Main St.',
				'Previous_Employer_2_Zip__c' => '96001',
				'Previous_Employer_2__c' => 'Text: 255',
				'Previous_Occupation_or_Rank_1__c' => 'Text: 255',
				'Red_Flag_Report_Url__c' => 'http://www.google.com',
				'Relationship_to_Applicant__c' => 'Text: 255',
				'Relative_City__c' => 'Redding',
				'Relative_Phone__c' => '530-555-1212',
				'Relative_State__c' => 'CA',
				'Relative_Street__c' => '1234 Main St.',
				'Relative_Zip__c' => '96001',
				'Social_Security_Number__c' => 'Text: 50',
				'Vehicle_1_Account_Number__c' => 'Text: 50',
				'Vehicle_1_City__c' => 'Redding',
				'Vehicle_1_Financed_Leased_By__c' => 'Text: 255',
				'Vehicle_1_Monthly_Payment__c' => 9.99,
				'Vehicle_1_State__c' => 'CA',
				'Vehicle_1_Street__c' => '1234 Main St.',
				'Vehicle_1_Zip__c' => '96001',
				'Vehicle_2_Account_Number__c' => 'Text: 30',
				'Vehicle_2_City__c' => 'Redding',
				'Vehicle_2_Financed_Leased_By__c' => 'Text: 255',
				'Vehicle_2_Monthly_Payment__c' => 9.99,
				'Vehicle_2_State__c' => 'CA',
				'Vehicle_2_Street__c' => '1234 Main St.',
				'Vehicle_2_Zip__c' => '96001',
				'X2nd_Mortgage_Amount__c' => 9.99
			};
		}
	}

	public class CRMSettingsDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Desk_Log_Deal_Status__c' => 'Text: 255',
				'Desk_Log_Deal_Types__c' => 'Text: 255',
				'Duplicate_Check_Statuses__c' => 'Text Area Test',
				'ILM_Duplicate_Time_Period__c' => 1,
				'Inventory_Media_Crop_Ratio__c' => '6',
				'Inventory_Media_Max_Size__c' => 1,
				'MPI_Generate_PDF_Status__c' => 'Text: 45',
				'MPI_Print_Footer__c' => 'Text: 255',
				'MPI_Print_Link_Pre_Printed_Form__c' => 'http://www.google.com',
				'MPI_Print_Preview_Full_Color__c' => 'Text: 255',
				'MPI_Upsell_OpCode__c' => 'Text: 40',
				'MPI_ePrint__c' => 'test@gmail.com',
				'Native_or_Non_Native_Dupe_Catching__c' => 'Text: 12',
				'Rewards_Discount_Code__c' => 'Text: 64',
				'Rewards_Expiration_Months__c' => 1,
				'Rewards_FreeService_OpCodes__c' => 'Text: 255',
				'Rewards_Free_Service_Interval__c' => 1,
				'Rewards_Number_Length__c' => 1,
				'Rewards_OilChange_OpCodes__c' => 'Text: 255',
				'Rewards_Percentage__c' => 10,
				'Sales_Up_Record_Prefix__c' => 'Text: 24'
			};
		}
	}

	public class Custom_EquipmentDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Category__c' => 'Text: 40',
				'Description__c' => 'Long Text Area Test',
				'Installed_By__c' => 'Text: 25',
				'Name__c' => 'Text: 255',
				'Option_Id__c' => 'Text: 25',
				'Order_Code__c' => 'Text: 25'
			};
		}
	}

	public class Dealer_LocationDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Name' => 'Location 1',
				'Address__c' => 'Text Area Test',
				'Appt_Duration__c' => 1,
				'BAR_Number__c' => 'Text: 80',
				'City__c' => 'Redding',
				'Close_Hour__c' => '5',
				'Company_Contracting_Name__c' => 'Text: 48',
				'Company_Number__c' => '1',
				'County__c' => 'Text: 80',
				'Customer_Pay_Labor_Rate__c' => 9.99,
				'Deal_Default_Labor_Rate__c' => 9.99,
				'DealerTrackPartnerDealerId__c' => 'Text: 20',
				'Dealer_License__c' => 'Text: 40',
				'Default_Days_to_First_Payment__c' => 1,
				'Default_Rate__c' => 10,
				'Default_Term__c' => 1,
				'EPA_Number__c' => 'Text: 80',
				'Email__c' => 'test@gmail.com',
				'Internal_Labor_Rate__c' => 9.99,
				'Main_Phone__c' => '530-555-1212',
				'Minimum_Commission__c' => 9.99,
				'Open_Hour__c' => '5',
				'Pack__c' => 9.99,
				'Parts_Invoice_Disclaimer__c' => 'Long Text Area Test',
				'Postal_Code__c' => 'Text: 15',
				'SalesUp_Queue__c' => 'Text: 40',
				'Service_Invoice_Disclaimer__c' => 'Long Text Area Test',
				'Service_RO_Disclaimer__c' => 'Long Text Area Test',
				'SevenHundredCredit_Acount_Name__c' => 'Text: 255',
				'SevenHundredCredit_Affiliate_User_Id__c' => 'Text: 255',
				'SevenHundredCredit_Affiliate_Username__c' => 'Text: 255',
				'SevenHundredCredit_Password__c' => 'Text: 255',
				'State__c' => 'CA',
				'Street__c' => 'Text Area Test',
				'Tax_ID_State__c' => 'CA',
				'Tax_ID__c' => 'Text: 40',
				'Tax_Local_Rate__c' => 10,
				'Tax_Local_Rental_Addition__c' => 10,
				'Website__c' => 'http://www.google.com'
			};
		}
	}

	public class Dealer_TradeDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Accessories_Inbound__c' => 9.99,
				'Accessories_Ours__c' => 9.99,
				'Advertising_Inbound__c' => 9.99,
				'Color_Inbound__c' => 'Text: 20',
				'Date__c' => Date.newInstance(1968, 12, 17),
				'Dealer_Code__c' => '6',
				'Dealer_Contact__c' => 'Text: 25',
				'Drive_Fee__c' => 9.99,
				'Drive_Hours__c' => 1,
				'Holdback_Inbound__c' => 9.99,
				'Honda_HN__c' => '6',
				'Invoice_Inbound__c' => 9.99,
				'Invoice_Outbound__c' => 9.99,
				'Key_Code__c' => '8',
				'Model_Inbound__c' => 'Text: 20',
				'Our_Advertising__c' => 9.99,
				'Our_Holdback__c' => 9.99,
				'Radio_Code__c' => '8',
				'Stock_No_Inbound__c' => '7',
				'Trade_Notes_Inbound__c' => 'Text Area Test',
				'Trade_Notes__c' => 'Text Area Test',
				'VIN_Inbound__c' => 'Text: 17'
			};
		}
	}

	public class Deal_PaymentDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Amount__c' => 9.99,
				'Due_Date__c' => Date.newInstance(1968, 12, 17),
				'Notes__c' => 'Text Area Test',
				'Reference__c' => 'Text: 25'
			};
		}
	}

	public class Deal_Status_Map_SettingDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Name' => 'Name',
				'Sales_Up_Status__c' => 'Text: 100',
				'We_Owe_Status__c' => 'Text: 100'
			};
		}
	}

	public class Deal_TaxDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Flat_Tax__c' => 9.99,
				'Tax_Percentage__c' => 10
			};
		}
	}

	public class DealDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Aftermarket_Gross__c' => 9.99,
				'Amt_Financed__c' => 9.99,
				'Auto_Insurance_Address__c' => '1234 Main St.',
				'Auto_Insurance_Agent__c' => 'Text: 64',
				'Auto_Insurance_COL_Deductable__c' => 9.99,
				'Auto_Insurance_COM_Deducatable__c' => 9.99,
				'Auto_Insurance_City__c' => 'Redding',
				'Auto_Insurance_Company__c' => 'Text: 128',
				'Auto_Insurance_Contact__c' => 'Text: 64',
				'Auto_Insurance_Effective_Date__c' => Date.newInstance(1968, 12, 17),
				'Auto_Insurance_Expiration_Date__c' => Date.newInstance(1968, 12, 17),
				'Auto_Insurance_Phone__c' => '530-555-1212',
				'Auto_Insurance_Policy__c' => 'Text: 128',
				'Auto_Insurance_State__c' => 'CA',
				'Auto_Insurance_Zip__c' => '96001',
				'Back_End_Gross__c' => 9.99,
				'Back_End_Net__c' => 9.99,
				'Broker_Address__c' => 'Text Area Test',
				'Broker_City__c' => 'Redding',
				'Broker_Contracting_Name__c' => 'Text: 80',
				'Broker_County__c' => 'Text: 40',
				'Broker_Department__c' => 'Text: 40',
				'Broker_Email__c' => 'test@gmail.com',
				'Broker_Home_Phone__c' => '530-555-1212',
				'Broker_Mobile_Phone__c' => '530-555-1212',
				'Broker_Postal_Code__c' => 'Text: 15',
				'Broker_State__c' => 'CA',
				'Broker_Title__c' => 'Text: 80',
				'Business_Address__c' => 'Text Area Test',
				'Business_City__c' => 'Redding',
				'Business_Contracting_Name__c' => 'Text: 80',
				'Business_County__c' => 'Text: 40',
				'Business_Department__c' => 'Text: 40',
				'Business_Email__c' => 'test@gmail.com',
				'Business_Phone__c' => '530-555-1212',
				'Business_Postal_Code__c' => 'Text: 15',
				'Business_State__c' => 'CA',
				'Business_Title__c' => 'Text: 40',
				'Buy_Rate__c' => 10,
				'Buyer_Address__c' => 'Text Area Test',
				'Buyer_Birthdate__c' => Date.newInstance(1968, 12, 17),
				'Buyer_City__c' => 'Redding',
				'Buyer_County__c' => 'Text: 80',
				'Buyer_Drivers_License_Exp_Date__c' => Date.newInstance(1968, 12, 17),
				'Buyer_Drivers_License__c' => 'Text: 25',
				'Buyer_Email__c' => 'test@gmail.com',
				'Buyer_First_Name__c' => 'Text: 40',
				'Buyer_Home_Phone__c' => '530-555-1212',
				'Buyer_Last_Name__c' => 'Text: 80',
				'Buyer_Middle_Name__c' => 'Text: 40',
				'Buyer_Mobile_Phone__c' => '530-555-1212',
				'Buyer_Postal_Code__c' => 'Text: 20',
				'Buyer_State__c' => 'CA',
				'Buyer_Work_Phone__c' => '530-555-1212',
				'Co_Buyer_Address__c' => 'Text Area Test',
				'Co_Buyer_Birth_Date__c' => Date.newInstance(1968, 12, 17),
				'Co_Buyer_City__c' => 'Redding',
				'Co_Buyer_County__c' => 'Text: 80',
				'Co_Buyer_Drivers_License_Exp_Date__c' => Date.newInstance(1968, 12, 17),
				'Co_Buyer_Drivers_License_Number__c' => 'Text: 25',
				'Co_Buyer_Email__c' => 'test@gmail.com',
				'Co_Buyer_First_Name__c' => 'Text: 40',
				'Co_Buyer_Home_Phone__c' => '530-555-1212',
				'Co_Buyer_Last_Name__c' => 'Text: 80',
				'Co_Buyer_Middle_Name__c' => 'Text: 40',
				'Co_Buyer_Mobile_Phone__c' => '530-555-1212',
				'Co_Buyer_Postal_Code__c' => 'Text: 20',
				'Co_Buyer_State__c' => 'CA',
				'Co_Buyer_Work_Phone__c' => '530-555-1212',
				'Company_Name__c' => 'Text: 255',
				'County_Rate__c' => 10,
				'County__c' => 'Text: 40',
				'Customer_Key__c' => 'Text: 40',
				'Days__c' => 1,
				'Days_to_First__c' => 1,
				'Deal_Close_Date__c' => Date.newInstance(1968, 12, 17),
				'Deal_Date__c' => Date.newInstance(1968, 12, 17),
				'Deferred_Date_1__c' => Date.newInstance(1968, 12, 17),
				'Deferred_Date_2__c' => Date.newInstance(1968, 12, 17),
				'Deferred_Date_3__c' => Date.newInstance(1968, 12, 17),
				'Deferred_Down_1__c' => 9.99,
				'Deferred_Down_2__c' => 9.99,
				'Deferred_Down_3__c' => 9.99,
				'Deferred_Note_1__c' => 'Text: 255',
				'Deferred_Note_2__c' => 'Text: 255',
				'Deferred_Note_3__c' => 'Text: 255',
				'Deferred_Reference_1__c' => 'Text: 40',
				'Deferred_Reference_2__c' => 'Text: 40',
				'Deferred_Reference_3__c' => 'Text: 40',
				'Delivery_City__c' => 'Redding',
				'Delivery_County__c' => 'Text: 40',
				'Delivery_Date__c' => Date.newInstance(1968, 12, 17),
				'Delivery_Email__c' => 'test@gmail.com',
				'Delivery_Mobile__c' => '530-555-1212',
				'Delivery_Notes__c' => 'Text Area Test',
				'Delivery_Phone__c' => '530-555-1212',
				'Delivery_Postal_Code__c' => 1,
				'Delivery_State__c' => 'CA',
				'Delivery_Street__c' => '1234 Main St.',
				'Deposit_Note__c' => 'Text Area Test',
				'Deposit__c' => 9.99,
				'Desk_Manager_Name__c' => 'Text: 80',
				'Desk_Manager_Number__c' => 'Text: 20',
				'Doc_Fee__c' => 9.99,
				'Down_Pymt__c' => 9.99,
				'Electronic_Filing_Fee__c' => 9.99,
				'Ext_Color__c' => 'Text: 80',
				'Ext_Warr_Gross__c' => 9.99,
				'Exterior_Color__c' => 'Text: 60',
				'F_I_Manager_Name__c' => 'Text: 80',
				'F_I_Manager_Number__c' => 'Text: 20',
				'Finance_Gross__c' => 9.99,
				'Financial_Inst__c' => 'Text: 255',
				'First_Payment_Date__c' => Date.newInstance(1968, 12, 17),
				'Front_End_Gross__c' => 9.99,
				'Front_End_Net__c' => 9.99,
				'GAP_Company__c' => 'Text: 255',
				'GAP_Cost__c' => 9.99,
				'GAP_Gross__c' => 9.99,
				'GAP_Premium__c' => 9.99,
				'GAP_Term__c' => 1,
				'GVWR__c' => 9.99,
				'Int_Color__c' => 'Text: 128',
				'Interior_Color__c' => 'Text: 80',
				'Last_Pymt_Date__c' => Date.newInstance(1968, 12, 17),
				'Lender_Code__c' => 'Text: 64',
				'License_Expiration__c' => Date.newInstance(1968, 12, 17),
				'License_Fee__c' => 9.99,
				'List_Price__c' => 9.99,
				'MQOptions__c' => 'Text Area Test',
				'Maintenance_Cost__c' => 9.99,
				'Maintenance_Gross__c' => 9.99,
				'Maintenance_Premium__c' => 9.99,
				'Make__c' => 'Text: 40',
				'Mileage__c' => 1,
				'Model__c' => 'Text: 80',
				'Monthly_Pymt__c' => 9.99,
				'Multi_Quote_Options__c' => 'Long Text Area Test',
				'NUO__c' => 'Text: 25',
				'Net_Cap_Cost__c' => 9.99,
				'Non_Trade_Transfer_Plate_No__c' => 'Text: 20',
				'Non_Trade_Transfer_Title_No__c' => 'Text: 64',
				'Non_Trade_Transfer_VIN__c' => '1FTFW1EVXAFA39102',
				'Other_Cost__c' => 9.99,
				'Other_Gross__c' => 9.99,
				'Other_Name__c' => 'Text: 55',
				'Other_Premium__c' => 9.99,
				'Payments_Per_Year__c' => 1,
				'Rate__c' => 10,
				'Rebate__c' => 9.99,
				'Registration_Title_Fee__c' => 9.99,
				'Residual_Amt__c' => 9.99,
				'Residuale_Rate__c' => 10,
				'Sale_Cost__c' => 9.99,
				'Sale_Price__c' => 9.99,
				'Sale_Source__c' => 'Text: 25',
				'Sales_Tax__c' => 9.99,
				'Salesperson_1_Name__c' => 'Text: 80',
				'Salesperson_1_Number__c' => 'Text: 20',
				'Salesperson_2_Name__c' => 'Text: 80',
				'Salesperson_2_Number__c' => 'Text: 20',
				'Smog_Cert__c' => 9.99,
				'Stock_Number__c' => 'Text: 25',
				'TAVT_Amount__c' => 9.99,
				'Tax_Rate__c' => 10,
				'Term__c' => 1,
				'Tire_Fee__c' => 9.99,
				'Total_Additional_Equipment__c' => 9.99,
				'Total_Cash_Down__c' => 9.99,
				'Total_Fees__c' => 9.99,
				'Total_Internal_Local_Equipment__c' => 9.99,
				'Total_Service_Contracts_Cost__c' => 9.99,
				'Total_Service_Contracts_Gross__c' => 9.99,
				'Total_Service_Contracts_Premium__c' => 9.99,
				'Total_Tax__c' => 9.99,
				'Trade_Allowance__c' => 9.99,
				'Trade_Payoff__c' => 9.99,
				'Trim_Level__c' => 'Text: 64',
				'VIN__c' => '1FTFW1EVXAFA39102',
				'Vehicle_Cost__c' => 9.99,
				'Vehicle_Gross__c' => 9.99,
				'Vehicle_Key__c' => 'Text: 40',
				'Vehicle_Price__c' => 9.99,
				'Warranty_Cost__c' => 9.99,
				'Warranty_Premium__c' => 9.99,
				'Wrnty_End_Date__c' => Date.newInstance(1968, 12, 17),
				'Wrnty_Mileage__c' => 1,
				'Year__c' => '4'
			};
		}
	}

	public class Desired_VehicleDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Exterior_Color__c' => 'Text: 48',
				'Interior_Color__c' => 'Text: 48',
				'Make__c' => 'Text: 48',
				'Model__c' => 'Text: 64',
				'Trim_Level__c' => 'Text: 128',
				'VIN__c' => '1FTFW1EVXAFA39102',
				'Year__c' => '4'
			};
		}
	}

	public class Discount_RebateDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Amount__c' => 9.99,
				'Desc__c' => 'Text: 255'
			};
		}
	}

	public class DMS_SettingsDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Name' => 'ActiveSettings',
				'Asking_Price__c' => 9.99,
				'Assign_Stock_Number_by_Custom_Field__c' => 'Text: 80',
				'Auction_Fee__c' => 9.99,
				'BAR__c' => 'Text: 48',
				'Certification__c' => 9.99,
				'Closed_Deal_Status_Codes__c' => 'Text: 48',
				'Corporate_Facebook_Page__c' => 'http://www.google.com',
				'Corporate_Website__c' => 'http://www.google.com',
				'DMSName__c' => 'Text: 48',
				'Deal_Closed_Status_Codes__c' => 'Text: 255',
				'Deal_Created_Default_Status__c' => 'Text: 100',
				'Deal_Default_Days__c' => 1,
				'Deal_Default_Payments_Per_Year__c' => 1,
				'Deal_Default_Rate__c' => 10,
				'Deal_Default_Term__c' => 1,
				'Deal_Doc_Fee_Retail__c' => 9.99,
				'Deal_Number__c' => 1,
				'Deal_status_for_inventory__c' => 'Text: 100',
				'Default_Tax_Rate__c' => 10,
				'EPA__c' => 'Text: 48',
				'In_Stock_Default_Status__c' => 'Text: 100',
				'Integrated_Financial_Application__c' => 'Text: 40',
				'Inventory_Status_for_Sold_Vehicle__c' => 'Text: 100',
				'Invoice_Logo__c' => 'Text: 128',
				'Profit_Objective__c' => 9.99,
				'RO_Status__c' => 'Text: 255',
				'Salesup_status_for_inventory__c' => 'Text: 100',
				'Service_Appointment_Durration__c' => 1,
				'Service_Appointment_Sequence_Number__c' => 1,
				'Service_CP_Labor_Rate__c' => 9.99,
				'Service_Contract_For_Gap_Premium__c' => 'Text: 100',
				'Service_Contract_For_Maint_Premium__c' => 'Text: 100',
				'Service_Contract_For_Warr_Premium__c' => 'Text: 100',
				'Service_Internal_Labor_Rate__c' => 9.99,
				'Service_Job_Line_Number__c' => 1,
				'Service_Warranty_Labor_Rate__c' => 9.99,
				'Status__c' => 'Text: 255',
				'Stock_Number_Current_Index__c' => 1,
				'Stock_Number_Length__c' => 1,
				'Transportation__c' => 9.99,
				'Vehicle_Search_Default_Status__c' => 'Text: 100',
				'Service_Current_Invoice_Number__c' => 30093, 
				'Service_Job_Line_Number__c' => 8, 
				'Parts_Current_Invoice_Number__c' => 50115, 
				'Parts_Current_Quote_Number__c' => 20028, 
				'Default_Tax_Rate__c' => 7.75, 
				'Service_Appointment_Sequence_Number__c' => 2000, 
				'Deal_Status_Controls_Sales_Up_Status__c' => true
			};
		}
	}

	public class DriverDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Birth_Date__c' => Date.newInstance(1968, 12, 17),
				'Home_Phone__c' => '530-555-1212',
				'Licence_Expiration_Date__c' => Date.newInstance(1968, 12, 17),
				'License_Number__c' => 'Text: 255',
				'Mobile_Phone__c' => '530-555-1212'
			};
		}
	}

	public class EmployeeDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Cell_Phone__c' => '530-555-1212',
				'Email__c' => 'test@gmail.com',
				'First_Name__c' => 'Text: 15',
				'Hire_Date__c' => Date.newInstance(1968, 12, 17),
				'Home_Address__c' => '1234 Main St.',
				'Home_City__c' => 'Redding',
				'Home_Phone__c' => '530-555-1212',
				'Home_State__c' => 'CA',
				'Home_Zip__c' => '96001',
				'Last_Name__c' => 'Text: 15',
				'Position__c' => 'Text: 22',
				'Re_Hire_Date__c' => Date.newInstance(1968, 12, 17),
				'Termination_Date__c' => Date.newInstance(1968, 12, 17)
			};
		}
	}

	public class Equipment_MasterDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Description__c' => 'Long Text Area Test',
				'Installed_By__c' => 'Text: 25',
				'Name__c' => 'Text: 255',
				'Option_Id__c' => 'Text: 255',
				'Order_Code__c' => 'Text: 25'
			};
		}
	}

	public class EquityDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Black_Book_Wholesale__c' => 9.99,
				'Cacellables__c' => 9.99,
				'Estimated_Value__c' => 9.99,
				'KBB_Wholesale__c' => 9.99,
				'Valuation_Date__c' => Date.newInstance(1968, 12, 17)
			};
		}
	}

	public class EventDefaults implements TestInterfaces.IFieldDefaults
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'ActivityDate' => system.Today(),
				'ActivityDateTime' => system.Today(),
				'DurationInMinutes' => 60
			};
		}
	}

	public class Finance_CompanyDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Bank_Address__c' => 'Text Area Test',
				'Bank_City__c' => 'Redding',
				'Bank_State__c' => 'CA',
				'Bank_Zip__c' => '96001',
				'Comments__c' => 'Text Area Test',
				'Days_in_Year__c' => 1,
				'ExternalId__c' => 'Text: 40',
				'New_Vehicle_Rate__c' => 10,
				'Phone__c' => '530-555-1212',
				'Reserve_Calculation_Method__c' => 'Text: 25',
				'Reserve_Percentage__c' => 10,
				'Screen_Order__c' => 1,
				'Used_Vehicle_Rate__c' => 10
			};
		}
	}

	public class Fit_GuideDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Installation_Guide__c' => 'http://www.google.com'
			};
		}
	}

	public class FixedOperationsSettingsDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Appointment_Color_Chart__c' => 'Text Area Test',
				'Appointment_Durration__c' => 1,
				'Cashier_PDF__c' => 'Text: 255',
				'Default_Scheduler_Location__c' => 'Text: 18',
				'Label_Printer__c' => 'Text: 80',
				'PartsReceiptPage__c' => 'Text: 255',
				'Parts_Inventory_Control_Method__c' => 'Text: 40',
				'PurchaseOrderLineManager__c' => 'Text: 255',
				'PurchaseOrderPartsReceiptAddress__c' => '1234 Main St.',
				'Purchase_Order_PDF__c' => 'Text: 255',
				'Purchase_Order_Post_FF__c' => 'Text: 255',
				'Repair_Order_Index__c' => 1,
				'Selected_Advisors__c' => 'Text Area Test'
			};
		}
	}

	public class FormDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Based_on_Object__c' => 'Text: 255',
				'FDF_Code__c' => 'Long Text Area Test',
				'FPDF_File_Name__c' => 'Text: 80',
				'Form_ID__c' => 'Text: 25',
				'Impact_Code__c' => 'Long Text Area Test',
				'Page_Name__c' => 'Text: 64',
				'Revision_Date__c' => Date.newInstance(1968, 12, 17),
				'Sequence__c' => 1
			};
		}
	}

	public class GL_AccountsDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Account__c' => 'Text: 18',
				'Adj_Balance__c' => 9.99,
				'Adj_Units__c' => 1,
				'Apr_Units__c' => 1,
				'Apr__c' => 9.99,
				'Aug_Units__c' => 1,
				'Aug__c' => 9.99,
				'Begining_Balance__c' => 9.99,
				'Dec_Units__c' => 1,
				'Dec__c' => 9.99,
				'Description__c' => 'Text: 128',
				'Feb_Units__c' => 1,
				'Feb__c' => 9.99,
				'Group_Name__c' => 'Text: 40',
				'Group_Number__c' => 1,
				'Jan_Units__c' => 1,
				'Jan__c' => 9.99,
				'Jul_Units__c' => 1,
				'Jul__c' => 9.99,
				'Jun_Units__c' => 1,
				'Jun__c' => 9.99,
				'Mar_Units__c' => 1,
				'Mar__c' => 9.99,
				'May_Units__c' => 1,
				'May__c' => 9.99,
				'Nov_Units__c' => 1,
				'Nov__c' => 9.99,
				'Oct_Units__c' => 1,
				'Oct__c' => 9.99,
				'Sep_Units__c' => 1,
				'Sep__c' => 9.99,
				'Year__c' => '4'
			};
		}
	}

	public class GLDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Account_Number__c' => 'Text: 45',
				'Control_Number__c' => 'Text: 48',
				'Credit__c' => 9.99,
				'Debit__c' => 9.99,
				'Description__c' => 'Text: 255',
				'Document_Number__c' => 'Text: 48',
				'Document_Type_Code__c' => 'Text: 15',
				'Journal_Code__c' => 'Text: 15',
				'Long_Account_Number__c' => 'Text: 18',
				'Reconciled_Date__c' => Date.newInstance(1968, 12, 17),
				'Record_Type_Code__c' => 'Text: 15',
				'Reference_Number__c' => 'Text: 48',
				'Sequence_Number__c' => 1,
				'Transaction_Amount__c' => 9.99,
				'Transaction_Date__c' => Date.newInstance(1968, 12, 17)
			};
		}
	}

	public class Inspection_Report_LinesDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Diagram_Reference_Number__c' => 1,
				'Hidden_Value__c' => 'Text: 255',
				'Notes__c' => 'Text: 255',
				'Repair_Estimate__c' => 9.99,
				'damageCoordinateX__c' => 1,
				'damageCoordinateY__c' => 1
			};
		}
	}

	public class Inspection_ReportDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Action_Item_Count__c' => 1,
				'Advisor__c' => 'Text: 80',
				'Alignment__c' => '1',
				'Balance_Recommended__c' => '1',
				'Battery_1_Actual_CCA__c' => 1,
				'Battery_1_Spec_CCA__c' => 1,
				'Battery_1_Status__c' => '1',
				'Battery_2_Actual_CCA__c' => 1,
				'Battery_2_Spec_CCA__c' => 1,
				'Battery_2_Status__c' => '1',
				'Body_Damage_URL__c' => 'http://www.google.com',
				'Body_Desc__c' => 'Text Area Test',
				'Body_Est__c' => 9.99,
				'Brake_DF__c' => '1',
				'Brake_DR__c' => '1',
				'Brake_Fluid__c' => '1',
				'Brake_Lights__c' => '1',
				'Brake_Lines_Hoses__c' => '1',
				'Brake_PF__c' => '1',
				'Brake_PR__c' => '1',
				'Brake_Recon_Est__c' => 9.99,
				'Brake_Wear_DF__c' => 1,
				'Brake_Wear_DR__c' => 1,
				'Brake_Wear_PF__c' => 1,
				'Brake_Wear_PR__c' => 1,
				'Break_DF__c' => '1',
				'Cabin_Air_Filter__c' => '1',
				'Charging_System_Output__c' => 1,
				'Clutch_Fluid__c' => '1',
				'Clutch_Operation__c' => '1',
				'Cooling_System__c' => '1',
				'Customer_Comments__c' => 'Long Text Area Test',
				'Customer_Name__c' => 'Text: 80',
				'Customer_Signature_URL__c' => 'http://www.google.com',
				'Cylinders__c' => 1,
				'Door_Handles__c' => '1',
				'Door_Locks__c' => '1',
				'Doors__c' => 9.99,
				'Drive_Belts__c' => '1',
				'Drive_Shaft__c' => '1',
				'Engine_Air_Filter__c' => '1',
				'Engine_Oil__c' => '1',
				'Est_Value__c' => 9.99,
				'Exhaust_System__c' => '1',
				'Existing_Vehicle_Damage_Description__c' => '<html>',
				'Exterior_Lights__c' => '1',
				'Fluid_Leaks_Engine_Oil_Quality__c' => '1',
				'Fluid_Levels__c' => '1',
				'Fuel_Lines__c' => '1',
				'HVAC_System__c' => '1',
				'Head_Lights__c' => '1',
				'Horn__c' => '1',
				'Hoses_Check__c' => '1',
				'Information_Center__c' => '1',
				'Interior_Desc__c' => 'Text Area Test',
				'Interior_Est__c' => 9.99,
				'Interior_Lights__c' => '1',
				'Internal_Comments__c' => 'Long Text Area Test',
				'Key_Fob_Operation__c' => '1',
				'Mechanical_Desc__c' => 'Text Area Test',
				'Mechanical_Est__c' => 9.99,
				'Mileage__c' => 1,
				'Parking_Brake__c' => '1',
				'Power_Points_Accessories__c' => '1',
				'Power_Steering_Fluid__c' => '1',
				'Radio_CD_Speakers__c' => '1',
				'Rear_Differential__c' => '1',
				'Repair_Order_Number__c' => 'Text: 20',
				'Rotation_Recommended__c' => '1',
				'Seat_Operation__c' => '1',
				'Shocks_Struts_Suspension__c' => '1',
				'Steering_Linkages__c' => '1',
				'Tag__c' => 'Text: 25',
				'Time_to_Advisor_Completion__c' => DateTime.newInstance(1968, 12, 17),
				'Time_to_Tech_Completion__c' => DateTime.newInstance(1968, 12, 17),
				'Tire_DF_Under_Inflated__c' => '1',
				'Tire_DF__c' => '1',
				'Tire_DR_Under_Inflated__c' => '1',
				'Tire_DR__c' => '1',
				'Tire_MMS_DF__c' => 1,
				'Tire_MMS_DR__c' => 1,
				'Tire_MMS_PF__c' => 1,
				'Tire_MMS_PR__c' => 1,
				'Tire_PF_Under_Inflated__c' => '1',
				'Tire_PF__c' => '1',
				'Tire_PR_Under_Inflated__c' => '1',
				'Tire_PR__c' => '1',
				'Tire_PSI_DF_Pre_Inspection__c' => 1,
				'Tire_PSI_DF__c' => 1,
				'Tire_PSI_DR_Inside__c' => 1,
				'Tire_PSI_DR_Pre_Inspection__c' => 1,
				'Tire_PSI_DR__c' => 1,
				'Tire_PSI_PF_Pre_Inspection__c' => 1,
				'Tire_PSI_PF__c' => 1,
				'Tire_PSI_PR_Inside__c' => 1,
				'Tire_PSI_PR_Pre_Inspection__c' => 1,
				'Tire_PSI_PR__c' => 1,
				'Tire_Recon_Est__c' => 9.99,
				'Tire_Spare_PSI__c' => 1,
				'Tire_Tread_DF__c' => '1',
				'Tire_Tread_DR__c' => '1',
				'Tire_Tread_PF__c' => '1',
				'Tire_Tread_PR__c' => '1',
				'Tire_Wear_DF__c' => 1,
				'Total_Est_Recon__c' => 9.99,
				'Transfer_Case__c' => '1',
				'Transmission_Fluid__c' => '1',
				'Turn_Signals__c' => '1',
				'U_Joints_CV_Boots_Output_Shaft_Seals__c' => '1',
				'Under_Hood_General_Condition__c' => '1',
				'VIN_Number__c' => 'Text: 17',
				'Vehicle_Damage_Coordaintes__c' => 'Long Text Area Test',
				'Widshield_Wipers_Ok__c' => '1',
				'Windshield_Washer_Fluid__c' => '1'
			};
		}
	}

	public class IntercompanyLeadRoutingDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Company_Number__c' => 'Text: 25',
				'LocalName__c' => 'Text: 48',
				'Lead_Type__c' => 'Text: 48'
			};
		}
	}

	public class InventoryFeedDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'APIFieldName__c' => 'Text: 40',
				'APIObjectName__c' => 'Text: 40',
				'FeedName__c' => 'Text: 40',
				'Type__c' => 'Text: 40'
			};
		}
	}

	public class Inventory_ImagesDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'CDNThumbnailURL__c' => 'http://www.google.com',
				'CDNURL__c' => 'http://www.google.com',
				'Height__c' => 1,
				'Image_Name__c' => 'Text: 255',
				'Image_URL__c' => 'http://www.google.com',
				'Sequence_Number__c' => 1,
				'Thumbnail_URL__c' => 'http://www.google.com',
				'Width__c' => 1
			};
		}
	}

	public class Kit_CategoryDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Order__c' => 1
			};
		}
	}

	public class Misc_Tax_CodesDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Percent__c' => 10
			};
		}
	}

	public class MobileApplicationSettingsDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'API_Name__c' => 'Text: 128',
				'Field_Label__c' => 'Text: 48',
				'Object_Name__c' => 'Text: 128',
				'Priority__c' => 1
			};
		}
	}

	public class MobileAppSettingsDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Field_Label__c' => 'Text: 255',
				'Field_Name__c' => 'Text: 255',
				'Object_name__c' => 'Text: 255',
				'Order__c' => 1,
				'Profile_Id__c' => 'Text: 255'
			};
		}
	}

	public class OrganizationDefaultsDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Name' => 'Name',
				'VIN_Decoder_API_URL__c' => 'http://www.google.com',
				'VIN_Decoder_Client_Id__c' => 'Text: 18',
				'VIN_Decoder_Key__c' => 'Text: 64',
				'VIN_Decoder_Name__c' => 'Text: 64'
			};
		}
	}

	public class OrganizationLocationSettingsDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Name' => 'Name',
				'Appointment_Duration__c' => 1,
				'Close_Hour__c' => 1,
				'Location_Members__c' => 'Text Area Test',
				'Open_Hour__c' => 1
			};
		}
	}

	public class PartsPhysicalDetailDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Bin__c' => 'Text: 25',
				'Cost__c' => 9.99,
				'Count__c' => 1,
				'General_Ledger_Variance_Value__c' => 9.99,
				'Initial_Quantity__c' => 1,
				'Notes__c' => 'Text Area Test',
				'Variance_Value__c' => 9.99
			};
		}
	}

	public class PartSupersessionDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Old_Part__c' => 'Text: 128'
			};
		}
	}

	public class Parts_InventoryDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Best_Stocking_Level__c' => 1,
				'Bin_2__c' => 'Text: 25',
				'Bin__c' => 'Text: 25',
				'Comments__c' => 'Text Area Test',
				'Comp__c' => 9.99,
				'Core__c' => 9.99,
				'Cost__c' => 9.99,
				'Description__c' => 'Text: 255',
				'Detail__c' => 'Text: 25',
				'Entry_Date__c' => Date.newInstance(1968, 12, 17),
				'Extended_Description__c' => 'Text Area Test',
				'Extra_Days__c' => 1,
				'Group__c' => 'Text: 10',
				'High_Days__c' => 1,
				'High_Year__c' => '4',
				'Illustration__c' => '<html>',
				'Jobber__c' => 9.99,
				'Last_Sale_Date__c' => Date.newInstance(1968, 12, 17),
				'List__c' => 9.99,
				'Low_Days__c' => 1,
				'Low_Year__c' => '4',
				'MFG__c' => 'Text: 15',
				'Max__c' => 1,
				'Min__c' => 1,
				'Minimum_Margin__c' => 10,
				'On_Back_Order__c' => 1,
				'On_Hand__c' => 1,
				'On_Order__c' => 1,
				'On_Special_Order__c' => 1,
				'PNC__c' => 'Text: 25',
				'Pack_QTY__c' => 1,
				'Re_Order_Point__c' => 1,
				'Remarks__c' => 'Text Area Test',
				'Replenishment_Date__c' => Date.newInstance(1968, 12, 17),
				'Reserved__c' => 1,
				'Return_Code__c' => '8',
				'Source__c' => 'Text: 25',
				'Static_Price__c' => 9.99,
				'Supersedes__c' => 'Text: 128',
				'Trade__c' => 1,
				'Warranty__c' => 1,
				'Weight__c' => 1
			};
		}
	}

	public class Parts_Invoice_LineDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Bin__c' => 'Text: 15',
				'Comment__c' => 'Long Text Area Test',
				'Core__c' => 9.99,
				'Cost__c' => 9.99,
				'Counterman_No__c' => 'Text: 15',
				'List__c' => 9.99,
				'MFG__c' => 'Text: 40',
				'Net__c' => 9.99,
				'Part_Description__c' => 'Text: 255',
				'Part_Number__c' => 'Text: 45',
				'Price_Level__c' => 'Text: 15',
				'Price__c' => 9.99,
				'Quantity_Ordered__c' => 1,
				'Quantity_Sold__c' => 1,
				'Sale_Date__c' => DateTime.newInstance(1968, 12, 17),
				'Sold_Via__c' => 'Text: 48',
				'Source__c' => 'Text: 15',
				'Stocking_Group__c' => 'Text: 40',
				'Total_Price__c' => 9.99,
				'Total_Tax__c' => 9.99,
				'Transaction_Code__c' => 'Text: 48'
			};
		}
	}

	public class Parts_InvoiceDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Comments__c' => 'Text Area Test',
				'Cust_No__c' => 'Text: 25',
				'Customer_Name__c' => 'Text: 128',
				'Customer_Purchase_Order__c' => 'Text: 45',
				'Customer_ShipTo_Address__c' => '1234 Main St.',
				'Customer_ShipTo_City__c' => 'Redding',
				'Customer_ShipTo_Country__c' => 'Text: 128',
				'Customer_ShipTo_Street__c' => 'Text Area Test',
				'Customer_ShipTo_Zip__c' => '96001',
				'Customer_Shipto_State__c' => 'CA',
				'Customer_SoldTo_Address__c' => '1234 Main St.',
				'Customer_SoldTo_City__c' => 'Redding',
				'Customer_SoldTo_Name__c' => 'Text: 255',
				'Customer_SoldTo_State__c' => 'CA',
				'Customer_SoldTo_Zip__c' => '96001',
				'Deposit__c' => 9.99,
				'Invoice_Date_Time__c' => DateTime.newInstance(1968, 12, 17),
				'Misc_Fee__c' => 9.99,
				'Open_Date_Time__c' => DateTime.newInstance(1968, 12, 17),
				'Post_Date_Time__c' => DateTime.newInstance(1968, 12, 17),
				'Price_Level__c' => 'Text: 25',
				'RMA_No__c' => 'Text: 18',
				'Required_Date__c' => Date.newInstance(1968, 12, 17),
				'Restocking_Fee__c' => 9.99,
				'Ship_To__c' => 'Text Area Test',
				'Ship_Via__c' => 'Text: 35',
				'Shipping_Charges__c' => 9.99,
				'Shipping_Notes__c' => 'Text Area Test',
				'Shipping_Tracking_No__c' => 'Text: 35'
			};
		}
	}

	public class Parts_Kit_ItemDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Extended_Cost__c' => 9.99,
				'Extended_List__c' => 9.99,
				'Quantity__c' => 1,
				'Sale_Price__c' => 9.99
			};
		}
	}

	public class Parts_KitDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Description__c' => 'Text: 255',
				'Kit_Hours__c' => 1,
				'Kit_Notes__c' => 'Text Area Test',
				'Kit_Price__c' => 9.99,
				'Labor_Cost__c' => 9.99,
				'Labor_Hourly_Cost__c' => 9.99,
				'Labor_Hourly_Sale__c' => 9.99,
				'Labor_Sale__c' => 9.99,
				'Manufacturer__c' => 'Text: 80',
				'Total_Cost__c' => 9.99
			};
		}
	}

	public class Parts_LedgerDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Entry_Date__c' => Date.newInstance(1968, 12, 17),
				'Item_Value__c' => 9.99,
				'Purchased_By__c' => 'Text: 255',
				'Quantity__c' => 1,
				'Sold_By__c' => 'Text: 255',
				'Transaction_Note__c' => 'Text: 255'
			};
		}
	}

	public class Parts_MasterDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Applications__c' => 'Text: 255',
				'Catalog_Image__c' => '<html>',
				'Core_Value__c' => 9.99,
				'Cost__c' => 9.99,
				'Height__c' => 1,
				'Jobber_Price__c' => 9.99,
				'Labor_Time__c' => 1,
				'Length__c' => 1,
				'MAP__c' => 9.99,
				'MFG_Comments__c' => 'Text: 255',
				'Pack_QTY__c' => 1,
				'Part_Description__c' => 'Text: 255',
				'Price_Tape_Date__c' => Date.newInstance(1968, 12, 17),
				'Raw_Part_Number__c' => 'Text: 25',
				'Retail_Price__c' => 9.99,
				'Return_Code__c' => 'Text: 15',
				'UPC__c' => 'Text: 18',
				'Warranty_Price__c' => 9.99,
				'Weight__c' => 1,
				'Width__c' => 1
			};
		}
	}

	public class Parts_OrderDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Back_Ordered__c' => 1,
				'Depot__c' => 'Text: 48',
				'Line_Posted__c' => DateTime.newInstance(1968, 12, 17),
				'Order_Date__c' => Date.newInstance(1968, 12, 17),
				'Quantity_Ordered__c' => 1,
				'Received__c' => 1,
				'Scan_Time__c' => DateTime.newInstance(1968, 12, 17),
				'Value__c' => 9.99
			};
		}
	}

	public class Parts_Quote_LineDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Core__c' => 9.99,
				'Cost__c' => 9.99,
				'List__c' => 9.99,
				'Part_Description__c' => 'Text: 255',
				'Part_Number__c' => 'Text: 45',
				'Price__c' => 9.99,
				'Quantity__c' => 1,
				'Total_Price__c' => 9.99,
				'Total_Tax__c' => 9.99
			};
		}
	}

	public class Parts_QuoteDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Comments__c' => 'Text Area Test',
				'Misc_Fee__c' => 9.99,
				'Price_Level__c' => 'Text: 25',
				'Shipping_Charges__c' => 9.99
			};
		}
	}

	public class Parts_Service_Pricing_StrategyDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Description__c' => 'Text: 64',
				'Minimum_Parts_Gross_Proft__c' => 10,
				'Order__c' => 1,
				'Parts_Variable_Amount__c' => 10
			};
		}
	}

	public class Parts_Stocking_GroupDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Description__c' => 'Text: 48'
			};
		}
	}

	public class Part_Inventory_HistoryDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Cost__c' => 9.99,
				'EventId__c' => 'Text: 18',
				'Event_Notes__c' => 'Text: 255',
				'Post_Transaction_QOH__c' => 1,
				'Quantity_Adjustment__c' => 1,
				'Related_Document__c' => 'http://www.google.com',
				'Sale__c' => 9.99,
				'Transaction_Event__c' => 'Text: 48',
				'Transaction_Time__c' => DateTime.newInstance(1968, 12, 17),
				'Units_Relieved__c' => 1,
				'Value_Relieved__c' => 9.99
			};
		}
	}

	public class PaymentMethodsDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Name' => 'Name',
				'Account_Number__c' => 'Text: 48',
				'Company_Number__c' => 'Text: 25',
				'Control_Number__c' => 'Text: 48',
				'Description__c' => 'Text: 255',
				'Method__c' => 'Text: 15',
				'Transaction_Fee_Account__c' => 'Text: 48',
				'Transaction_Fee_Percent__c' => 10,
				'Type__c' => 'Text: 15'
			};
		}
	}

	public class Payment_MethodsDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Name' => 'Name',
				'Account_Number__c' => 'Text: 48',
				'Company_Number__c' => 'Text: 25',
				'Control_Number__c' => 'Text: 48',
				'Description__c' => 'Text: 255',
				'Method__c' => 'Text: 25',
				'Transaction_Fee_Account__c' => 'Text: 48',
				'Transaction_Fee_Percent__c' => 10,
				'Type__c' => 'Text: 25'
			};
		}
	}

	public class PostingTemplateRuleDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'ControlBy__c' => 'Text: 80',
				'Description__c' => 'Text: 255',
				'Reference__c' => 'Text: 80',
				'Value__c' => 'Text: 80'
			};
		}
	}

	public class Purchase_Order_LineDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Amount__c' => 9.99,
				'Customer_Total__c' => 9.99,
				'Description__c' => 'Text: 255',
				'Drop_Ship_Address__c' => 'Text Area Test',
				'Drop_Ship_To__c' => 'Text: 255',
				'Part_Quantity_Received__c' => 1,
				'Part_Quantity__c' => 1,
				'Special_Instructions__c' => 'Text Area Test'
			};
		}
	}

	public class Purchase_OrderDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Accepted_DateTime__c' => DateTime.newInstance(1968, 12, 17),
				'Carrier__c' => 'Text: 64',
				'Comments__c' => 'Long Text Area Test',
				'Date_Required__c' => Date.newInstance(1968, 12, 17),
				'Estimated_Arrival_Time__c' => DateTime.newInstance(1968, 12, 17),
				'Freight__c' => 9.99,
				'Invoice_Adjustment__c' => 9.99,
				'Invoice_Amount__c' => 9.99,
				'Invoice_Date__c' => Date.newInstance(1968, 12, 17),
				'Invoice_Number__c' => 'Text: 35',
				'Make__c' => 'Text: 40',
				'Model__c' => 'Text: 40',
				'PO_Key__c' => 'Text: 48',
				'Parts_Amount__c' => 9.99,
				'Post_Date_Time__c' => DateTime.newInstance(1968, 12, 17),
				'Requested_By__c' => 'Text: 48',
				'StockNumber__c' => 'Text: 25',
				'Tracking__c' => 'Text: 255',
				'VIN__c' => '1FTFW1EVXAFA39102',
				'Vehicle_Status__c' => 'Text: 80',
				'Vendor_City__c' => 'Redding',
				'Vendor_Country__c' => 'Text: 40',
				'Vendor_Email__c' => 'test@gmail.com',
				'Vendor_Name__c' => 'Text: 255',
				'Vendor_Phone__c' => '530-555-1212',
				'Vendor_Postal_Code__c' => 'Text: 20',
				'Vendor_State__c' => 'CA',
				'Vendor_Street__c' => 'Text Area Test',
				'Year__c' => '4'
			};
		}
	}

	public class RentalSettingsDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'ContractFormName__c' => 'Text: 255',
				'DailyMileageLimit__c' => 1,
				'ExcessMileageFee__c' => 9.99,
				'FuelChargePerGallon__c' => 9.99,
				'ReceiptFormName__c' => 'Text: 255',
				'RefuelingFee__c' => 9.99
			};
		}
	}

	public class Rental_AccessoriesDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Daily_Rate__c' => 9.99,
				'Description__c' => 'Text: 128'
			};
		}
	}

	public class Rental_AgreementsDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Additional_Charges_Notes__c' => 'Text Area Test',
				'Additional_Driver__c' => 'Text: 35',
				'Additional_Drivers_Birthday__c' => Date.newInstance(1968, 12, 17),
				'Additional_Drivers_Lic_Exp__c' => Date.newInstance(1968, 12, 17),
				'Additional_Drivers_Lic__c' => 'Text: 12',
				'Adjustment_Charges__c' => 9.99,
				'Agent__c' => 'Text: 35',
				'Authorization_Number__c' => 'Text: 12',
				'CC_Phone_Number__c' => '530-555-1212',
				'Credit_Card_Expiration_Date__c' => '5',
				'Customer_Pay_Amount__c' => 9.99,
				'Date_DUE_In__c' => Date.newInstance(1968, 12, 17),
				'Date_Out__c' => Date.newInstance(1968, 12, 17),
				'Days_Free__c' => 1,
				'Delivery_Fee__c' => 9.99,
				'Delivery_Instructions__c' => '<html>',
				'Deposit_Amount__c' => 9.99,
				'Discount_Percentage__c' => 10,
				'Discount__c' => 9.99,
				'Drivers_Birthdate__c' => Date.newInstance(1968, 12, 17),
				'Drivers_Lic_Exp__c' => Date.newInstance(1968, 12, 17),
				'Drivers_Lic__c' => 'Text: 17',
				'Estimated_Tax__c' => 9.99,
				'Excess_Miles_Fee__c' => 9.99,
				'Existing_Damage__c' => 'Text Area Test',
				'Fuel_Charge_on_Return__c' => 9.99,
				'Fuel_Charge_per_Gallon__c' => 9.99,
				'Insurer_Phone__c' => '530-555-1212',
				'Insurer__c' => 'Text: 64',
				'Mileage_Limit_Daily__c' => 1,
				'Mileage_Out__c' => 1,
				'Policy_Expiration_Date__c' => Date.newInstance(1968, 12, 17),
				'Policy_No__c' => 'Text: 35',
				'Purchase_Order__c' => 'Text: 15',
				'Re_Fuel_Fee__c' => 9.99,
				'Refueling_Fee__c' => 9.99,
				'Return_Damage__c' => 'Text Area Test',
				'Return_Date__c' => Date.newInstance(1968, 12, 17),
				'Return_Mileage__c' => 1,
				'Return_Time__c' => 'Text: 12',
				'Split_Payment_Notes__c' => 'Text Area Test',
				'SubTotal__c' => 9.99,
				'Time_DUE_IN__c' => '8',
				'Time_OUT__c' => '8',
				'Total_Mileage_Limit__c' => 9.99,
				'Total_Payments__c' => 9.99,
				'Vehicle_Licence_Fee__c' => 9.99,
				'Void_Reason__c' => 'Text Area Test'
			};
		}
	}

	public class Rental_RatesDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Daily_Miles_Allowed__c' => 1,
				'Daily_Rate__c' => 9.99,
				'Rate_Description__c' => 'Text: 45',
				'Weekly_Rate__c' => 9.99
			};
		}
	}

	public class RewardsDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Balance__c' => 1,
				'Lifetime_Claims__c' => 1,
				'Lifetime_Earnings__c' => 1,
				'Oil_Change_Count__c' => 1,
				'Transaction_Count__c' => 1
			};
		}
	}

	public class Reward_JournalDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Balance__c' => 1,
				'Control__c' => 'Text: 48',
				'Credit__c' => 1,
				'Debit__c' => 1,
				'Expiration_Date__c' => Date.newInstance(1968, 12, 17),
				'Notes__c' => 'Text: 255',
				'Transaction_Date__c' => Date.newInstance(1968, 12, 17)
			};
		}
	}

	public class Reward_TransactionDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Balance_at_Transaction_Time__c' => 1,
				'Credit__c' => 1,
				'Customer_Charges_this_visit__c' => 9.99,
				'Funds_Expiration_Date__c' => Date.newInstance(1968, 12, 17),
				'Funds_Expiration_Processed__c' => Date.newInstance(1968, 12, 17),
				'Rewards_Claimed__c' => 1,
				'Rewards_Earned__c' => 1,
				'Transaction_Date__c' => Date.newInstance(1968, 12, 17),
				'Transaction_Document__c' => 'Text: 64',
				'Transaction_Notes__c' => 'Text: 255'
			};
		}
	}

	public class RO_Status_SettingsDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Name' => 'Name',
				'We_Owe_Status__c' => 'Text: 255'
			};
		}
	}

	public class SalesDeskLogSettingsDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'CompanyNumbers__c' => 'Text: 48',
				'DealerTeam_Client_ID__c' => 'Text: 40',
				'Impact_Printer_Name__c' => 'Text: 40',
				'RunDate__c' => Date.newInstance(1968, 12, 17),
				'SMS_Account_Code__c' => 'Text: 128',
				'SMS_Phone_Number__c' => '530-555-1212',
				'SelectedTab__c' => 'Text: 25',
				'TrafficType__c' => 'Text: 15'
			};
		}
	}

	public class SalesDispositionsDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Name' => 'Name',
				'Deal_Status__c' => 'Text: 20',
				'SalesUp_Status__c' => 'Text: 20',
				'Disposition__c' => 'Text: 80'
			};
		}
	}

	public class SalesUp_Status_SettingsDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Name' => 'Name',
				'Status__c' => 'Text: 255',
				'We_Owe_Status__c' => 'Text: 255'
			};
		}
	}

	public class Sales_AppointmentDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'DateTime__c' => DateTime.newInstance(1968, 12, 17),
				'Date__c' => Date.newInstance(1968, 12, 17),
				'Notes__c' => 'Text Area Test',
				'Original_Date__c' => Date.newInstance(1968, 12, 17),
				'Original_Time__c' => 'Text: 12',
				'Other_Parties_Present__c' => 'Text Area Test',
				'Time__c' => 'Text: 12'
			};
		}
	}

	public class Sales_FeeDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Description__c' => 'Text: 255',
				'Fee_Amount__c' => 9.99,
				'Sequence_Number__c' => 1,
				'Type__c' => '1'
			};
		}
	}

	public class Sales_UpDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'ADF_File_Name__c' => 'Text: 25',
				'Address_Identifier__c' => '1234 Main St.',
				'Birthdate__c' => Date.newInstance(1968, 12, 17),
				'Color_Preference_Ext__c' => 'Text: 128',
				'Color_Preference_Int__c' => 'Text: 128',
				'Comments__c' => 'Long Text Area Test',
				'County__c' => 'Text: 40',
				'Current_Monthly_Payment__c' => 9.99,
				'Desired_Mileage__c' => 1,
				'Desired_Monthly_Payment__c' => 9.99,
				'Desired_Options__c' => '<html>',
				'Down_Payment__c' => 9.99,
				'Email__c' => 'test@gmail.com',
				'Enterprise_System_Submission_Date__c' => DateTime.newInstance(1968, 12, 17),
				'FirstName__c' => 'Text: 40',
				'First_Store_Visit_Date__c' => DateTime.newInstance(1968, 12, 17),
				'From_Email__c' => 'test@gmail.com',
				'Home_Phone__c' => '530-555-1212',
				'Internet_Lead_Request_Time__c' => DateTime.newInstance(1968, 12, 17),
				'LastName__c' => 'Text: 80',
				'Last_Store_Visit_Date__c' => DateTime.newInstance(1968, 12, 17),
				'Latest_Appointment_Date_Time__c' => DateTime.newInstance(1968, 12, 17),
				'Lead_Date__c' => Date.newInstance(1968, 12, 17),
				'Lead_Origination_Service__c' => 'Text: 255',
				'Mailing_City__c' => 'Redding',
				'Mailing_State__c' => 'CA',
				'Mailing_Street__c' => 'Text Area Test',
				'Mailing_Zip__c' => '96001',
				'Make__c' => 'Text: 64',
				'Managers_Note__c' => 'Text Area Test',
				'Mobile__c' => '530-555-1212',
				'Model__c' => 'Text: 64',
				'NextActivityDate__c' => Date.newInstance(1968, 12, 17),
				'Phone__c' => '530-555-1212',
				'Pre_qualified_Loan_Amount__c' => 9.99,
				'Price_High__c' => 9.99,
				'Price_Low__c' => 9.99,
				'Related_Tasks__c' => 1,
				'Response_Time__c' => 1,
				'Sale_Date__c' => Date.newInstance(1968, 12, 17),
				'Shopper__c' => 'Text: 60',
				'Timeframe__c' => 'Text: 64',
				'Trade_Appraised_Value__c' => 9.99,
				'Trade_Body_Type__c' => 'Text: 25',
				'Trade_Comments__c' => 'Text Area Test',
				'Trade_Make__c' => 'Text: 64',
				'Trade_Mileage__c' => 1,
				'Trade_Model__c' => 'Text: 64',
				'Trade_Trim_Level__c' => 'Text: 128',
				'Trade_VIN__c' => '1FTFW1EVXAFA39102',
				'Transmission__c' => 'Text: 128',
				'Trim__c' => 'Text: 128',
				'VIN__c' => '1FTFW1EVXAFA39102',
				'vAuto_Appraisal_Link__c' => 'http://www.google.com'
			};
		}
	}

	public class SchedulerSelectionDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Selected_Users__c' => 'Long Text Area Test'
			};
		}
	}

	public class ServiceLaborRateDefaultDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Labor_Rate__c' => 9.99
			};
		}
	}

	public class Service_Appointment_LineDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Appointment_Key__c' => 'Text: 40',
				'Complaint__c' => 'Text Area Test',
				'CustomerConcern__c' => 'Long Text Area Test',
				'Line_Key__c' => 'Text: 48',
				'Line__c' => 1,
				'Op_Code_Name__c' => 'Text: 64',
				'Priority__c' => 1,
				'Qoute__c' => 9.99,
				'Time_Estimate__c' => 1
			};
		}
	}

	public class Service_AppointmentDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Advisor_Number__c' => 'Text: 12',
				'Appointment_Time__c' => 'Text: 15',
				'Color_Code__c' => '7',
				'Comments__c' => 'Long Text Area Test',
				'Customer_Number__c' => 'Text: 25',
				'Date_Time__c' => DateTime.newInstance(1968, 12, 17),
				'Durration__c' => 1,
				'Email__c' => 'test@gmail.com',
				'Make__c' => 'Text: 40',
				'Mileage__c' => 1,
				'Model__c' => 'Text: 80',
				'Open_DateTime__c' => DateTime.newInstance(1968, 12, 17),
				'Promised_Completion_Time__c' => DateTime.newInstance(1968, 12, 17),
				'Vehicle_VIN__c' => '1FTFW1EVXAFA39102',
				'Year__c' => '4'
			};
		}
	}

	public class Service_ContractDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Cost__c' => 9.99,
				'Deductable__c' => 9.99,
				'Description__c' => 'Text: 255',
				'End_Date__c' => Date.newInstance(1968, 12, 17),
				'Expiration_Mileage__c' => 1,
				'Expiration_Months__c' => 1,
				'Odometer_at_Sale__c' => 1,
				'Order__c' => 1,
				'Plan_Code__c' => 'Text: 64',
				'Product_Code__c' => 'Text: 64',
				'SDRecordKey__c' => 1,
				'Sale_Price__c' => 9.99,
				'Start_Date__c' => Date.newInstance(1968, 12, 17)
			};
		}
	}

	public class Service_Estimate_LineDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Book_Time__c' => 1,
				'Cosmetic_Estimate__c' => 9.99,
				'Description__c' => 'Long Text Area Test',
				'Detail_Expense__c' => 9.99,
				'Diagram_Reference_Number__c' => 1,
				'Labor__c' => 9.99,
				'Part_Description__c' => 'Text: 64',
				'Parts__c' => 9.99,
				'Repair_Estimate__c' => 9.99,
				'Sublet_Charges__c' => 9.99,
				'Sublet_Work__c' => 'Text: 255',
				'Tax__c' => 9.99,
				'Tire_QTY__c' => '1',
				'Vendor__c' => 'Text: 45',
				'damageCoordinateX__c' => 1,
				'damageCoordinateY__c' => 1
			};
		}
	}

	public class Service_EstimateDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Appraisal_VIN__c' => '1FTFW1EVXAFA39102',
				'Cosmetic_Notes__c' => 'Text Area Test',
				'Current_MMR__c' => 9.99,
				'Current_Mileage__c' => 1,
				'Desired_Profit__c' => 9.99,
				'Detail__c' => Date.newInstance(1968, 12, 17),
				'Estimate_Notes__c' => 'Long Text Area Test',
				'Estimated_Pack__c' => 9.99,
				'Finish_Date__c' => Date.newInstance(1968, 12, 17),
				'Safety__c' => Date.newInstance(1968, 12, 17),
				'Smog__c' => Date.newInstance(1968, 12, 17),
				'Suggested_Retail_Price__c' => 9.99,
				'Transport_Damage_Description__c' => 'Text Area Test'
			};
		}
	}

	public class Service_Job_CCC_AuditDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Cause__c' => 'Long Text Area Test',
				'Complaint__c' => 'Long Text Area Test',
				'Correction__c' => 'Long Text Area Test'
			};
		}
	}

	public class Service_JobDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Actual_Time__c' => 1,
				'Book_Time__c' => 1,
				'CauseExtended__c' => 'Long Text Area Test',
				'Cause__c' => 'Text: 255',
				'Claim__c' => 'Text: 40',
				'Concern__c' => 'Text: 255',
				'Correction__c' => 'Long Text Area Test',
				'CustomerConcern__c' => 'Long Text Area Test',
				'Estimate__c' => 9.99,
				'Job_Added_Date__c' => DateTime.newInstance(1968, 12, 17),
				'Job_Finish__c' => DateTime.newInstance(1968, 12, 17),
				'Job_Start__c' => DateTime.newInstance(1968, 12, 17),
				'Labor_Charges__c' => 9.99,
				'Labor_Rate__c' => 'Text: 12',
				'Line_Number__c' => 1,
				'Misc_Charges__c' => 9.99,
				'Op_Code__c' => 'Text: 64',
				'Op_Description__c' => 'Text: 255',
				'Parent_Record__c' => 'Text: 40',
				'Parts_Cost__c' => 9.99,
				'Parts_Total__c' => 9.99,
				'Payment_Notes__c' => 'Text Area Test',
				'Sublet_Cost__c' => 9.99,
				'Sublet_Total__c' => 9.99,
				'Technician_Cost__c' => 9.99,
				'Technician_ID__c' => 'Text: 10'
			};
		}
	}

	public class Service_Loyalty_EventDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Control_Formula__c' => 'Text Area Test',
				'Default_Days_to_Execute__c' => 1,
				'Media_Template_Id__c' => 'Text: 48',
				'Media_Title__c' => 'Text: 255'
			};
		}
	}

	public class Service_Misc_ChargeDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Amount__c' => 9.99
			};
		}
	}

	public class Service_Repair_OrderDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Color_Code__c' => '7',
				'Comments__c' => 'Long Text Area Test',
				'Create_Date_Time__c' => DateTime.newInstance(1968, 12, 17),
				'Customer_Charges__c' => 9.99,
				'Customer_Labor_Charges__c' => 9.99,
				'Customer_Number__c' => 'Text: 25',
				'Customer_Parts_Charges__c' => 9.99,
				'Customer_Sublet_Charges__c' => 9.99,
				'Customer_Tax__c' => 9.99,
				'Deposit__c' => 9.99,
				'Discount_Code__c' => 'Text: 15',
				'Discount_Total__c' => 9.99,
				'Estimate__c' => 9.99,
				'Expected_Service_End__c' => DateTime.newInstance(1968, 12, 17),
				'Expected_Service_Start__c' => DateTime.newInstance(1968, 12, 17),
				'Freight_Charges__c' => 9.99,
				'Hazardous_Materials__c' => 9.99,
				'Internal_Charges__c' => 9.99,
				'Invoiced_Date_Time__c' => DateTime.newInstance(1968, 12, 17),
				'Lift_Cycle_Count__c' => 1,
				'Lift_MFG__c' => 'Text: 40',
				'Lift_Model__c' => 'Text: 40',
				'Lift_Serial_Number__c' => 'Text: 40',
				'Mileage_In__c' => 1,
				'Mileage_Out__c' => 1,
				'Payments_Total__c' => 9.99,
				'Promise_Date__c' => Date.newInstance(1968, 12, 17),
				'Promise_Time__c' => '8',
				'Recommendations__c' => 'Long Text Area Test',
				'Service_Advisor_ID__c' => 'Text: 10',
				'Service_Advisor_Name__c' => 'Text: 80',
				'Shop_Supplies__c' => 9.99,
				'Tag__c' => '8',
				'Tax__c' => 9.99,
				'VIN__c' => '1FTFW1EVXAFA39102',
				'Warranty_Auth__c' => 'Text: 10',
				'Warranty_Charges__c' => 9.99,
				'Warranty_Comments__c' => 'Text Area Test',
				'upload_Customer__c' => 'Text: 18'
			};
		}
	}

	public class Service_Vehicle_EquipmentDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Category__c' => 'Text: 40',
				'Description__c' => 'Long Text Area Test',
				'Installed_By__c' => 'Text: 25',
				'Option_Id__c' => 'Text: 25',
				'Order_Code__c' => 'Text: 25',
				'dealer_Name__c' => 'Text: 255'
			};
		}
	}

	public class Service_VehicleDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Body_Style_Id__c' => 'Text: 12',
				'Body_Style__c' => 'Text: 64',
				'Body_Type__c' => 'Text: 35',
				'Carline__c' => 'Text: 40',
				'Comments__c' => 'Long Text Area Test',
				'Customer_Key__c' => 'Text: 25',
				'Doors__c' => 1,
				'Drive_Type__c' => 'Text: 15',
				'Engine_Description__c' => 'Text: 64',
				'Engine_Displacement__c' => 1,
				'Engine_ID__c' => 'Text: 24',
				'Equipment_Number__c' => 'Text: 10',
				'Ext_Color__c' => 'Text: 64',
				'Horsepower__c' => 1,
				'Hours__c' => 1,
				'In_Service_Date__c' => Date.newInstance(1968, 12, 17),
				'Int_Color__c' => 'Text: 80',
				'Key_1__c' => 'Text: 24',
				'Key_2__c' => 'Text: 24',
				'Last_6__c' => '6',
				'Last_8__c' => '8',
				'Last_Activity__c' => Date.newInstance(1968, 12, 17),
				'Last_Odometer__c' => 1,
				'Last_Service__c' => Date.newInstance(1968, 12, 17),
				'Licence__c' => 'Text: 10',
				'Make_Code__c' => '4',
				'Make__c' => 'Text: 40',
				'Marketing_ID__c' => 1,
				'Model_Code__c' => 'Text: 25',
				'Open_Repair_Orders__c' => 1,
				'Package_Code__c' => '8',
				'Recommendations__c' => 'Long Text Area Test',
				'Sale_Date__c' => Date.newInstance(1968, 12, 17),
				'Search_Names__c' => 'Text: 255',
				'Service_Interval_Average_Days__c' => 1,
				'Service_Interval_Average_Odometer__c' => 1,
				'Stock_Number__c' => 'Text: 24',
				'Style_Id__c' => 'Text: 48',
				'Transmission_Type__c' => 'Text: 64',
				'Trim_Level__c' => 'Text: 128',
				'VIN_Decode_Id__c' => 'Text: 48',
				'Vehicle_Description__c' => 'Text: 128',
				'Vehicle_Type__c' => 'Text: 64',
				'Warranty_Exp_Date__c' => Date.newInstance(1968, 12, 17),
				'Warranty_Exp_Miles__c' => 1,
				'Year__c' => '4'
			};
		}
	}

	public class Special_Order_LineDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Cancel_Date__c' => Date.newInstance(1968, 12, 17),
				'Close_Date__c' => Date.newInstance(1968, 12, 17),
				'Description__c' => 'Text: 40',
				'External_Id__c' => 'Text: 25',
				'Line__c' => 1,
				'Order_Date__c' => Date.newInstance(1968, 12, 17),
				'Order_Number__c' => 'Text: 35',
				'Ordered_By_Number__c' => 'Text: 25',
				'Part_Number__c' => 'Text: 25',
				'Quantity__c' => 1,
				'Received_Date__c' => Date.newInstance(1968, 12, 17),
				'Received__c' => 1
			};
		}
	}

	public class Special_OrderDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Close_Date__c' => Date.newInstance(1968, 12, 17),
				'Comments__c' => 'Long Text Area Test',
				'Customer_Number__c' => 'Text: 17',
				'Open_Date__c' => Date.newInstance(1968, 12, 17),
				'Order_Number__c' => 'Text: 40',
				'Purchase_Order__c' => 'Text: 25',
				'Service_Advisor_Number__c' => 'Text: 25'
			};
		}
	}

	public class StandardOpCodeDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Associated_Marketing_Template__c' => 'Text: 48',
				'Book_Time__c' => 1,
				'Cause__c' => 'Long Text Area Test',
				'Company_Number__c' => 'Text: 18',
				'Concern__c' => 'Long Text Area Test',
				'Correction__c' => 'Long Text Area Test',
				'Dispatch_Code__c' => 'Text: 40',
				'Labor_Code__c' => '8',
				'Labor_Estimate__c' => 9.99,
				'Labor_Rate__c' => 9.99,
				'Make__c' => 'Text: 12',
				'Op_Code_Description__c' => 'Text: 255',
				'Operation_Notes__c' => '<html>',
				'Part_Markup_Internal__c' => 10,
				'Part_Markup_Warranty__c' => 10,
				'Parts_Estimate__c' => 9.99,
				'Remarketing_Default_Delay__c' => 1
			};
		}
	}

	public class Stock_Number_BookDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Sequence__c' => 1,
				'VIN__c' => '1FTFW1EVXAFA39102',
				'VehicleRecordTypeId__c' => 'Text: 18',
				'VehicleRecordType__c' => 'Text: 40'
			};
		}
	}

	public class Stock_Order_LineDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Back_Ordered__c' => 1,
				'Cancelled__c' => 1,
				'Depot__c' => 'Text: 25',
				'Order__c' => 1,
				'Received__c' => 1,
				'Referred__c' => 1
			};
		}
	}

	public class Stock_OrderDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Date_Ordered__c' => Date.newInstance(1968, 12, 17),
				'Date_of_Arrival__c' => Date.newInstance(1968, 12, 17),
				'Description__c' => 'Text Area Test',
				'Manufacturer__c' => 'Text: 25',
				'Packing_Slip__c' => 'Text: 25'
			};
		}
	}

	public class Survey_QuestionDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Alpha_Value__c' => 'Text: 255',
				'Numeric_Value__c' => 1,
				'Question_Name__c' => 'Text: 255',
				'Question_Number__c' => 1
			};
		}
	}

	public class SurveyDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Agent_String__c' => 'Text: 255',
				'Completion_DateTime__c' => DateTime.newInstance(1968, 12, 17),
				'IP_Address__c' => '1234 Main St.',
				'Net_Promoter_Score__c' => 1
			};
		}
	}

	public class System_LogDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'SOQL__c' => 'Long Text Area Test'
			};
		}
	}

	public class TaxSettingsDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'State_Tax_Rate__c' => 10
			};
		}
	}

	public class Tax_ZonesDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'City__c' => 'Redding',
				'County__c' => 'Text: 40',
				'Effective_Date__c' => Date.newInstance(1968, 12, 17),
				'Expires_Date__c' => Date.newInstance(1968, 12, 17),
				'Postal_Code__c' => 'Text: 15',
				'Rate__c' => 10,
				'State__c' => 'CA'
			};
		}
	}

	public class Technician_Job_TimeDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Actual_Time_Entry__c' => 1,
				'Book_Time_Entry__c' => 1,
				'Date__c' => Date.newInstance(1968, 12, 17),
				'End_Time__c' => DateTime.newInstance(1968, 12, 17),
				'Flat_Rate_Time__c' => 1,
				'Labor_Cost__c' => 9.99,
				'Labor_Total__c' => 9.99,
				'Payment_Method_Labor_Rate__c' => 9.99,
				'Start_Time__c' => DateTime.newInstance(1968, 12, 17),
				'Time_Punch_Notes__c' => 'Text Area Test'
			};
		}
	}

	public class Time_Clock_LineDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'In__c' => DateTime.newInstance(1968, 12, 17),
				'Note__c' => 'Text Area Test',
				'Out__c' => DateTime.newInstance(1968, 12, 17)
			};
		}
	}

	public class Time_ClockDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Clock_In__c' => DateTime.newInstance(1968, 12, 17),
				'Clock_Out__c' => DateTime.newInstance(1968, 12, 17),
				'Lunch_Break_End__c' => DateTime.newInstance(1968, 12, 17),
				'Lunch_Break_Start__c' => DateTime.newInstance(1968, 12, 17),
				'Session_ID__c' => 'Text: 255'
			};
		}
	}

	public class Trade_InDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'ACV__c' => 9.99,
				'Appraisal_Date__c' => Date.newInstance(1968, 12, 17),
				'Black_Book_Retail__c' => 9.99,
				'Black_Book_Wholesale__c' => 9.99,
				'K_B_B_Retail__c' => 9.99,
				'K_B_B_Wholesale_Value__c' => 9.99,
				'Make__c' => 'Text: 48',
				'Model__c' => 'Text: 48',
				'NADA_Retail__c' => 9.99,
				'NADA_Wholesale__c' => 9.99,
				'Net__c' => 9.99,
				'Odometer_at_Trade_In__c' => 1,
				'Pay_Off_Account_Number__c' => 'Text: 50',
				'Pay_Off_Amount__c' => 9.99,
				'Pay_Off_Expiration_Date__c' => Date.newInstance(1968, 12, 17),
				'Pay_Off_To__c' => 'Text: 255',
				'Position__c' => 1,
				'Profit__c' => 9.99,
				'Recon__c' => 9.99,
				'Stock_Number__c' => 'Text: 25',
				'Trade_Allowance__c' => 9.99,
				'Trim_Level__c' => 'Text: 48',
				'VIN__c' => '1FTFW1EVXAFA39102',
				'Year__c' => '4'
			};
		}
	}

	public class Traffic_LogDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Call_Accounting_ID__c' => 'Text: 128',
				'Call_End__c' => DateTime.newInstance(1968, 12, 17),
				'Call_Integration_Account_ID__c' => 'Text: 25',
				'Call_Profile_Link__c' => 'http://www.google.com',
				'Call_Provider__c' => 'Text: 64',
				'Call_Start__c' => DateTime.newInstance(1968, 12, 17),
				'Call_Termination_Cause__c' => 'Text: 64',
				'Called_Internal_Number__c' => '530-555-1212',
				'Called_Number__c' => '530-555-1212',
				'Caller_Id_FirstName__c' => 'Text: 48',
				'Caller_Id_LastName__c' => 'Text: 48',
				'Calling_Number__c' => '530-555-1212',
				'Conversation_End__c' => DateTime.newInstance(1968, 12, 17),
				'Conversation_Start__c' => DateTime.newInstance(1968, 12, 17),
				'Customer_Email__c' => 'test@gmail.com',
				'Date_In__c' => DateTime.newInstance(1968, 12, 17),
				'First_Name__c' => 'Text: 40',
				'Form_Name__c' => 'Text: 80',
				'Last_Name__c' => 'Text: 40',
				'Phone_Type__c' => 'Text: 48',
				'Shopper__c' => 'Text: 60',
				'Source__c' => 'Text: 255',
				'Traffic_Notes__c' => 'Text Area Test'
			};
		}
	}

	public class UserDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Dealership_Location__c' => 'Text: 255',
				'Flat_Rate_Hourly_Wage__c' => 9.99
			};
		}
	}

	public class VehicleModelDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Body_Style__c' => 'Text: 80',
				'Engine__c' => 'Text: 64',
				'Make__c' => 'Text: 64',
				'Model_Id__c' => 'Text: 80',
				'Model__c' => 'Text: 64',
				'Transmission__c' => 'Text: 64',
				'Trim__c' => 'Text: 64',
				'Year__c' => '4'
			};
		}
	}

	public class Vehicle_EquipmentDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Category__c' => 'Text: 40',
				'Description__c' => 'Long Text Area Test',
				'Installed_By__c' => 'Text: 25',
				'Name__c' => 'Text: 255',
				'Option_Id__c' => 'Text: 25',
				'Order_Code__c' => 'Text: 25'
			};
		}
	}

	public class Vehicle_Inventory_Status_Code_HistoryDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Date_Assigned__c' => Date.newInstance(1968, 12, 17),
				'Date_Unassigned__c' => Date.newInstance(1968, 12, 17),
				'Status_Code__c' => 'Text: 40'
			};
		}
	}

	public class Vehicle_InventoryDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Acct_Make__c' => '4',
				'Acquisition_Date__c' => Date.newInstance(1968, 12, 17),
				'Admin_Fee__c' => 9.99,
				'AutoTrader_com_Image_Count__c' => 1,
				'AutoTrader_com_SRP__c' => 1,
				'AutoTrader_com_VDP__c' => 1,
				'Black_Book_Finance_Advance__c' => 9.99,
				'Black_Book_Retail__c' => 9.99,
				'Black_Book_Wholesale__c' => 9.99,
				'Body_Company_Website__c' => 'http://www.google.com',
				'Body_Company__c' => 'Text: 24',
				'Body_Style__c' => 'Text: 64',
				'Body_Type__c' => 'Text: 64',
				'Branded_Title_State__c' => 'CA',
				'Cars_com_Image_Count__c' => 1,
				'Cars_com_SRP__c' => 1,
				'Cars_com_VDP__c' => 1,
				'City_MPG__c' => 1,
				'Coded_Cost__c' => 9.99,
				'Conversion_Cost__c' => 9.99,
				'Current_Discount__c' => 9.99,
				'Delivery_Date__c' => Date.newInstance(1968, 12, 17),
				'Destination_Charge__c' => 9.99,
				'Doors__c' => 1,
				'Drive_Type__c' => 'Text: 15',
				'Engine_Description__c' => 'Text: 85',
				'Engine_Displacement__c' => 1,
				'Engine_Id__c' => 'Text: 24',
				'Estimated_Reconditioning__c' => 9.99,
				'Exterior_Color__c' => 'Text: 60',
				'Fuel_Tank_Capacity__c' => 1,
				'Fuel_Type__c' => 'Text: 48',
				'FundingExpirationDate__c' => Date.newInstance(1968, 12, 17),
				'GVWR__c' => 1,
				'Highway_MPG__c' => 1,
				'Holdback__c' => 9.99,
				'Hours__c' => 1,
				'Ignition_Key_Code__c' => 'Text: 24',
				'Initial_Retail_Price__c' => 9.99,
				'Interior_Color__c' => 'Text: 80',
				'Internal_Charges__c' => 9.99,
				'Inventory_Date__c' => Date.newInstance(1968, 12, 17),
				'Invoice_Price__c' => 9.99,
				'Invoice_Reference__c' => 'Text: 16',
				'KBB_Private_Party__c' => 9.99,
				'KBB_Retail__c' => 9.99,
				'KBB_Trade_In__c' => 9.99,
				'Keyless_Entry_Code__c' => 'Text: 25',
				'Last_6__c' => '6',
				'Last_Retail_Price_Change__c' => Date.newInstance(1968, 12, 17),
				'Last_VIN_Decode__c' => Date.newInstance(1968, 12, 17),
				'Latitude__c' => 1,
				'License_Exp__c' => Date.newInstance(1968, 12, 17),
				'License__c' => 'Text: 15',
				'Location__c' => 'Text: 64',
				'Longitude__c' => 1,
				'MMR_Retail__c' => 9.99,
				'MMR_Wholesale__c' => 9.99,
				'MSRP__c' => 9.99,
				'Make__c' => 'Text: 40',
				'Max_HP_At__c' => 1,
				'Max_HP__c' => 1,
				'Max_Seating__c' => 1,
				'Max_Torque_At__c' => 1,
				'Max_Torque__c' => 1,
				'Memo_One__c' => 'Text: 25',
				'Memo_Two__c' => 'Text: 25',
				'Mileage__c' => 1,
				'Model_Code__c' => 'Text: 25',
				'Model__c' => 'Text: 64',
				'NADA_Loan__c' => 9.99,
				'NADA_Retail__c' => 9.99,
				'NADA_Trade_In__c' => 9.99,
				'NUO__c' => 'Text: 25',
				'New_Tires__c' => 1,
				'Original_Cost__c' => 9.99,
				'Pack__c' => 9.99,
				'Package_Code__c' => 'Text: 14',
				'Position_Accuracy__c' => 1,
				'Purchase_Date__c' => Date.newInstance(1968, 12, 17),
				'Purchase_Price__c' => 9.99,
				'Purchased_From__c' => 'Text: 64',
				'Rear_Axle_Type__c' => 'Text: 15',
				'Reserve_Price__c' => 9.99,
				'Retail_Price__c' => 9.99,
				'Retail_Ready__c' => Date.newInstance(1968, 12, 17),
				'Sale_Date__c' => Date.newInstance(1968, 12, 17),
				'Status_Code_Assignment_Date__c' => Date.newInstance(1968, 12, 17),
				'Stock_Number__c' => '17F190',
				'Style_Id__c' => 'Text: 40',
				'SuggestedRetailPrice__c' => 9.99,
				'Towing_Capacity__c' => 1,
				'Transmission_Id__c' => 'Text: 25',
				'Transmission_Type__c' => 'Text: 64',
				'Transportation_Fees__c' => 9.99,
				'Trim_Level__c' => 'Text: 64',
				'VIN_Decode_Id__c' => 'Text: 64',
				'VIN__c' => '1FTFW1EVXAFA39102',
				'VUID__c' => 'Text: 18',
				'Vehicle_Cost__c' => 9.99,
				'Vehicle_Order_Number__c' => 'Text: 25',
				'Vehicle_Size__c' => 'Text: 25',
				'Vehicle_Type__c' => 'Text: 25',
				'Web_Comments__c' => '<html>',
				'Work_in_Process__c' => 9.99,
				'Year__c' => '4',
				'vAuto_Adjusted_Cost_to_Market__c' => 10,
				'vAuto_Adjusted_to_Market__c' => 10,
				'vAuto_Average_Market_Price__c' => 9.99,
				'vAuto_Competitive_Set__c' => 1,
				'vAuto_Cost_to_Market__c' => 10,
				'vAuto_Like_Mine__c' => 1,
				'vAuto_Overall_Market__c' => 1,
				'vAuto_Percent_of_Market__c' => 10,
				'vAuto_Price_Rank_Bucket__c' => 'Text: 25',
				'vAuto_rBook__c' => 9.99,
				'vPrice_Rank__c' => 1,
				'vRank_Bucket__c' => 'Text: 25',
				'vRank__c' => 1
			};
		}
	}

	public class VINDecoderCSDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Name' => 'ActiveSettings',
				'DecoderAPI_URL__c' => 'http://www.google.com',
				'DecoderClientID__c' => 'Text: 18',
				'DecoderKey__c' => 'Text: 64',
				'DecoderName__c' => 'Text: 48'
			};
		}
	}

	public class We_Owe_LineDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Cost__c' => 9.99,
				'Description__c' => 'Text Area Test',
				'Labor_Hours__c' => 1,
				'Labor_Sale__c' => 9.99,
				'List_Price__c' => 9.99,
				'Parts_Sale__c' => 9.99,
				'Sale_Price__c' => 9.99
			};
		}
	}

	public class We_OweDefaults implements TestInterfaces.IFieldDefaults 
	{
		public Map<String, Object> getFieldDefaults() 
		{
			return new Map<String, Object> 
			{
				'Closed_Date__c' => DateTime.newInstance(1968, 12, 17),
				'Code__c' => 'Text: 25',
				'Cost__c' => 9.99,
				'Deal_Key__c' => 'Text: 40',
				'Description__c' => 'Text: 255',
				'External_Id__c' => 'Text: 25',
				'RetailPrice__c' => 9.99
			};
		}
	}
}