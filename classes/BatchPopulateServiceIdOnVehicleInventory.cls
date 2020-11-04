/**
 * BatchPopulateServiceIdOnVehicleInventory
 * @description
 */ 
global with sharing class BatchPopulateServiceIdOnVehicleInventory implements Database.Batchable<sObject> {
	
	String query;
	global List<id> ListRecForEmailId;

	/**
	 * BatchPopulateServiceIdOnVehicleInventory
	 * @description
	 */
	global BatchPopulateServiceIdOnVehicleInventory() 
	{
		ListRecForEmailId = new List<id>();
	}
	
	/**
	 * start description
	 * @param  BC   
	 * @description
	 */ 
	global Database.QueryLocator start(Database.BatchableContext BC) 
	{
		query = 'Select id, name, dealer__VIN__c, dealer__Service_Vehicle__c from dealer__Vehicle_Inventory__c where dealer__Service_Vehicle__c = null and dealer__VIN__c != null';
		return Database.getQueryLocator(query);
	}

	/**
	 * execute description
	 * @param  BC   
	 * @param  scope 
	 * @return void
	 * @description	
	 */ 
   	global void execute(Database.BatchableContext BC, List<dealer__Vehicle_Inventory__c> scope) 
	{
		Set<String> svSet = new Set<String>();
        Map<String, dealer__Service_Vehicle__c> svExistingData = new Map<String, dealer__Service_Vehicle__c>();
        List<dealer__Vehicle_Inventory__c> ListUpdateVehicle = new List<dealer__Vehicle_Inventory__c>();
        List<id> AllSuccessRecordId = new List<id>();
        set<id> AllRecordId = new set<id>();

		for(dealer__Vehicle_Inventory__c objVeh: scope)
		{
			if(!svSet.contains(objVeh.dealer__VIN__c)) {
                svSet.add(objVeh.dealer__VIN__c);
            } 
		}

		for(dealer__Service_Vehicle__c svExisting : [Select id, name, dealer__VIN__c  
                                From dealer__Service_Vehicle__c where dealer__VIN__c IN:svSet]) {
            svExistingData.put(svExisting.dealer__VIN__c, svExisting);
        }

        for(dealer__Vehicle_Inventory__c objVeh: scope)
		{
			if(svExistingData.containsKey(objVeh.dealer__VIN__c)) {
                objVeh.dealer__Service_Vehicle__c = svExistingData.get(objVeh.dealer__VIN__c).id;
                ListUpdateVehicle.add(objVeh);
                AllRecordId.add(objVeh.id);
            } 
		}
		//update ListUpdateVehicle;
		Database.SaveResult[] srList = Database.update(ListUpdateVehicle, false);

		// Iterate through each returned result
		for (Database.SaveResult sr : srList) {
		    if (sr.isSuccess()) {
		        // Operation was successful, so get the ID of the record that was processed
		        System.debug('Successfully inserted records: ' + sr.getId());
		        AllSuccessRecordId.add(sr.getId());
		    }
		}
		AllRecordId.removeAll(AllSuccessRecordId);
		if(AllRecordId.size() > 0)
		{
			ListRecForEmailId.addAll(AllRecordId);
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
		
			AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email
 						     FROM AsyncApexJob WHERE Id = :BC.getJobId()];

			 // Email each Batch failed records  
			 Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();  
			 String[] toAddresses = new String[] {'apexerror@dealerteam.com'};  
			 mail.setToAddresses(toAddresses);  
			 mail.setSubject('Org:('+UserInfo.getOrganizationId()+')BatchPopulateServiceIdOnVehicleInventory Failed Records');  
			 mail.setHTMLBody('Org ID:('+UserInfo.getOrganizationId()+')<br></br><b> BatchPopulateServiceIdOnVehicleInventory failed records ID:</b> <br></br> <br></br>' +ListRecForEmailId);  

			 Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 

	}
	
}