public with sharing class RouteOne {
    public class Callout
    {
        public String providerId;
        public Credit_Application__c app;
        public Sales_Up__c sup;
        public Deal__c deal;
        public Vehicle_Inventory__c vehicle;
        public Trade_In__c trade;

        public Callout(Id appId, Id dealId, String providerId){
            this.providerId = providerId;
            app = (Credit_Application__c)Utility.queryAllfields('dealer__Credit_Application__c', appId);
            deal = new Deal__c();
            vehicle = new Vehicle_Inventory__c();
        
            sup = app.Sales_up__c == null ? new Sales_Up__c() : [Select Id, dealer__Car_Deal__c FROM Sales_Up__c WHERE Id =: app.dealer__Sales_Up__c];

            if(dealId != null){
                deal = (Deal__c)Utility.queryAllfields('dealer__Deal__c', dealId);
                System.assert(deal.Id != null, 'Supplied Deal Id is not valid.');
                Trade_In__c [] trades = [SELECT Make__c, Model__c, Year__c FROM Trade_In__c WHERE Car_Deal__c =: dealId];
                trade = trades.size() > 0 ? trades[0] : new Trade_In__c();
                if(deal.Vehicle__c != null){
                    vehicle = (Vehicle_Inventory__c)Utility.queryAllFields('dealer__Vehicle_Inventory__c', deal.Vehicle__c);
                }
            }
        }
    }

    public class SubmissionResponse{
        public String conversationId;
        public ResponseBody response;
    }

    public class ResponseBody{
        public String body;
        //Only errors returned are missing fields from validation
        public List<String> errors;
    }
}