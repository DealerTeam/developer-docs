@isTest
public class TestVINDecoder {

    @testSetup static void insertTestSetup() {

        TestClassUtil tu = new TestClassUtil();
        tu.insertDMSSettings();

        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
        Profile prof = [select id from profile where name='system Administrator'];
        User usr = new User(alias = 'usr', email='us.name@vmailtest342s.com',
        emailencodingkey='UTF-8', lastname='lstname',
        timezonesidkey='America/Los_Angeles',
        languagelocalekey='en_US',
        localesidkey='en_US', profileid = prof.Id,
        username='testuser128@testorgvmailtest342s.com',
        Division='DT1');
        insert usr;   
        
		DMS_Settings__c dms = new DMS_Settings__c();
        dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        if( dms == null){
            dms.Name = 'ActiveSettings';
            dms.dealer__Service_Current_Invoice_Number__c = 30093;
            dms.dealer__Service_Job_Line_Number__c = 8;
            dms.dealer__Parts_Current_Invoice_Number__c = 50115;
            dms.dealer__Parts_Current_Quote_Number__c = 20028;
            dms.dealer__Default_Tax_Rate__c = 7.75;
            dms.dealer__Assign_Stock_Number__c = true;
            dms.dealer__Assign_Stock_Number_by_Sequence__c = true;
            dms.Stock_Number_Current_Index__c = 1;
            insert dms; 
        } else {
            dms.dealer__Assign_Stock_Number__c = true;
            dms.dealer__Assign_Stock_Number_by_Sequence__c = true;
            dms.dealer__Assign_Stock_Number_by_Stock_Book__c = true;
            dms.Stock_Number_Current_Index__c = 1;
            update dms;            
        }

        

        if(dealer__VINDecoderCS__c.getValues('ActiveSettings') == null){
            dealer__VINDecoderCS__c VINDecod = new dealer__VINDecoderCS__c();
            VINDecod.Name = 'ActiveSettings';
            VINDecod.dealer__DecoderAPI_URL__c = 'https://api.dataonesoftware.com/webservices/vindecoder/decode';
            VINDecod.dealer__DecoderClientID__c = '6310';
            VINDecod.dealer__DecoderKey__c = 'XxxxxxXXXXxxXXXXxxxxXXX';
            VINDecod.dealer__DecoderName__c = 'Data One Software';
            insert VINDecod;
        }      
    }
    
    static testmethod void TestVINDecoder_EXT() {

        User u = [Select Id from User where username = 'testuser128@testorgvmailtest342s.com' limit 1];
        System.runAs(u) {
            VinDecoderCS__c decodeSettings = VINDecoderAPI.DecodeSettings();
            boolean UBOS = decodeSettings.UseBigObjectStorage__c;
            decodeSettings.UseBigObjectStorage__c = false;
            update decodeSettings;

            dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c(
                    Name='1234',
                    dealer__VIN__c='3GNEK12Z15G244588',
                    dealer__Make__c='Chevrolet',
                    dealer__Model__c='1500',
                    dealer__Stock_Number__c='VT100',
                    dealer__Year__c='2012',
                    dealer__Engine_Id__c = '2342'
                );

            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(inv);
            VINDecoder_EXT ext = new VINDecoder_EXT(sc);

            ext.skipDecodeAction = false;
            
            //stores VinDecoder_Ext.ddat and VinDecoder_Ext.VINDecoder.decodeData
            ext.doDecode(inv.VIN__c);
            ext.getDecode();
            ext.getModelKeyList();
            ext.setSelectedStyleId('18163');
            String styleId = ext.getSelectedStyleId();
            ext.setSelectedStyleId('18163');
            
            VINDecoderDataObject.Style selectedStyle = ext.vd.SelectedStyle(styleId);
            system.assertEquals('18163',selectedStyle.vehicle_id);

            ext.doDecodePage();
            ext.isEdit = true;
            ext.editPage();
            system.assertEquals(1,ext.getEngines().size());
            system.assertEquals(1,ext.getTransmissions().size());
            system.assertEquals('208',ext.getTransmissions()[0].transmission_id);
            system.debug(ext.getEngines());
            
            ext.selectedTransmission = '208';
            ext.selectedEngine = '213330';
            Test.startTest();
            ext.save();
            ext.skipVinDecode();
            ext.getTransmissionSelect();
            Test.stopTest();
            
            system.assertEquals(22, [select id, combinedMPG__c FROM Vehicle_Inventory__c WHERE Id =: inv.id].CombinedMPG__c, 'Combined MPG was not updated.');
            //Was equipment created correctly?
            system.assert([select id,name from Vehicle_Equipment__c].size() == 14,'Vehicle Equipment was not saved to the database correctly.');
            system.assert([select id,name from Service_Vehicle_Equipment__c].size() == 14, 'Service Vehicle Equipment was not saved to database correctly.');
           
            decodeSettings.UseBigObjectStorage__c = UBOS;//back to original setting.
            update decodeSettings;
        }
    }
        
