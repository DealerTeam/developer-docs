/**
 * InvFeed : Manages and produces feed output for sharing venicle inventory via JSON.  
 * 			 This controller and InvWebFeed.page can be included in Salesforce Sites for syndication
 *
 * Tested By: Test_InventoryFeedManager
 * @author jarrett kuljis
 * @notes 
 */
public with sharing class InvFeed {

	public Map<String, String> urlParameters = new Map<String, String>();

	public String id { get; set; }
	public String vin { get; set; }
	public String stock { get; set; }
	public String recordtype { get; set; }
	public String publishToWeb { get; set; }
	public String storeId { get; set; } // Contains a list of locations by Company Number
	public String nuo { get; set; } 
	public Boolean hasURLParams { get; set; }
	public Boolean xmlOutput {get;set;}
	public String contentTypeVar {get;set;}

	public List<dealer__InventoryFeed__c> feedItems { get; set; }
	public List<String> xmlFields {get;set;}
	public List<String> vehicle_inventory_fields { get; set; }
	public List<String> image_fields { get; set; }
	public List<String> equip_fields { get; set; }
	public List<String> veh_equip_fields { get; set; }
	
	/**
	 * InvFeed Constructor
	 * @notes The constructor load the inventory feed items in a public list for VF Page consumption
	 */
	public InvFeed() {
		hasURLParams = false;
		readURLParameters();
		loadFeedItems();
		vehicle_inventory_fields = new List<String>();
		image_fields = new List<String>();
		equip_fields = new List<String>();
		veh_equip_fields = new List<String>();
		buildQueryStrings();
	}

	/**
	 *
	 *	readURLParameters 
	 * 	@notes The read parameters routine will allow specific field filters.  The filters are specifically as follows.
	 *  		RecordID, RecordType, VIN, StockNumber, PublishToWeb, StoreLocation, NUO
	 */
	public void readURLParameters(){
		urlParameters = ApexPages.currentPage().getParameters();

        if( urlParameters.get('id') != null ) {
            id = String.valueOf( urlParameters.get('id') );
			hasURLParams=true;
        }

        if( urlParameters.get('vin') != null ) {
            vin = String.valueOf( urlParameters.get('vin') );
			hasURLParams=true;
        }

        if( urlParameters.get('stock') != null ) {
            stock = String.valueOf( urlParameters.get('stock') );
			hasURLParams=true;
        }

        if( urlParameters.get('recordtype') != null ) {
            recordtype = String.valueOf( urlParameters.get('recordtype') );
			hasURLParams=true;
        }

        if( urlParameters.get('publishtoweb') != null ) {
            publishToWeb = String.valueOf( urlParameters.get('publishtoweb') );
			hasURLParams=true;
        }

        if( urlParameters.get('storeId') != null ) {
            storeId = String.valueOf( urlParameters.get('storeId') );
			hasURLParams=true;
        }

        if( urlParameters.get('nuo') != null ) {
            nuo = String.valueOf( urlParameters.get('nuo') );
			hasURLParams=true;
        }		

		xmlOutput = urlParameters.get('xmloutput') == 'true' ? true : false;
		contentTypeVar = xmlOutput == true ? 'application/xml; charset=utf-8' : 'application/x-JavaScript; charset=utf-8';
	}

	/**
	 * loadFeedTabe - Erases and re-creates the feed table items
	 * @return pagereferece null
	 */
	public PageReference loadFeedTable() {
		
		// Clear the table

		//need a map of old feed items so we can prepopulate include on reload.
		Map<String,Boolean> existingFeedMap = new Map<String,Boolean>();

		List<dealer__InventoryFeed__c> clearEvent = new List<dealer__InventoryFeed__c>();
		for(InventoryFeed__c feedItem : [Select Id, APIObjectName__c, APIFieldName__c, Include__c from InventoryFeed__c]) {
			String apiFieldName = feedItem.APIObjectName__c+'.'+feedItem.APIFieldName__c;
			if(existingFeedMap.get(apiFieldName) == null){
				existingFeedMap.put(apiFieldName,feedItem.Include__c);
			}
			clearEvent.add(feedItem);
		}
		delete clearEvent;

		Decimal incr = 1;
		List<dealer__InventoryFeed__c> newFeedItems = new List<dealer__InventoryFeed__c>();
		
		// Prepare Inventory Header Data
		Map<String, Schema.SObjectField> schemaMap = Schema.SObjectType.dealer__Vehicle_Inventory__c.fields.getMap();
		for(String field : schemaMap.keySet()) {
			Schema.DescribeFieldResult  dsr = schemaMap.get(field).getDescribe();
			String apiFieldName = 'dealer__Vehicle_Inventory__c.'+dsr.getName();

			incr++;
			newFeedItems.add(new dealer__InventoryFeed__c(
								Name=String.valueOf(incr),
								dealer__Include__c=existingFeedMap.get(apiFieldName) != null ? existingFeedMap.get(apiFieldName) : false,
								dealer__FeedName__c=dsr.getName(),
								dealer__APIFieldName__c=dsr.getName(),
								dealer__APIObjectName__c='dealer__Vehicle_Inventory__c',
								dealer__Type__c=String.valueOf(dsr.getType()),
								dealer__FeedItemId__c=incr
							)
			);
		}

		// Prepare Images
		Map<String, Schema.SObjectField> schemaImgMap = Schema.SObjectType.dealer__Inventory_Images__c.fields.getMap();
		for(String field : schemaImgMap.keySet()) {
			Schema.DescribeFieldResult dir = schemaImgMap.get(field).getDescribe();
			String apiFieldName = 'dealer__Iventory_Images__c.'+dir.getName();
			incr++;
			newFeedItems.add(new dealer__InventoryFeed__c(
						Name=String.valueOf(incr),
						dealer__Include__c=existingFeedMap.get(apiFieldName) != null ? existingFeedMap.get(apiFieldName) : false,
						dealer__FeedName__c=dir.getName(),
						dealer__APIFieldName__c=dir.getName(),
						dealer__APIObjectName__c='dealer__Inventory_Images__c',
						dealer__Type__c=String.valueOf(dir.getType()),
						dealer__FeedItemId__c=incr
					)
			);
		}

		//Prepare Equipment
		Map<String, Schema.SObjectField> equipMap = Schema.SObjectType.dealer__Equipment__c.fields.getMap();
		for(String field : equipMap.keySet()) {
			Schema.DescribeFieldResult dir = equipMap.get(field).getDescribe();
			String apiFieldName = 'dealer__Equipment__c.'+dir.getName();

			incr++;
			newFeedItems.add(new dealer__InventoryFeed__c(
						Name=String.valueOf(incr),
						dealer__Include__c=existingFeedMap.get(apiFieldName) != null ? existingFeedMap.get(apiFieldName) : false,
						dealer__FeedName__c=dir.getName(),
						dealer__APIFieldName__c=dir.getName(),
						dealer__APIObjectName__c='dealer__Equipment__c',
						dealer__Type__c=String.valueOf(dir.getType()),
						dealer__FeedItemId__c=incr
					)
			);
		}

		//Prepare Vehicle Equipment (Vin Decoded Information)
		/*Map<String, Schema.SObjectField> vehicleEquipMap = Schema.SObjectType.dealer__Vehicle_Equipment__c.fields.getMap();
		for(String field : vehicleEquipMap.keySet()) {
			Schema.DescribeFieldResult dir = vehicleEquipMap.get(field).getDescribe();
			String apiFieldName = 'dealer__Vehicle_Equipment__c.'+dir.getName();

			incr++;
			newFeedItems.add(new dealer__InventoryFeed__c(
						Name=String.valueOf(incr),
						dealer__Include__c=existingFeedMap.get(apiFieldName) != null ? existingFeedMap.get(apiFieldName) : false,
						dealer__FeedName__c=dir.getName(),
						dealer__APIFieldName__c=dir.getName(),
						dealer__APIObjectName__c='dealer__Vehicle_Equipment__c',
						dealer__Type__c=String.valueOf(dir.getType()),
						dealer__FeedItemId__c=incr
					)
			);
		}*/

		try {
			insert newFeedItems;
		} Catch(DmlException e) {
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
		}

		loadFeedItems();

		return null;
	}

	/**
	 * loadFeedItems
	 *
	 * @return void
	 * @notes performs SOQL to get all inventory feed items into the public list of feed items
	 */
	public void loadFeedItems() {
		feedItems = [Select Id, Name, dealer__FeedName__c, dealer__APIFieldName__c, dealer__Include__c,
					dealer__APIObjectName__c, dealer__Type__c, dealer__FeedItemId__c
					From  dealer__InventoryFeed__c order by dealer__FeedItemId__c ASC];
	}

	/**
	 * buildQueryStrings
	 * @return void
	 * @notes builds list of strings for the selected fields.
	 */
	public void buildQueryStrings(){
		
		vehicle_inventory_fields.add('Id');
		vehicle_inventory_fields.add('dealer__Service_Vehicle__c');

		if(xmlOutput == true){
			xmlFields = new List<String>{'dealer__Stock_Number__c', 'dealer__Inventory_Date__c', 'CreatedDate', 'dealer__VIN__c', 'dealer__Unit_Type__c', 'dealer__New_Used_Other__c', 'dealer__Make__c', 'dealer__Year__c', 'dealer__Model__c', 'dealer__Trim_Level__c', 'dealer__Body_Type__c', 'dealer__Doors__c', 'dealer__Transmission_Shift_Type__c', 'dealer__Engine_Description__c', 'dealer__Status_Code__c', 'dealer__Drive_Type__c', 'dealer__Fuel_Type__c', 'dealer__CombinedMPG__c', 'dealer__City_MPG__c', 'dealer__Highway_MPG__c', 'dealer__Exterior_Color__c', 'dealer__Interior_Color__c', 'dealer__Store_Location__c', 'dealer__Store_Location__r.Name', 'dealer__Title_Type__c', 'dealer__Certified_Pre_Owned__c', 'dealer__MSRP__c', 'dealer__Coded_Cost__c', 'dealer__Web_Comments__c', 'dealer__Mileage__c'};
		}
		
		image_fields.add('Id');
		if(xmlOutput == true){
			image_fields.add('dealer__Image_URL__c');
			image_fields.add('dealer__CDNURL__c');
		}
		equip_fields.add('Id');
		equip_fields.add('dealer__Service_Vehicle__c');

		veh_equip_fields.add('Id');
		veh_equip_fields.add('dealer__Vehicle_Inventory__c');
		

		for(dealer__InventoryFeed__c invf : [Select Id, Name, dealer__FeedName__c, dealer__APIFieldName__c, dealer__Include__c,
					dealer__APIObjectName__c, dealer__Type__c, dealer__FeedItemId__c
					From  dealer__InventoryFeed__c where dealer__Include__c = true]) {

			if(invf.dealer__APIObjectName__c=='dealer__Vehicle_Inventory__c' && invf.dealer__APIFieldName__c != 'Id' && invf.dealer__APIFieldName__c != 'dealer__Service_Vehicle__c') {
				vehicle_inventory_fields.add(invf.dealer__APIFieldName__c);
			}

			if(invf.dealer__APIObjectName__c=='dealer__Inventory_Images__c' && invf.dealer__APIFieldName__c != 'Id' && xmlOutput==false) {
				image_fields.add(invf.dealer__APIFieldName__c);
			}

			if(invf.dealer__APIObjectName__c=='dealer__Equipment__c' && invf.dealer__APIFieldName__c != 'Id' && invf.dealer__APIFieldName__c != 'dealer__Service_Vehicle__c' ) {
				equip_fields.add(invf.dealer__APIFieldName__c);
			}
			if(invf.dealer__APIObjectName__c=='dealer__Vehicle_Equipment__c' && invf.dealer__APIFieldName__c != 'Id' && invf.dealer__APIFieldName__c != 'dealer__Vehicle_Inventory__c' ) {
				veh_equip_fields.add(invf.dealer__APIFieldName__c);
			}
			
		}
		//Only add xml fields to query string if they aren't present to prevent duplicate fields error
		if(xmlFields != null){
			for(String s : xmlFields){
				if(!vehicle_inventory_fields.contains(s)){
					vehicle_inventory_fields.add(s);
				}
			}
		}
		

	}
	/**
	 * queryVehicleInventory
	 * @return List<Vehicle_Inventory__c>
	 * @notes performs SOQL to get all inventory feed items into the public list of feed items
	 */
	public  List<dealer__Vehicle_Inventory__c> queryVehicleInventory(){
		
		// Generate Vehicle SOQL
		String query;
		if(hasURLParams && (id!=null || stock!=null || vin!=null)){
			
			String apiName = id!=null?'Id':stock!=null?'Stock_Number__c':vin!=null?'VIN__c':'';
			String filterValue = id!=null?'\''+id+'\'':stock!=null?'\''+stock+'\'':vin!=null?'\''+vin+'\'':'';
			query = ' SELECT ' +
				String.join( vehicle_inventory_fields , ',' ) +
				' , (SELECT ' + String.join ( image_fields , ',' ) + ' FROM Inventory_Images__r ORDER BY dealer__Sequence_Number__c ASC) ' +
			' FROM Vehicle_Inventory__c ' +
			' WHERE '+apiName+' = '+filterValue+' ' +
			' Limit 1';

		} else if(hasURLParams) {
			
			query = ' SELECT ' +
				String.join( vehicle_inventory_fields , ',' ) +
				' , (SELECT ' + String.join ( image_fields , ',' ) + ' FROM Inventory_Images__r ORDER BY dealer__Sequence_Number__c ASC) ' +
			' FROM Vehicle_Inventory__c ' +
			' WHERE Name != NULL ';
			if(recordtype!=null) { query += ' AND RecordType.DeveloperName = \''+ String.escapeSingleQuotes(recordtype) +'\' '; }
			if(publishToWeb!=null) { query += ' AND Publish_Vehicle_Info_To_Web__c = '+ String.escapeSingleQuotes(publishToWeb); }  
			if(storeId!=null) { 
				List<String> locationsList = storeId.split(',');
				query+= ' AND Store_Location__r.Company_Number__c IN :locationsList ';
				/*  \''+ String.escapeSingleQuotes(storeId) +'\''; */
			}
			if(nuo!=null) { query+= 'AND New_Used_Other__c = \''+ String.escapeSingleQuotes(nuo) +'\' '; }
			query += ' Limit 5000';	

		} else {
			
			query = ' SELECT ' +
				String.join( vehicle_inventory_fields , ',' ) +
				' , (SELECT ' + String.join ( image_fields , ',' ) + ' FROM Inventory_Images__r ORDER BY dealer__Sequence_Number__c ASC) ' +
			' FROM Vehicle_Inventory__c ' +
			' WHERE In_Stock__c = true ' +
			' Limit 5000';

		}

		try{
			return Database.query(query);
		} catch(DmlException e){
			throw new DmlException(e.getMessage());
		}
	}

	/**
	 * queryServiceVehicles
	 * @return Map<Id, List<Decode_Values__b>>
	 * @notes performs SOQL to get all service vehicles into the public set of service vehicles
	 */
	public Map<Id, List<Decode_Values__b>> queryServiceVehicles(Set<Id> serviceVehicleIds){

		try {
			return VINDecoderAPI.decodedEquipment(serviceVehicleIds);
		} catch(Exception e){
			throw new InventoryFeedException(e.getMessage());
		}


	}
	
	/**
	 * getEquipmentMap
	 * @return Map<Id, List<Equipment__c>>
	 * @notes Map<service vehicle Id,  Equipment list for that Service Vehicle> (Non-vin decoded equipment)
	 */
	public Map<Id, List<Equipment__c>> getEquipmentMap(List<Vehicle_Inventory__c> vehicleList){//service vehicle Id  / Equipment list for that svc vehicle
		Map<Id,List<Equipment__c>> equipMap = new Map<Id, List<Equipment__c>> ();

		if(vehicleList.size()==0) {
			return equipMap;
		}
		
		List<String> serviceVehicleIds = new List<String>();
		for(Vehicle_Inventory__c inv : vehicleList){
			serviceVehicleIds.add('\''+inv.Service_Vehicle__c+'\'');
		}

		String fields = String.join(serviceVehicleIds,',');
		String query = ' SELECT ' +
		      String.join( equip_fields , ',' ) +
		  ' FROM dealer__Equipment__c ' +
		  ' WHERE dealer__Service_Vehicle__c IN ('+fields+') '+
		  ' AND dealer__Publish__c = true ';
		try{
			for(Equipment__c equip : Database.query(query)){
				if(!equipMap.containsKey(equip.Service_Vehicle__c)){
					equipMap.put(equip.Service_Vehicle__c,new List<Equipment__c>());
				}
				equipMap.get(equip.Service_Vehicle__c).add(equip);
			}	
		}catch(DmlException e){
			throw new DmlException(e.getMessage());
		}
		return equipMap;
	}

	public Map<Id, List<Vehicle_Equipment__c>> getVehicleEquipmentMap(List<Vehicle_Inventory__c> vehicleList){
		Map<Id,List<Vehicle_Equipment__c>> equipMap = new Map<Id, List<Vehicle_Equipment__c>> ();

		if(vehicleList.size()==0) {
			return equipMap;
		}		
		
		List<String> vehicleIds = new List<String>();
		for(Vehicle_Inventory__c inv : vehicleList){
			vehicleIds.add('\''+inv.Id+'\'');
		}

		String fields = String.join(vehicleIds,',');
		String query = ' SELECT ' +
		      String.join( veh_equip_fields , ',' ) +
		  ' FROM dealer__Vehicle_Equipment__c ' +
		  ' WHERE dealer__Vehicle_Inventory__c IN ('+fields+') ';
		try{
			for(Vehicle_Equipment__c equip : Database.query(query)){
				if(!equipMap.containsKey(equip.Vehicle_Inventory__c)){
					equipMap.put(equip.Vehicle_Inventory__c,new List<Vehicle_Equipment__c>());
				}
				equipMap.get(equip.Vehicle_Inventory__c).add(equip);
			}	
		}catch(DmlException e){
			throw new DmlException(e.getMessage());
		}
		return equipMap;
	}

	/**
	 * getInventory - returns inventoryWrapper class of the inventory and equipment 
	 * @return List (inventoryWrapper.class)
	 */
	public List<InventoryWrapper> getInventory(){
		
		List<Vehicle_Inventory__c> vehicleList = queryVehicleInventory();
		
		// Get Decoder Data prepared
		Set<Id> serviceVehicleIds = new Set<Id>();
		for(Vehicle_Inventory__c v : vehicleList) {
			serviceVehicleIds.add(v.dealer__Service_Vehicle__c);
		}

		Map<Id, List<Decode_Values__b>> decoderMap = new Map<Id, List<Decode_Values__b>>();
		
		if(xmlOutput==true) { 
			decoderMap = queryServiceVehicles(serviceVehicleIds);
		}

		// Get Equipment Data
		Map<Id,List<Equipment__c>> equipmentMap = getEquipmentMap(vehicleList);
		Map<Id,List<Vehicle_Equipment__c>> vehicleEquipmentMap = new Map<Id,List<Vehicle_Equipment__c>>();
		
		if(hasUrlParams) vehicleEquipmentMap = getVehicleEquipmentMap(vehicleList);

		List<InventoryWrapper> invList = new List<InventoryWrapper>();
		for(Vehicle_Inventory__c v :vehicleList){
			InventoryWrapper inv = new InventoryWrapper();
			inv.vehicle = v;
			inv.equipment= equipmentMap.get(v.Service_Vehicle__c);
			inv.vehicleEquipment = vehicleEquipmentMap.get(v.Id);
			inv.decoderValues = decoderMap.get(v.dealer__Service_Vehicle__c);
			invList.add(inv);
		}
		return invList;
	}

	public List<InventoryWrapper> invWrap = new list<InventoryWrapper>();

	public class InventoryWrapper{
		public Vehicle_Inventory__c vehicle {get;set;}
		public List<Equipment__c> equipment {get;set;}
		public List<Vehicle_Equipment__c> vehicleEquipment {get;set;}
		public List<Decode_Values__b> decoderValues {get;set;}
	}

	/**
	 * formatFeed - take the list of inventory and create json from the feed
	 * @return String (JSON)
	 * @notes Generate a json feed based on the selected items for the feed
	 */
	public String formatFeed() {

		// Obtain Ivnentory matched
		List<inventoryWrapper> matchedInventory = getInventory();

		// If no inventory matched return empty list
		if(matchedInventory.size()==0) {
			return '[{}]';
		}

		// Create a map of the feed items for friendly names
		Map<String, String> fnames = new Map<String, String>();
		for(dealer__InventoryFeed__c f : feedItems) {
			fnames.put(f.dealer__APIFieldName__c, f.dealer__FeedName__c);
		}

		// Iterate over the list of inventory records and display the json
		JSONGenerator gen = JSON.createGenerator(true);
		gen.writeStartObject();
		
		//Vehicles
		gen.writeFieldName('vehicles');
		gen.writeStartArray();
		for(inventoryWrapper v : matchedInventory){
			Vehicle_Inventory__c veh = v.vehicle;
			gen.writeStartObject();
			for(dealer__InventoryFeed__c f : feedItems) {
				if(f.dealer__APIObjectName__c == 'dealer__Vehicle_Inventory__c' && f.dealer__Include__c==true) {
					if(veh.get(f.dealer__APIFieldName__c) !=null) {
						gen.writeStringField(f.dealer__FeedName__c, String.valueOf(veh.get(f.dealer__APIFieldName__c)));
					}
				}

			}

			//Images
			gen.writeFieldName('images');
			gen.writeStartArray();
				for(dealer__Inventory_Images__c i : veh.Inventory_Images__r) {
					gen.writeStartObject();
					for(dealer__InventoryFeed__c f : feedItems) {
						if(f.dealer__APIObjectName__c == 'dealer__Inventory_Images__c' && f.dealer__Include__c==true) {
							if(i.get(f.dealer__FeedName__c)!=null) {
								gen.writeStringField(f.dealer__FeedName__c, String.valueOf(i.get(f.dealer__APIFieldName__c)));
							}
						}
					}
					gen.writeEndObject();
				}
			gen.writeEndArray();
			
			//Equipment Non-Decoded Data
			gen.writeFieldName('equipment');
			gen.writeStartArray();
			if(v.equipment != null){
				for(Equipment__c e : v.equipment){
					gen.writeStartObject();
					for(dealer__InventoryFeed__c f : feedItems) {
						if(f.dealer__APIObjectName__c == 'dealer__Equipment__c' && f.dealer__Include__c==true) {
							if(e.get(f.dealer__FeedName__c)!=null) {
								gen.writeStringField(f.dealer__FeedName__c, String.valueOf(e.get(f.dealer__APIFieldName__c)));
							}
						}
					}
					gen.writeEndObject();
				}
			}
			gen.writeEndArray();

			// Vehicle Equipment (Vin Decoded Data)
			if(hasURLParams){
				gen.writeFieldName('vehicle_equipment');
				gen.writeStartArray();
				if(v.vehicleEquipment != null){
					for(Vehicle_Equipment__c e : v.vehicleEquipment){
						gen.writeStartObject();
						for(dealer__InventoryFeed__c f : feedItems) {
							if(f.dealer__APIObjectName__c == 'dealer__Vehicle_Equipment__c' && f.dealer__Include__c==true) {
								if(e.get(f.dealer__FeedName__c)!=null) {
									gen.writeStringField(f.dealer__FeedName__c, String.valueOf(e.get(f.dealer__APIFieldName__c)));
								}
							}
						}
						gen.writeEndObject();
					}
				}
				gen.writeEndArray();
			}

			gen.writeEndObject();
		}
		gen.writeEndArray();
		gen.writeEndObject();

		return gen.getAsString();
	}

	public String formatXmlFeed(){
		// Obtain Ivnentory matched
		List<inventoryWrapper> matchedInventory = getInventory();

		// If no inventory matched return empty list
		if(matchedInventory.size()==0) {
			return '[{}]';
		}

		// Create a map of the feed items for friendly names
		Map<String, String> fnames = new Map<String, String>();
		for(dealer__InventoryFeed__c f : feedItems) {
			fnames.put(f.dealer__APIFieldName__c, f.dealer__FeedName__c);
		}

		List<String> additionalFields = new list<String> {'SubType', 'TruckType', 'TruckEngine', 'TruckHorsepower', 'TruckClass', 'TruckTrans', 'TruckAuto', 'TruckManual', 'TruckAxles', 'TruckSuspension', 'TruckTireSize',
															'RVType', 'RVLength', 'RVSleepingCapacity', 'RVSlideOuts', 'RVWaterCapacity', 'RVLevellingJacks', 'RVAwnings', 'RVAirConditioners'};

		Xmlstreamwriter xmlFeed = new Xmlstreamwriter();
		xmlFeed.writeStartDocument('utf-8','1.0');
			xmlFeed.writeStartElement(null,'Inventory', null);
				for(InventoryWrapper v : matchedInventory){
					Vehicle_Inventory__c veh = v.vehicle;
					xmlFeed.writeStartElement(null,'Vehicle',null);
						xmlFeed.writeStartElement(null, 'ID', null);
							xmlFeed.writeCharacters(String.valueOf(veh.Id));
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'StockNum', null);
						if(veh.Stock_Number__c != null){
							xmlFeed.writeCharacters(String.valueOf(veh.Stock_Number__c));
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'InventoryDate', null);
						if(veh.Inventory_Date__c != null){
							xmlFeed.writeCharacters(String.valueOf(veh.Inventory_Date__c));
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'CreatedDate', null);
							xmlFeed.writeCharacters(String.valueOf(veh.CreatedDate.date()));
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'VIN', null);
							xmlFeed.writeCharacters(veh.Vin__c);
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'LotID', null);
							xmlFeed.writeCharacters('');
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'Type', null);
						if(veh.New_Used_Other__c != null){
							xmlFeed.writeCharacters(veh.New_Used_Other__c);
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'VehicleCategory', null);
						xmlFeed.writeCharacters('Passenger');
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'Certified', null);
						if(veh.Certified_Pre_Owned__c != null){
							xmlFeed.writeCharacters(String.valueOf(veh.Certified_Pre_Owned__c));
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'Year', null);
						if(veh.Year__c != null){
							xmlFeed.writeCharacters(veh.Year__c);
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'Make', null);
						if(veh.Make__c != null){
							xmlFeed.writeCData(veh.Make__c);
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'Model', null);
						if(veh.Model__c != null){
							xmlFeed.writeCData(veh.Model__c);
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'ModelNum', null);
						if(veh.Trim_Level__c != null){
							xmlFeed.writeCData(veh.Trim_Level__c);
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'SubModel', null);
						
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'Style', null);
						if(veh.Body_Type__c != null){
							xmlFeed.writeCharacters(veh.Body_Type__c);
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'VehicleType', null);
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'Doors', null);
						if(veh.Doors__c != null){
							xmlFeed.writeCharacters(String.valueOf(veh.Doors__c));
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'Transmission', null);
						if(veh.Transmission_Shift_Type__c != null){
							xmlFeed.writeCharacters(veh.Transmission_Shift_Type__c);
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'Engine', null);
						if(veh.Engine_Description__c != null){
							xmlFeed.writeCData(veh.Engine_Description__c);
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'SaleStatus', null);
						if(veh.Status_Code__c != null){
							xmlFeed.writeCData(veh.Status_Code__c);
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'SpecialHeadline', null);
						if(veh.Web_Comments__c != null){
							xmlFeed.writeCData(veh.Web_Comments__c);
						}						
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'Cylinders', null);
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'Drivetrain', null);
						if(veh.Drive_Type__c != null){
							xmlFeed.writeCharacters(veh.Drive_Type__c);
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'Fuel', null);
						if(veh.Fuel_Type__c != null){
							xmlFeed.writeCharacters(veh.Fuel_Type__c);
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'Mileage', null);
						if(veh.Mileage__c != null){
							xmlFeed.writeCharacters(String.valueOf(veh.Mileage__c));
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'MpgCity', null);
						if(veh.City_MPG__c != null){
							xmlFeed.writeCharacters(String.valueOf(veh.City_MPG__c));
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'MpgHighway', null);
						if(veh.Highway_MPG__c != null){
							xmlFeed.writeCharacters(String.valueOf(veh.Highway_MPG__c));
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'ExtColor', null);
						if(veh.Exterior_Color__c != null){
							xmlFeed.writeCharacters(veh.Exterior_Color__c);
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'ExtColor_Factory', null);
						if(veh.Exterior_Color__c != null){
							xmlFeed.writeCharacters(veh.Exterior_Color__c);
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'IntColor', null);
						if(veh.Interior_Color__c != null){
							xmlFeed.writeCharacters(veh.Interior_Color__c);
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'IntColor_Factory', null);
						if(veh.Interior_Color__c != null){
							xmlFeed.writeCharacters(veh.Interior_Color__c);
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'Location', null);
						if(veh.Store_Location__c != null){
							xmlFeed.writeCData(veh.Store_Location__r.Name);
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'Title', null);
						if(veh.Title_Type__c != null){
							xmlFeed.writeCharacters(String.valueOf(veh.Title_Type__c));
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'MonthlyPayment', null);
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'ShowroomPrice', null);
						if(veh.MSRP__c != null){
							xmlFeed.writeCharacters(String.valueOf(veh.MSRP__c));
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null, 'InternetPrice', null);
						if(veh.Coded_Cost__c != null){
							xmlFeed.writeCharacters(String.valueOf(veh.Coded_Cost__c));
						}
						xmlFeed.writeEndElement();
		//Iterate these???
						for(String additionalField : additionalFields){
							xmlFeed.writeStartElement(null, additionalField, null);
							xmlFeed.writeEndElement();
						}
						
						// VIN Decode (Equiped) data
						List<Decode_Values__b> equipmentList = v.decoderValues;

						if (equipmentList != null) {

							xmlFeed.writeStartElement(null, 'Features', null);

							// Create category map
							Map<String, List<Decode_Values__b>> categoryMap = new Map<String, List<Decode_Values__b>>();
							for(Decode_Values__b d : equipmentList) {
								if(categoryMap.get(String.valueOf(d.EquipmentCategory__c))==null) {
									categoryMap.put(String.valueOf(d.EquipmentCategory__c), new List<Decode_Values__b> { d });
								} else {
									List<Decode_Values__b> dList = categoryMap.get(String.valueOf(d.EquipmentCategory__c));
									dList.add(d);
									categoryMap.put(String.valueOf(d.EquipmentCategory__c), dList);
								}
							}

							for(String c : categoryMap.keySet()) {
								// Start Category Node
								xmlFeed.writeStartElement(null, 'Category', null);
								xmlFeed.writeAttribute(null,null,'Name', c);
								
									// Itegrate Features
									for(Decode_Values__b dv : categoryMap.get(c)) {
										xmlFeed.writeStartElement(null, 'Feature', null);
											xmlFeed.writeCData(String.valueOf(dv.Equipmentname__c) +': '+ String.valueOf(dv.Description__c));
										xmlFeed.writeEndElement();
									}

								// End Category Node
								xmlFeed.writeEndElement();
							}


							
							// End Features Node
							xmlFeed.writeEndElement();
						}
						

						xmlFeed.writeStartElement(null, 'PhotosCount', null);
						if(veh.Inventory_Images__r != null){
							xmlFeed.writeCharacters(String.valueOf(veh.Inventory_Images__r.size()));
						}
						else{
							xmlFeed.writeCharacters('0');
						}
						xmlFeed.writeEndElement();
						xmlFeed.writeStartElement(null,'PhotoURLs', null);
						
						for(Inventory_Images__c image : veh.Inventory_Images__r){
							xmlFeed.writeStartElement(null,'PhotoURL', null);
							if(image.dealer__CDNURL__c != null){
								xmlFeed.writeCharacters(String.valueOf(image.dealer__CDNURL__c));
							}
							xmlFeed.writeEndElement();
						}
						xmlFeed.writeEndElement(); //Close PhotoURLs			
					xmlFeed.writeEndElement(); //Close Vehicle

				}
			xmlFeed.writeEndElement(); //Close Inventory
		xmlFeed.writeEndDocument(); //Close XML document

		String xmlStringxmlRes = xmlFeed.getXmlString();
   
		xmlFeed.close();

		return xmlStringxmlRes;
	}

	/**
	 * getDisplayFeed
	 * @return String (JSON)
	 * @notes Getter for the VF Page InvWebFeed
	 */
	public String getDisplayFeed() {
		return xmlOutput != true ? formatFeed().replace('{ }, ','').replace('{ } ','') : formatXmlFeed();
	}

	/**
	 * saveInclude 
	 * @param  String : Id of the field to include in the results of the Feed
	 * @return Boolean
	 */
	@RemoteAction
	public static boolean saveInclude(String s) {
		dealer__InventoryFeed__c invfeed = [Select Id, dealer__Include__c from dealer__InventoryFeed__c where Id =:s limit 1];
		if(invFeed.dealer__Include__c==true) {
			invFeed.dealer__Include__c = false;
		} else {
			invFeed.dealer__Include__c = true;
		}
		update invFeed;
		return true;
	}

	/**
	 * saveLabel 
	 * @param  String colon seperated name:id
	 * @return Boolean
	 * @notes sets the value of the output field in the JSON Feed
	 */
	@RemoteAction
	public static boolean saveLabel(String sI) {
		String[] s = sI.split(':');
		dealer__InventoryFeed__c invfeed = [Select Id, dealer__FeedName__c 
												from dealer__InventoryFeed__c 
												where Id =:s[0] limit 1];
		invFeed.dealer__FeedName__c=s[1];
		update invFeed;
		return true;
	}

	public class InventoryFeedException extends Exception {}

}