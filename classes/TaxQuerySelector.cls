public with sharing class TaxQuerySelector {
    public static Deal__c deal(String dealId) {
        return [SELECT Id, Pickup_or_Delivery__c, Buyer_City__c, Buyer_State__c, Buyer_Postal_Code__c, Buyer_County__c, Delivery_City__c, Delivery_State__c, Delivery_Postal_Code__c, Delivery_County__c, Store_Location__c, Store_Location__r.Tax_Delivery_Address__c, Store_Location__r.City__c, Store_Location__r.State__c, Store_Location__r.County__c, Store_Location__r.Postal_Code__c FROM Deal__c WHERE Id =: dealId];
    }
}