    static testmethod void testErrors() {
          User u = [Select Id from User where username = 'testuser128@testorgvmailtest342s.com' limit 1];
        System.runAs(u) {
            
            dealer__DMS_Settings__c dms = new dealer__DMS_Settings__c();
            if(dealer__DMS_Settings__c.getValues('ActiveSettings') == null){

                dms.Name = 'ActiveSettings';
                dms.dealer__Service_Current_Invoice_Number__c = 30093;
                dms.dealer__Service_Job_Line_Number__c = 8;
                dms.dealer__Parts_Current_Invoice_Number__c = 50115;
                dms.dealer__Parts_Current_Quote_Number__c = 20028;
                dms.dealer__Default_Tax_Rate__c = 7.75;
                dms.dealer__Assign_Stock_Number__c = true;
                dms.dealer__Assign_Stock_Number_by_Sequence__c = false;
                insert dms; 
            }
            else{
                dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
            }
            dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c(
                    Name='',
                    dealer__VIN__c='',
                    dealer__Make__c='Chevrolet',
                    dealer__Model__c='1500',
                    dealer__Stock_Number__c='VT100',
                    dealer__Year__c='2012'
                );
                
            VINDecoder_DataOneSoftware vinDecoder = new VINDecoder_DataOneSoftware();
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(inv);
            VINDecoder_EXT controller = new VINDecoder_EXT(sc);
            ApexPages.currentPage().getParameters().put('vin', '3GNEK12Z15G244588');
            controller.Save();
        }
    }
    
