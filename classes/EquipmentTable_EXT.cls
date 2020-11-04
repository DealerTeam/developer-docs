global with sharing class EquipmentTable_EXT {

	/*LEX Methods*/
	@AuraEnabled
	public static List<Equipment__c> readEquipmentLEX(String vehicleId){
		//Determine RecordType Id
		Map<String,String> keys = new Map<String,String>();
		Map<String,Schema.SobjectType> describe = Schema.getGlobalDescribe();
		for(String s:describe.keyset()){
			keys.put(describe.get(s).getDescribe().getKeyPrefix(),s);
		}
		String sObjectType = keys.get(vehicleId.substring(0,3));

		List<Equipment__c> equipment = new List<Equipment__c>();		
		if(sObjectType == 'dealer__Vehicle_Inventory__c'){
			for(Equipment__c e : [SELECT Id, Service_Vehicle__c, Equipment_Master__c, Description__c, 
									Serial__c, Featured__c, Publish__c, Confirmed__c, 
									Confirmed_Date_Time__c, Confirmed_By__c, Data_Source__c, Notes__c, 
									LastModifiedById, LastModifiedDate, CreatedById, CreatedDate, Name 
									FROM Equipment__c WHERE Service_Vehicle__r.dealer__Sales_Inventory__c =:vehicleId ORDER By CreatedDate DESC]){
				equipment.add(e);							
			}
		} else if(sObjectType == 'dealer__Service_Vehicle__c'){
			for(Equipment__c e : [SELECT Id, Service_Vehicle__c, Equipment_Master__c, Description__c, 
									Serial__c, Featured__c, Publish__c, Confirmed__c, 
									Confirmed_Date_Time__c, Confirmed_By__c, Data_Source__c, Notes__c, 
									LastModifiedById, LastModifiedDate, CreatedById, CreatedDate, Name 
									FROM Equipment__c WHERE Service_Vehicle__c =:vehicleId ORDER By CreatedDate DESC]){
				equipment.add(e);							
			}
		}
		return equipment;
	}
	@AuraEnabled
	public static string getServiceVehicleId(String vehicleId){
		Map<String,String> keys = new Map<String,String>();
		Map<String,Schema.SobjectType> describe = Schema.getGlobalDescribe();
		for(String s:describe.keyset()){
			keys.put(describe.get(s).getDescribe().getKeyPrefix(),s);
		}
		String sObjectType = keys.get(vehicleId.substring(0,3));
		if(sObjectType == 'dealer__Service_Vehicle__c'){
			return sObjectType;
		} else if(sObjectType == 'dealer__Vehicle_Inventory__c'){
			try{
				return [SELECT Id From Service_Vehicle__c WHERE Sales_Inventory__c =: vehicleId LIMIT 1].Id;
			} catch (QueryException e){
				throw new AuraHandledException(e.getMessage());
			}
		}
		return '';
	}
	@AuraEnabled
	public static list <Equipment__c> deleteEquipmentLine(Equipment__c line){
		system.debug('line '+json.serialize(line));
		String vehicleId = line.Service_Vehicle__c;
		try{
			delete line;
		}catch(DmlException e){
			throw new AuraHandledException(e.getMessage());
		}
		return readEquipmentLEX(vehicleId);
	}


	/* Remotes */
	@RemoteAction
	global static List<Equipment__c> readEquipment(String vehicleId) {

		if(vehicleId==null || vehicleId=='') {
			return new List<Equipment__c>();
		}

		return [SELECT Service_Vehicle__c, Equipment_Master__c, Description__c, Serial__c, Featured__c, Publish__c, Confirmed__c, Confirmed_Date_Time__c, Confirmed_By__c, 
						Data_Source__c, Notes__c, LastModifiedById, LastModifiedDate, CreatedById, CreatedDate, Name, Id 
					FROM Equipment__c
					WHERE Service_Vehicle__c =:vehicleId ORDER By CreatedDate DESC];
	}
	@RemoteAction
	global static List<Equipment_Master__c> readEquipmentTemplates(){
		try{
			return [SELECT Name__c,Description__c,Featured__c,Publish__c,Option_Id__c, Id FROM Equipment_Master__c];
		}Catch(DmlException e){
			return new List<Equipment_Master__c>();
		}
	}
	
	@RemoteAction
	global static List<Equipment__c> createEquipment(String line) {
		

		// Convert string into object
		try {
			Equipment__c eline = (Equipment__c)JSON.deserialize(line, Equipment__c.class);
			System.assert(eline.Service_Vehicle__c != null, 'Service_Vehicle__c required, value not found.');
			
			eline.Id=null;
			insert eline; 

			return EquipmentTable_EXT.readEquipment(eline.Service_Vehicle__c);

		} Catch(JSONException e) {
			throw new EquipmentTableException(e.getMessage());
		} Catch(DmlException e) {
			throw new EquipmentTableException(e.getMessage());
		} Catch(Exception e) {
			throw new EquipmentTableException(e.getMessage());
		}
	}

	@RemoteAction
	global static List<Equipment__c> updateEquipment(String line) {
		// Convert string into object
		try {

			Equipment__c eline = (Equipment__c)JSON.deserialize(line, Equipment__c.class);
			System.assert(eline.Id!=null, 'Line ID must be present to update');
			System.assert(eline.Service_Vehicle__c != null, 'Service_Vehicle__c required, value not found.');

			update eline;

			return EquipmentTable_EXT.readEquipment(eline.Service_Vehicle__c);

		} Catch(JSONException e) {
			throw new EquipmentTableException(e.getMessage());
		} Catch(DmlException e) {
			throw new EquipmentTableException(e.getMessage());
		} Catch(Exception e) {
			throw new EquipmentTableException(e.getMessage());
		}
	}

	@RemoteAction
	global static void deleteEquipment(String line) {
		try {

			Equipment__c eline = (Equipment__c)JSON.deserialize(line, Equipment__c.class);
			System.assert(eline.Id!=null, 'Line ID must be present to update');

			delete eline;

		} Catch(JSONException e) {
			throw new EquipmentTableException(e.getMessage());
		} Catch(DmlException e) {
			throw new EquipmentTableException(e.getMessage());
		} Catch(Exception e) {
			throw new EquipmentTableException(e.getMessage());
		}		
	}

	public class EquipmentTableException extends Exception{}

}