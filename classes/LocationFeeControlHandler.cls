public with sharing class LocationFeeControlHandler {
    public LocationFeeControlHandler() {

    }
    public static void setQuickTextFields(List<LocationFee__c> triggerNew)
    {
        for(LocationFee__c l : triggerNew){
            if(l.DefaultCost__c != null){
                l.QuickCost__c = l.DefaultCost__c.length() >= 255 ? l.DefaultCost__c.substring(0,254) : l.DefaultCost__c;
            }
            if(l.DefaultPrice__c != null){
                l.QuickPrice__c = l.DefaultPrice__c.length() >= 255 ? l.DefaultPrice__c.substring(0,254) : l.DefaultPrice__c;
            }
        }
    }
}
