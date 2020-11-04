@isTest
private class TestServiceVehicle_EXT {

    @testSetup static void testDataInit() {
        TestClassUtil util = new TestClassUtil();
        dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        if (dms == null) {
            util.insertDMSSettings();
        }

        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
        Profile prof = [select id from profile where name = 'system Administrator'];
        User usr = new User(alias = 'usr', email = 'us.name@vmail.com',
            emailencodingkey = 'UTF-8', lastname = 'lstname',
            timezonesidkey = 'America/Los_Angeles',
            languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = prof.Id,
            username = 'testuser128@testorgx.com',
            Division = 'DT1');
        insert usr;

        dealer__Service_Vehicle__c sv = new dealer__Service_Vehicle__c(Name = 'test',
            dealer__Year__c = '2012',
            dealer__Make__c = 'Honda',
            dealer__Carline__c = 'Civic',
            dealer__VIN__c = '1GYFK63837R301368',
            dealer__Body_Type__c = 'Truck',
            dealer__VIN_Not_Present__c = false);
        insert sv;

        /********** Added by KVP (1/12/2015) ******************/
        //Inserting appriasal vehicle for ServiceVehicleSanitize trigger
        dealer__Appraisal_Vehicle__c apprVehicle = new dealer__Appraisal_Vehicle__c();
        apprVehicle.dealer__VIN__c = sv.dealer__VIN__c;
        apprVehicle.dealer__Service_Vehicle__c = sv.id;
        insert apprVehicle;

        //Inserting Salesup for ServiceVehicleSanitize trigger
        dealer__sales_Up__c salesUp = new dealer__sales_Up__c();
        salesUp.dealer__LastName__c = 'Test';
        salesUp.dealer__Trade_VIN__c = sv.dealer__VIN__c;
        salesUp.dealer__Service_Vehicle__c = sv.id;
        insert salesUp;

        update sv;

        /*****************************************************/

        dealer__Service_vehicle_Equipment__c srEquipment = new dealer__Service_vehicle_Equipment__c();
        srEquipment.dealer__service_Vehicle__c = sv.Id;
        srEquipment.service_Vehicle__c = sv.id;
        insert srEquipment;
    }

    static testmethod void testSVEXT() {

        if (dealer__VINDecoderCS__c.getValues('ActiveSettings') == null) {
            dealer__VINDecoderCS__c VINDecod = new dealer__VINDecoderCS__c();
            VINDecod.Name = 'ActiveSettings';
            VINDecod.dealer__DecoderAPI_URL__c = 'https://api.dataonesoftware.com/webservices/vindecoder/decode';
            VINDecod.dealer__DecoderClientID__c = '6310';
            VINDecod.dealer__DecoderKey__c = 'asdfasdfasdfasdfasdfasdf';
            VINDecod.dealer__DecoderName__c = 'Data One Software';
            insert VINDecod;
        }

        User u = [Select Id from User where Username = 'testuser128@testorgx.com'];
        System.runAs(u) {
            TestClassUtil newUtil = new TestClassUtil();
            dealer__Service_Vehicle__c sv = new dealer__Service_Vehicle__c();
            sv.dealer__Year__c = '2014';
            sv.dealer__Veh_Owner_Contact__c = newUtil.insertContact();
            sv.dealer__VIN__c = 'B54998';
            sv.dealer__Stock_Number__c = '1234';
            sv.dealer__Make__c = 'Test';
            sv.dealer__Customer_Key__c = '1234';
            sv.dealer__Licence__c = 'Test';
            sv.dealer__Last_Service__c = System.today();
            sv.dealer__Carline__c = '2014';
            sv.dealer__Last_6__c = 'B54998';

            insert sv;

            dealer__sales_Up__c salesup = [Select Id from dealer__sales_Up__c limit 1];

            pageReference pr = page.VINDecodeServiceVehicleStyleSelect;
            pr.getParameters().put('id', sv.id);
            pr.getParameters().put('owner', userInfo.getUserId());
            pr.getParameters().put('suid', salesUp.id);
            test.setCurrentPage(pr);
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(sv);
            ServiceVehicle_EXT sxt = new ServiceVehicle_EXT(sc);
            String json = sxt.vd.doVINDecodeCallout(sv.dealer__VIN__c);
            sxt.doDecode(sv.dealer__VIN__c);

            String engine = sxt.selectedEngine;
            String trans = sxt.selectedTransmission;

            sxt.setSelectedStyleId('100378355');
            sxt.doDecodePage();
            sxt.editPage();

            sxt.vinNotPresent();
            sxt.doDecodePage();
            sxt.getDecode();
            sxt.getModelKeyList();
            sxt.getSelectedStyleId();
            sxt.setSelectedStyleId('123');

            sxt.getDecode();
            sxt.getModelKeyList();
            String styleIDreturned = sxt.getSelectedStyleId();
            System.assertEquals(sxt.SelectedStyleId, styleIDreturned);
            sxt.vd.StyleDat(sxt.SelectedStyleId);
            sxt.setSelectedStyleId('100378355');
            sxt.vd.StyleDat('100378355');

            sxt.getEngineSelect();
            sxt.getTransmissionSelect();
            sxt.Save();
            sxt.sv.Id = null;
            sxt.Save();
            sxt.getInstalledEquipment();
            sxt.getOptEquip();

            sxt.editPage();
            sxt.redirectToBack();
            sxt.getsvEquip();
            sxt.getsvEquip();

        }
    }

