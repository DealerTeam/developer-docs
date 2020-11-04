/**
 * VehicleInventoryAPI 
 *  Test Class: TestVehicleInventoryAPI
 */
public with sharing class VehicleInventoryAPI {

    public DMS_Settings__c dms { 
        get {
            DMS_Settings__c dms = new DMS_Settings__c();
            try {
                return DMS_Settings__c.getValues('ActiveSettings');
            } Catch(Exception e) {
                throw new VehicleInventoryAPIException('DMS Active Settings have not been created.  Please contact your system administrator.');
            }
        }
    }

    public List<Vehicle_Inventory__c> markSold(List<Deal__c> deals) {
        List<Vehicle_Inventory__c> vehicles = new List<Vehicle_Inventory__c>();
        Map<Id, Service_Vehicle__c> svcVehicle = new Map<Id, Service_Vehicle__c>();
        for(Deal__c d : deals) {
            System.assert(d.Vehicle__c!=null, 'Method requires deal to contain vehicle inventory record.');
            System.assert(d.Delivery_Date__c!=null && d.Deal_Date__c!=null, 'Both Delivery Date and Deal Date are required for this method.');
            vehicles.add(new Vehicle_Inventory__c(
                Id=d.Vehicle__c,
                Status_Code__c=(String.IsBlank(dms.Inventory_Status_for_Sold_Vehicle__c)) ? 'Sold' : dms.Inventory_Status_for_Sold_Vehicle__c,
                In_Stock__c=false,
                Delivery_Date__c=d.Delivery_Date__c,
                Sale_Date__c=d.Deal_Date__c,
                Deal__c = d.Id
            ));

            svcVehicle.put(d.Service_Vehicle__c,
                new Service_Vehicle__c(
                    Id=d.Service_Vehicle__c,
                    Last_Odometer__c=d.Mileage__c,
                    Veh_Owner__c=d.Buyer__c,
                    Veh_Owner_Contact__c=d.Buyer_Contact__c
                )
            );
        }

        try {
            update vehicles;
            update svcVehicle.values();
            return vehicles;
        } Catch(DmlException e) {
            throw new VehicleInventoryAPIException(e.getMessage());
        }

    }

    public List<Vehicle_Inventory__c> createInventoryFromTrades(List<Trade_In__c> tradeList) {

		Set<Id> tradeIds = new Set<Id>();
		for(Trade_In__c t : tradeList) {
			if(!tradeIds.contains(t.Id)) { tradeIds.add(t.Id); }
		}

		List<Trade_In__c> trades = [SELECT Car_Deal__c, ACV__c, Appraisal_Date__c, Appraised_By__c,  Lost_Trade__c, 
												Make__c, Model__c, NADA_Retail__c, NADA_Wholesale__c, Odometer_at_Trade_In__c, 
												Pay_Off_Amount__c, Pay_Off_Expiration_Date__c, Pay_Off_To__c, Position__c, Stock_Number__c, 
												Trade_Allowance__c, VIN__c, Year__c, Appraisal_Vehicle__c, Inventory_Vehicle__c, Net__c, 
												Pay_Off_Account_Number__c, Pay_Off_Account__c, Profit__c, Recon__c, 
                                                    Service_Vehicle__c,
                                                    Service_Vehicle__r.Ext_Color__c,
                                                    Service_Vehicle__r.Int_Color__c,
												    Trim_Level__c, CreatedDate, CreatedById, Name, Id,
													Car_Deal__r.Store_Location__c,
													Car_Deal__r.Delivery_Date__c, 
													Car_Deal__r.Deal_Date__c,
													Car_Deal__r.Buyer__c, Car_Deal__r.Buyer__r.Name,
													Car_Deal__r.Service_Vehicle__c, 
                                                    Car_Deal__r.Service_Vehicle__r.Ext_Color__c, 
                                                    Car_Deal__r.Service_Vehicle__r.Int_Color__c,
                                                    Car_Deal__r.Store_Location__r.Location_Account__c,
                                                    Car_Deal__r.Store_Location__r.Company_Number__c,
                                                    Car_Deal__r.Mileage__c
											FROM Trade_In__c
											WHERE Id IN:tradeIds];        
        
        
        // Validate fields, set vales and move forward
        List<String> error_messages = new List<String>();
        List<Vehicle_Inventory__c> vehicles = new List<Vehicle_Inventory__c>();
        List<Service_Vehicle__c> svVehicles = new List<Service_Vehicle__c>();
        for(Trade_In__c t : trades) {

            // Generate Stock Number
            String stockNumber = (String.isEmpty(t.Stock_Number__c)) ? getNextStockNumber(t.VIN__c) : t.Stock_Number__c;

            vehicles.add(new Vehicle_Inventory__c(
                    VIN__c=t.VIN__c,
                    Year__c=t.Year__c,
                    Make__c=t.Make__c,
                    Model__c=t.Model__c,
                    Stock_Number__c=stockNumber,
                    In_Stock__c=true,
                    Status_Code__c=(String.isBlank(dms.In_Stock_Default_Status__c)) ? defaultInventoryStatusValue() : dms.In_Stock_Default_Status__c,
                    Store_Location__c=t.Car_Deal__r.Store_Location__c,
                    Inventory_Date__c=t.Car_Deal__r.Delivery_Date__c,
                    Purchase_date__c=t.Car_Deal__r.Deal_Date__c,
                    Purchased_From__c=t.Car_Deal__r.Buyer__r.Name,
                    Purchase_Price__c=t.Trade_Allowance__c,
                    Vehicle_Cost__c=t.Trade_Allowance__c,
                    Mileage__c=t.Odometer_at_Trade_In__c,
                    Exterior_Color__c=t.Service_Vehicle__r.Ext_Color__c,
                    Interior_Color__c=t.Service_Vehicle__r.Int_Color__c,
                    Status_Code_Assignment_Date__c=Date.today(),
                    Service_Vehicle__c=t.Service_Vehicle__c,
                    Acquisition_Date__c=t.Car_Deal__r.Delivery_Date__c,
                    Acquisition_Method__c='Trade-In'
                )
            );

            if(t.Service_Vehicle__c != Null){
                svVehicles.add(new Service_Vehicle__c(
                    Id=t.Service_Vehicle__c,
                    Veh_Owner__c=t.Car_Deal__r.Store_Location__r.Location_Account__c,
                    Company_Number__c=t.Car_Deal__r.Store_Location__r.Company_Number__c,
                    Last_Odometer__c=t.Odometer_at_Trade_In__c
                    ));
            }
        }

        try {
            insert vehicles;
            update svVehicles;
        } Catch(DmlException e) {
            throw new VehicleInventoryAPIException('Unable to create vehicle inventory records from Trade.  DML Exception: '+e.getMessage());
        } Catch(Exception e) {
            throw new VehicleInventoryAPIException(e.getMessage());
        }

        return vehicles;
    }

    private String defaultInventoryStatusValue() {
        Schema.DescribeFieldResult F = Vehicle_Inventory__c.Status_Code__c.getDescribe();
        List <Schema.PicklistEntry> pickVals = F.getPicklistValues();        
        for (Schema.PicklistEntry pv: pickVals) {
            if (pv.isDefaultValue()) {
                return pv.getValue();
            }    
        }
        return null;
    }

    /**
    * Note: Method currently only supports sequence or VIN, future logic should include other options
    */
    public String getNextStockNumber(String vin) {
        StockNumberAssigmentMethod stkmethod = getAssignmentMethod();
        DMS_Settings__c dms = DMS_Settings__c.getValues('ActiveSettings');
        if(stkmethod == StockNumberAssigmentMethod.VIN)
            return  VehicleInventoryAPI.getStockByLastOfVIN(new Vehicle_Inventory__c(VIN__c=vin), dms);
        if(stkmethod == StockNumberAssigmentMethod.SEQUENCE)
            return  VehicleInventoryAPI.getStockBySequence();
        if(stkmethod == StockNumberAssigmentMethod.DATE_SEQ)
            return VehicleInventoryAPI.getStockNumberByDate(new Vehicle_Inventory__c(VIN__c = vin), dms);

        return null;
    }

	public static string getStockByLastOfVIN(dealer__Vehicle_Inventory__c veh,dealer__DMS_Settings__c dms) {

            Map<Double, String> alphabetMap = new Map<Double, String>();
            for(StockNumberVINSuffix__c vsufffix : StockNumberVINSuffix__c.getall().values()) {
                alphabetMap.put(vsufffix.Sequence__c, vsufffix.Name);
            }

            if(alphabetMap.isEmpty()) {
                alphabetMap.put(1, 'A');
                alphabetMap.put(2, 'B');
                alphabetMap.put(3, 'C');
                alphabetMap.put(4, 'D');
                alphabetMap.put(5, 'E');
                alphabetMap.put(6, 'F');
                alphabetMap.put(7, 'G');
                alphabetMap.put(8, 'H');
                alphabetMap.put(9, 'I');
            }

            String last6 = veh.dealer__VIN__c.right(6);
            String last8 = veh.dealer__VIN__c.right(8);
            dealer__Vehicle_Inventory__c[] vehiclesMatched = [Select Id from dealer__Vehicle_Inventory__c
                                                                where dealer__Last_6__c =:last6 limit 100];
                                                       
            // Split 8 by Half with hyphen and append
            if(dms.dealer__Stock_Number_Length__c==null) { dms.dealer__Stock_Number_Length__c = 8; }
            String newStkNumber = veh.dealer__VIN__c.right(Integer.valueOf(dms.dealer__Stock_Number_Length__c));

            if(dms.dealer__Stock_Number_Length__c==6) {
                newStkNumber=last6;
            }

            if(dms.dealer__Stock_Number_Length__c==8) {
                String vin4L = last8.left(4);
                String vin4R = last8.right(4);
                newStkNumber = vin4L+vin4R;
            }

            newStkNumber = newStkNumber.toUpperCase();
            if(vehiclesMatched.size()>=1) {    
                System.assert(alphabetMap.get(vehiclesMatched.size())!=null, 'The defined suffix map has fewer elements than this VIN has cycled in your inventory.  Please contact your sytsems administrator. VIN Cycle Number :'+vehiclesMatched.size());        
                newStkNumber = newStkNumber+alphabetMap.get(vehiclesMatched.size());                
            }                  
                                    
            return newStkNumber;
	}
    public static String getStockNumberByDate(Vehicle_Inventory__c veh, DMS_Settings__c dms){
        Organization orgTimeZone = [SELECT Id, TimeZoneSidKey FROM Organization];
        TimeZone tz = TimeZone.getTimeZone(orgTimeZone.TimeZoneSidKey);

        Datetime currentTime = Datetime.now();
        Integer offset = tz.getOffset(currentTime);
        Datetime orgTime = currentTime.addSeconds(offset/1000);
        String sequence = orgTime.format('YYMM');
        dms.Stock_Number_Current_Index__c = dms.Stock_Number_Current_Index__c == null ? 0 : dms.Stock_Number_Current_Index__c;
        dms.Stock_Number_Current_Index__c++;
        String indexNum = '';
        indexNum += (Integer)dms.Stock_Number_Current_Index__c;

        for(Integer i = 0; i < (4-indexNum.length()); i++){
            sequence += '0';
        }

        sequence += indexNum;

        try {
            update dms;
        } Catch(DmlException e) {
           throw new VehicleInventoryAPIException(e.getMessage());
        }

        return sequence;
    }
    /**
     * resetStockSequence creates a scheduled job to run at the start of each month to reset Stock_Number_Current_Index__c to 0
     */
    public static void resetStockSequence(){
       resetStockNumber resetIt = new resetStockNumber();
       String sched = '0 1 0 1 * ? *';
       String jobId = System.schedule('Reset Stock Number Index', sched, resetIt);
    }

	public static string getStockBySequence() {
	   DMS_Settings__c settings = [Select Id, Stock_Number_Current_Index__c 
                                                    from DMS_Settings__c
                                                    where Name = 'ActiveSettings'
                                                    limit 1
                                                    for update
                                                ];
        Decimal currentStockSequence = (settings.Stock_Number_Current_Index__c==null) ? 0 : settings.Stock_Number_Current_Index__c;
        currentStockSequence++;

        settings.Stock_Number_Current_Index__c = currentStockSequence;

        try { 
            update settings;
        } Catch(DmlException e) {
            throw new VehicleInventoryAPIException(e.getMessage());
        }

        return String.valueOf(currentStockSequence);
	}

	public static List<StockNumberBookEntry> getStockByStockBook(String RecordTypeId, dealer__Dealer_Location__c loc) {
		List<StockNumberBookEntry> objStockWrapperList = new List<StockNumberBookEntry>();
        

        
        if(loc!=null){
            for(dealer__Stock_Number_Book__c objStockNumber : [SELECT Id, Name, dealer__Active__c, 
                                                                    dealer__Location__r.Name, dealer__Vehicle_Inventory__c,
                                                                    dealer__VehicleRecordType__c,  dealer__Sequence__c,
                                                                dealer__VehicleRecordTypeId__c
                                                                FROM dealer__Stock_Number_Book__c 
                                                                WHERE dealer__Active__c = true 
                                                                AND dealer__Location__c =:loc.Id 
                                                                AND dealer__Vehicle_Inventory__c = NULL 
                                                                ORDER BY Name LIMIT 200]){
                // Issue stock book
                objStockWrapperList.add(new StockNumberBookEntry(objStockNumber));
            }
        }      

        return objStockWrapperList;
	}

    public static Map<String, Object> getStockByCustomField(dealer__Vehicle_Inventory__c veh, dealer__DMS_Settings__c dms) {

        if(dms.dealer__Assign_Stock_Number_by_Custom_Field__c==NULL) {
            throw new VehicleInventoryAPIException('Stock Number by custom formula field is being requested but no field exists in the Setting.');
        }

        SavePoint sp = Database.setSavePoint();

        try {
            veh.dealer__Stock_Number__c = String.valueOf(Math.random()).left(25);
            veh.dealer__Stock_Number__c = String.valueOf(Math.random()).left(25);
            veh.dealer__Make__c = 'make';
            veh.dealer__Model__c = 'model';
            veh.dealer__Year__c = '0000';
            if(veh.dealer__Store_Location__c == null)
            {
                veh.dealer__Store_Location__c = [SELECT Id FROM dealer__Dealer_Location__c LIMIT 1].id;
            }		
            insert veh;
        } Catch(DmlException e) {
           throw new VehicleInventoryAPIException(e.getMessage()); 
        }

        dealer__Stock_Number_Book__c newSbEntry = new dealer__Stock_Number_Book__c();
        newSbEntry.dealer__Active__c=true;
        newSbEntry.dealer__Location__c=veh.dealer__Store_Location__c;
        newSbEntry.dealer__VehicleRecordTypeId__c=veh.RecordTypeId;
        newSbEntry.dealer__Vehicle_Inventory__c=veh.Id;
        newSbEntry.dealer__Sequence__c = dms.dealer__Stock_Number_Current_Index__c++;

        try {
            insert newSbEntry;
        } Catch(DmlException e) {
            Database.rollBack(sp);
            throw new VehicleInventoryAPIException(e.getMessage());
        }

        // Get All fields.  Try block for propper error handling
        try {
        String sql = 'SELECT Id,Name,dealer__Sequence__c,'+String.escapeSingleQuotes(dms.dealer__Assign_Stock_Number_by_Custom_Field__c)+' FROM dealer__Stock_Number_Book__c WHERE Id=\''+newSbEntry.Id+'\' LIMIT 1';
        newSbEntry = Database.query(sql);
        } Catch(DmlException e) {
            throw new VehicleInventoryAPIException(e.getMessage());
        }

        Map<String, Object> sObjectMap = newSbEntry.getPopulatedFieldsAsMap();

        Database.rollBack(sp);
        
        veh.id = null;
        // Index Increase
        dealer__DMS_Settings__c dmsToUpdate = [SELECT Id, dealer__Stock_Number_Current_Index__c FROM dealer__DMS_Settings__c WHERE Name='ActiveSettings' FOR UPDATE];
        dmsToUpdate.dealer__Stock_Number_Current_Index__c++;
        try {
            update dmsToUpdate;
        } Catch(DmlException e) {
            throw new VehicleInventoryAPIException(e.getMessage());
        }

        return  sObjectMap;
    }

	public static string getStockByLastOfVON(dealer__Vehicle_Inventory__c veh,dealer__DMS_Settings__c dms) {

            // Default to 6 digit TEMP Stock Number
            if(dms.dealer__Stock_Number_Length__c==null) {
                dms.dealer__Stock_Number_Length__c=6;
            }
            
            String newStkNumber = veh.dealer__Vehicle_Order_Number__c.right(Integer.valueOf(dms.dealer__Stock_Number_Length__c));

            newStkNumber = newStkNumber.toUpperCase();              
                                    
            return newStkNumber;
	}

    /**
    *   
    */
    public static Vehicle_Inventory__c selectAllFields(Id inventoryRecordId) {
        try {
            return (Vehicle_Inventory__c)Utility.queryAllFields('dealer__Vehicle_Inventory__c', inventoryRecordId);
        } Catch(QueryException e) {
            throw new VehicleInventoryAPIException(e.getMessage());
        }
    }    

    public enum StockNumberAssigmentMethod { VIN, SEQUENCE, STOCK_BOOK, CUSTOM_FORMULA, DATE_SEQ }

    public StockNumberAssigmentMethod getAssignmentMethod() {
        try {
            DMS_Settings__c dms = DMS_Settings__c.getValues('ActiveSettings');

            if(dms.Assign_Stock_Number_by_Sequence__c==true) {
                return StockNumberAssigmentMethod.SEQUENCE;
            }

            if(dms.Assign_Stock_Number_by_Stock_Book__c==true) {
                return StockNumberAssigmentMethod.STOCK_BOOK;
            }

            if(dms.Assign_Stock_Number_by_Custom_Field__c!=null) {
                return StockNumberAssigmentMethod.CUSTOM_FORMULA;
            }  
            if(dms.AssignStockNumberByDate__c == true){
                return StockNumberAssigmentMethod.DATE_SEQ;
            }         

            if(dms.Assign_Stock_Number__c==true) {
                return StockNumberAssigmentMethod.VIN;
            }
            else{
                throw new VehicleInventoryAPIException('Stock Number Assignment must be selected in DMS Settings.');
            }


        } Catch(Exception e) {
            throw new VehicleInventoryAPIException('Unable to locate valid DMS Settings '+e.getMessage());
        }

    }
    /**
     * getActiveHolds returns a list of Vehicles with active holds
     * @param  vehicleIds vehicleIds vehicles to check for active holds
     * @return            return list of active InventoryHold__c records from the set of Ids
     */
     public static List<InventoryHold__c> getActiveHolds(Set<Id> vehicleIds){  
        List<Vehicle_Inventory__c> heldVehicles = new List<Vehicle_Inventory__c>();        
        if(vehicleIds.size() > 0){
            List<InventoryHold__c> activeHolds = [SELECT Id, Name, VehicleInventory__c, Deal__c, Deal__r.Name, ExpirationDate__c FROM InventoryHold__c WHERE Active__c = true AND VehicleInventory__c IN: vehicleIds];

            return activeHolds;     
        }
        return null;   
    }

    /**
     * selectDefaults finds if custom setting exists for a given hold type and returns values
     * @param  String holdType Hold Type to check against custom settings
     * @param  String objectType Object api name of hold to check against custom settings (Ex: Vehicle Hold would be dealer__Vehicle_Inventory__c)
     * @return InventoryHold__c returns an InventoryHold__c object with default values taken from custom setting for that type
     */
    public static InventoryHold__c selectHoldDefaults(Id holdType, String objectType){

        InventoryHoldType__c holdConfig = [SELECT Id, Name, HoldDuration__c, HoldStatus__c, ReturnToPriorStatus__c, SObjectType__c, DefaultStatus__c FROM InventoryHoldType__c WHERE Id =: holdType];
        
        InventoryHold__c hold = new InventoryHold__c();
        if(holdConfig.HoldDuration__c != null){
            hold.ExpirationDate__c = Date.today().addDays((Integer)holdConfig.HoldDuration__c);
        }
        if(holdConfig.HoldStatus__c != null){
            hold.HoldStatus__c = holdConfig.HoldStatus__c;
        }
        if(holdConfig.ReturnToPriorStatus__c != null){
            hold.ReturnToPriorStatus__c = holdConfig.ReturnToPriorStatus__c;
        }
        if(holdConfig.DefaultStatus__c != null){
            hold.DefaultStatus__c = holdConfig.DefaultStatus__c;
        }
        return hold;
    
    }

    public static Service_Vehicle__c simpleVINDecode(String VIN){
        VINDecoderDataObject.DecodeData decodeData = new VINDecoderDataObject.DecodeData();
        decodeData = (VINDecoderDataObject.DecodeData) JSON.deserialize(VinDecoderAPI.DoCallout(VIN), VinDecoderDataObject.DecodeData.class);

        Service_Vehicle__c sv = new Service_Vehicle__c();
        sv.Year__c = decodeData.common_data.year;
        sv.Make__c = decodeData.common_data.make;
        sv.Carline__c = decodeData.common_data.model;

        return sv;
    }

	/*W-000736 Begin*/    
    public class StockNumberBookEntry{
        public Boolean isSelected{get;set;}
        public String Name{get;set;}
        public String Location{get;set;}
        public String recordTypeId {get;set;}
        public String recordType {get;set;}
        public String customStockNumber {get;set;}
        public Decimal sequence {get;set;}
        
        public StockNumberBookEntry(dealer__Stock_Number_Book__c objStockNumberBook){
            this.isSelected = false;
            this.Name = objStockNumberBook.Name;
            this.Location = objStockNumberBook.dealer__Location__r.Name;
            this.recordTypeId = objStockNumberBook.dealer__VehicleRecordType__c;
            this.recordType = objStockNumberBook.dealer__VehicleRecordType__c;
            this.sequence = objStockNumberBook.dealer__Sequence__c;
        }        
    }
    /*W-000736 End*/  

	public class VehicleInventoryAPIException extends Exception{}
}