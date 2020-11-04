global with sharing class BatchCarfaxHistoryReport implements Database.Batchable<sObject>, Database.AllowsCallouts  {
	String query;
    
    global BatchCarfaxHistoryReport() {

    }

    /**
	 * start 
	 * @param  BC 
	 * @description forming batch requires query
	 */
	global Database.QueryLocator start(Database.BatchableContext BC) 
	{
        query = 'SELECT Id, VIN__c, In_Stock__c, Store_Location__c, Store_Location__r.Carfax_Password__c, Store_Location__r.Carfax_Username__c FROM Vehicle_Inventory__c WHERE In_Stock__c = true';

		return Database.getQueryLocator(query);
	}
	
	/**
	 * execute description
	 * @param  BC   
	 * @param  scope 
	 * @return void
	 * @description Process the records
	 */
   	global void execute(Database.BatchableContext BC, List<sObject> scope) 
	{
        System.assert(scope.size() <= 1, 'This batchable method is limited to a batch size of 1, please reduce the batch size and try again.');
        
        Vehicle_Inventory__c vehicle = (Vehicle_Inventory__c) scope[0];

        if(vehicle.Store_Location__c != null && vehicle.VIN__c !=null && Vehicle.Store_Location__r.Carfax_Password__c !=null && vehicle.Store_Location__r.Carfax_Username__c !=null){
            
            CarFaxReportHandler.RequestResult result = new CarFaxReportHandler.RequestResult();
            
            if(!Test.isRunningTest()) result = CarFaxReportHandler.CreateRequest(new Set<String>{vehicle.VIN__c}, vehicle.Store_Location__r.Carfax_Username__c, Vehicle.Store_Location__r.Carfax_Password__c, 'VHR');
            
            if(Test.isRunningTest()){
                result.success = true;
            }
            
            if(!result.success){
                string error = 'An unknown error has occurred';
                if(result.messages.size() > 0){
                    throw new CarFaxAPI.CarFaxAPIException(result.messages[0]);
                } else {
                    throw new CarFaxAPI.CarFaxAPIException(error);
                }
            }
        }
    }
    
	/**
	 * finish 
	 * @param  BC 
	 * @return void
	 * @description
	 */ 
	global void finish(Database.BatchableContext BC) 
	{
		
	}
}
