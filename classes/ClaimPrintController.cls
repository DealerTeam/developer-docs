/**
 * ClaimPrintController
 * @description
 */
global with sharing class ClaimPrintController {

    /**
     * @description
     */  
    global ClaimAPI.claim claimW {get;set;}
    
    /**
     * @description
     */
    global String InvoiceLogo {get;set;}

    /**
     * ClaimPrintController 
     * @param  controller 
     * @description  
     */
    global ClaimPrintController(ApexPages.StandardController controller) 
    {
        Id claimId = ApexPages.currentPage().getParameters().get('id');
        claimW = ClaimAPI.claimData(claimId);
        
        if (claimW.location.Id != null  ) {
			 	InvoiceLogo = dealer.DealershipLocationAPI.formLogoURL(claimW.location.Id);

        }

    }
}