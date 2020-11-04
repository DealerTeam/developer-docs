global with sharing class BatchDeleteVehicleEquipment implements Database.Batchable<sObject> {

	String query;
	
	/**
	 * BatchUpdatePartSaleMetric description
	 * @description
	 */ 
	global BatchDeleteVehicleEquipment() 
	{
		
    }
    
	/**
	 * start 
	 * @param  BC 
	 * @description forming batch requires query
	 */
	global Database.QueryLocator start(Database.BatchableContext BC) 
	{
        query = 'SELECT Id, Sales_Inventory__c FROM Service_Vehicle__c';
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
        System.assert(scope.size() <= 100, 'This batchable method is limited to a batch size of 100, please reduce the batch size and try again.');
        List<Service_Vehicle__c> sVehicles = new List<Service_Vehicle__c>();
           
   		for(Sobject s : scope){
            Service_Vehicle__c v = (Service_Vehicle__c)s;
            sVehicles.add(v);
        }
           
   		VehicleEquipmentAPI.deleteVehicleEquipment(sVehicles);
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
