public with sharing class ServiceVehicle_EXT {

    public Service_Vehicle__c sv;

    @TestVisible transient VINDecoderDataObject.DecodeData ddat;
    @TestVisible transient VINDEcoderDataObject.Style sdat;
    public List < VINDecoderDataObject.Style > ModelKeyList = new List < VINDecoderDataObject.Style > ();
    public List < VinDecoderAPI.OptionalEquipment > OptEquip = new List < VinDecoderAPI.OptionalEquipment > ();
    public List < VinDecoderAPI.InstalledEquipment > InstalledEquipment = new List < VinDecoderAPI.InstalledEquipment > ();

    public String SelectedStyleId;

    public List < SelectOption > engineSelect = new List < SelectOption > ();
    public String selectedEngine {
        get;
        set;
    }
    public List < SelectOption > transmissionSelect = new List < SelectOption > ();
    public String selectedTransmission {
        get;
        set;
    }
    public String svId;
    public String suId;
    public VINDecoder vd = new VINDecoder();

    public ServiceVehicle_EXT(ApexPages.standardController controller) {
        sv = new Service_Vehicle__c();
        this.sv = (Service_Vehicle__c) controller.getRecord();
        String svId = Apexpages.currentPage().getParameters().get('id');

        if (svId != null && svId != '') {
            this.sv.id = svid;
            service_Vehicle__c serVeh = [select VIN__c from service_Vehicle__c where id =: svId];
            sv.VIN__c = serVeh.VIN__c;
            doDecode(sv.VIN__c);
            //This is for redictecting VINDecodeServiceVehicleStyleSelect when VIN tradin button click on salesup
            String currentPageURL = Apexpages.currentPage().getURL();
            String currentPage = currentPageURL.split('/apex')[1];
            if (currentPage == 'VINDecodeServiceVehicleStyleSelect') {
                doDecode(sv.VIN__c);
            }

        }
        if (ApexPages.currentPage().getParameters().get('owner') != null) {
            sv.Veh_Owner_Contact__c = ID.valueOf(ApexPages.currentPage().getParameters().get('owner'));
        }

        if (ApexPages.currentPage().getParameters().get('suid') != null) {
            suId = ID.valueOf(ApexPages.currentPage().getParameters().get('suid'));
        }

    }

    public void doDecode(String VIN) {
        vd.DecodeVIN(VIN);
        ddat = vd.decodeData;
        ModelKeyList = ddat.styles;

        //Get year/make/model for VINDecodeServiceVehicleStyleSelect page
        if (ddat != null && ddat.common_data != null) {
            sv.Year__c = ddat.common_data.year;
            sv.Make__c = ddat.common_data.make;
            sv.CarLine__c = ddat.common_data.model;
            sv.Body_Type__c = ddat.common_data.body_type;
            this.sv.Name = sv.Year__c + ' ' + sv.Make__c + ' ' + sv.Carline__c;
        }
    }

    public PageReference doDecodePage() {
        if (this.sv.VIN__c == null) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'VIN must be present'));
            return null;
        }
        doDecode(this.sv.VIN__c);
        return Page.VINDecodeServiceVehicleStyleSelect;
    }

    public PageReference vinNotPresent() {
        this.sv.VIN_Not_Present__c = true;
        return Page.ServiceVehicleNewAdd;
    }

    public PageReference editPage() {
        Sales_Up__c sup;
        if (!dealer.Utility.isBlank(suId)) {
            sup = [SELECT Id, Name, Trade_Year__c, Trade_Make__c, Trade_Model__c, Trade_Trim_Level__c, Trade_Mileage__c FROM Sales_Up__c WHERE Id =: suId LIMIT 1];
        }
        if (SelectedStyleId != null) {
            ddat = vd.decodeData;
            sdat = vd.SelectedStyle(SelectedStyleId);
        }

        // Determine if Vehicle exists or if this is a new record
        Service_Vehicle__c[] ev = [Select d.Year__c, d.Warranty_Exp_Miles__c, d.Warranty_Exp_Date__c, d.Vehicle_Type__c,
            d.Vehicle_Description__c, d.Veh_Owner__c, d.Veh_Owner_Contact__c, d.VIN__c,
            d.Trim_Level__c, d.Transmission_Type__c, d.Stock_Number__c, d.Sales_Inventory__c,
            d.Recommendations__c, d.Package_Code__c, d.Make__c, d.Make_Code__c, d.Licence__c,
            d.Last_Service__c, d.Last_Odometer__c, d.Last_Activity__c, d.Last_6__c, d.Key_2__c,
            d.Key_1__c, d.Int_Color__c, d.In_Service_Date__c, d.Ext_Color__c,
            d.Equipment_Number__c, d.Engine_ID__c, d.Engine_Displacement__c, d.Engine_Description__c,
            d.Drive_Type__c, d.Company_Number__c, d.Comments__c, d.Carline__c, d.Body_Style_Id__c,
            d.SystemModstamp, d.OwnerId, d.Name, d.LastModifiedDate, d.LastModifiedById, d.LastActivityDate, d.IsDeleted, d.Id,
            d.CreatedDate, d.CreatedById
            From Service_Vehicle__c d
            Where Id =: this.sv.Id limit 1
        ];

        if (ev.size() > 0) {
            sv.Name = ev[0].Name;
        }
        if (ddat != null && ddat.common_data != null) {
            sv.Year__c = ddat.common_data.year;
            sv.Make__c = ddat.common_data.make;
            sv.CarLine__c = ddat.common_data.model;
            sv.Body_Type__c = ddat.common_data.body_type;
            this.sv.Name = sv.Year__c + ' ' + sv.Make__c + ' ' + sv.Carline__c;
        } else if (ddat != null && ddat.styles.size() > 0 && ddat.styles[0].vehicle_id != null && ddat.styles[0].basic_data != null) {
            sv.Year__c = ddat.styles[0].basic_data.year;
            sv.Make__c = ddat.styles[0].basic_data.make;
            sv.Carline__c = ddat.styles[0].basic_data.model;
            this.sv.Name = sv.Year__c + ' ' + sv.Make__c + ' ' + sv.Carline__c;
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to decode VIN, ' + vd.decodeError));
            system.debug('Unable to decode VIN ' + vd.decodeError);
            return null;
        }

        if (sup != null) {
            sv.Last_Odometer__c = sup.Trade_Mileage__c;
        }

        if (sdat != null) {
            if (sdat.basic_data != null) {
                sv.Trim_Level__c = sdat.basic_data.trim;
                sv.Model_Code__c = String.valueOf(sdat.basic_data.model_number);
                sv.Doors__c = Decimal.valueOf(sdat.basic_data.doors);
                sv.Drive_Type__c = sdat.basic_data.drive_type;

                if (!Utility.isBlank(sdat.basic_data.body_subtype)) {
                    sv.Body_Style__c = sdat.basic_data.body_subtype;
                } else if (ddat != null) {
                    sv.Body_Style__c = ddat.common_data.body_type;
                }
            }
        }

        if (sdat.engines != null && sdat.engines.size() > 0) {
            sv.Engine_Description__c = sdat.engines[0].name;
            sv.Engine_Displacement__c = Decimal.valueOf(sdat.engines[0].displacement);
            sv.Engine_Id__c = sdat.engines[0].engine_id;
            for (VINDecoderDataObject.Engine engine: sdat.engines) {
                engineSelect.add(new SelectOption(engine.engine_id, engine.name));
            }
        }

        //check list size before accessing 0th record
        if (sdat.transmissions != null && sdat.transmissions.size() > 0) {
            //populate transmission related fields 
            sv.Transmission_Type__c = sdat.transmissions[0].name + ' (' + sdat.transmissions[0].type + ')';
            for (VINDecoderDataObject.Transmission transmission: sdat.transmissions) {
                transmissionSelect.add(new SelectOption(transmission.transmission_id, transmission.name));
            }
        }

        // Get Optional Equipment
        if (sdat.optional_equipment != null) {
            for (VINDecoderDataObject.OptionalEquipment oe: sdat.optional_equipment) {
                // Get List of OptionalEquipment in this Category
                List < VINDecoderDataObject.OptionalEquipmentDetails > opEdList = oe.options;
                for (VINDecoderDataObject.OptionalEquipmentDetails opEd: opEdList) {
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
        return Page.ServiceVehicleNewAdd;
    }

    public PageReference Save() {
        // Override the save class to ensure that the duplicate vehicles are matched with 
        Service_Vehicle__c[] vehicle_match = [SELECT Id, Veh_Owner__c, Veh_Owner_Contact__c,
            Veh_Owner__r.Name, VIN__c FROM Service_Vehicle__c
            where VIN__c =: sv.VIN__c
            AND Make__c != 'test'
            AND Year__c != null
            AND Carline__c != null limit 1
        ];
        try {
            upsert sv;
        } catch (DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return null;
        }
        if (sv.VIN_Not_Present__c == false && vd.decodeError == '') {
            update sv;
            VinDecoderAPI.storeDecodeData(sv.Id, null, JSON.serialize(InstalledEquipment), JSON.serialize(OptEquip));
        }

        // Return to sales up if the service vehicle was created from a sales up. - DR -10/11/2015
        if (!dealer.Utility.isBlank(suId)) {
            //Update Sales Up before forwarding
            Sales_Up__c sup = new Sales_Up__c();
            sup = [SELECT Id, Name, Trade_Year__c, Trade_Make__c, Trade_Model__c, Trade_Trim_Level__c, Trade_Mileage__c FROM Sales_Up__c WHERE Id =: suId LIMIT 1];

            sup.Trade_Year__c = sv.Year__c;
            sup.Trade_Make__c = sv.Make__c;
            sup.Trade_Model__c = sv.Carline__c;
            sup.Trade_Trim_Level__c = sv.Trim_Level__c;

            update sup;

            PageReference pageRef = new PageReference('/' + suId);
            return pageRef;
        } else {
            return new ApexPages.standardController(sv).view();
        }
    }

    public pageReference redirectToBack() {
        if (!dealer.Utility.isBlank(suId)) {
            PageReference pageRef = new PageReference('/' + suId);
            return pageRef;
        } else {
            return new ApexPages.standardController(sv).view();

        }
    }

    public List < Service_Vehicle_Equipment__c > getsvEquip() {
        List < Service_Vehicle_Equipment__c > svEquip = new List < Service_Vehicle_Equipment__c > ();
        svEquip = [Select Id, Name, service_Vehicle__c From Service_Vehicle_Equipment__c Where service_Vehicle__c =: sv.Id];
        return svEquip;
    }

    public PageReference updateVehicle() {
        try {
            upsert sv;
        } catch (DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return null;
        }

        List < Service_Vehicle_Equipment__c > svEquip = new List < Service_Vehicle_Equipment__c > ();
        svEquip = [Select Id, Name, service_Vehicle__c From Service_Vehicle_Equipment__c Where service_Vehicle__c =: sv.Id];

        try {
            delete svEquip;
        } catch (DmlException e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getMessage()));
            return null;
        }

        if (sv.VIN_Not_Present__c == false && vd.decodeError == '') {

            update sv;
            VinDecoderAPI.storeDecodeData(sv.Id, null, JSON.serialize(InstalledEquipment), JSON.serialize(OptEquip));
        }

        // Return to sales up if the service vehicle was created from a sales up. - DR -10/11/2015
        if (!dealer.Utility.isBlank(suId)) {
            PageReference pageRef = new PageReference('/' + suId);
            return pageRef;
        } else {
            return new ApexPages.standardController(sv).view();
        }
    }

    public List < VINDEcoderDataObject.Style > getModelKeyList() {
        return ModelKeyList;
    }

    public VINDecoderDataObject.DecodeData getDecode() {
        return ddat;
    }

    public String getSelectedStyleId() {
        return SelectedStyleId;
    }

    public void setSelectedStyleId(String SelectedStyleId) {
        this.SelectedStyleId = SelectedStyleId;
    }

    public List < SelectOption > getEngineSelect() {
        return engineSelect;
    }

    public List < SelectOption > getTransmissionSelect() {
        return transmissionSelect;
    }

    public List < VinDecoderAPI.OptionalEquipment > getOptEquip() {
        return OptEquip;
    }

    public List < VinDecoderAPI.InstalledEquipment > getInstalledEquipment() {
        return InstalledEquipment;
    }

    //Deprecated 4.7+
    public class OE {
        public Boolean selected {get;set;}
        public string category { get;set;}
        public String name { get; set;}
        public String description {get;set;}
        public String installedBy {get;set;}
        public String orderCode {get;set;}
        public String optionId {get;set;}
    }
    public class IE {
        public Boolean selected {get;set;}
        public String category {get;set;}
        public String name { get;set;}
        public String description {get;set;}
    }

}