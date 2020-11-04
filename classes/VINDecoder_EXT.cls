/**
 * VINDecoder_EXT - This standard controller extension of dealer__Vehicle_Inventory__c performs the decode actions applicable when saving a vehicle record
 * 2016-04-30   |Jarrett Kuljis     |W-000178
 * Added check to Engine Max HP and related Decimal properties
 *  of the vehicle object to ensure the strings returned contain numberic values (engine.displacement.isNumeric())
 * NULL checked for sdat.engines and sdat.transmissions before looping over results
 * Added try/catch blocks on insertion or update of data
 * --
 */

public with sharing class VINDecoder_EXT {

    public dealer__Vehicle_Inventory__c veh{get;set;}
    public boolean IsStockBook {get;set;}
    public dealer__DMS_Settings__c dms { get; private set; }

    @TestVisible transient VINDecoderDataObject.DecodeData ddat;
    @TestVisible transient VINDEcoderDataObject.Style sdat;
    public List<VINDecoderDataObject.Style> ModelKeyList = new List<VINDecoderDataObject.Style>();

    public List<SelectOption> engineSelect = new List<SelectOption>();
    public String selectedEngine { get;set; }
    public List<SelectOption> transmissionSelect = new List<SelectOption>();
    public String selectedTransmission {get;set;}
    //public List<VINDecoder_DataOneSoftware.EngineList> EngineList;
    public String SelectedStyleId {get;set;}
    public Map<String, Object> vinDecodeData;
    public List<VinDecoderAPI.OptionalEquipment> OptEquip = new List<VinDecoderAPI.OptionalEquipment>();
    public List<VinDecoderAPI.InstalledEquipment> InstalledEquipment = new List<VinDecoderAPI.InstalledEquipment>();
    @TestVisible transient VINDecoder vd;
    public Boolean skipDecodeAction;
    public List<VehicleInventoryAPI.StockNumberBookEntry> objStockWrapperList{get;set;}
    public Boolean renderModalSection{get;set;}
    public Boolean renderModalSectionOne{get;set;}
    public Boolean isEdit {get;set;}

    public VINDecoder_EXT(ApexPages.StandardController stdController) {

        isEdit=false;
        renderModalSection = false;
        renderModalSectionOne = true;
        IsStockBook = false;
        objStockWrapperList = new List<VehicleInventoryAPI.StockNumberBookEntry>();
        skipDecodeAction = false;
        dms = dealer__DMS_Settings__c.getValues('ActiveSettings');

        // Get all fields
        Map<String, Schema.SObjectField> M = Schema.SObjectType.dealer__Vehicle_Inventory__c.fields.getMap();
        List<String> af = new List<String>();
        Set<String> fieldnames = M.keySet();
        af.addAll(fieldnames);
        if(!Test.isRunningTest()) {
            stdController.addFields(af);
        }

        this.veh = (dealer__Vehicle_Inventory__c)stdController.getRecord();

        if(veh.dealer__Store_Location__c==null) {
            veh.dealer__Store_Location__c=Utility.lookupUserLocation();
        }

        // Check to see if VIN Was passed as an argument
        if(ApexPages.currentPage().getParameters().get('vin')!=null){
            this.veh.dealer__VIN__c = ApexPages.currentPage().getParameters().get('vin');
        }

        doInit();

        if(dms != null && dms.dealer__Assign_Stock_Number__c == true && dms.dealer__Assign_Stock_Number_By_Stock_Book__c == true) {        

            String RTName = '';    

            User currUser = [Select id, name, Division from user where id =: Userinfo.getUserId()];
            List<dealer__Dealer_Location__c> locationList;

            if(currUser.Division != '' || currUser.Division != null){
                locationList = new List<dealer__Dealer_Location__c>([Select id, dealer__Company_Number__c 
                    from dealer__Dealer_Location__c 
                    where dealer__Company_Number__c =: currUser.Division]);
            }


            if(locationList.size()>0){                
                objStockWrapperList = VehicleInventoryAPI.getStockByStockBook(RTName, locationList[0]);  
            }

            IsStockBook = true; 

            if(objStockWrapperList.size() > 0){
                List<dealer__Vehicle_Inventory__c> vehid = [SELECT Id, Name,dealer__Stock_Number__c FROM 
                dealer__Vehicle_Inventory__c ORDER By CreatedDate DESC LIMIT 1];

                if(vehid.size() > 0){
                    String name = vehid[0].dealer__Stock_Number__c;

                    List<dealer__Stock_Number_Book__c> lastUsedStock = [SELECT Id, Name, dealer__Sequence__c 
                    FROM dealer__Stock_Number_Book__c 
                    WHERE Name =:  name ORDER By Name DESC LIMIT 1];
                    if(lastUsedStock.size()>0){
                        Decimal sequence = lastUsedStock[0].dealer__Sequence__c;
                        sequence++;
                        List<dealer__Stock_Number_Book__c> suggestedStock = [SELECT Id, Name, dealer__Sequence__c 
                        FROM dealer__Stock_Number_Book__c 
                        WHERE dealer__Sequence__c  =:  sequence ORDER By Name DESC LIMIT 1];

                        if(suggestedStock.size() > 0){
                            veh.dealer__Stock_Number__c = suggestedStock[0].Name;         

                        }
                    }
                }
                renderModalSection = true;
                renderModalSectionOne = false;
            }    
        }

        /*W-000736 End*/
    }

    public void deriveStockNumber() {

        if( veh.dealer__VIN__c != null
            && dms.dealer__Assign_Stock_Number__c==true 
            && dms.dealer__Assign_Stock_Number_by_Sequence__c==false 
            && dms.dealer__Assign_Stock_Number_By_Stock_Book__c == false 
            && dms.AssignStockNumberByDate__c == false
            && dms.dealer__Assign_Stock_Number_by_Custom_Field__c==null) {
                veh.dealer__Stock_Number__c = VehicleInventoryAPI.getStockByLastOfVIN(veh, dms);
                return;
        }

        if(dms.dealer__Assign_Stock_Number__c==true && dms.dealer__Assign_Stock_Number_by_Sequence__c==true && dms.dealer__Assign_Stock_Number_By_Stock_Book__c ==false) {

            try {
                veh.dealer__Stock_Number__c  = VehicleInventoryAPI.getStockBySequence();
            } Catch(DmlException e) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to assign next stock#, '+vd.decodeError));
                return;
            }
            return;
        }
        if(dms.AssignStockNumberByDate__c==true && dms.dealer__Assign_Stock_Number__c==true) {
            // dealer__DMS_Settings__c settings = [Select Id, dealer__Stock_Number_Current_Index__c 
            //                                         from dealer__DMS_Settings__c
            //                                         where Name = 'ActiveSettings'
            //                                         limit 1
            //                                         for update
            //                                     ];
            veh.Stock_Number__c = VehicleInventoryAPI.getStockNumberByDate(veh, dms);
        }

        if(dms.dealer__Assign_Stock_Number_by_Custom_Field__c!=null) {
            Map<String, Object> sbMap = new Map<String, Object>();
            sbMap =  VehicleInventoryAPI.getStockByCustomField(veh, dms);
            veh.dealer__Stock_Number__c = String.valueOf(sbMap.get(dms.dealer__Assign_Stock_Number_by_Custom_Field__c));
        }

        if(dms.dealer__Assign_Stock_Number__c==true && veh != null && veh.dealer__Vehicle_Order_Number__c != null && dms.AssignStockNumberByDate__c != true) {
            // Defaults to 6 digits
            veh.dealer__Stock_Number__c = VehicleInventoryAPI.getStockByLastOfVON(veh,dms);
        }

    }
    public void doInit() {
        if( ModelKeyList == null || ModelKeyList.size() != 1 || ModelKeyList.size() == 1 && ModelKeyList[0].basic_data == null ) {
            ddat = new VINDecoderDataObject.DecodeData();
            vinDecodeData = new Map<String, Object>();
            vd = new VINDecoder();
            sdat = new VINDEcoderDataObject.Style();
            ModelKeyList = new List<VINDecoderDataObject.Style>();
            if (this.veh.dealer__VIN__c != '' && this.veh.dealer__VIN__c != null) {
                doDecode(this.veh.dealer__VIN__c);  // The StyleSElect (Edit->VIN Decode) requires this.
            } else if (ApexPages.currentPage().getParameters().get('vin') != null) {
                this.veh.dealer__VIN__c = ApexPages.currentPage().getParameters().get('vin');
                doDecode(this.veh.dealer__VIN__c);
            }
        }
    }

    public void doDecode(String VIN) {
        try {
            vd.DecodeVIN(VIN);
        } Catch(Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to decode VIN, '+vd.decodeError+' '+e.getMessage()));
        }
        ddat = vd.decodeData;
        ModelKeyList = ddat.styles;
    }

    public PageReference doDecodePage() {

        // VIN/VON Required Validation
        if(this.veh.dealer__VIN__c == null ) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'VIN: You must enter a value to decode a VIN'));
            return Page.VehicleInventoryNew;
        }

        // Perform Callout before ANY DML
        ModelKeyList = null;
        doInit();
        SavePoint sp = Database.setSavePoint();

        if(!String.isBlank(vd.decodeError)) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to decode VIN, Error: `'+vd.decodeError+'`'));
            Database.rollback(sp);
            return null;
        }

        if(ddat==null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to decode VIN, Error: Common Data does not exist for this VIN'));
            Database.rollback(sp);
            return null;
        }

        // If this VIN did not decode, give error
        if(ddat.transaction_id==null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to decode VIN, No Transaction ID was returned.  Transaction ID is empty.'));
            Database.rollback(sp);
            return null;
        }

        if(ddat.common_data!=null) {
            veh.dealer__Year__c = ddat.common_data.year;
            veh.dealer__Make__c = string.valueOf(ddat.common_data.make);
            veh.dealer__Model__c= string.valueOf(ddat.common_data.model);
            veh.Name = veh.dealer__Year__c+' '+veh.dealer__Make__c+' '+veh.dealer__Model__c;
        }

        else if(ddat.common_data!=null && ddat.styles.size()>0 && ddat.styles[0] != null && ddat.styles[0].basic_data != null){

            veh.dealer__Year__c = ddat.styles[0].basic_data.year;
            veh.dealer__Make__c = ddat.styles[0].basic_data.make;
            veh.dealer__Model__c = ddat.styles[0].basic_data.model;
            veh.Name = veh.dealer__Year__c+' '+veh.dealer__Make__c+' '+veh.dealer__Model__c;
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to decode VIN, '+vd.decodeError));
            Database.rollback(sp);
            return null;
        }

        // Now that we have a valid vehicle let's get a stock#
        deriveStockNumber();

        if(String.isBlank(vd.decodeError) && ModelKeyList.size()>1) {
            System.debug('No Error, forward VINDecodeStyleSelect');
            return Page.VINDecodeStyleSelect;
        } else if(ModelKeyList.size()==1) {
            sdat=ModelKeyList[0];
            SelectedStyleId=ModelKeyList[0].vehicle_id;
            editPage();
            return Page.VehicleInventoryNewAdd;
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Unable to decode VIN, '+vd.decodeError));
            return Page.VehicleInventoryNewAdd;
        }
    }

    public PageReference skipVinDecode() {
        if(this.veh.dealer__VIN__c == null &&  this.veh.dealer__Vehicle_Order_Number__c == null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'You must enter a value for VIN or Vehicle Order Number.'));
            return Page.VehicleInventoryNew;
        }
        skipDecodeAction = true;
        deriveStockNumber();
        return Page.VehicleInventoryNewAdd;
    }

    public PageReference editPage() {

        if(isEdit){
            ddat = new VINDecoderDataObject.DecodeData();
            vinDecodeData = new Map<String, Object>();
            vd = new VINDecoder();
            sdat = new VINDEcoderDataObject.Style();
            ModelKeyList = new List<VINDecoderDataObject.Style>();


            if (this.veh.dealer__VIN__c != '' && this.veh.dealer__VIN__c != null) {
                doDecode(this.veh.dealer__VIN__c);  
            } else if (ApexPages.currentPage().getParameters().get('vin') != null) {
                this.veh.dealer__VIN__c = ApexPages.currentPage().getParameters().get('vin');
                doDecode(this.veh.dealer__VIN__c);
            }
        }

        if(SelectedStyleId != null) {
            sdat = vd.SelectedStyle(SelectedStyleId);
        } 

        dealer__Vehicle_Inventory__c[] ev = [Select d.dealer__Vehicle_Type__c, d.dealer__Trim_Level__c, d.dealer__Style_Id__c, d.dealer__Stock_Number__c,
        d.dealer__Status_Code__c, d.dealer__NUO__c, d.dealer__Model__c, d.dealer__Model_Code__c, d.dealer__License_Exp__c,
        d.dealer__Last_VIN_Decode__c, d.dealer__Keyless_Entry_Code__c, d.dealer__Invoice_Price__c, d.dealer__Inventory_Date__c,
        d.dealer__In_Stock__c, d.dealer__Holdback__c, d.dealer__Fuel_Type__c, d.dealer__Fuel_Tank_Capacity__c, d.dealer__Mileage__c,
        d.dealer__Exterior_Color__c, d.dealer__Engine_Displacement__c, d.dealer__Engine_Description__c, d.dealer__Drive_Type__c,
        d.dealer__Doors__c, d.dealer__Demo_Indicator__c, d.dealer__Coded_Cost__c, d.dealer__Body_Type__c, d.dealer__Body_Style__c, dealer__Store_Location__c,
        d.RecordTypeId, d.Name, d.Id, d.dealer__Location__c,dealer__Year__c,dealer__Make__c
        From dealer__Vehicle_Inventory__c d
        Where Id = :this.veh.Id limit 1];
        
        veh.dealer__Last_VIN_Decode__c = Date.Today();

        if(ev.size() > 0) {
            veh.Name=ev[0].Name;
            veh.dealer__Year__c=ev[0].dealer__Year__c;
            veh.dealer__Make__c=ev[0].dealer__Make__c;
            veh.dealer__Model__c=ev[0].dealer__Model__c;
            veh.dealer__Stock_Number__c=ev[0].dealer__Stock_Number__c;
            veh.dealer__Mileage__c=ev[0].dealer__Mileage__c;
            veh.dealer__Status_Code__c=ev[0].dealer__Status_Code__c;
            veh.dealer__Inventory_Date__c=ev[0].dealer__Inventory_Date__c;
            if(veh.dealer__Purchase_Date__c==null) {
                veh.Purchase_Date__c=ev[0].dealer__Inventory_Date__c;
            }
            veh.dealer__Location__c=ev[0].dealer__Location__c;
            veh.dealer__In_Stock__c=ev[0].dealer__In_Stock__c;
        } else {
            veh.dealer__In_Stock__c=true;
            veh.dealer__Inventory_Date__c=Date.Today();
            veh.dealer__Purchase_Date__c=Date.Today();
        }
        
        if(ddat.styles.size() > 0 && ddat.styles[0].vehicle_id!=null){        
            veh.dealer__VIN_Decode_Id__c = ddat.styles[0].vehicle_id;
        }

        if(ddat.common_data != null ){
            veh.dealer__Year__c = ddat.common_data.year;
            veh.dealer__Make__c = ddat.common_data.make;
            veh.dealer__Model__c= ddat.common_data.model;
            veh.dealer__Body_Type__c = ddat.common_data.body_type;
        }
        if(sdat.basic_data != null) {
            veh.dealer__Trim_Level__c = sdat.basic_data.trim;
            veh.dealer__Model_Code__c = sdat.basic_data.model_number;
            veh.dealer__Doors__c = Decimal.valueOf(sdat.basic_data.doors);
            veh.dealer__Drive_Type__c = sdat.basic_data.drive_type;
            veh.dealer__Body_Style__c = sdat.basic_data.body_subtype;
        }
        
        if(sdat.engines != null && sdat.engines.size()>0) {

            veh.dealer__Engine_Description__c = sdat.engines[0].name;
            veh.dealer__Engine_Displacement__c= Decimal.valueOf(sdat.engines[0].displacement);
            veh.dealer__Engine_Id__c          = sdat.engines[0].engine_id;

            for(VINDecoderDataObject.Engine engine : sdat.engines) {
                engineSelect.add(new SelectOption(engine.engine_id, engine.name));
            }
        }

        if(sdat.transmissions != null && sdat.transmissions.size()>0) {
            //Begin W-002071 fixed bug that appended NULL to transmissions with no types j0sh C.
            veh.dealer__Transmission_Type__c = '';
            veh.dealer__Transmission_Id__c='';

            if(sdat.transmissions[0].type != null){
                veh.dealer__Transmission_Type__c = sdat.transmissions[0].name +' ('+sdat.transmissions[0].type+')';
                veh.dealer__Transmission_Id__c   = sdat.transmissions[0].transmission_id;

            } else {
                veh.dealer__Transmission_Type__c = sdat.transmissions[0].name;
                veh.dealer__Transmission_Id__c   = sdat.transmissions[0].transmission_id;
            }
            // End W-002071
            for(VINDecoderDataObject.Transmission transmission : sdat.transmissions) {
                transmissionSelect.add(new SelectOption(transmission.transmission_id, transmission.name));
            }

        }

        if(sdat.epa_fuel_efficiency != null && sdat.epa_fuel_efficiency.size() > 0 && veh.Engine_Id__c != null && veh.Transmission_Id__c != null){
            for(VINDecoderDataObject.FuelEfficiency epa : sdat.epa_fuel_efficiency){
                    if(epa.engine_id == veh.Engine_Id__c && epa.transmission_id == veh.Transmission_Id__c){
                        veh.City_MPG__c = epa.city;
                        veh.Highway_MPG__c = epa.highway;
                        veh.CombinedMPG__c = epa.combined;
                        veh.Fuel_Type__c = epa.fuel_type;
                    }
                }
        }

        // Color Data

        //tk123 need to uncomment
        // if(sdat.epa_fuel_efficiency != null) {
        //     // Check for the Gasoline Type of Fuel (not-ethonal)
        //     for(Integer fs = 0; fs<sdat.epa_fuel_efficiency.size(); fs++)
        //         if(sdat.epa_fuel_efficiency[fs].fuel_type=='Gasoline') {
        //             veh.dealer__City_MPG__c = Decimal.valueOf(sdat.epa_fuel_efficiency[fs].city);
        //             veh.dealer__Highway_MPG__c = Decimal.valueOf(sdat.epa_fuel_efficiency[fs].highway);
        //         }
        // }

        // Get Optional Equipment
        if(sdat.optional_equipment!=null) {
            for(VINDecoderDataObject.OptionalEquipment oe : sdat.optional_equipment) {
                // Get List of OptionalEquipment in this Category
                List<VINDecoderDataObject.OptionalEquipmentDetails> opEdList = oe.options;
                for(VINDecoderDataObject.OptionalEquipmentDetails opEd : opEdList) {
                    VinDecoderAPI.OptionalEquipment optEquipList = new VinDecoderAPI.OptionalEquipment(
                        false,
                        oe.category,
                        opEd.name,
                        opEd.description,
                        opEd.install_type,
                        opEd.order_code,
                        opEd.option_id
                        );
                    this.OptEquip.add(optEquipList); //tk222
                }
            }
        }

        // Get Installed Equipment ->eqList
        if(sdat.installed_equipment!=null) {
            for(VINDEcoderDataObject.InstalledEquipment ie : sdat.installed_equipment) {
                List<VINDecoderDataObject.InstalledEquipmentDetails> ieList = ie.equipment;
                for(VINDecoderDataObject.InstalledEquipmentDetails opIq : ieList) {
                    VinDecoderAPI.InstalledEquipment inEqList=new VinDecoderAPI.InstalledEquipment(
                        true,
                        ie.category,
                        opIq.name,
                        opIq.values[0]
                        );
                    this.InstalledEquipment.add(inEqList);
                }
            }
        }

        //W-000548 begin
        ModelKeyList = new List<VINDecoderDataObject.Style>();
        ddat = new VINDecoderDataObject.DecodeData();
        vd = new VINDecoder();
        //W-000548

        PageReference vinadd = Page.VehicleInventoryNewAdd;
        return vinadd;
    }

    public List<VinDecoderAPI.OptionalEquipment> getOptEquip() {
        return OptEquip;
    }

    public List<VinDecoderAPI.InstalledEquipment> getInstalledEquipment() {
        return InstalledEquipment;
    }

    public List<VINDEcoderDataObject.Style> getModelKeyList() {
        return ModelKeyList;
    }

    public VINDecoderDataObject.DecodeData getDecode() {
        return ddat;
    }

    public List<VINDecoderDataObject.Engine> getEngines() {
        return sdat.engines;
    }

    public List<SelectOption> getEngineSelect() {
        return engineSelect;
    }

    public List<VINDecoderDataObject.Transmission> getTransmissions() {
        return sdat.transmissions;
    }

    public List<SelectOption> getTransmissionSelect() {
        return transmissionSelect;
    }

    public String getSelectedStyleId() {
        return SelectedStyleId;
    }

    public void setSelectedStyleId(String SelectedStyleId) {
        this.SelectedStyleId = SelectedStyleId;
    }

    public PageReference Save() {
        doInit();
        // Lookup Vehicle VIN and Stock Number to see if in stock already
        if(veh.Id == null) {
            dealer__Vehicle_Inventory__c[] inVehs = [Select Id, dealer__VIN__c, dealer__In_Stock__c, dealer__Stock_Number__c, dealer__Store_Location__c
            from dealer__Vehicle_Inventory__c
            where dealer__Stock_Number__c =:veh.dealer__Stock_Number__c
            or dealer__VIN__c =: veh.dealer__VIN__c
            limit 100];
            if(inVehs.size()>0) {
                // Iterate results and see that we do not have an existing match
                for(dealer__Vehicle_Inventory__c evs : inVehs) {
                    if(evs.dealer__In_Stock__c==true && veh.dealer__In_Stock__c == true) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'An In-Stock Vehicle with Stock# '+evs.dealer__Stock_Number__c+' and VIN '+evs.dealer__VIN__c+' already exists in inventory.'));
                        return Page.VehicleInventoryNewAdd;
                    }
                    if(evs.dealer__Stock_Number__c==veh.dealer__Stock_Number__c) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Stock# '+evs.dealer__Stock_Number__c+' previously used, please choose another Stock#'));
                        return Page.VehicleInventoryNewAdd;
                    }
                }
            }
        }

        if(SelectedStyleId != null) {
            
            vd = new VINDecoder();
            sdat = new VINDEcoderDataObject.Style();
            doDecode(veh.VIN__c);
            sdat = vd.SelectedStyle(SelectedStyleId);
        } 
        // create/update vehicle
        if(veh.Id==null){
            try {
                insert veh;
            } Catch(DmlException e) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
                return null;
            }
        } else {
            try {
                update veh;
            } Catch(DmlException e) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
                return null;
            }
        }

        if(skipDecodeAction==false && vd.decodeError=='') {
            // Set Engine and Transmission ID's 
            veh.dealer__Engine_Id__c = selectedEngine;
            veh.dealer__Transmission_Id__c = selectedTransmission;

            // Get engine & transmission features
            if(sdat.engines!=null) {
                for(VINDecoderDataObject.Engine engine : sdat.engines) {
                    if(engine.engine_id == selectedEngine) {
                        veh.dealer__Engine_Description__c = engine.name;
                        veh.dealer__Engine_Displacement__c = (engine.displacement==null || !engine.displacement.isNumeric()) ? null : Decimal.valueOf(engine.displacement);
                        veh.dealer__Max_HP__c = (engine.max_hp==null || !engine.max_hp.isNumeric()) ? null : Decimal.valueOf(engine.max_hp);
                        veh.dealer__Max_HP_At__c = (engine.max_hp_at==null || !engine.max_hp_at.isNumeric()) ? null : Decimal.valueOf(engine.max_hp_at);
                        veh.dealer__Max_Torque__c = (engine.max_torque==null || !engine.max_torque.isNumeric()) ? null : Decimal.valueOf(engine.max_torque);
                        veh.dealer__Max_Torque_At__c = (engine.max_torque_at==null || !engine.max_torque_at.isNumeric()) ? null : Decimal.valueOf(engine.max_torque_at);
                    }
                }
            }

            if(sdat.transmissions !=null) {
                for(VINDecoderDataObject.Transmission trans : sdat.transmissions) {
                    if(trans.transmission_id == selectedTransmission) {
                        veh.dealer__Transmission_Type__c =trans.name;
                        if(trans.type == 'A') { veh.dealer__Transmission_Shift_Type__c = 'Automatic'; }
                        if(trans.type == 'M') { veh.dealer__Transmission_Shift_Type__c = 'Manual'; }
                        if(trans.type == 'C') { veh.dealer__Transmission_Shift_Type__c = 'CVT'; }
                    }
                }
            }

            if(sdat.epa_fuel_efficiency != null && selectedEngine != null && selectedTransmission != null){
                for(VINDecoderDataObject.FuelEfficiency epa : sdat.epa_fuel_efficiency){
                    if(epa.engine_id == selectedEngine && epa.transmission_id == selectedTransmission){
                        veh.City_MPG__c = epa.city;
                        veh.Highway_MPG__c = epa.highway;
                        veh.CombinedMPG__c = epa.combined;
                        veh.Fuel_Type__c = epa.fuel_type;
                    }
                }
            }

            try {
                update veh;
            } Catch(DmlException e) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, e.getMessage()));
                return null;
            }
            Service_Vehicle__c sv;
            try{
               Id svId = [SELECT Service_Vehicle__c FROM Vehicle_Inventory__c WHERE Id =:veh.Id].Service_Vehicle__c;
               sv = [SELECT Id FROM Service_Vehicle__c WHERE Id =: svId];
               VinDecoderAPI.storeDecodeData(sv.Id,veh.Id,JSON.serialize(InstalledEquipment),JSON.serialize(OptEquip));
            } catch(QueryException e){}
        }

        PageReference vehiclePage = new ApexPages.StandardController(veh).view();
        vehiclePage.setRedirect(true);
        return vehiclePage;
    }
}