    static testmethod void vindecoderDataOneSoftwareTest(){
        VINDecoder_DataOneSoftware.DecoderMessages dm = new VINDecoder_DataOneSoftware.DecoderMessages();
        dm.service_provider = 'test';
        dm.decoder_version ='test';
        dm.decoder_errors = 'test';
        dm.decoder_error_list = new list<String>();
        
        VINDecoder_DataOneSoftware.ResponseData rd = new VINDecoder_DataOneSoftware.ResponseData();
        rd.transaction_id = null;
        rd.query_error = null;
        rd.styles = null;
        rd.common_data = null;

        VINDecoder_DataOneSoftware.QueryResponses qr = new VINDecoder_DataOneSoftware.QueryResponses();
        qr.unique_request = rd;

        VINDecoder_DataOneSoftware.QueryError qe = new VINDecoder_DataOneSoftware.QueryError();
        qe.error_code = ' test';
        qe.error_message = 'test';
                
        VINDecoder_DataOneSoftware.CommonData comd = new VINDecoder_DataOneSoftware.CommonData();
        comd.basic_data = null;
        comd.pricing = null;
        comd.engines = null;
        comd.transmissions = null;
        comd.warranties = null;
        comd.epa_fuel_efficiency = null;
        comd.optional_equipment = null;
        comd.installed_equipment = null;
        
        VINDecoder_DataOneSoftware.StyleData sd = new VINDecoder_DataOneSoftware.StyleData();
        sd.name = null;
        sd.vehicle_id = null;
        sd.complete = null;
        sd.basic_data = null;
        sd.pricing = null;
        sd.engines = null;
        sd.transmissions = null;
        sd.warranties = null;
        sd.epa_fuel_efficiency = null;
        sd.optional_equipment = null;
        sd.installed_equipment = null;
        sd.colors = null;

        VINDecoder_DataOneSoftware.BasicData basd = new VINDecoder_DataOneSoftware.BasicData();
        basd.market = null;
        basd.year = null;
        basd.make = null;
        basd.model=null;
        basd.trim=null;
        basd.vehicle_type=null;
        basd.body_type=null;
        basd.body_subtype=null;
        basd.doors=null;
        basd.model_number=null;
        basd.package_code=null;
        basd.drive_type=null;
        basd.brake_system=null;
        basd.restraint_type=null;
        basd.country_of_Manufacture=null;
        basd.plant=null;

        VINDecoder_DataOneSoftware.pricing pri = new VINDecoder_DataOneSoftware.pricing();
        pri.msrp = null;
        pri.invoice_price=null;
        pri.destination_charge=null;
        pri.gas_guzzler_tax=null;

        VINDecoder_DataOneSoftware.EngineList el = new VINDecoder_DataOneSoftware.EngineList();
        el.name=null;
        el.brand=null;
        el.engine_id=null;
        el.availability=null;
        el.aspiration=null;
        el.block_type=null;
        el.bore=null;
        el.cam_type=null;
        el.compression=null;
        el.cylinders=null;
        el.displacement=null;
        el.fuel_induction=null;
        el.fuel_quality=null;
        el.fuel_type=null;
        el.msrp=null;
        el.invoice_price=null;
        el.marketing_name=null;
        el.max_hp=null;
        el.max_hp_at=null;
        el.max_payload=null;
        el.max_torque=null;
        el.max_torque_at=null;
        el.oil_capacity=null;
        el.order_code=null;
        el.redline=null;
        el.stroke=null;
        el.valve_timing=null;
        el.valves=null;

        VINDecoder_DataOneSoftware.TransmissionList tl = new VINDecoder_DataOneSoftware.TransmissionList();
        tl.name=null;
        tl.brand=null;
        tl.msrp=null;
        tl.transmission_id=null;
        tl.availability=null;
        tl.item_type=null;
        tl.detail_type=null;
        tl.gears=null;
        tl.invoice_price=null;
        tl.order_code=null;

        VINDecoder_DataOneSoftware.WarrantyList warl = new VINDecoder_DataOneSoftware.WarrantyList();
        warl.name=null;
        warl.item_type=null;
        warl.months=null;
        warl.miles=null;

        VINDecoder_DataOneSoftware.RequestData req = new VINDecoder_DataOneSoftware.RequestData();
        req.vin=null;
        req.year=null;
        req.make=null;
        req.model=null;
        req.trim=null;
        req.model_number=null;
        req.package_code=null;
        req.drive_type=null;
        req.vehicle_type=null;
        req.body_type=null;
        req.doors=null;
        req.bedlength=null;
        req.wheelbase=null;
        req.msrp=null;
        req.invoice=null;
        req.engine=null;
        req.transmission=null;
        req.optional_equipment_codes=null;
        req.installed_equipment_descriptions=null;
        req.interior_color=null;
        req.exterior_color=null;

        VINDecoder_DataOneSoftware.StylePacks styp = new VINDecoder_DataOneSoftware.StylePacks();
        styp.basic_data=null;
        styp.pricing=null;
        styp.engines=null;
        styp.transmissions=null;
        styp.specifications= null;
        styp.installed_equipment=null;
        styp.optional_equipment=null;
        styp.colors=null;
        styp.safety_equipment=null;
        styp.warranties=null;
        styp.fuel_efficiency=null;


        VINDecoder_DataOneSoftware.CommonPacks compa = new VINDecoder_DataOneSoftware.CommonPacks();
        compa.basic_data=null;
        compa.pricing=null;
        compa.engines=null;
        compa.transmissions=null;
        compa.specifications=null;
        compa.installed_equipment=null;
        compa.optional_equipment=null;
        compa.colors=null;
        compa.safety_equipment=null;
        compa.warranties=null;
        compa.fuel_efficiency=null;

        VINDecoder_DataOneSoftware.EngineParameters epp = new VINDecoder_DataOneSoftware.EngineParameters();
        epp.description=null;
        epp.block_type =null;
        epp.cylinders=null;
        epp.displacement=null;
        epp.fuel_type=null;

        VINDecoder_DataOneSoftware.TransmissionParameters TPP = new VINDecoder_DataOneSoftware.TransmissionParameters();
        TPP.description=null;
        TPP.trans_type = null;
        TPP.Trans_Speeds=null;

        VINDecoder_DataOneSoftware.IntColor ic = new VINDecoder_DataOneSoftware.IntColor();
        ic.description=null;
        ic.color_code=null;

        VINDecoder_DataOneSoftware.ExtColor extc = new VINDecoder_DataOneSoftware.ExtColor();
        extc.description=null;
        extc.color_code=null;

        VINDecoder_DataOneSoftware.DecoderSettings dss = new VINDecoder_DataOneSoftware.DecoderSettings();
        dss.display=null;
        dss.styles=null;
        dss.style_data_packs=null;
        dss.common_data=null;
        dss.common_data_packs=null;

        VINDecoder_DataOneSoftware.EPAFuelEfficiencyList EPA = new VINDecoder_DataOneSoftware.EPAFuelEfficiencyList();
        EPA.engine_id=null;
        EPA.transmission_id=null;
        EPA.fuel_type=null;
        EPA.fuel_grade=null;
        EPA.city=null;
        EPA.highway=null;
        EPA.combined=null;

        VINDecoder_DataOneSoftware.OptionalEquipmentList OEL = new VINDecoder_DataOneSoftware.OptionalEquipmentList();
        OEL.category=null;
        OEL.options=null;

        VINDecoder_DataOneSoftware.OptionalEquipmentDetails OED = new VINDecoder_DataOneSoftware.OptionalEquipmentDetails();
        OED.name=null;
        OED.option_id=null;
        OED.Order_code=null;
        OED.installed=null;
        OED.install_type=null;
        OED.invoice_price=null;
        OED.msrp=null;
        OED.description=null;
        
        VINDecoder_DataOneSoftware.InstalledEquipmentList IEL = new VINDecoder_DataOneSoftware.InstalledEquipmentList();
        IEL.category=null;
        IEL.equipment=null;

        VINDecoder_DataOneSoftware.InstalledEquipmentDetails IEDA = new VINDecoder_DataOneSoftware.InstalledEquipmentDetails();
        IEDA.name=null;
        IEDA.values=null;

        VINDecoder_DataOneSoftware.ExteriorColors extca = new VINDecoder_DataOneSoftware.ExteriorColors();
        extca.mfr_code=null;
        extca.two_tone=null;
        extca.generic_color_name=null;
        extca.mfr_color_name=null;
        extca.primary_rgb_code=null;
        extca.secondary_rgb_code=null;

        VINDecoder_DataOneSoftware.InteriorColors intc = new VINDecoder_DataOneSoftware.InteriorColors();
        intc.mfr_code=null;
        intc.two_tone=null;
        intc.generic_color_name=null;
        intc.mfr_color_name=null;
        intc.primary_rgb_code=null;
        intc.secondary_rgb_code=null;

        VINDecoder_DataOneSoftware.RGB rbg = new VINDecoder_DataOneSoftware.RGB();
        rbg.r=null;
        rbg.g=null;
        rbg.b=null;
        rbg.hex=null;

        VINDecoder_DataOneSoftware.QueryRequests asdf = new VINDecoder_DataOneSoftware.QueryRequests();
        asdf.unique_request = null;

        VINDecoder_DataOneSoftware.DecodeRequestStruct drs = new VINDecoder_DataOneSoftware.DecodeRequestStruct();
    }

