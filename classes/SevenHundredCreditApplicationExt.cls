public with sharing class SevenHundredCreditApplicationExt 
{
    public dealer__Credit_Application__c creditapp { get; set; }
    public String reportType { get; set; }
    public List<String> BureauOptions { get; set; }
    public List<String> Bureaus { get; set; }
    public boolean FormIsInvalid { get; set; }
	
	public SevenHundredCreditApplicationExt(ApexPages.standardController sc) 
	{
	        		
	Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__Credit_Application__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet();
        af.addAll(fieldnames);
        af.add('dealer__Store_Location__r');
        af.add('dealer__Store_Location__r.SevenHundredCredit_Acount_Name__c');
        af.add('dealer__Store_Location__r.SevenHundredCredit_Password__c');
        af.add('dealer__Store_Location__r.SevenHundredCredit_Bureaus__c');
        
        if(!Test.isRunningTest()) 
        {
            sc.addFields(af);
        }
        
        creditapp = (dealer__Credit_Application__c)sc.getRecord();

        FormIsInvalid = FormInvalid();
        
        if(!FormIsInvalid)
            PopulateBureaus();
	}

    private void PopulateBureaus()
    {
        // populate the bureau select list
        BureauOptions = new List<String>();
        BureauOptions.addAll(creditapp.Store_Location__r.SevenHundredCredit_Bureaus__c.split(';'));
    }

    public List<SelectOption> getBureauSelectOptions() 
    {
        List<SelectOption> options = new List<SelectOption>();

        if(!FormIsInvalid)
        {
            for(string opt : BureauOptions)
            {
                // Enum - TU, XPN, EFX - Example: "TU:XPN:EFX"
                if(opt == 'Equifax')
                    options.add(new SelectOption('EFX', opt));

                if(opt == 'Experian')
                    options.add(new SelectOption('XPN', opt));

                if(opt == 'TransUnion')
                    options.add(new SelectOption('TU', opt));
            }
        }

        return options;
    }
    
    public PageReference RunReport()
    {
        if(PostedDataIsValid())
        {
            try
            {      
                SevenHundredCreditApplicationHandler.InquiryResult result = SevenHundredCreditApplicationHandler.CreateInquiry(new Set<Id>{  creditapp.Id }, reportType, bureaus);

                if(!result.success)
                {
                    // default error message
                    string error = 'An unknown error has occurred';
                    
                    // actual error message
                    if(result.messages.size() > 0)
                        error = result.messages[0];
                    
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, error));              
                }
                else
                {
                    return new PageReference('/' + creditapp.Id);
                }
            }
            catch(System.DmlException e)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getDmlMessage(0)));
            }
            
            return null;            
        } else {
            return null;
        }         
    }

    public boolean FormInvalid()
    {
        boolean invalid = false;

        if(creditapp.Store_Location__r == null)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please set the store location and try again.'));
            invalid = true;
        }

        if(creditapp.Store_Location__r.SevenHundredCredit_Acount_Name__c == null)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please set the 700Credit Account Name in store location and try again.'));
            invalid = true;
        }

        if(creditapp.Store_Location__r.SevenHundredCredit_Password__c == null)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please set the 700Credit Password in store location and try again.'));
            invalid = true;
        }

        if(creditapp.Store_Location__r.SevenHundredCredit_Bureaus__c == null)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please set the 700Credit Bureaus in store location and try again.'));
            invalid = true;
        }

        if(creditapp.Current_Address_State__c != null && creditapp.Current_Address_State__c.length() > 2 || creditapp.Previous_Address_1_State__c != null && creditapp.Previous_Address_1_State__c.length() > 2)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Applicant States must be a 2 character abbreviation. i.e. CA'));
            invalid = true;
        }

        if(creditapp.Co_App_Current_Address_State__c != null && creditapp.Co_App_Current_Address_State__c.length() > 2 || creditapp.Co_App_Prev_Address_1_State__c != null && creditapp.Co_App_Prev_Address_1_State__c.length() > 2)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Co-Applicant States must be a 2 character abbreviation. i.e. CA'));
            invalid = true;
        }

        if(creditapp.Experian_Credit_Report_Url__c != null)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'An Experian Credit Report has already been pulled. You will be charged again!'));         
        }

        if(creditapp.Equifax_Credit_Report_Url__c != null)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'An Equifax Credit Report has already been pulled. You will be charged again!'));         
        }

        if(creditapp.TransUnion_Credit_Report_Url__c != null)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'A TransUnion Credit Report has already been pulled. You will be charged again!'));      
        }

        if(creditapp.OFAC_Report_Url__c != null)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'An OFAC Report has already been pulled. You will be charged again!'));         
        }

        if(creditapp.Red_Flag_Report_Url__c != null)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'A Red Flag Report has already been pulled. You will be charged again!'));         
        }


        return invalid;
    }

	public Boolean getFormInValid() {
		return FormIsInvalid;
	}
 
    // Data posted to the form
    boolean PostedDataIsValid()
    {
        boolean valid = true;

        if(reportType == 'CREDIT' && bureaus.size() == 0)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You must select at least one bureau to run report'));
            valid = false;
        }

        if(reportType == 'CREDIT' || reportType == 'OFAC')
        {
            if(creditapp.First_Name__c == null || creditapp.Last_Name__c == null || creditapp.Social_Security_Number__c == null || creditapp.Current_Address_City__c == null || creditapp.Current_Address_State__c == null || creditApp.Current_Address_Zip__c == null)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'First Name, Last Name, SSN, Address, City, State and Zip are required for Credit and Ofac Reports'));
                valid = false;
            }
        }

        if(reportType == 'REDFLAG')
        {
            if(creditapp.First_Name__c == null || creditapp.Last_Name__c == null)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'First Name and Last Name are required for Redflag Reports'));
                valid = false;
            }
        }

        return valid;      
    }
}