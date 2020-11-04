public with sharing class VINDecoder_EXT_Tech {
    
    public dealer__Vehicle_Inventory__c veh;
    public dealer__DMS_Settings__c dms { get; private set; }
    
    @TestVisible transient VINDecoderDataObject.DecodeData ddat;
    @TestVisible transient VINDEcoderDataObject.Style sdat;
    public List < VINDecoderDataObject.Style > ModelKeyList = new List < VINDecoderDataObject.Style > ();

    public List<SelectOption> engineSelect = new List<SelectOption>();
    public String selectedEngine { get;set; }
    public List<SelectOption> transmissionSelect = new List<SelectOption>();
    public String selectedTransmission {get;set;}
    public String SelectedStyleId;
    
    public List<VinDecoderAPI.OptionalEquipment> LstTemplateEquip = new List<VinDecoderAPI.OptionalEquipment>();
	public List<VinDecoderAPI.InstalledEquipment> InstalledEquipment = new List<VinDecoderAPI.InstalledEquipment>();
    
    public VINDecoder vd = new VINDecoder();
    public Boolean skipDecodeAction;
    public Set<String> AllEquip { get;set; }
    public map<String, List<VinDecoderAPI.OptionalEquipment>> mapTempByEquip{get; set;}
    public List<dealer__Vehicle_Equipment__c> VehEquipment = new List<dealer__Vehicle_Equipment__c>();
    public List<dealer__Custom_Equipment__c> LstObjOE =  new List<dealer__Custom_Equipment__c>();
    public Set<String> SetOptionId = new Set<String>();
        
    public VINDecoder_EXT_Tech(ApexPages.StandardController stdController) {
        try{
        skipDecodeAction = false;
        dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        this.veh = (dealer__Vehicle_Inventory__c)stdController.getRecord();
        if(this.veh.dealer__VIN__c != '' && this.veh.dealer__VIN__c != null) {
            doDecode(this.veh.dealer__VIN__c);
        }

        // Check to see if VIN Was passed as an argument
        if(ApexPages.currentPage().getParameters().get('vin')!=null) {
            this.veh.dealer__VIN__c=ApexPages.currentPage().getParameters().get('vin');
        }
        }
        catch(Exception e)
        {
        system.debug(e.getMessage());
        system.debug(e.getlineNumber());
        }
    }
    
    public void doDecode(String VIN) {
            vd.DecodeVIN(VIN);
            ddat = vd.decodeData;
            ModelKeyList = ddat.styles;
    }
    
    public PageReference doDecodePage() {

        // Perform Callout before ANY DML
        doDecode(this.veh.dealer__VIN__c);

        if(vd.decodeError!=null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to decode VIN, '+vd.decodeError));
            return null;            
        }

        // Set Record Name Basics
        veh.dealer__Year__c = ddat.common_data.year;
        veh.dealer__Make__c = ddat.common_data.make;
        veh.dealer__Model__c= ddat.common_data.model;
        this.veh.Name = veh.dealer__Year__c+' '+veh.dealer__Make__c+' '+veh.dealer__Model__c;

        // IF DMS Settings tell to set stock number, choose method and proceed.
        if(dms.dealer__Assign_Stock_Number__c==true && dms.dealer__Assign_Stock_Number_by_Sequence__c==false) {
            Map<Double, String> alphabetMap = new Map<Double, String>();
            alphabetMap.put(1, 'A');
            alphabetMap.put(2, 'B');
            alphabetMap.put(3, 'C');
            alphabetMap.put(4, 'D');
            alphabetMap.put(5, 'E');
            alphabetMap.put(6, 'F');
            alphabetMap.put(7, 'G');
            alphabetMap.put(8, 'H');
            alphabetMap.put(9, 'I');
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
                newStkNumber = vin4L+'-'+vin4R;
            }

            if(vehiclesMatched.size()>=1) {
                newStkNumber = newStkNumber+alphabetMap.get(vehiclesMatched.size());
            }                                          

            

            this.veh.dealer__Stock_Number__c = newStkNumber.toUpperCase();                                                         
        }

        if(dms.dealer__Assign_Stock_Number_by_Sequence__c==true && dms.dealer__Assign_Stock_Number__c==true) {
            dealer__DMS_Settings__c settings = [Select Id, dealer__Stock_Number_Current_Index__c 
                                                    from dealer__DMS_Settings__c
                                                    where Name = 'ActiveSettings'
                                                    limit 1
                                                    for update
                                                ];
            Decimal currentStockSequence = settings.dealer__Stock_Number_Current_Index__c;
            currentStockSequence++;
            veh.dealer__Stock_Number__c  = String.valueOf(currentStockSequence);

            settings.dealer__Stock_Number_Current_Index__c = currentStockSequence;
            update settings;
        }


        if(vd.decodeError==null) {
            return Page.VINDecodeStyleSelect_Tech;
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Unable to decode VIN, '+vd.decodeError));
            return Page.VehicleInventoryNewAdd_Tech;
        }
    }   
    
    public PageReference skipVinDecode() {
        skipDecodeAction = true;
        return Page.VehicleInventoryNewAdd_Tech;
    }
    
    public PageReference editPage() {
        // System.debug('##-## '+SelectedStyleId);
        
        // Determin Specific Selected Vehicles Optional Equipment
        
        try
        {
        if(SelectedStyleId != null) {
            sdat = vd.SelectedStyle(SelectedStyleId);
        }
        // System.debug(this.veh+ ' (SDAT) ' +sdat);
        // Determin if Vehicle exists or if this is a new record
        
        dealer__Vehicle_Inventory__c[] ev = [Select d.dealer__Vehicle_Type__c, d.dealer__Trim_Level__c, d.dealer__Style_Id__c, d.dealer__Stock_Number__c, 
                                                d.dealer__Status_Code__c, d.dealer__NUO__c, d.dealer__Model__c, d.dealer__Model_Code__c, d.dealer__License_Exp__c, 
                                                d.dealer__Last_VIN_Decode__c, d.dealer__Keyless_Entry_Code__c, d.dealer__Invoice_Price__c, d.dealer__Inventory_Date__c, 
                                                d.dealer__In_Stock__c, d.dealer__Holdback__c, d.dealer__Fuel_Type__c, d.dealer__Fuel_Tank_Capacity__c, d.dealer__Mileage__c,
                                                d.dealer__Exterior_Color__c, d.dealer__Engine_Displacement__c, d.dealer__Engine_Description__c, d.dealer__Drive_Type__c, 
                                                d.dealer__Doors__c, d.dealer__Demo_Indicator__c, d.dealer__Coded_Cost__c, d.dealer__Body_Type__c, d.dealer__Body_Style__c, 
                                                d.RecordTypeId, d.Name, d.Id, d.dealer__Location__c, 
                                                (Select dealer__Category__c ,dealer__Description__c ,dealer__Equipped__c ,dealer__Equipment_Type__c ,dealer__Installed_By__c ,
                                                dealer__Name__c ,dealer__Option_Id__c ,dealer__Order_Code__c from dealer__Vehicle_Equipment__r)  
                                                    From dealer__Vehicle_Inventory__c d
                                                    Where Id = :this.veh.Id limit 1];

        if(ev.size() > 0) {
            VehEquipment = ev[0].dealer__Vehicle_Equipment__r;
            veh.Name=ev[0].Name;
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
        
        // Set Record Name Basics
        veh.dealer__Year__c = ddat.common_data.year;
        veh.dealer__Make__c = ddat.common_data.make;
        veh.dealer__Model__c= ddat.common_data.model;
        this.veh.Name = veh.dealer__Year__c+' '+veh.dealer__Make__c+' '+veh.dealer__Model__c;

        
        if(sdat.basic_data != null) {
            veh.dealer__Trim_Level__c = sdat.basic_data.trim;
            veh.dealer__Model_Code__c = sdat.basic_data.model_number;
            veh.dealer__Doors__c = Decimal.valueOf(sdat.basic_data.doors);
            veh.dealer__Drive_Type__c = sdat.basic_data.drive_type;
            veh.dealer__Body_Style__c = sdat.basic_data.body_subtype;
        }
        
        if(sdat.engines != null) {
            for(VINDecoderDataObject.Engine engine : sdat.engines) {
                engineSelect.add(new SelectOption(engine.engine_id, engine.name));
            }
        }

        if(sdat.transmissions != null) {
            for(VINDecoderDataObject.Transmission trans : sdat.transmissions) {
                transmissionSelect.add(new SelectOption(trans.transmission_id, trans.name));
            }

        }

        // Color Data
        // tk123 uncomment
        // if(sdat.epa_fuel_efficiency != null) {
        //     // Check for the Gasoline Type of Fuel (not-ethonal)
        //     for(Integer fs = 0; fs<sdat.epa_fuel_efficiency.size(); fs++)
        //     if(sdat.epa_fuel_efficiency[fs].fuel_type=='Gasoline') {
        //         veh.dealer__City_MPG__c = Decimal.valueOf(sdat.epa_fuel_efficiency[fs].city);
        //         veh.dealer__Highway_MPG__c = Decimal.valueOf(sdat.epa_fuel_efficiency[fs].highway);  
        //     }
        // }
        
        mapTempByEquip = new map<String, List<VinDecoderAPI.OptionalEquipment>>();
        
        for(dealer__Vehicle_Equipment__c objVe : VehEquipment)
        {
            SetOptionId.add(objVe.dealer__Option_Id__c);
        }
        
        LstObjOE = [Select Category__c ,Description__c ,Equipped__c ,Equipment_Type__c ,Installed_By__c ,Name__c ,Option_Id__c ,Order_Code__c from dealer__Custom_Equipment__c];
        
        if(LstObjOE.size() >0)
        {
            for(dealer__Custom_Equipment__c opEd : LstObjOE) {
                Boolean selected = SetOptionId.contains(opEd.Option_Id__c) ? true : false;
                VinDecoderAPI.OptionalEquipment LstTemplateEquipList = new VinDecoderAPI.OptionalEquipment(
                    selected,
                    opEd.Category__c,
                    opEd.Name__c,
                    opEd.Description__C,
                    opEd.Installed_By__c,
                    opEd.Order_Code__c,
                    opEd.Option_Id__c
                );
            }   
         }
         
        // Get Installed Equipment
        if (sdat.installed_equipment != null) {
            for (VINDEcoderDataObject.InstalledEquipment ie: sdat.installed_equipment) {
                List < VINDecoderDataObject.InstalledEquipmentDetails > ieList = ie.equipment;
                for (VINDecoderDataObject.InstalledEquipmentDetails opIq: ieList) {
                    VinDecoderAPI.InstalledEquipment inEqList = new VinDecoderAPI.InstalledEquipment(
                        true,
                        ie.category,
                        opIq.name,
                        opIq.values[0]
                    );
                    this.InstalledEquipment.add(inEqList);
                }
            }
        }
        
        // System.debug('Optional Equipment ' + LstTemplateEquip);
        
        //this.EngineList = sdat.engines;
       
        }
        catch(Exception e)
        {
        system.debug(e.getMessage());
        system.debug(e.getlineNumber());
        }
        PageReference vinadd = Page.VehicleInventoryNewAdd_Tech;
        return vinadd;
    }
    
    public List<VinDecoderAPI.OptionalEquipment> getLstTemplateEquip() {
        return LstTemplateEquip;
    }
    
    public List<VinDecoderAPI.InstalledEquipment> getInstalledEquipment() {
        return InstalledEquipment;
    }
    
    public List<VINDecoderDataObject.Style> getModelKeyList() {
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

        // Updating Vehicle Inventory
        List<String> lstUpdatedVE = new List<String>();
        List<String> lstRemovedOE = new List<String>();
        
        system.debug('mapTempByEquip >>' +mapTempByEquip);
        
        for(List<VinDecoderAPI.OptionalEquipment> lstOE : mapTempByEquip.values())
        {
            for(VinDecoderAPI.OptionalEquipment tempOE : lstOE)
            {
                if(tempOE.selected == true)
                {
                    if(!SetOptionId.contains(tempOE.optionId))
                    {
                        lstUpdatedVE.add(tempOE.optionId);
                    }
                }
                else
                {
                    if(SetOptionId.contains(tempOE.optionId))
                    {
                        lstRemovedOE.add(tempOE.optionId);
                    }
                }
            }
        }
        system.debug('lstUpdatedVE >>' +lstUpdatedVE);
        system.debug('lstRemovedOE >>' +lstRemovedOE);
        
        dealer__Service_Vehicle__c[] RelatedSV = [Select id, name, dealer__Sales_Inventory__c from dealer__Service_Vehicle__c where dealer__Sales_Inventory__c =: veh.id];
        
        List<dealer__Vehicle_Equipment__c> LstDeleteVERecord = new List<dealer__Vehicle_Equipment__c>();
        List<dealer__Service_Vehicle_Equipment__c> LstDeleteSERecord = new List<dealer__Service_Vehicle_Equipment__c>();
        
        LstDeleteVERecord = [Select id from dealer__Vehicle_Equipment__c where dealer__Option_Id__c in: lstRemovedOE ];
        LstDeleteSERecord = [Select id from dealer__Service_Vehicle_Equipment__c where dealer__Option_Id__c in: lstRemovedOE ];
        delete LstDeleteVERecord;
        delete LstDeleteSERecord;
        
        List<dealer__Vehicle_Equipment__c> LstAddVERecord = new List<dealer__Vehicle_Equipment__c>();   
        List<dealer__Custom_Equipment__c> NewVETemplateRecord = [Select Category__c ,Description__c ,Equipped__c ,Equipment_Type__c ,Installed_By__c ,Name__c ,Option_Id__c ,Order_Code__c from dealer__Custom_Equipment__c where Option_Id__c IN: lstUpdatedVE];
        
        list<dealer__Service_Vehicle_Equipment__c> PresentSE = [Select dealer__Category__c ,dealer__Description__c ,dealer__Equipped__c ,dealer__Equipment_Type__c ,dealer__Installed_By__c ,
                             dealer__dealer_Name__c ,dealer__Option_Id__c ,dealer__Order_Code__c 
                             from dealer__Service_Vehicle_Equipment__c where dealer__Option_Id__c IN : lstUpdatedVE];
        
        Set<String> SetCreateNewSV = new Set<String>(lstUpdatedVE);
        
        for(dealer__Service_Vehicle_Equipment__c objSV1 : PresentSE)
        {
            SetCreateNewSV.remove(objSV1.dealer__Option_Id__c);
        }
        
        //Add equipment in Service vehicle as well
        List<dealer__Service_Vehicle_Equipment__c> LstAddSERecord = new List<dealer__Service_Vehicle_Equipment__c>();   
             
        for(dealer__Custom_Equipment__c obj : NewVETemplateRecord )
        {
            dealer__Vehicle_Equipment__c objVE = new dealer__Vehicle_Equipment__c();
            objVE.dealer__Category__c = obj.Category__c;
            objVE.dealer__Description__c = obj.Description__c;
            objVE.dealer__Equipped__c = obj.Equiped__c;
            objVE.dealer__Equipment_Type__c = obj.Equipment_Type__c;
            objVE.dealer__Installed_By__c = obj.Installed_By__c;
            objVE.dealer__Name__c = obj.Name__c;
            objVE.dealer__Option_Id__c = obj.Option_Id__c;
            objVE.dealer__Order_Code__c = obj.Order_Code__c;
            objVE.dealer__Vehicle_Inventory__c = veh.id;
            LstAddVERecord.add(objVE);
            
            if(RelatedSV != null && SetCreateNewSV.contains(obj.Option_Id__c))
            {
            dealer__Service_Vehicle_Equipment__c objSE = new dealer__Service_Vehicle_Equipment__c();
            objSE.dealer__Category__c = obj.Category__c;
            objSE.dealer__Description__c = obj.Description__c;
            objSE.dealer__Equipped__c = obj.Equiped__c;
            objSE.dealer__Equipment_Type__c = obj.Equipment_Type__c;
            objSE.dealer__Installed_By__c = obj.Installed_By__c;
            objSE.dealer__dealer_Name__c = obj.Name__c;
            objSE.dealer__Option_Id__c = obj.Option_Id__c;
            objSE.dealer__Order_Code__c = obj.Order_Code__c;
            objSE.dealer__Service_Vehicle__c = RelatedSV[0].id;
            LstAddSERecord.add(objSE);
            }
            
        }
        Insert LstAddVERecord;
        Insert LstAddSERecord;
        
        
        
        // Lookup Vehicle VIN and Stock Number to see if in stock already
        if(veh.Id == null) {
            dealer__Vehicle_Inventory__c[] inVehs = [Select Id, dealer__VIN__c, dealer__In_Stock__c, dealer__Stock_Number__c 
                                                        from dealer__Vehicle_Inventory__c 
                                                        where dealer__Stock_Number__c =:veh.dealer__Stock_Number__c
                                                        or dealer__VIN__c =: veh.dealer__VIN__c
                                                        limit 100];
            if(inVehs.size()>0) {
                // Iterate results and see that we do not have an existing match
                for(dealer__Vehicle_Inventory__c evs : inVehs) {
                    if(evs.dealer__In_Stock__c==true) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Vehicle with Stock# '+evs.dealer__Stock_Number__c+' VIN '+evs.dealer__VIN__c+' exists in inventory'));
                        return Page.VehicleInventoryNewAdd_Tech;                     
                    }
                    if(evs.dealer__Stock_Number__c==veh.dealer__Stock_Number__c) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Stock# '+evs.dealer__Stock_Number__c+' previously used, please choose another Stock#'));
                        return Page.VehicleInventoryNewAdd_Tech;                         
                    }
                    /*
                    if(evs.dealer__In_Stock__c==false && evs.dealer__VIN__c == veh.dealer__VIN__c) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'VIN '+evs.dealer__VIN__c+' has been in your inventory previously, Reference Stock# '+evs.dealer__Stock_Number__c));
                        return Page.VehicleInventoryNewAdd_Tech;                     
                    }
                    */                  
                }
            }                                       
        }


        // Create / Update the vehicle
        /*
        Schema.SObjectField vehER = dealer__Vehicle_Inventory__c.Fields.dealer__Stock_Number__c;
        Database.Upsertresult result = Database.upsert(veh, vehER);
        */
        if(veh.Id==null){
            insert veh;
        } else {
            update veh;
        }

        System.debug(vd.decodeError);

        if(skipDecodeAction==false && vd.decodeError==null) {
            // Set Engine and Transmission ID's 
            veh.dealer__Engine_Id__c = selectedEngine;
            veh.dealer__Transmission_Id__c = selectedTransmission;

            System.debug(selectedEngine+' '+selectedTransmission);


            // Get engine & transmission features
            for(VINDecoderDataObject.Engine engine : sdat.engines) {
                if(engine.engine_id == selectedEngine) {
                    veh.dealer__Engine_Displacement__c = Decimal.valueOf(engine.displacement);
                    veh.dealer__Engine_Description__c = engine.name;
                    veh.dealer__Max_HP__c = Decimal.valueOf(engine.max_hp);
                    veh.dealer__Max_HP_At__c = Decimal.valueOf(engine.max_hp_at);
                    veh.dealer__Max_Torque__c = Decimal.valueOf(engine.max_torque);
                    veh.dealer__Max_Torque_At__c = Decimal.valueOf(engine.max_torque_at);
                }
            }

            for(VINDecoderDataObject.Transmission trans : sdat.transmissions) {
                if(trans.transmission_id == selectedTransmission) {
                    veh.dealer__Transmission_Type__c =trans.name;
                    if(trans.type == 'A') { veh.dealer__Transmission_Shift_Type__c = 'Automatic'; }
                    if(trans.type == 'M') { veh.dealer__Transmission_Shift_Type__c = 'Manual'; }
                    if(trans.type == 'C') { veh.dealer__Transmission_Shift_Type__c = 'CVT'; }              
                }
            }

            if(selectedEngine != null && selectedTransmission != null){
                for(VINDecoderDataObject.FuelEfficiency epa : sdat.epa_fuel_efficiency){
                    if(epa.engine_id == selectedEngine && epa.transmission_id == selectedTransmission){
                        veh.City_MPG__c = epa.city;
                        veh.Highway_MPG__c = epa.highway;
                        veh.Fuel_Type__c = epa.fuel_type;

                    }
                }
            }
            
            
            update veh;
            
            if(LstTemplateEquip.size()>0) {
                List<dealer__Vehicle_Equipment__c> vQ = new List<dealer__Vehicle_Equipment__c>();
                
                for(VinDecoderAPI.InstalledEquipment iq : InstalledEquipment) {
                    vQ.add(new dealer__Vehicle_Equipment__c(dealer__Category__c=iq.category,
                                                            dealer__Equipped__c=iq.selected,
                                                            dealer__Name__c=iq.name,
                                                            dealer__Description__c=iq.description,
                                                            dealer__Vehicle_Inventory__c=veh.Id
                                                            ));
                }
                
                for(VinDecoderAPI.OptionalEquipment oq : LstTemplateEquip) {

                    vQ.add(new dealer__Vehicle_Equipment__c(dealer__Category__c=oq.category,
                                                            dealer__Description__c=String.valueOf(oq.description),
                                                            dealer__Equipped__c=oq.selected,
                                                            dealer__Installed_By__c=oq.installedBy,
                                                            dealer__Name__c=oq.name,
                                                            dealer__Option_Id__c=oq.optionId,
                                                            dealer__Order_Code__c=oq.orderCode,
                                                            dealer__Vehicle_Inventory__c=veh.Id
                                                            ));
                    
                } 
                
                if(vQ.size()>0) {
                    insert vQ;
                }
            }
        }
        
        PageReference vehiclePage = new ApexPages.StandardController(veh).view();
        vehiclePage.setRedirect(true);
        return vehiclePage;
    }
}