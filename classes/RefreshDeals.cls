//Created by MKS 10/29/15
//Last updated: MKS 11/9/15


public with sharing class RefreshDeals {
   
    public List<dealer__Deal__c> deals;
    public ApexPages.StandardSetController ssc;

    public decimal dealListSize{get;set;}

    public RefreshDeals(ApexPages.StandardSetController standardSetController){
        this.ssc = standardSetController;
        if(!Test.isRunningTest()) {
            ssc.addFields(new List<String> {'dealer__Company_Number__c','dealer__Deal_ID__c'});
        }
        
        this.deals = ssc.getSelected();
        this.dealListSize = ssc.getResultSize();

    }

    //Refresh Vehicles Version 2
    public PageReference SyncDeals(){
        //if the list is larger than 0
        if(dealListSize <= 0){
            return null;
        }
        else{
            //generate JSON payload

            //initialize JSON Generator and write first '{'
            JSONGenerator generator = JSON.createGenerator(true);
            generator.writeStartObject();

            generator.writeFieldName('deals');
            generator.writeStartArray();

            //iterate through the list
            for(dealer__Deal__c d : deals){
                generator.writeStartObject();
                generator.writeStringField('store', d.dealer__Company_Number__c);
                generator.writeStringField('dealid', d.dealer__Deal_ID__c);
                generator.writeEndObject();
            }

            //end vehicles array
            generator.writeEndArray();

            generator.writeEndObject();
            String vehiclesJSON = generator.getAsString();

            //POST JSON payload
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setMethod('POST');
            req.setBody(vehiclesJSON);
            req.setEndpoint('https://apsv1.dealerteam.com/api/dealertrack/crmMultDealSync.php?orgid='+UserInfo.getOrganizationId());

            if(!Test.isRunningTest()) {
                HTTPResponse res = http.send(req);
            }
            
            return ssc.save();
        }
    }
}