/**
 * DealerTrackCreditApplicationExt
 */
public with sharing class DealerTrackCreditApplicationExt
{	
	/**
	 * @description
	 */ 
    public dealer__Credit_Application__c creditapp { get; set; }
	
	/**
	 * @description
	 */ 
	public boolean validationFailed { get; set; }

	/**
	 * @description
	 */
    public DealerTrackEnums Enums { get; set; }

	/**
	 * @description
	 */ 
	public DealerTrackCreditApplicationHandler.CreditAppDto Dto { get; set; }
	
	/**
	 * DealerTrackCreditApplicationExt 
	 * @param  sc 
	 * @description 
	 */ 
	public DealerTrackCreditApplicationExt(ApexPages.standardController sc) 
	{
	        		
		Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__Credit_Application__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet();
        af.addAll(fieldnames);
		af.add('Store_Location__r.DealerTrackPartnerDealerId__c');
        
        if(!Test.isRunningTest()) 
        {
            sc.addFields(af);
        }
        
		Enums = new DealerTrackEnums();
		Dto = new DealerTrackCreditApplicationHandler.CreditAppDto();
		Dto.EnumProperties = new DealerTrackEnumProperties();
		Dto.app = (dealer__Credit_Application__c)sc.getRecord();

		ValidateApp(Dto.app);
	}

	/**
	 * ValidateApp 
	 * @param  app 
	 * @return void
	 */
	void ValidateApp(dealer__Credit_Application__c app)
	{
		validationFailed = false;

		if(app.Store_Location__c == null)
		{
			app.addError('Store location is required!');
			validationFailed = true;
		}

		if(app.First_Name__c == null || app.Last_Name__c == null)
		{
			app.addError('First Name and Last Name are required!');
			validationFailed = true;
		}

		if(app.Co_App_First_Name__c != null || app.Co_App_Last_Name__c != null)
		{
			if(app.Co_App_First_Name__c == null || app.Co_App_Last_Name__c == null)
			{
				app.addError('If you intend to add a Co-Applicant, First Name and Last Name are required!');
				validationFailed = true;
			}			
		}

		if(validationFailed)
			return;
        
		// populate saved pick list values if we have already created a lead
	    if(app.DealerTrack_DTO__c != null && app.Dealer_Track_Lead_Reference_Number__c != null)
		{
			Dto.EnumProperties = (DealerTrackEnumProperties)JSON.deserialize(app.DealerTrack_DTO__c, DealerTrackEnumProperties.class);
			return;
		}		


		Dto.EnumProperties.ApplicantState = app.Current_Address_State__c != null && app.Current_Address_State__c.length() == 2 ? app.Current_Address_State__c : '';
		Dto.EnumProperties.ApplicantPreviousState = app.Previous_Address_1_State__c != null && app.Previous_Address_1_State__c.length() == 2 ? app.Previous_Address_1_State__c : '';
		Dto.EnumProperties.PresentEmployerState = app.Present_Employer_State__c != null && app.Present_Employer_State__c.length() == 2 ? app.Present_Employer_State__c : '';
		Dto.EnumProperties.PreviousEmployerState = app.Previous_Employer_1_State__c != null && app.Previous_Employer_1_State__c.length() == 2 ? app.Previous_Employer_1_State__c : '';

		Dto.EnumProperties.CoAppRelationship = app.Co_App_Realationship_to_Applicant__c != null && app.Co_App_Realationship_to_Applicant__c.length() == 2 ? app.Co_App_Realationship_to_Applicant__c : '';
		Dto.EnumProperties.CoApplicantState = app.Co_App_Current_Address_State__c != null && app.Co_App_Current_Address_State__c.length() == 2 ? app.Co_App_Current_Address_State__c : '';
		Dto.EnumProperties.CoAppPreviousState  = app.Co_App_Prev_Address_1_State__c != null && app.Co_App_Prev_Address_1_State__c.length() == 2 ? app.Co_App_Prev_Address_1_State__c : '';
		Dto.EnumProperties.CoAppPresentEmployerState = app.Co_App_Present_Employer_State__c != null && app.Co_App_Present_Employer_State__c.length() == 2 ? app.Co_App_Present_Employer_State__c : '';
		Dto.EnumProperties.CoAppPreviousEmployerState = app.Co_App_Previous_Employer_1_State__c != null && app.Co_App_Previous_Employer_1_State__c.length() == 2 ? app.Co_App_Previous_Employer_1_State__c : '';
	}
    
	/**
	 * createLead 
	 * @return PageReference
	 * @descripton
	 */
    public PageReference createLead() 
    { 
    	try
    	{      
	        DealerTrackCreditApplicationHandler.CreateDealerTrackLead(new List<DealerTrackCreditApplicationHandler.CreditAppDto>{ Dto });        
	        return new PageReference('/' + Dto.app.Id);
    	}
    	catch(System.DmlException e)
    	{
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getDmlMessage(0)));
    	}
    	
    	return null;
    }
    
	/**
	 * updateLead 
	 * @return PageReference
	 * @description
	 */
    public PageReference updateLead() 
    {               
    	try
    	{      
	        DealerTrackCreditApplicationHandler.UpdateDealerTrackLead(new List<DealerTrackCreditApplicationHandler.CreditAppDto>{ Dto });        
	        return new PageReference('/' + Dto.app.Id);
    	}
    	catch(System.DmlException e)
    	{
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getDmlMessage(0)));
    	}
    	
    	return null;
    }
}