@isTest
private class ServiceVehicleServiceLayer {
    @TestSetup
    static void makeData(){
	TestClassUtil tcu = new TestClassUtil();
		tcu.insertDMSSettings();
		Dealer_Location__c loc = TestClassUtil.insertDealerLocation('RD1', 'Redding Motorcar Company');

        //SV Customer Account
		Account a = new Account(FirstName='Test', LastName='mcTest');
        insert a;

        //SV Owner Contact
		Contact c = [SELECT Id, AccountId FROM Contact WHERE AccountId=:a.Id Limit 1];

        //create sales Inventory
        Vehicle_Inventory__c VI = new Vehicle_Inventory__c();
			VI.Name = 'Test Vehicle Inventory';
			VI.Model__c = 'Civic';
			VI.Stock_Number__c = dealer.TestClassUtil.generateRandomString(8);
			VI.VIN__c = '5TDYK3DCXBS075856';
			VI.Company_Number__c = 'RD1';
			VI.Store_Location__c = loc.Id;
			VI.Year__c = '2014';
			VI.Make__c = 'Honda';
			VI.In_Stock__c = true;

		insert VI;
        

        //create parts Kit
		Id kitId = tcu.insertPartsKit();

        Service_Vehicle__c sv = [select Id from Service_Vehicle__c LIMIT 1];
        sv.Veh_Owner__c = a.Id;
        sv.Veh_Owner_Contact__c = c.Id;
        sv.Conversion__c = kitId;
        update sv;

        //Create SRO
        Service_Repair_Order__c  sro = new Service_Repair_Order__c(
            Customer__c = a.Id,
            Mileage_In__c = 1,
            Status__c = 'Open',
            Company__c = loc.Id,
            RO_Number__c = '199999',
            Vehicle__c = sv.Id
        );
        insert sro;

        //Create Service Job Line
        Service_Job__c sj = new Service_Job__c(
            Service_Repair_Order__c = sro.Id
        );
        insert sj;

        //Create Equipment
        Equipment__c equipment = new Equipment__c(
            Name='test',
            Service_Vehicle__c = sv.id
        );
        insert equipment;

        //create service contracts
        Service_Contract__c serviceContract = new Service_Contract__c(
            Customer_Contact__c = c.Id,
            Customer__c = a.Id,
            Deductable__c = 25,
            Description__c = 'Test desc',
            Plan_Code__c = 'Test Plan',
            Product_Code__c = 'Code 1',
            Sale_Price__c = 200,
            Service_Vehicle__c = sv.Id,
            Start_Date__c = System.today(),
            Vehicle_Inventory__c = vi.Id,
            Type__c = 'GAP'
        );
        insert serviceContract; 

        //create inspection report
        Inspection_Report__c ir = new Inspection_Report__c(
            Service_Vehicle__c = sv.Id
        );
        insert ir;
        
        //create appraisal
        Appraisal__c appraisal = new Appraisal__c(
            Appraised_Value__c = 12000,
            ConversionModel__c ='Braun XT',
            Service_Vehicle__c = sv.Id
        );
        insert appraisal;

        //Standard Op Codes
        StandardOPCode__c opCodes = new StandardOPCode__c(
            Name='test',
            Active__c = true,
            Concern__c = 'test'
        );
        insert opcodes;

    }
    @isTest static void testServiceVehicleAPI(){
        Id svId = [SELECT Id from Service_Vehicle__c LIMIT 1].Id;
        ServiceVehicleAPI.sv sv = ServiceVehicleAPI.svData(svId);

        System.assert(sv.vehicle != null, 'ServiceVehicleAPI.svData should have returned a Vehicle');
        System.assert(sv.svHeader != null, 'ServiceVehicleAPI.svData should have returned Header data');
        System.assert(sv.sro.size() > 0, 'ServiceVehicleAPI.svData should have returned SROS');
        System.assert(sv.ownerContact != null, 'ServiceVehicleAPI.svData should have returned an owner contact');
        System.assert(sv.ownerAcct != null, 'ServiceVehicleAPI.svData should have returned an owner account');
        System.assert(sv.inspectionReports.size() > 0, 'ServiceVehicleAPI.svData should have returned Inspection Reports');
        System.assert(sv.equipmentInvs.size() > 0, 'ServiceVehicleAPI.svData should have returned Equipment Invs');
        System.assert(sv.employee != null, 'ServiceVehicleAPI.svData should have returned Users' );
        System.assert(sv.conversion != null , 'ServiceVehicleAPI.svData should have returned a Conversion');
        System.assert(sv.contract.size() > 0 , 'ServiceVehicleAPI.svData should have returned Service Contracts');
        System.assert(sv.appraisals.size() > 0 , 'ServiceVehicleAPI.svData should have returned Appraisals');
    }

    @isTest static void testServiceAPI(){

        Id svId = [SELECT Id from Service_Vehicle__c LIMIT 1].Id;
        Account a = [SELECT Id From Account limit 1];
        Dealer_Location__c loc = [SELECT Id FROM Dealer_Location__c LIMIT 1];

        loc.Location_Account__c = a.Id;
        loc.Warranty_Labor_Rate__c = 100;
        update loc;
       
        Id sroId = [SELECT Id FROM Service_Repair_Order__c LIMIT 1].Id;

        StandardOPCode__c [] opCodes = ServiceAPI.standardOperationCodes();
        System.assert(opCodes.size() > 0 );

        MiscChargeCode__c[] misc = ServiceAPI.miscChargeCodes(loc.Id);
        System.assert(misc.size() > 0,'Picklist entries should have been returned if Misc. Charge Codes do not exist.');

        MiscChargeCode__c newMisc = new MiscChargeCode__c(
            Location__c = loc.Id,
            Name = 'test',
            Active__c = true,
            ApplicablePayType__c = 'c',
            BaseCharge__c = 'Labor Sale',
            Description__c = 'test desc'
        );
        insert newMisc;

        misc = ServiceAPI.miscChargeCodes(loc.Id);
        System.assert(misc.size() > 0);

        DispatchEvent__c de = new DispatchEvent__c(
            ServiceRepairOrderRef__c = sroId,
            Location__c = loc.Id,
            StartDateTime__c= Datetime.newInstance(1960, 2, 17),
            EndDateTime__c =Datetime.newInstance(1960, 2, 18)
        );
        ServiceAPI.storeDispatchEvent(de);

        DispatchEvent__c[] dispatch = ServiceAPI.getDispatchEvents(loc);
        System.assert(dispatch.size() > 0, 'Dispatch Event should have been created');

        Service_Job__c[] dispatchLines = ServiceAPI.getJobLinesForDispatch(loc);
        System.assert(dispatchLines.size() > 0, 'Jobs for dispatch should have records returned.');

        ServiceAPI.DispachedWork dWrapper = new ServiceAPI.DispachedWork(de);

        ServiceAPI.deleteDispatchEvent(dWrapper.dispatchEvent);
        System.assert([SELECT Id FROM DispatchEvent__c WHERE Id =: de.Id].size() == 0, 'Dispatch Event should have been deleted.');

        String TechJSON = '{"FullName": "Tyler Kauffman", "UserId":"'+loc.Id+'"}';
        ServiceAPI.Technician tech = (ServiceAPI.Technician)JSON.deserialize(TechJSON, ServiceAPI.Technician.class);

        System.assert(ServiceAPI.getWarrantyLaborRate(a.Id) == 100,'Warranty Labor rate did not return correct value (100).');
    }
}