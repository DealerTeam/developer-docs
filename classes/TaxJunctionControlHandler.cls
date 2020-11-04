public with sharing class TaxJunctionControlHandler {
    public static void setTaxZoneDates(List<TaxJunction__c> triggerNew){
        List<Tax_Region__c> regions = new List<Tax_Region__c>();
        for(TaxJunction__c tj : triggerNew){
            if(tj.TaxRegion__c != null){
                regions.add(new Tax_Region__c(Id = tj.TaxRegion__c));
            }
        }
        TaxAPI.setTaxZoneDates(regions);
    }
}
