//Created by MKS 10/29/15
//Last updated: MKS 11/4/15

public with sharing class RefreshVehicles {
   
    public List<dealer__Vehicle_Inventory__c> vehicles; 
    public ApexPages.StandardSetController ssc;

    public decimal vehicleListSize {get;set;}

    public RefreshVehicles(ApexPages.StandardSetController standardSetController){
        this.ssc = standardSetController;

        if(!Test.isRunningTest()) {
            ssc.addFields(new List<String> {'dealer__Company_Number__c', 'dealer__Stock_Number__c'});
        }
        
        this.vehicles = ssc.getSelected();
        this.vehicleListSize = ssc.getResultSize();

    }

    //Refresh Vehicles Version 2
    public PageReference SyncVehicles(){
        //if the list is larger than 0
        if(vehicleListSize <= 0){
            return null;
        }
        else{
            //generate JSON payload

            //initialize JSON Generator and write first '{'
            JSONGenerator generator = JSON.createGenerator(true);
            generator.writeStartObject();

            //As per JK's gist
            generator.writeFieldName('vehicles');
            generator.writeStartArray();

            //iterate through the list
            for(dealer__Vehicle_Inventory__c v : vehicles){
                generator.writeStartObject();
                generator.writeStringField('store', v.dealer__Company_Number__c);
                generator.writeStringField('stock', v.dealer__Stock_Number__c);
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
            req.setEndpoint('https://apsv1.dealerteam.com/api/dealertrack/crmMultVehicleSync.php?orgid='+UserInfo.getOrganizationId());
            if(!Test.isRunningTest()) {
                HTTPResponse res = http.send(req);
            }
            return ssc.save();
        }
    }



}