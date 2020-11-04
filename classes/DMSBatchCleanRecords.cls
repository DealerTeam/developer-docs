/**
 * DMSBatchCleanRecords
 * @test TestDMSImports
 * @description Cleans records of invalid external Ids
 */
global class DMSBatchCleanRecords implements Database.Batchable<sObject>,
										        Database.AllowsCallouts {
	
	String query;
    public String ObjectAPIName {get;set;}
    public String DMSObjJSON {get;set;}
	
	/**
	 * DMSBatchCleanRecords description
	 * @description constructor
	 */ 
	global DMSBatchCleanRecords(String Type, String objJSON) 
	{
		ObjectAPIName = Type;
        DMSObjJSON = objJSON;
	}
	
	/**
	 * start 
	 * @param  BC 
	 * @description forming batch requires query
	 */
	global Database.QueryLocator start(Database.BatchableContext BC) 
	{   
        query = 'SELECT Id FROM '+ObjectAPIName;

        if(ObjectAPIName == 'Account'){
            query = 'SELECT Id, dealer__External_Id__c FROM Account';
        }
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

        if(ObjectAPIName == 'Account'){
            List<Account> sfAccts = (List<Account>)scope;
            List<Account> dmsAccts = (List<Account>)JSON.deserialize(DMSObjJSON, List<Account>.class);
            DMSImportsAPI.cleanAccounts(sfAccts, dmsAccts);
        }
        // else if vehicle, deal etc...

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