    static testmethod void testDeleteSVEXT() {

        User u = [Select Id from User where Username = 'testuser128@testorgx.com'];
        System.runAs(u) {
            TestClassUtil newUtil = new TestClassUtil();

            dealer__Service_Vehicle__c sv = new dealer__Service_Vehicle__c();
            sv.dealer__Year__c = '2014';
            sv.dealer__Veh_Owner_Contact__c = newUtil.insertContact();
            sv.dealer__VIN__c = 'B54998';
            sv.dealer__Stock_Number__c = '1234';
            sv.dealer__Make__c = 'Test';
            sv.dealer__Customer_Key__c = '1234';
            sv.dealer__Licence__c = 'Test';
            sv.dealer__Last_Service__c = System.today();
            sv.dealer__Carline__c = '2014';
            sv.dealer__Last_6__c = 'B54998';
            insert sv;

            dealer__Service_Appointment__c SA = new dealer__Service_Appointment__c();
            SA.Name = 'Test Appointment';
            SA.dealer__Date_Time__c = System.now();
            SA.dealer__External_Id__c = '12345';
            SA.dealer__Vehicle__c = sv.id;
            SA.dealer__Mileage__c = 100;

            insert SA;

            dealer__Service_Repair_Order__c spo = new dealer__Service_Repair_Order__c();

            spo.dealer__Customer__c = newUtil.insertAccount();
            spo.dealer__Deposit__c = 100;
            spo.dealer__Customer_Contact__c = newUtil.insertContact();
            spo.Name = 'Test Service Repair Order';
            spo.dealer__Customer_Charges__c = 50;
            spo.dealer__Company_Number__c = 'Location 1';
            spo.dealer__Tax__c = 30;
            spo.dealer__Vehicle__c = sv.id;
            spo.dealer__Shop_Supplies__c = 20;
            spo.dealer__RO_Number__c = 'RO100';
            spo.dealer__Mileage_In__c = 10;
            spo.dealer__Mileage_Out__c = 5;

            insert spo;

            try {
                delete sv;
                System.assert(false, 'Unable to delete service vehicle.  This vehicle has service appointments associated.');
                System.assert(false, 'Unable to delete this service vehicle.  This Vehicle has Repair Orders associated.');
            }
            Catch(DmlException e) {
                String message = e.getMessage();
                System.assert(message.contains('This Vehicle has Repair Orders associated.'), 'message=' + message);
           
            }

        }
    }

    @isTest static void TestUpdate() {

        TestFactory.createSobject(new VINDecoderCS__c(), true);

        VinDecoderAPI.OptionalEquipment opte = new VinDecoderAPI.OptionalEquipment(
            true,
            'test',
            'test',
            'test',
            'test',
            'test',
            'test'
        );

        VinDecoderAPI.InstalledEquipment ie = new VinDecoderAPI.InstalledEquipment(
            true,
            'test',
            'test',
            'test'
        );

        service_Vehicle__c serv = (service_Vehicle__c) TestFactory.createSobject(new service_Vehicle__c(), true);
        TestFactory.createSobject(new Service_Vehicle_Equipment__c(service_Vehicle__c = serv.Id), true);

        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(serv);
        ServiceVehicle_EXT sxt = new ServiceVehicle_EXT(sc);
        sxt.OptEquip.add(opte);
        sxt.InstalledEquipment.add(ie);

        sxt.doDecode(serv.Vin__c);

        VINDecoderDataObject.DecodeData r = sxt.ddat;
        VINDecoderDataObject.Style r2 = sxt.vd.SelectedStyle('18163');

        VINDecoderDataObject.OptionalEquipment oe = new VINDecoderDataObject.OptionalEquipment();
        oe.category = 'test';

        VINDecoderDataObject.OptionalEquipmentDetails det = new VINDecoderDataObject.OptionalEquipmentDetails();
        det.name = 'test';
        List < VINDecoderDataObject.OptionalEquipmentDetails > oed = new List < VINDecoderDataObject.OptionalEquipmentDetails > ();
        oed.add(det);

        oe.options = oed;

        List < VINDecoderDataObject.OptionalEquipment > oelist = new List < VINDecoderDataObject.OptionalEquipment > ();
        oelist.add(oe);



        VINDecoderDataObject.InstalledEquipment iel = new VINDecoderDataObject.InstalledEquipment();
        iel.category = 'test';

        VINDecoderDataObject.InstalledEquipmentDetails idet = new VINDecoderDataObject.InstalledEquipmentDetails();
        idet.name = 'test';
        idet.values = new List < string > {
            'test'
        };
        List < VINDecoderDataObject.InstalledEquipmentDetails > lid = new List < VINDecoderDataObject.InstalledEquipmentDetails > ();
        lid.add(idet);

        iel.equipment = lid;

        List < VINDecoderDataObject.InstalledEquipment > ielist = new List < VINDecoderDataObject.InstalledEquipment > ();
        ielist.add(iel);


        r2.optional_equipment = oelist;
        r2.installed_equipment = ielist;

        sxt.ddat = r;
        sxt.sdat = r2;

        sxt.updateVehicle();
        sxt.save();

        sxt.editPage();

    }
}