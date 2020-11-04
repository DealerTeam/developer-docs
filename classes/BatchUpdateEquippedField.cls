/**
 * BatchUpdateEquippedField
 * @description
 */ 
global with sharing class BatchUpdateEquippedField implements Database.Batchable<sObject>, Database.Stateful {

   /**
	* @description
	*/
	global final String Query;
   
   /**
	* @description
	*/
	global final String Entity;

   /**
	* @description
	*/
	global final String OldField;

   /**
	* @description
	*/
	global final String NewField;
   
   /**
	* @description
	*/
	global List<id> ListRecForEmailId;

   /**
	* BatchUpdateEquippedField 
	* @param  e 
	* @param  f 
	* @param  v 
	* @description  
	*/
   global BatchUpdateEquippedField(String q, String e, String f, String v)
   {
             Query=q; Entity=e; OldField=f;NewField=v;
             ListRecForEmailId = new List<id>();
   }

   /**
	* start 
	* @param  BC 
	* @return Database.QueryLocator
	* @description
	*/
	global Database.QueryLocator start(Database.BatchableContext BC)
   {
      return Database.getQueryLocator(query);
   }

   /**
	* execute 
	* @param  BC    
	* @param  scope 
	* @return void
	* @description
	*/ 
   global void execute(Database.BatchableContext BC, List<sObject> scope)
   {

   		set<id> AllRecordId = new set<id>();
   		List<id> AllSuccessRecordId = new List<id>();
	      for(Sobject s : scope)
	      {
	      	Boolean oldValue = (Boolean)s.get(OldField);
	      	s.put(NewField,oldValue); 
	      	AllRecordId.add(s.id);
	      }
      //update scope;
		Database.SaveResult[] srList = Database.update(scope, false);

		// Iterate through each returned result
		for (Database.SaveResult sr : srList) {
		    if (sr.isSuccess()) {
		        // Operation was successful, so get the ID of the record that was processed
		        System.debug('Successfully inserted Equipment: ' + sr.getId());
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
			 mail.setSubject('Org:('+UserInfo.getOrganizationId()+') BatchUpdateEquippedField Failed Records');  
			 mail.setHTMLBody('Org ID:('+UserInfo.getOrganizationId()+')<br></br><b> BatchUpdateEquippedField failed records ID:</b> <br></br><br></br>' +ListRecForEmailId);  

			 Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });  

   }

}