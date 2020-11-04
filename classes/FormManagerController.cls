/**
 * @author DealerTeam.com, LLC
 * @description Service Layer controller for Aura and LWC components.  Used within the Form Manager UX.
 */
public with sharing class FormManagerController {
   
    /* Form Assignment methods */
    /**
     * getForms description
     * @param  locId locId description
     * @return       return description
     */
    @AuraEnabled(cacheable=true)
    public static FMFormWrapper getForms(Id locId) 
    {
        List<Form__c> availableForms = new List<Form__c>();
        List<FormRef__c> selectedFormRefs = new List<FormRef__c>();
        Set<Id> selectedFormIds = new Set<Id>();

        for(FormRef__c fr : [SELECT Id, Name, Form__c, Note__c,
                            Form__r.Name, Form__r.Description__c, Form__r.DefaultFormula__c
                            FROM FormRef__c WHERE Location__c =: locId AND Deselected__c = null]){
            selectedFormRefs.add(fr);
            selectedFormIds.add(fr.Form__c);
        }

        for(Form__c form: [SELECT Id, Name, Description__c, DefaultFormula__c, Document_Object__c FROM Form__c WHERE Id NOT IN: selectedFormIds]){
                availableForms.add(form);
        }

        return new FMFormWrapper(availableForms, selectedFormRefs);
    }

    /**
     * getTabUrl description
     * @return   return description
     */
    @AuraEnabled(cacheable=true)
    public static String getTabUrl(){
        return DealerMetadata.getObjectTabUrl('dealer__Form__c');
    }

    /**
     * formData description
     * @param  recordId recordId description
     * @return          return description
     */
    @AuraEnabled(cacheable=true)
    public static FormWrapper formData(String recordId){
        
        List<Form__c> availableForms = allForms(recordId);
        List<Form__c> applicableForms = applicableForms(recordId);
        List<Form__c> selectedForms = selectedForms(recordId);

        return new FormWrapper(availableForms,applicableForms,selectedForms);
    }

    /**
     * allForms description
     * @param  recordId recordId description
     * @return          return description
     */
    public static List<Form__c> allForms(String recordId){
        //TODO-get sobject type from recordId
        return DealAPI.availableForms(recordId);
    }

    /**
     * applicableForms description
     * @param  recordId recordId description
     * @return          return description
     */
    public static List<Form__c> applicableForms(String recordId) {
        //TODO-get sobject type from recordId
        return DealAPI.applicableForms(recordId);
    }

    /**
     * selectedForms description
     * @param  recordId recordId description
     * @return          return description
     */
    public static List<Form__c> selectedForms(String recordId) {
        //TODO-get sobject type from recordId
        return DealAPI.selectedForms(recordId);
    }

    /**
     * removeForm description
     * @param  recordId recordId description
     * @param  formId   formId description
     * @return          return description
     */
    @AuraEnabled
    public static Boolean removeForm(String recordId, String formId){
        // IF object is deal:
        DealAPI.removeDealForm(recordId, formId);
        return true;
    }

    /**
     * addForms description
     * @param  recordId recordId description
     * @param  formIds  formIds description
     * @return          return description
     */
    @AuraEnabled
    public static Boolean addForms(String recordId, List<String> formIds){
        DealAPI.addDealForms(recordId, formIds);
        return true;      
    }

    /**
     * printForms description
     * @param  recordId recordId description
     * @param  formIds  formIds description
     * @return          return description
     */
    @AuraEnabled
    public static PrintResult printForms(String recordId, List<String> formIds){

        List<Form__c> applicableForms = DealAPI.applicableForms(recordId);

        Map<Id, Form__c> applicableMap = new Map<Id, Form__c>();
        for(Form__c form : applicableForms){
            applicableMap.put(form.Id, form);
        }

        List<String> formsToAdd = new List<String>();
        List<Form__c> formsToPrint = new List<Form__c>();

        for(Form__c form : [SELECT Id, dealer__DocumentContentId__c, dealer__Page_Name__c, dealer__Print_Type__c, dealer__FDF_Code__c FROM Form__c where Id IN: formIds]){
            formsToPrint.add(form);
            //Does not exist on current record (deal for now only)
            if(applicableMap.get(form.Id) != null){
                formsToAdd.add(form.Id);
            }
        }
       
        return new PrintResult(formAPI.bundleForms(recordId, formsToPrint), formsToAdd);
        // return FormAPI.bundleForms(recordId, formsToPrint);
    }

    /**
     *  @description 
     */
    public class PrintResult {

        /** @description result contains the print request result */
        @AuraEnabled public String result {get;set;}

        /** @description List of forms to be added to the print request */
        @AuraEnabled public List<String> formsToAdd {get;set;}

        /**
         * PrintResult description
         * @param  result     result description
         * @param  formsToAdd formsToAdd description
         * @return            return description
         */
        public PrintResult(String result, List<String> formsToAdd){
            this.Result = result;
            this.FormsToAdd = formsToAdd;
        }
    }

    /**
     * @description Nested wrapper class
     */
    public class FMFormWrapper {

        /** @description List of form sobjects available for printing */
        @AuraEnabled List<Form__c> availableForms {get;set;}
        
        /** @description List of form reference of selected forms */
        @AuraEnabled List<FormRef__c> selectedFormRefs {get;set;}

        /**
         * FMFormWrapper description
         * @param  availableFormsT   availableFormsT description
         * @param  selectedFormRefsT selectedFormRefsT description
         * @return                   return description
         */
        public FMFormWrapper(List<Form__c> availableFormsT, List<FormRef__c> selectedFormRefsT){
            availableForms = availableFormsT;
            selectedFormRefs = selectedFormRefsT;
        }
    }    
    
    /**
     * @description This wrapper class organizes the form data for column based layout usage. 
     */
    public class FormWrapper{

        @AuraEnabled List<Form__c> availableForms {get;set;}
        @AuraEnabled List<Form__c> applicableForms {get;set;}
        @AuraEnabled List<Form__c> selectedForms {get;set;}

        /**
         * FormWrapper description
         * @param  availableForms  availableForms description
         * @param  applicableForms applicableForms description
         * @param  selectedForms   selectedForms description
         * @return                 return description
         */
        public FormWrapper(List<Form__c> availableForms, List<Form__c> applicableForms, List<Form__c> selectedForms){
            this.availableForms = availableForms.size() > 0 ? availableForms : new List<Form__c>();
            this.applicableForms = applicableForms.size() > 0 ? applicableForms : new List<Form__c>();
            this.selectedForms = selectedForms.size() > 0 ? selectedForms : new List<Form__c>();
        }
    }
}