/**
 * @description
 */
public with sharing class CreditApplicationController 
{
    /**
     * saveRecord 
     * @param  record 
     * @return  Credit_Application__c
     */
    @AuraEnabled
	public static Credit_Application__c saveRecord(Credit_Application__c record) {
        // Perform isUpdatable() checking first, then
        // 
		
        if(record.Id==null) {
            
            // set the Name Property
            String iso8601 = Datetime.now().format('yyyy-MM-dd');
            if (record.First_Name__c != null) {
                record.name = iso8601+'-'+record.First_Name__c+' '+record.Last_Name__c;
            } else {
                record.name = iso8601+'-'+record.Business_Name__c;
            }
            
            record.Store_Location__c = Utility.lookupUserLocation();
            
            try {
                insert record;
            } Catch(DmlException e) {
                throw new creditException(e.getMessage());
            }
        }
        
        if(record.Id!=null) {
            try {
                update record;
            } Catch(DmlException e) {
                throw new creditException(e.getMessage());
            }
        }
		
        return record;
    }

    @AuraEnabled(cacheable=true)
    public static string getApplicationType(String recordId){
       return [SELECT Id, ApplicationType__c FROM Credit_Application__c WHERE Id =: recordId].ApplicationType__c;
    }

    /**
     * GetApplication 
     * @param  appId 
     * @return  Credit_Application__c
     * @description
     */
    @auraEnabled
    public static Credit_Application__c GetApplication(string appId)
    {
        List<string> fields = new List<string>(Credit_Application__c.SObjectType.getDescribe().fields.getMap().keySet());
        fields.add('Store_Location__r.SevenHundredCredit_Acount_Name__c');
        fields.add('Store_Location__r.SevenHundredCredit_Password__c');
        fields.add('Store_Location__r.SevenHundredCredit_Bureaus__c');
        string soql = 'SELECT ' + string.join(fields, ',') + ' from Credit_Application__c where id = \''+ appId +'\' limit 1';

        return Database.query(soql);
    }

    /**
     * getRelatedApps retrieves applications related to the sales up of a deal
     * @param  appId appId description
     * @return       return description
     */
    @AuraEnabled(cacheable=true)
    public static List<LookupSearchResult> getRelatedApps(String dealId){
        LookupSearchCreditApplications ls = new LookupSearchCreditApplications();
        return ls.dealRelatedApps(dealId);
    }

    @AuraEnabled
    public static Sales_Up__c getSalesUp(String supId){
        return (Sales_Up__c)Utility.queryAllFields('dealer__Sales_Up__c', supId);
    }

    @AuraEnabled
    public static Credit_Application__c createAppFromSalesUp(String supId){
        return CreditApplicationAPI.createFromSalesUp(supId);
    }

    @AuraEnabled(cacheable=true)
    public static List<CreditApplicationSubmission__c> getPreviousSubmissions(String appId){
        CreditApplicationSubmission__c [] submissions = [SELECT Id, CreatedDate, Status__c, SubmissionResponse__c, Deal__c, Deal__r.Name, UUID__c FROM CreditApplicationSubmission__c WHERE CreditApplication__c =: appId ORDER BY CreatedDate DESC];
        return submissions;
    }

    @AuraEnabled(cacheable=true)
    public static List<LookupSearchResult> primaryDeal(String appId){
        LookupSearchDeals ls = new LookupSearchDeals();
        Credit_Application__c app = [SELECT Id, Sales_Up__c FROM Credit_Application__c WHERE Id =: appId];
        if(app.Sales_Up__c != null){
            Sales_Up__c sup = [SELECT Id, Car_Deal__c FROM Sales_up__c WHERE Id =: app.Sales_Up__c];
            if(sup.Car_Deal__c != null){
                return ls.geSelectionById(sup.Car_Deal__c);
            }
        }
        return null;
    }

    @AuraEnabled(cacheable=true)
    public static List<LookupSearchResult> getRelatedDeals(String appId){
        LookupSearchDeals ls = new LookupSearchDeals();
        return ls.appRelatedDeals(appId);
    }

    @AuraEnabled
    public static List<LookupSearchResult> getServiceProviders(String appId){
        Credit_Application__c app = [SELECT Id, Sales_Up__c, Sales_Up__r.Store_Location__c FROM Credit_Application__c WHERE Id =: appId];
        LookupSearchLocationServices ls = new LookupSearchLocationServices();
        return ls.locationServices(app.Sales_Up__r.Store_Location__c);
    }

    @AuraEnabled
    public static List<LookupSearchResult> getServiceProvidersDeal(String dealId){
        Deal__c deal = [SELECT Id, Store_Location__c FROM Deal__c WHERE Id =: dealId];
        LookupSearchLocationServices ls = new LookupSearchLocationServices();
        return ls.locationServices(deal.Store_Location__c);
    }

    @AuraEnabled
    public static CreditApplicationSubmission__c submitApplication(String integration, String recordId, String dealId, String providerId){
        //TODO - Determine Other application integrations (only RouteOne is supported as of early 2020)
        try{
            if(integration == 'RouteOne'){
                return CreditApplicationAPI.submitRouteOne(recordId, dealId, providerId);
            }else if(integration == 'DealerTrack'){
                return CreditApplicationAPI.submitDealerTrack(recordId, dealId, providerId);
            }
            return new CreditApplicationSubmission__c();
        } catch(Exception e){
            system.debug(e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }

    
    /**
     * creditException
     * @description
     */
    public class creditException extends Exception {}
}