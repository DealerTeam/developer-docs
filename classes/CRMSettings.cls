/**
 * CRMSettings 
 * @description
 */
public with sharing class CRMSettings {
    
    /**
     * @description
     */
    public dealer__CRMSettings__c crm {get;set;}
    
    /**
     * @description
     */
    public String selectedDupeOption{get;set;}
    
    /**
     * CRMSettings 
     * @description
     */
    public CRMSettings() 
    {
        crm=dealer__CRMSettings__c.getOrgDefaults();
        if(crm==null) {
            crm=new dealer__CRMSettings__c();
        }
        
        if(crm.dealer__Native_or_Non_Native_Dupe_Catching__c == null || crm.dealer__Native_or_Non_Native_Dupe_Catching__c == ''){
            selectedDupeOption = 'Non-Native';
            crm.dealer__Native_or_Non_Native_Dupe_Catching__c = selectedDupeOption;
        }
        if(crm.Duplicate_Check_Statuses__c == null || crm.Duplicate_Check_Statuses__c == ''){
            crm.Duplicate_Check_Statuses__c = 'Open, Duplicate';
        }
    }

    /**
     * getDupeOptions 
     * @return  List<SelectOption>
     * @description
     */
    public List<SelectOption> getDupeOptions() 
    {
        List<SelectOption> dupeOptions = new List<SelectOption>();
        dupeoptions.add(new SelectOption('Select One','Select One'));
        dupeoptions.add(new SelectOption('Native','Native'));
        dupeoptions.add(new SelectOption('Non-Native','Non-Native'));
 
        return dupeOptions;
    }
    
    /**
     * Save 
     * @return  PageReference
     * @description
     */
    public PageReference Save() 
    {
        // If dealer__MPI_Upsell_OpCode__c set verify
        if(crm.dealer__MPI_Upsell_OpCode__c != null) {
            dealer__StandardOpCode__c[] defaultOpCode = [Select Id from dealer__StandardOpCode__c where dealer__Op_Code__c =:crm.dealer__MPI_Upsell_OpCode__c limit 1];
            if(defaultOpCode.size()==0) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error: MPI Default Op Code Not Found'));
                return null;              
            }
        }
        // Save Settings
        try {
            if(crm.Id==null) {
                    insert crm;
                } else {
                    update crm;
            }
        } Catch(DmlException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
                return null;             
        }

        PageReference p = Page.CRMSettings;
        p.setRedirect(true);
        return p;
    }

    /**
     * deleteRecord 
     * @return  PageReference
     * @description
     */
    public PageReference deleteRecord() 
    {
        crm=dealer__CRMSettings__c.getOrgDefaults();
        try {
            delete crm;
        } Catch(DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
            return null;              
        }

        PageReference p = Page.CRMSettings;
        p.setRedirect(true);
        return p;        
    }
}