@isTest (seeAllData=true)
public with sharing class TestSalesUpListController_EXT {
    static testmethod void testSUPListController() {
        List<dealer__Sales_Up__c> lup = [Select Id, Name from dealer__Sales_Up__c limit 100];
        ApexPages.Standardsetcontroller slc = new ApexPages.Standardsetcontroller(lup);
        SalesUp_EXT controller = new SalesUp_EXT(slc);
        controller.getProxyDate();
        controller.searchLeadVehicleMake='Ford';
        controller.searchLeadVehicleModel='Fusion';
        
        controller.searchUps();
    }
}