    static testmethod void TestDecodeSettingCheck() {

        VINDecoderCS__c df = VINDecoderCS__c.getValues('ActiveSettings');
        VINDecoder vd = new VINDecoder();

        try {
            delete df;
            vd.DecodeVIN('3GNEK12Z15G244588');
        } catch(Exception e) {
            Boolean expectedExceptionThrown = e.getMessage().contains('Error:  No active VIN Decoder setup.  Please contact your System Administrator') ? true : false;
            System.assertEquals(expectedExceptionThrown, true);
        }
        try {
            vd.doVINDecodeCallout('3GNEK12Z15G244588'); 
        } catch(Exception e) {
            Boolean expectedExceptionThrown = e.getMessage().contains('Error:  No active VIN Decoder setup.  Please contact your System Administrator') ? true : false;
            System.assertEquals(expectedExceptionThrown, true);
        }
    }
   
    @isTest static void testEditPageMethodOneModel() {

        User u = [Select Id from User where username = 'testuser128@testorgvmailtest342s.com' limit 1];
        System.runAs(u) {
           dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
            VinDecoderCS__c decodeSettings = VINDecoderAPI.DecodeSettings();
            decodeSettings.UseBigObjectStorage__c = false;
            update decodeSettings;

            dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c(
                    Name='1234',
                    dealer__VIN__c='3GNEK12Z15G244588',
                    dealer__Make__c='Chevrolet',
                    dealer__Model__c='1500',
                    dealer__Stock_Number__c='VT100',
                    dealer__Year__c='2012',
                    dealer__Engine_Id__c = '2342'
                );
                insert inv;

            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(inv);
            VINDecoder_EXT ext = new VINDecoder_EXT(sc);
            dms.dealer__Assign_Stock_Number__c = true;
            dms.dealer__Assign_Stock_Number_by_Sequence__c = false;
            dms.dealer__Stock_Number_Current_Index__c = 1;
            update dms;

            ext.skipDecodeAction = false;
            
            //stores VinDecoder_Ext.ddat and VinDecoder_Ext.VINDecoder.decodeData
            ext.doDecode(inv.VIN__c);
            ext.getDecode();
            ext.getModelKeyList();
            ext.setSelectedStyleId('18163');
            String styleId = ext.getSelectedStyleId();
            ext.setSelectedStyleId('18163');
            
            VINDecoderDataObject.Style selectedStyle = ext.vd.SelectedStyle(styleId);
            system.assertEquals('18163',selectedStyle.vehicle_id);

            ext.doDecodePage();
            ext.isEdit = true;
            ext.editPage();
            system.assertEquals(1,ext.getEngines().size());
            system.assertEquals(1,ext.getTransmissions().size());
            system.assertEquals('208',ext.getTransmissions()[0].transmission_id);
            
            ext.selectedTransmission = '208';

            ext.isEdit=true;
            ext.editPage();
            System.assertEquals(ext.SelectedStyleId, '18163');
        }
    }
    
