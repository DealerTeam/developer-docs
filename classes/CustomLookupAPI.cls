public with sharing class CustomLookupAPI {
    @AuraEnabled
    public static List<LookupSearchResult> searchLocation(String searchTerm) {
        try {
            String sObjectName = Dealer_Location__c.SObjectType.getDescribe().getName();
            LookupSearch s = LookupSearchFactory.getInstance().getLookupSearch(sObjectName);
            return s.search(searchTerm);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<LookupSearchResult> getRecentLocations() {
        try {
            String sObjectName = Dealer_Location__c.SObjectType.getDescribe().getName();
            LookupSearch s = LookupSearchFactory.getInstance().getLookupSearch(sObjectName);
            return s.getRecent();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<LookupSearchResult> selectedLocation(String locId)
    {
        try {
            LookupSearchDealerLocation ls = new LookupSearchDealerLocation();
            return ls.geSelectionById(locId);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<LookupSearchResult> selectedVehicle(String dealId)
    {
        try {
            Deal__c d = [SELECT Vehicle__c FROM Deal__c WHERE Id =: dealId];
            LookupSearchVehicleInventory ls = new LookupSearchVehicleInventory();
            return ls.geSelectionById(d.Vehicle__c);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}