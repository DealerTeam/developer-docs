/**
 * BatchUpdatePartSaleMetric
 * @test PartAnalyticsSystemLayer
 * @description Handles Batch processing of parts inventory
 */
global with sharing class BatchUpdatePartSaleMetric implements Database.Batchable<sObject> {
	
	String query;
	
	/**
	 * BatchUpdatePartSaleMetric description
	 * @description
	 */ 
	global BatchUpdatePartSaleMetric() 
	{
		
	}
	
	/**
	 * start 
	 * @param  BC 
	 * @description forming batch requires query
	 */
	global Database.QueryLocator start(Database.BatchableContext BC) 
	{
		query = 'SELECT Id, Sale_Metrics__c FROM Parts_Inventory__c';
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
   		Map<Id,Parts_Inventory__c> partsInventoryMap = new Map<Id, Parts_Inventory__c>();
   		for(Sobject s : scope){
   			partsInventoryMap.put( (Id)s.Id,(Parts_Inventory__c)s );
   		}
   		PartApi.saleMetricHandler(partsInventoryMap);
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