    // /*
    //  * Verify stock number assigned is the next in the list
    //  */
    @isTest static void testStockBookAutoSuggestion(){
        
        
        List<DMS_Settings__c> dmsSettings = [SELECT Id, dealer__Assign_Stock_Number__c,
                                     dealer__Assign_Stock_Number_By_Stock_Book__c,
                                     dealer__Assign_Stock_Number_by_Sequence__c
                                     FROM DMS_Settings__c LIMIT 1];
        dmsSettings[0].dealer__Assign_Stock_Number__c = true;
        dmsSettings[0].dealer__Assign_Stock_Number_By_Stock_Book__c = true;
        dmsSettings[0].dealer__Assign_Stock_Number_by_Sequence__c = false;
        
        update dmsSettings;
        
    
        Id locationId = [SELECT Id FROM dealer__Dealer_Location__c WHERE Name =: 'DealerTeam Motors'].Id;
        
        dealer__Stock_Number_Book__c stockBook = new dealer__Stock_Number_Book__c();     
        stockBook.Name = '1234';
        stockBook.dealer__Location__c = locationId;
        stockBook.dealer__Sequence__c = 1.0;
        insert stockBook;
        
        dealer__Stock_Number_Book__c nextStockBook = new dealer__Stock_Number_Book__c();
        nextStockBook.Name = '12345';
        nextStockBook.dealer__Location__c = locationId;
        nextStockBook.dealer__Sequence__c = 2.0;
        insert nextStockBook;
        
        
        dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c(
                     Name='inv1',
                    dealer__VIN__c='1FTMF1CP5GKD57509',
                    dealer__Make__c='Chevrolet',
                    dealer__Model__c='1500',
                    dealer__Stock_Number__c='1234',
                    dealer__Year__c='2012',
                    dealer__Engine_Id__c = '2342'
                );
                
    
        
         dealer__Vehicle_Inventory__c inv3 = new dealer__Vehicle_Inventory__c(
                     Name='inv3',
                    dealer__VIN__c='1FTPW12527FB64921',
                    dealer__Make__c='Chevrolet',
                    dealer__Model__c='1500',
                    dealer__Year__c='2012',
                    dealer__Engine_Id__c = '2342'
       );
        insert inv;
        
        User u = [Select Id from User where username = 'testuser128@testorgvmailtest342s.com' limit 1];
        System.runAs(u) {
        	ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(inv3);
        	VINDecoder_EXT controller = new VINDecoder_EXT(sc);
            controller.Save();
        }

        List<dealer__Vehicle_Inventory__c> vehicle = [SELECT Id, Name,dealer__Stock_Number__c  
                                                      FROM dealer__Vehicle_Inventory__c ORDER By CreatedDate ASC];
        
        System.assertEquals(2,vehicle.size());
        //Verify stock number assigned is the next in the list
        System.assertEquals('12345',vehicle[1].dealer__Stock_Number__c);
    }
    
