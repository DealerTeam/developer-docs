/**
 * DealPrintController
 * @description
 */
global with sharing class DealPrintController {
    
    /**
     * @description
     */
    global DealAPI.Deal dealW {get;set;}
    
    /**
     * @description
     */
    global String InvoiceLogo {get;set;}
    
    /**
     * DealPrintController 
     * @param  controller 
     * @description
     */
    global DealPrintController(ApexPages.StandardController controller) 
    {
        Id dealId = ApexPages.currentPage().getParameters().get('id');
        dealW = DealAPI.dealData(dealId);
        InvoiceLogo = dealer.DealershipLocationAPI.formLogoURL(dealW.location.Id);
    }
}