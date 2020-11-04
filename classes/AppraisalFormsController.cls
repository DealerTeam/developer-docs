/**
 * Print Controller for Appraisals
 * @description Tested by AppraisalControllerTest
 */
public with sharing class AppraisalFormsController {
    public dealer__Appraisal__c appraisal {get;set;}
    public String form_id {get;set;}
     public Map<String, String> urlParams = new Map<String, String>();
 
    
    /**
     * AppraisalFormsController 
     * @param controller 
     * @description Constructor         
     */ 
    public AppraisalFormsController(ApexPages.StandardController controller) 
    {
        appraisal = (dealer__Appraisal__c)controller.getRecord();
         urlParams = ApexPages.currentPage().getParameters();
        
           
    }
    
    /**
     * formList 
     * @returns List<dealer__Form__c>
     * @description Returns list of forms
     */
    public List<dealer__Form__c> formList 
    {
        get {
            return [
            SELECT dealer__Active__c, dealer__Form_ID__c, dealer__Impact_Code__c, dealer__Library__c, dealer__Page_Name__c, dealer__Print_Type__c, dealer__Proofed_by__c, 
            dealer__Revision_Date__c, dealer__Sequence__c, Name, Id, dealer__Flatten__c, dealer__DocumentContentId__c 
            FROM dealer__Form__c where dealer__Document_Object__c = 'Appraisals'];

        }
    }
    
       //Retreive FDF Blob
	
    /**
     * getcompiledFDF 
     * @param urlParams 
     * @return String
     * @description
     */ 
    @remoteAction
    public static String getcompiledFDF(String urlParams) 
    {

        String[] params = urlParams.split('~');
        
        String fid = params[0];
        String aid = params[1];
        
        String urlPR = '/apex/dealer__FormFDFData?fid='+fid+'&aprid='+aid;

        PageReference p = new PageReference(urlPR);
        Blob uContetent;
        if(Test.isRunningTest()){
            uContetent = blob.valueof('TEST');
        }
        else {
            uContetent = p.getContent();
        }

        return uContetent.toString();
    }
    
    /**
     * returnToAppraisal
     * @return PageReference
     * @description Return to appraisal detail page
     */
    public PageReference returnToAppraisal() 
    {
        String url = '/apex/dealer__AppraisalWorksheet?id='+appraisal.Id+'&sfdc.override=1';
        PageReference svc = new PageReference(url);
        svc.setRedirect(true);
        return svc;     
    }
    
    /**
     * @description To print Impact form
     */ 
    public dealer__Form__c form = new dealer__Form__c();

    /**
     * selectImpactForm 
     * @return PageReference
     * @description
     */ 
    public PageReference selectImpactForm() 
    {
        if(form_id!=null &&form_id!='') {
            form = [Select Id, dealer__Impact_Code__c from dealer__Form__c where Id=:form_id limit 1];
        }
        return null;
    }
    
    /**
     * compileFDF
     * @param fd 
     * @return String
     * @description 
     */ 
    @RemoteAction 
    public static String compileFDF(String fd) 
    {

        Map<String, Object> js = (Map<String, Object>)JSON.deserializeUntyped(fd);
        String formId = (String)js.get('form');
        String dealId = (String)js.get('deal');
        String urlPR = '/apex/dealer__FormFDFData?fid='+formId+'&did='+dealId;
        
        PageReference p = new PageReference(urlPR);
        	
        if(!Test.isRunningTest()) {
			Blob uContetent = p.getContent();
	        return uContetent.toString();            
        }
        
       	return null;
    }
}