    @isTest 
    static void testAssignStockNumberbyCustomField(){
        
        
        List<DMS_Settings__c> dmsSettings = [SELECT Id, dealer__Assign_Stock_Number__c,
                                     dealer__Assign_Stock_Number_by_Custom_Field__c,
                                     dealer__Stock_Number_Current_Index__c
                                     FROM DMS_Settings__c LIMIT 1];
        dmsSettings[0].dealer__Assign_Stock_Number__c = true;
        dmsSettings[0].dealer__Assign_Stock_Number_by_Custom_Field__c = 'VehicleRecordType__c'; 
        dmsSettings[0].dealer__Stock_Number_Current_Index__c = 0;
        
        update dmsSettings;
        
    
        Id locationId = [SELECT Id FROM dealer__Dealer_Location__c WHERE Name =: 'DealerTeam Motors'].Id;
        
        dealer__Stock_Number_Book__c stockBook = new dealer__Stock_Number_Book__c();     
        stockBook.Name = '1234';
        stockBook.dealer__Location__c = locationId;
        stockBook.dealer__Sequence__c = 1.0;
        insert stockBook;
        
        dealer__Stock_Number_Book__c nextStockBook = new dealer__Stock_Number_Book__c();
        nextStockBook.Name = '12345';
        nextStockBook.dealer__Location__c = locationId;
        nextStockBook.dealer__Sequence__c = 2.0;
        insert nextStockBook;
        
        
        dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c(
                     Name='inv1',
                    dealer__VIN__c='1FTMF1CP5GKD57509',
                    dealer__Make__c='Chevrolet',
                    dealer__Model__c='1500',
                    dealer__Stock_Number__c='1234',
                    dealer__Year__c='2012',
                    dealer__Engine_Id__c = '2342'
                );
                
    
        
         dealer__Vehicle_Inventory__c inv3 = new dealer__Vehicle_Inventory__c(
                     Name='inv3',
                    dealer__VIN__c='1FTPW12527FB64921',
                    dealer__Make__c='Chevrolet',
                    dealer__Model__c='1500',
                    dealer__Year__c='2012',
                    dealer__Engine_Id__c = '2342'
       );
        insert inv;
        
        User u = [Select Id from User where username = 'testuser128@testorgvmailtest342s.com' limit 1];
        System.runAs(u) {
        	ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(inv3);
        	VINDecoder_EXT controller = new VINDecoder_EXT(sc);
            controller.deriveStockNumber();
        }

        List<dealer__Vehicle_Inventory__c> vehicle = [SELECT Id, Name,dealer__Stock_Number__c  
                                                      FROM dealer__Vehicle_Inventory__c ORDER By CreatedDate ASC];
        

    }

    @isTest
    static void testSave() {

        User u = [Select Id from User where username = 'testuser128@testorgvmailtest342s.com' limit 1];
        System.runAs(u) {
            VinDecoderCS__c decodeSettings = VINDecoderAPI.DecodeSettings();
            boolean UBOS = decodeSettings.UseBigObjectStorage__c;
            decodeSettings.UseBigObjectStorage__c = false;
            update decodeSettings;

            dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c(
                    Name='1234',
                    dealer__VIN__c='3GNEK12Z15G244588',
                    dealer__Make__c='Chevrolet',
                    dealer__Model__c='1500',
                    dealer__Stock_Number__c='VT100',
                    dealer__Year__c='2012',
                    dealer__Engine_Id__c = '2342'
                );
            insert inv;

            dealer__Vehicle_Inventory__c inv1 = new dealer__Vehicle_Inventory__c(
                    Name='1234',
                    dealer__VIN__c='3GNEK12Z15G244588',
                    dealer__Make__c='Chevrolet',
                    dealer__Model__c='1500',
                    dealer__Stock_Number__c='VT100',
                    dealer__Year__c='2012',
                    dealer__Engine_Id__c = '2342'
                );

            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(inv1);
            VINDecoder_EXT ext = new VINDecoder_EXT(sc);
            
            Test.startTest();
            ext.save();
            Test.stopTest();
           
        }
    }

    @isTest
    static void testSave2() {

        // Test Cases
        // 1. Insert VI WITHOUT VIN
        //    - NO Service Vehicle is Created
        // 2. UPDATE VI WITH VIN
        //    - Service Vehicle is Created
        // 3. UPDATE VI VIN Field
        //    - Unble to Edit VIN due to validation rule.

        User u = [Select Id from User where username = 'testuser128@testorgvmailtest342s.com' limit 1];
        System.runAs(u) {
            VinDecoderCS__c decodeSettings = VINDecoderAPI.DecodeSettings();
            boolean UBOS = decodeSettings.UseBigObjectStorage__c;
            decodeSettings.UseBigObjectStorage__c = false;
            update decodeSettings;

            dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c(
                    Name='1234',
                    // dealer__VIN__c='3GNEK12Z15G244588',
                    // dealer__Vehicle_Order_Number__c = '123456',
                    dealer__Make__c='Chevrolet',
                    dealer__Model__c='1500',
                    // dealer__Stock_Number__c='VT100',
                    dealer__Year__c='2019'
                );
            // insert inv;

            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(inv);
            VINDecoder_EXT ext = new VINDecoder_EXT(sc);
            
            Test.startTest();

            // TC 1
            try {
                ext.skipVinDecode();
            } catch (Exception e) {
                System.Assert(e.getMessage().contains('You must enter a value for VIN or Vehicle Order Number'));
            }
            
            inv.dealer__Vehicle_Order_Number__c = '123456';
            
            sc = new ApexPages.Standardcontroller(inv);
            ext = new VINDecoder_EXT(sc);
            
            ext.skipVinDecode(); // Now update Stock Number
            ext.save();

            List<Vehicle_Inventory__c> svs = [
                SELECT Id, Service_Vehicle__c
                FROM Vehicle_Inventory__c
                WHERE Vehicle_Order_Number__c = '123456'
                LIMIT 1
            ];

            // Verify actual save without VIN
            System.assert(inv.Id != null);
            // Verify NO Service Vehicle Created
            System.assert(svs[0].Service_Vehicle__c == null);
            
            // TC 2
            inv.VIN__c='3GNEK12Z15G244588';
            update inv;

            svs = [
                SELECT Id, VIN__c, Service_Vehicle__c
                FROM Vehicle_Inventory__c
                WHERE VIN__c = '3GNEK12Z15G244588'
                LIMIT 1
            ];
            
            // Verify Service Vehicle Creation
            System.assert(svs[0].Service_Vehicle__c != null);

            // TC 3
            try {
                inv.VIN__c='3GNEK12Z15G244589';
                update inv;
            } catch (Exception e) {
                System.Assert(e.getMessage().contains('VIN cannot be updated'));
            }
            
            Test.stopTest();

        }
    }
      
}