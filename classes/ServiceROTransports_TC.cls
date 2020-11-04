/**
 * Date            |Developer            |Work#
 * Notes
 * --
 * 2016.12.15      |Gaurav               |#W-000811
 * Modified class failing because of SRO location
 **/
@isTest
private class ServiceROTransports_TC {

    @testSetup static void testSetup() {
        TestClassUtil tu = new TestClassUtil();
        tu.insertDMSSettings();

        // Create the location
        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');

        // Create the user
        Profile prof = [select id from profile where name = 'system Administrator'];
        User usr = new User(alias = 'usr', email = 'us.name@vmail.com',
            emailencodingkey = 'UTF-8', lastname = 'lstname',
            timezonesidkey = 'America/Los_Angeles',
            languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = prof.Id,
            username = 'testuser128@testorgx.com',
            Division = 'DT1');
        insert usr;

        Parts_Service_Pricing_Strategy__c ps = new Parts_Service_Pricing_Strategy__c();
        ps.Method__c = 'Jobber';
        ps.Active__c = true;
        ps.Description__c = 'test';
        ps.Default__c = true;
        ps.dealer__Parts_Variable_Amount__c = 10;
        ps.dealer__Formula_Operand__c = '+';
        insert ps;

        /*W-000811 Begin*/
        dealer__Dealer_Location_User__c objUserLocation = new dealer__Dealer_Location_User__c();
        objUserLocation.dealer__Dealer_Location__c = loc.Id;
        objUserLocation.dealer__User__c = usr.Id;
        insert objUserLocation;
        /*W-000811 End*/

        tu.insertAccount();
        tu.insertContact();

        //W-000811
        System.runAs(usr) {

            dealer__MiscChargeCode__c miscCharges = New dealer__MiscChargeCode__c();
            miscCharges.Name = 'Test';
            miscCharges.dealer__Location__c = loc.Id;
            miscCharges.dealer__ApplicablePayType__c = 'c';
            miscCharges.dealer__BaseCharge__c = 'Labor Sale';
            miscCharges.dealer__Description__c = 'test';
            insert miscCharges;

            dealer__MiscChargeCode__c miscCharges1 = New dealer__MiscChargeCode__c();
            miscCharges1.Name = 'Parts';
            miscCharges1.dealer__Location__c = loc.Id;
            miscCharges1.dealer__ApplicablePayType__c = 'c';
            miscCharges1.dealer__BaseCharge__c = 'Parts Sale';
            miscCharges1.dealer__Description__c = 'test';
            insert miscCharges1;


            dealer__Service_Repair_Order__c dsr = new dealer__Service_Repair_Order__c();
            dsr.dealer__Customer__c = [Select Id from Account limit 1].Id;
            dsr.dealer__Mileage_In__c = 12;
            dsr.dealer__RO_Number__c = '1119810';
            dsr.dealer__Company_Number__c = 'DT1';
            dsr.dealer__Company__c = loc.id;
            insert dsr;

            dealer__Service_Job__c dsj = new dealer__Service_Job__c();
            dsj.dealer__Cause__c = 'Test';
            dsj.dealer__Labor_Charges__c = 12;
            dsj.dealer__Service_Repair_Order__c = dsr.id;
            dsj.dealer__Labor_Type__c = 'c';
            dsj.dealer__Labor_Rate__c = 'Test';
            dsj.dealer__Misc_Charges__c = 11;
            dsj.dealer__Concern__c = 'test';
            dsj.dealer__CustomerConcern__c = 'test';
            dsj.dealer__Correction__c = 'test';
            dsj.dealer__Op_Code__c = '71232';
            //dsj.dealer__Line_Total__c=12;
            dsj.dealer__Parts_Total__c = 7;
            dsj.dealer__Service_Type__c = 'MR';
            dsj.dealer__Line_Number__c = 1;
            //dsj.dealer__Operation_Code_Description__c='Test';
            dsj.dealer__Stat__c = 'Open';
            dsj.dealer__Technician__c = UserInfo.getuserid();
            dsj.dealer__Book_Time__c = 11;
            dsj.dealer__Line_Number__c = 1;
            insert dsj;

            dealer__Technician_Job_Time__c dtj = new dealer__Technician_Job_Time__c();
            dtj.Name = 'Test Job';
            dtj.dealer__Service_Job_Line__c = dsj.id;
            dtj.dealer__Start_Time__c = system.today();
            dtj.dealer__End_Time__c = system.today();
            // dtj.dealer__Time_Clock__c =dtc.id;
            dtj.Labor_Total__c = 23;
            dtj.dealer__Technician__c = usr.Id;
            insert dtj;


            dealer__Service_Repair_Order__c sro = new dealer__Service_Repair_Order__c();
            sro.dealer__Customer__c = [Select Id from Account limit 1].Id;
            sro.dealer__Mileage_In__c = 13;
            sro.dealer__RO_Number__c = '1119819';
            sro.dealer__Company_Number__c = 'DT1';
            sro.dealer__Company__c = loc.id;
            insert sro;

            dealer__Service_Job__c jobStatus = new dealer__Service_Job__c();
            jobStatus.dealer__Cause__c = 'Test2';
            jobStatus.dealer__Labor_Charges__c = 13;
            jobStatus.dealer__Service_Repair_Order__c = sro.id;
            jobStatus.dealer__Labor_Type__c = 'c';
            jobStatus.dealer__Labor_Rate__c = 'Test';
            jobStatus.dealer__Misc_Charges__c = 11;
            jobStatus.dealer__Concern__c = 'test';
            jobStatus.dealer__CustomerConcern__c = 'test';
            jobStatus.dealer__Correction__c = 'test';
            jobStatus.dealer__Op_Code__c = '71232';
            jobStatus.dealer__Parts_Total__c = 7;
            jobStatus.dealer__Service_Type__c = 'MR';
            jobStatus.dealer__Line_Number__c = 1;
            jobStatus.dealer__Stat__c = 'Declined';
            jobStatus.dealer__Technician__c = UserInfo.getuserid();
            jobStatus.dealer__Book_Time__c = 11;
            jobStatus.dealer__Line_Number__c = 1;
            insert jobStatus;


            dealer__Service_Repair_Order__c sroComplete = new dealer__Service_Repair_Order__c();
            sroComplete.dealer__Customer__c = [Select Id from Account limit 1].Id;
            sroComplete.dealer__Mileage_In__c = 16;
            sroComplete.dealer__RO_Number__c = '111982';
            sroComplete.dealer__Company_Number__c = 'DT1';
            sroComplete.dealer__Company__c = loc.id;
            insert sroComplete;


            dealer__Service_Job__c jobComplete = new dealer__Service_Job__c();
            jobComplete.dealer__Cause__c = 'Test4';
            jobComplete.dealer__Labor_Charges__c = 12;
            jobComplete.dealer__Service_Repair_Order__c = sroComplete.id;
            jobComplete.dealer__Labor_Type__c = 'c';
            jobComplete.dealer__Labor_Rate__c = 'Test2';
            jobComplete.dealer__Misc_Charges__c = 11;
            jobComplete.dealer__Concern__c = 'test';
            jobComplete.dealer__CustomerConcern__c = 'test';
            jobComplete.dealer__Correction__c = 'test';
            jobComplete.dealer__Op_Code__c = '71232';
            jobComplete.dealer__Parts_Total__c = 7;
            jobComplete.dealer__Service_Type__c = 'MR';
            jobComplete.dealer__Line_Number__c = 1;
            jobComplete.dealer__Stat__c = 'Complete';
            jobComplete.dealer__Technician__c = UserInfo.getuserid();
            jobComplete.dealer__Book_Time__c = 11;
            jobComplete.dealer__Line_Number__c = 1;
            insert jobComplete;

        }
    }

    static testmethod void testRoTransports() {

        User u = [Select Id from User where username = 'testuser128@testorgx.com'];
        System.runAs(u) {

            TestClassUtil t = new TestClassUtil();

            Account a = [select id from Account limit 1];
            Contact con = [select id from Contact limit 1];

            dealer__Parts_Master__c partsMaster = TestClassUtil.insertPartsMaster();

            dealer__Service_Job__c dsj = [Select Id from dealer__Service_Job__c limit 1];

            System.currentPageReference().getParameters().put('QTY', '2');
            System.currentPageReference().getParameters().put('lid', dsj.id);
            System.currentPageReference().getParameters().put('SalePrice', '2');
            System.currentPageReference().getParameters().put('Order', '2');
            // System.currentPageReference().getParameters().put('Id', dpl.id);
            System.currentPageReference().getParameters().put('action', 'delete_parts_Line');
            System.currentPageReference().getParameters().put('rid', dsj.id);
            // System.currentPageReference().getParameters().put('PartInventoryId', pi.id);
            System.currentPageReference().getParameters().put('dealer__Actual_Time_Entry__c', '2');
            System.currentPageReference().getParameters().put('dealer__Date__c', '8/8/2015');
            System.currentPageReference().getParameters().put('Labor_Total__c', '2');
            System.currentPageReference().getParameters().put('dealer__Technician__c[Id]', u.Id);


            System.currentPageReference().getParameters().put('Labor_Total__c', '2');
            Id sroId = [SELECT ID FROM dealer__Service_Repair_Order__c LIMIT 1].Id;




            System.currentPageReference().getParameters().put('dealer__Repair_Order_Id__c', sroId);

            Test.startTest();

            ServiceROTransports srt = new ServiceROTransports();

            String mr = srt.miscResult;

            dealer__Dealer_Location__c loc = srt.location;

            String s = srt.jobLineId;
            String s1 = srt.ttId;
            String s2 = srt.updateResult;
            String s3 = srt.lookupPartResult;
            String s4 = srt.masterId; // Parts Master Id
            String s5 = srt.locationId; // Location Id
            String s6 = srt.search;

            String s7 = srt.trans;
            String s8 = srt.roId;
            String s9 = srt.jobLineId;
            String s10 = srt.ttId;
            String s11 = srt.updateResult;
            String s12 = srt.lookupPartResult;
            String s13 = srt.masterId;
            String s14 = srt.locationId;
            String s15 = srt.search;
            srt.updateLine();
            dealer__Dealer_Location__c dlrLocation = srt.location;

            srt.ttid = [Select Id from dealer__Technician_Job_Time__c limit 1].Id;
            srt.roId = [Select Id from dealer__Service_Repair_Order__c limit 1].Id;
            srt.masterId = partsMaster.id;
            // srt.partLine = dpl.id;
            srt.locationId = [Select Id from dealer__Dealer_Location__c limit 1].Id;
            srt.getTechRow();
            srt.getOperationCodes();
            srt.getRoLines();
            srt.getTechTimes();
            srt.getTechnicians();
            srt.getstatusCodes();
            srt.getMiscTypes();

            srt.getReadParts();
            // Set job Line 

            t.insertServiceJob();

            dealer__Service_Job__c j = [Select Id from dealer__Service_Job__c where dealer__Service_Repair_Order__r.dealer__Posted_Date_Time__c = null limit 1];
            srt.jobLineId = j.Id;
            srt.getReadParts();

            srt.getMiscItems();

            srt.search = partsMaster.Name;
            srt.getSearchParts();

            srt.search = 'BRAKE';
            srt.getSearchParts();
            Parts_Service_Pricing_Strategy__c ps;
            srt.lookupPart(ps);
            srt.getStoreInventory();
            srt.getPartLine();

            srt.getUserList();

            Test.stopTest();


        } // End System.runAs(u);
    }

    static testmethod void testGetVariables() {
        User u = [Select Id from User where username = 'testuser128@testorgx.com'];
        System.runAs(u) {

            PageReference sro = Page.ServiceTRS;
            Test.setCurrentPage(sro);

            ApexPages.currentPage().getParameters().put('action', 'operations');
            ServiceROTransports sroController_1 = new ServiceROTransports();

            ApexPages.currentPage().getParameters().put('action', 'payment_methods');
            ServiceROTransports sroController_2 = new ServiceROTransports();

            // test Techs on a repair order
            String rid = [Select Id from dealer__Service_Job__c limit 1].Id; // Set by test data method
            ApexPages.currentPage().getParameters().put('action', 'techs');
            ApexPages.currentPage().getParameters().put('rId', rid);
            ServiceROTransports sroController_3 = new ServiceROTransports();

            // misc types available
            ApexPages.currentPage().getParameters().put('action', 'misc_types');
            ServiceROTransports sroController_4 = new ServiceROTransports();

            // RO Stats
            ApexPages.currentPage().getParameters().put('action', 'stat');
            ServiceROTransports sroController_5 = new ServiceROTransports();

            ApexPages.currentPage().getParameters().put('action', 'rolines');
            ApexPages.currentPage().getParameters().put('id', [Select Id from dealer__Service_Repair_Order__c limit 1].Id);
            ServiceROTransports sroController_6 = new ServiceROTransports();

            ApexPages.currentPage().getParameters().put('action', 'read_tech_time');
            ServiceROTransports sroController_7 = new ServiceROTransports();
        }
    }

    static testmethod void testGetVariables2() {
        User u = [Select Id from User where username = 'testuser128@testorgx.com'];
        System.runAs(u) {

            PageReference sro = Page.ServiceTRS;
            Test.setCurrentPage(sro);

            ApexPages.currentPage().getParameters().put('action', 'create');
            ServiceROTransports sroController_1 = new ServiceROTransports();

            ApexPages.currentPage().getParameters().put('action', 'read_parts');
            ServiceROTransports sroController_2 = new ServiceROTransports();
            // misc types available
            ApexPages.currentPage().getParameters().put('action', 'read_users');
            ServiceROTransports sroController_4 = new ServiceROTransports();

            ApexPages.currentPage().getParameters().put('action', 'read_misc');
            ServiceROTransports sroController_5 = new ServiceROTransports();

            ApexPages.currentPage().getParameters().put('action', 'search_parts');
            ServiceROTransports sroController_6 = new ServiceROTransports();

            ApexPages.currentPage().getParameters().put('action', 'PicklistValues');
            ServiceROTransports sroController_7 = new ServiceROTransports();

            ApexPages.currentPage().getParameters().put('action', 'global_inventory');
            ServiceROTransports sroController_8 = new ServiceROTransports();
        }
    }

    @isTest static void testCreateUpdateFunc() {
        // Create the location
        dealer__Dealer_Location__c loc = [Select Id from dealer__Dealer_Location__c limit 1];


        // Create the user
        Profile prof = [select id from profile where name = 'system Administrator'];
        User usr = [Select Id from User where username = 'testuser128@testorgx.com'];


        // create technician record
        User tch = new User(alias = 'tech', email = 'technician@blank.org',
            emailencodingkey = 'UTF-8', lastname = 'techlastname',
            timezonesidkey = 'America/Los_Angeles',
            languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = prof.Id,
            username = 'tech@blackhole.org',
            dealer__Technician__c = true,
            Division = 'DT1');

        insert tch;



        System.runAs(usr) {
            dealer__Service_Repair_Order__c dsr = new dealer__Service_Repair_Order__c();
            dsr.dealer__Customer__c = [Select Id from Account limit 1].Id;
            dsr.dealer__Mileage_In__c = 1;
            dsr.dealer__RO_Number__c = '1119817';
            dsr.dealer__Company_Number__c = 'DT1';
            dsr.dealer__Company__c = loc.Id;
            insert dsr;

            PageReference sro = Page.ServiceTRS;
            Test.setCurrentPage(sro);
            Test.startTest();
            ApexPages.currentPage().getParameters().put('action', 'create');
            Id sroId = [SELECT Id from dealer__Service_Repair_Order__c LIMIT 1].Id;
            ApexPages.currentPage().getParameters().put('dealer__Repair_Order_Id__c', sroId);
            System.currentPageReference().getParameters().put('rid', dsr.id);
            ServiceROTransports sroController_1 = new ServiceROTransports();
            sroController_1.saveAction();

            ApexPages.currentPage().getParameters().put('action', 'update');
            System.currentPageReference().getParameters().put('rid', dsr.id);
            System.currentPageReference().getParameters().put('dealer__Repair_Order_Id__c', dsr.id);
            ServiceROTransports sroController_2 = new ServiceROTransports();
            sroController_2.saveAction();
            Test.stopTest();
        }
    }

    static testmethod void testPartLineFunc() {

        Test.startTest();
        // Create the location
        dealer__Dealer_Location__c loc = [Select Id from dealer__Dealer_Location__c limit 1];


        // Create the user
        User usr = [Select Id from User where username = 'testuser128@testorgx.com'];



        System.runAs(usr) {

            dealer__Service_Repair_Order__c dsr = new dealer__Service_Repair_Order__c();
            dsr.dealer__Customer__c = [Select Id from Account limit 1].Id;
            dsr.dealer__Mileage_In__c = 12;
            dsr.dealer__RO_Number__c = '1219811';
            dsr.dealer__Company_Number__c = 'DT1';
            dsr.dealer__Company__c = loc.Id;
            insert dsr;

            dealer__Service_Job__c dsj = new dealer__Service_Job__c();
            dsj.dealer__Cause__c = 'Test';
            dsj.dealer__Labor_Charges__c = 15;
            dsj.dealer__Service_Repair_Order__c = dsr.id;
            dsj.dealer__Labor_Type__c = 'W';
            dsj.dealer__Labor_Rate__c = 'Test';
            dsj.dealer__Misc_Charges__c = 11;
            dsj.dealer__Concern__c = 'test';
            dsj.dealer__CustomerConcern__c = 'test';
            dsj.dealer__Correction__c = 'test';
            dsj.dealer__Op_Code__c = '71232';
            //dsj.dealer__Line_Total__c=12;
            dsj.dealer__Parts_Total__c = 7;
            dsj.dealer__Service_Type__c = 'MR';
            dsj.dealer__Line_Number__c = 1;
            //dsj.dealer__Operation_Code_Description__c='Test';
            dsj.dealer__Stat__c = 'Open';
            dsj.dealer__Technician__c = UserInfo.getuserid();
            dsj.dealer__Book_Time__c = 11;
            dsj.dealer__Line_Number__c = 1;
            insert dsj;

            dealer__Service_Job__c dsj2 = new dealer__Service_Job__c();
            dsj2.dealer__Cause__c = 'Test';
            dsj2.dealer__Labor_Charges__c = 0;
            dsj2.dealer__Service_Repair_Order__c = dsr.id;
            dsj2.dealer__Labor_Type__c = 'W';
            dsj2.dealer__Labor_Rate__c = 'Test';
            dsj2.dealer__Misc_Charges__c = 0;
            dsj2.dealer__Concern__c = 'test';
            dsj2.dealer__CustomerConcern__c = 'test';
            dsj2.dealer__Correction__c = 'test';
            dsj2.dealer__Op_Code__c = '71232';
            //dsj.dealer__Line_Total__c=12;
            dsj2.dealer__Parts_Total__c = 0;
            dsj2.dealer__Service_Type__c = 'MR';
            dsj2.dealer__Line_Number__c = 0;
            //dsj.dealer__Operation_Code_Description__c='Test';
            dsj2.dealer__Stat__c = 'Open';
            dsj2.dealer__Technician__c = UserInfo.getuserid();
            dsj2.dealer__Book_Time__c = 0;
            insert dsj2;

            PageReference sro = Page.ServiceTRS;
            Test.setCurrentPage(sro);

            ServiceROTransports srt;

            dealer__Parts_Invoice__c dv = new dealer__Parts_Invoice__c();
            dv.dealer__Comments__c = 'Test';
            dv.Location__c = loc.Id;
            dv.dealer__Invoice_Number__c = 'Test';
            insert dv;


            dealer__Parts_Master__c pm = new dealer__Parts_Master__c();
            pm.Name = 'Oil Filter';
            pm.dealer__Retail_Price__c = 99.99;
            pm.Manufacturer__c = 'FD';
            insert pm;

            // Create a Test Part
            dealer__Parts_Inventory__c part = new dealer__Parts_Inventory__c();
            part.dealer__Description__c = 'Oil Filter';
            part.dealer__Cost__c = 10;
            part.dealer__Source__c = 'Stocking';
            part.dealer__On_Hand__c = 1;
            part.dealer__Part_No__c = 'FL1A-XX';
            part.dealer__List__c = 22;
            part.dealer__Parts_Master__c = pm.Id;
            part.dealer__Location__c = loc.Id;

            insert part;


            dealer__Parts_Invoice_Line__c dpi = new dealer__Parts_Invoice_Line__c();
            dpi.dealer__Bin__c = 'Test';
            dpi.dealer__Parts_Invoice__c = dv.id;
            dpi.dealer__Part_Number__c = 'Test';
            dpi.dealer__Quantity_Sold__c = 12;
            dpi.dealer__Part__c = part.Id;
            dpi.dealer__Price__c = 100;
            dpi.dealer__Cost__c = 60;
            insert dpi;

            ApexPages.currentPage().getParameters().clear();
            ApexPages.currentPage().getParameters().put('mid', pm.Id);
            ApexPages.currentPage().getParameters().put('QTY', '1');
            ApexPages.currentPage().getParameters().put('rid', dsj.Id);
            ApexPages.currentPage().getParameters().put('PartInventoryId', part.Id);
            ApexPages.currentPage().getParameters().put('SalePrice', '1.50');
            ApexPages.currentPage().getParameters().put('partOrderUrgency', '');
            ApexPages.currentPage().getParameters().put('Order', '2');
            ApexPages.currentPage().getParameters().put('action', 'create_parts_line');
            srt = new ServiceROTransports();
            system.debug('Before create');
            //srt.saveAction();
            system.debug('After create');

            ApexPages.currentPage().getParameters().clear();
            ApexPages.currentPage().getParameters().put('Id', dpi.Id);
            ApexPages.currentPage().getParameters().put('QTY', '1');
            System.currentPageReference().getParameters().put('dealer__Repair_Order_Id__c', dsr.id);
            ApexPages.currentPage().getParameters().put('action', 'update_parts_line');
            try {
                // srt.saveAction();
            } catch (Exception e) {}

            ApexPages.currentPage().getParameters().put('action', 'delete_parts_line');
            ServiceROTransports sroController_3 = new ServiceROTransports();
            //sroController_3.saveAction();

            System.currentPageReference().getParameters().put('action', 'delete_line');
            System.currentPageReference().getParameters().put('id', dsj2.id);
            sroController_3.saveAction();

            Test.stopTest();
        }
    }

    static testmethod void testWrapperClasses() {

        TestClassUtil tu = new TestClassUtil();
        dealer__Parts_Master__c pm = TestClassUtil.insertPartsMaster();
        dealer__Dealer_Location__c loc = [Select Id from dealer__Dealer_Location__c limit 1];
        dealer__Parts_Inventory__c pinv = TestClassUtil.insertPartInventory(pm.Id, loc.Id);

        ServiceROTransports srowrapper = new ServiceROTransports();
        // srowrapper.PartRowInventory = new srowrapper.PartRowInventory(pinv);
        // 
        ServiceROTransports.PartSearch pSearch = new ServiceROTransports.PartSearch(pm);
        ServiceROTransports.StoreInventory storeInv = new ServiceROTransports.StoreInventory('s', 0);

        // Test Parts Wrapper
        dealer__Parts_Invoice_Line__c dpl = new dealer__Parts_Invoice_Line__c();
        dpl.dealer__Parts_Invoice__c = tu.insertPartsInvoice();
        dpl.Name = 'test';
        dpl.dealer__Core__c = 12;
        dpl.dealer__Cost__c = 12;
        dpl.dealer__Price__c = 12;
        dpl.dealer__Part_Number__c = '12';
        dpl.dealer__Quantity_Sold__c = 12;
        dpl.dealer__Quantity_Ordered__c = 12;
        dpl.dealer__Part_Description__c = 'test';
        dpl.dealer__Total_Price__c = 12;
        dpl.dealer__Part__c = pinv.Id;
        insert dpl;

        dealer__Parts_Invoice_Line__c invLine = [Select Id, Name, dealer__Job_Line__c, Part_Master_Record__c, dealer__Part__c,
            dealer__Part_Number__c, dealer__Part_Description__c, dealer__Currently_Available__c, Currently_On_Order__c, dealer__List__c,
            dealer__Price__c, dealer__Quantity_Sold__c, dealer__Quantity_Ordered__c,
            Negative_QTY__c, dealer__Extended_Price__c, dealer__Cost__c from dealer__Parts_Invoice_Line__c where Id =: dpl.Id limit 1
        ];

        ServiceROTransports.PartRow pRow = new ServiceROTransports.PartRow(invLine);

    }

    static testmethod void testTechActions() {

        User u = [Select Id from User where username = 'testuser128@testorgx.com'];
        System.runAs(u) {


            dealer__Technician_Job_Time__c tt = [SELECT Id, dealer__Service_Job_Line__c FROM dealer__Technician_Job_Time__c WHERE dealer__Service_Job_Line__r.dealer__Service_Repair_Order__r.dealer__Posted_Date_Time__c = null LIMIT 1];

            System.currentPageReference().getParameters().put('Id', tt.Id);
            System.currentPageReference().getParameters().put('lid', tt.dealer__Service_Job_Line__c);
            System.currentPageReference().getParameters().put('dealer__Technician__c[Id]', u.Id);

            System.currentPageReference().getParameters().put('dealer__Actual_Time_Entry__c', '1');
            System.currentPageReference().getParameters().put('dealer__Date__c', '09/05/2015');
            System.currentPageReference().getParameters().put('dealer__Payment_Method_Labor_Rate__c', '15');


            Test.startTest();

            ServiceROTransports srt = new ServiceROTransports();

            srt.updateTechTime();
            srt.deletTechTime();
            srt.calculateLaborCost(tt.dealer__Service_Job_Line__c);

            srt.createTechTime();

            Test.stopTest();
        }

    }

    static testmethod void testMiscActions() {

        User u = [Select Id from User where username = 'testuser128@testorgx.com'];
        System.runAs(u) {

            dealer__Service_Misc_Charge__c smc = new dealer__Service_Misc_Charge__c();
            smc.Type__c = 'Freight';
            smc.Service_Job_Lines__c = [Select Id from dealer__Service_Job__c limit 1].Id;
            smc.Amount__c = 11;
            insert smc;

            dealer__Technician_Job_Time__c tt = [Select Id, dealer__Service_Job_Line__c,
                dealer__Service_Job_Line__r.dealer__Service_Repair_Order__c from dealer__Technician_Job_Time__c where dealer__Service_Job_Line__r.dealer__Service_Repair_Order__r.dealer__Posted_Date_Time__c = null limit 1
            ];
            dealer__Service_Misc_Charge__c m = [Select Id from dealer__Service_Misc_Charge__c limit 1];

            System.currentPageReference().getParameters().put('Id', m.Id);
            System.currentPageReference().getParameters().put('lid', tt.dealer__Service_Job_Line__c);
            System.currentPageReference().getParameters().put('rid', tt.dealer__Service_Job_Line__r.dealer__Service_Repair_Order__c);
            System.currentPageReference().getParameters().put('dealer__Type__c', 'Freight');
            System.currentPageReference().getParameters().put('dealer__Amount__c', '100');

            ServiceROTransports srt = new ServiceROTransports();

            Test.startTest();
            srt.createMisc();

            // Delete Misc
            PageReference sro = Page.ServiceTRS;
            Test.setCurrentPage(sro);

            ApexPages.currentPage().getParameters().put('Id', m.Id);
            ApexPages.currentPage().getParameters().put('dealer__Service_Job_Lines__c', tt.dealer__Service_Job_Line__c);
            ApexPages.currentPage().getParameters().put('rId', tt.dealer__Service_Job_Line__r.dealer__Service_Repair_Order__c);

            ServiceROTRansports srt2 = new ServiceROTransports();
            srt2.deleteMisc();
            Test.stopTest();

            //srt.updateMisc();
            //srt.deleteMisc();
            //
        }

    }

    static testmethod void testMisc2() {

        User u = [Select Id from User where username = 'testuser128@testorgx.com'];
        System.runAs(u) {

            dealer__Service_Misc_Charge__c smc = new dealer__Service_Misc_Charge__c();
            smc.Type__c = 'Freight';
            smc.Service_Job_Lines__c = [Select Id from dealer__Service_Job__c limit 1].Id;
            smc.Amount__c = 11;
            insert smc;

            dealer__Technician_Job_Time__c tt = [Select Id, dealer__Service_Job_Line__c,
                dealer__Service_Job_Line__r.dealer__Service_Repair_Order__c
                from dealer__Technician_Job_Time__c where
                dealer__Service_Job_Line__r.dealer__Service_Repair_Order__r.dealer__Posted_Date_Time__c = null limit 1
            ];
            dealer__Service_Misc_Charge__c m = [Select Id from dealer__Service_Misc_Charge__c limit 1];

            PageReference sro = Page.ServiceTRS;
            Test.setCurrentPage(sro);

            ApexPages.currentPage().getParameters().put('Id', m.Id);
            ApexPages.currentPage().getParameters().put('dealer__Service_Job_Lines__c', tt.dealer__Service_Job_Line__c);
            ApexPages.currentPage().getParameters().put('rId', tt.dealer__Service_Job_Line__r.dealer__Service_Repair_Order__c);

            // for update
            ApexPages.currentPage().getParameters().put('dealer__Amount__c', '100');
            ApexPages.currentPage().getParameters().put('dealer__Type__c', 'Freight');
            ServiceROTransports srt1 = new ServiceROTransports();


        }
    }

    static testmethod void testPartsCRUD() {
        User u = [Select Id from User where username = 'testuser128@testorgx.com'];
        System.runAs(u) {


            dealer__FixedOperationsSettings__c fs = dealer__FixedOperationsSettings__c.getOrgDefaults();
            fs.dealer__Parts_Inventory_Control_Method__c = 'FIFO';
            fs.dealer__DO_NOT_Run_Managed_RO_Trigger__c = true;
            upsert fs;
            // dealer__Parts_Inventory_Control_Method__c

            dealer__Service_Job__c sjob = [Select Id from dealer__Service_Job__c limit 1];
            dealer__Parts_Master__c pm = TestClassUtil.insertPartsMaster();
            dealer__Dealer_Location__c loc = [Select Id from dealer__Dealer_Location__c limit 1];
            dealer__Parts_Inventory__c pinv = TestClassUtil.insertPartInventory(pm.Id, loc.Id);

            Test.startTest(); //W-000811

            PageReference sro = Page.ServiceTRS;
            Test.setCurrentPage(sro);

            ApexPages.currentPage().getParameters().put('rid', sjob.Id);
            ApexPages.currentPage().getParameters().put('QTY', '1');
            ApexPages.currentPage().getParameters().put('PartInventoryId', pinv.Id);
            ApexPages.currentPage().getParameters().put('SalePrice', '90.99');
            // ApexPages.currentPage().getParameters().put('Order', '0');

            ServiceROTransports st = new ServiceROTransports();
            st.createPartLine();
            
            Test.stopTest(); //W-000811
        }
    }

    static testMethod void testCreateOnOrder() {
        User u = [Select Id from User where username = 'testuser128@testorgx.com'];
        System.runAs(u) {

            dealer__FixedOperationsSettings__c fs = dealer__FixedOperationsSettings__c.getOrgDefaults();
            fs.dealer__Parts_Inventory_Control_Method__c = 'FIFO';
            fs.dealer__DO_NOT_Run_Managed_RO_Trigger__c = true;
            upsert fs;
            // dealer__Parts_Inventory_Control_Method__c

            dealer__Service_Job__c sjob = [Select Id from dealer__Service_Job__c limit 1];
            dealer__Parts_Master__c pm = TestClassUtil.insertPartsMaster();
            dealer__Dealer_Location__c loc = [Select Id from dealer__Dealer_Location__c limit 1];
            dealer__Parts_Inventory__c pinv = TestClassUtil.insertPartInventory(pm.Id, loc.Id);

            dealer__Service_Misc_Charge__c smc = new dealer__Service_Misc_Charge__c();
            smc.Type__c = 'parts';
            smc.Service_Job_Lines__c = [Select Id from dealer__Service_Job__c limit 1].Id;
            smc.Amount__c = 11;
            insert smc;

            Test.startTest(); //W-000811

            PageReference sro = Page.ServiceTRS;
            Test.setCurrentPage(sro);

            ApexPages.currentPage().getParameters().put('rid', sjob.Id);
            ApexPages.currentPage().getParameters().put('QTY', '3');
            ApexPages.currentPage().getParameters().put('PartInventoryId', pinv.Id);
            ApexPages.currentPage().getParameters().put('SalePrice', '90.99');
            // ApexPages.currentPage().getParameters().put('Order', '0');

            ServiceROTransports st = new ServiceROTransports();
            st.createPartLine();
            pinv = [SELECT Id, Name, dealer__On_Order__c, dealer__On_Hand__c FROM dealer__Parts_Inventory__c WHERE Id =: pinv.Id];
            system.assertEquals(2, pinv.On_Order__c );
            system.assertEquals(-2, pinv.On_Hand__c);
            Test.stopTest(); //W-000811


        }

    }

    static testMethod void testUpdateOnOrder() {
            User u = [Select Id from User where username = 'testuser128@testorgx.com'];
            System.runAs(u) {
            
            dealer__FixedOperationsSettings__c fs = dealer__FixedOperationsSettings__c.getOrgDefaults();
            fs.dealer__Parts_Inventory_Control_Method__c = 'FIFO';
            fs.dealer__DO_NOT_Run_Managed_RO_Trigger__c = true;
            upsert fs;
            // dealer__Parts_Inventory_Control_Method__c

            dealer__Service_Job__c sjob = [Select Id from dealer__Service_Job__c limit 1];
            dealer__Parts_Master__c pm = TestClassUtil.insertPartsMaster();
            dealer__Dealer_Location__c loc = [Select Id from dealer__Dealer_Location__c limit 1];
            dealer__Parts_Inventory__c pinv = TestClassUtil.insertPartInventory(pm.Id, loc.Id);

            //Add Part Line
            
            PageReference sro = Page.ServiceTRS;
            Test.setCurrentPage(sro);
            ApexPages.currentPage().getParameters().put('rid', sjob.Id);
            ApexPages.currentPage().getParameters().put('QTY', '3');
            ApexPages.currentPage().getParameters().put('PartInventoryId', pinv.Id);
            ApexPages.currentPage().getParameters().put('SalePrice', '90.99');

            ServiceROTransports st = new ServiceROTransports();
        }
    }

    static testmethod void testActions() {

        User u = [Select Id from User where username = 'testuser128@testorgx.com'];
        System.runAs(u) {

            test.startTest();

            dealer__Service_Repair_Order__c dsr = [select id from dealer__Service_Repair_Order__c where dealer__Invoiced_Date_Time__c = null limit 1];

            
            dealer__Service_Job__c dsj = new dealer__Service_Job__c();
            dsj.dealer__Cause__c = 'Test';
            dsj.dealer__Labor_Charges__c = 12;
            dsj.dealer__Service_Repair_Order__c = dsr.id;
            dsj.dealer__Labor_Type__c = 'c';
            dsj.dealer__Labor_Rate__c = 'Test';
            dsj.dealer__Misc_Charges__c = 11;
            dsj.dealer__Concern__c = 'test';
            dsj.dealer__CustomerConcern__c = 'test';
            dsj.dealer__Correction__c = 'test';
            dsj.dealer__Op_Code__c = '71232';
            //dsj.dealer__Line_Total__c=12;
            dsj.dealer__Parts_Total__c = 7;
            dsj.dealer__Service_Type__c = 'MR';
            dsj.dealer__Line_Number__c = 1;
            //dsj.dealer__Operation_Code_Description__c='Test';
            dsj.dealer__Stat__c = 'Open';
            dsj.dealer__Technician__c = UserInfo.getuserid();
            dsj.dealer__Book_Time__c = 11;
            dsj.dealer__Line_Number__c = 1;
            insert dsj;

            dealer__Parts_Master__c partsMaster = TestClassUtil.insertPartsMaster();

            System.currentPageReference().getParameters().put('QTY', '2');
            System.currentPageReference().getParameters().put('lid', dsj.id);
            System.currentPageReference().getParameters().put('SalePrice', '2');
            System.currentPageReference().getParameters().put('Order', '2');
            System.currentPageReference().getParameters().put('rid', dsr.id);
            System.currentPageReference().getParameters().put('dealer__Actual_Time_Entry__c', '2');
            System.currentPageReference().getParameters().put('dealer__Date__c', '8/8/2015');
            System.currentPageReference().getParameters().put('Labor_Total__c', '2');
            System.currentPageReference().getParameters().put('dealer__Technician__c[Id]', u.Id);


            System.currentPageReference().getParameters().put('Labor_Total__c', '2');
            ServiceROTransports srt = new ServiceROTransports();

            //srt.createTechTime();
            dealer__Technician_Job_Time__c tt = [Select Id from dealer__Technician_Job_Time__c where dealer__Job_Status__c = 'Open' limit 1];
            
            dealer__Service_Misc_Charge__c smc = new dealer__Service_Misc_Charge__c();
            smc.Type__c = 'test';
            smc.Service_Job_Lines__c = [Select Id from dealer__Service_Job__c limit 1].Id;
            smc.Amount__c = 11;
            insert smc;

            srt.updateTechTime(tt.Id, 1.9, Date.today(), 1.0, 99, '');

            test.stopTest();
        }
    }

    static testmethod void testAggregates() {

        User u = [Select Id from User where username = 'testuser128@testorgx.com'];
        System.runAs(u) {

            dealer__Service_Repair_Order__c dsr = [select id from dealer__Service_Repair_Order__c where dealer__Invoiced_Date_Time__c = null limit 1];

            dealer__Service_Job__c dsj = new dealer__Service_Job__c();
            dsj.dealer__Cause__c = 'Test';
            dsj.dealer__Labor_Charges__c = 12;
            dsj.dealer__Service_Repair_Order__c = dsr.id;
            dsj.dealer__Labor_Type__c = 'C';
            dsj.dealer__Labor_Rate__c = 'Test';
            dsj.dealer__Misc_Charges__c = 11;
            dsj.dealer__Concern__c = 'test';
            dsj.dealer__CustomerConcern__c = 'test';
            dsj.dealer__Correction__c = 'test';
            dsj.dealer__Op_Code__c = '71232';
            //dsj.dealer__Line_Total__c=12;
            dsj.dealer__Parts_Total__c = 7;
            dsj.dealer__Service_Type__c = 'MR';
            dsj.dealer__Line_Number__c = 1;
            //dsj.dealer__Operation_Code_Description__c='Test';
            dsj.dealer__Stat__c = 'Closed';
            dsj.dealer__Technician__c = UserInfo.getuserid();
            dsj.dealer__Book_Time__c = 11;
            dsj.dealer__Line_Number__c = 1;
            insert dsj;

            ServiceROTransports srt = new ServiceROTransports();

            Test.startTest();
            srt.lineTotalMisc(dsj.id);
            srt.lineTotalParts(dsj.id);
            srt.lineTotalLabor(dsj.id);
            srt.saveAction();

            Test.stopTest();

        }

    }

    @isTest
    static void testCreateMiscChargeLines() {

        User u = [Select Id from User where username = 'testuser128@testorgx.com'];
        System.runAs(u) {
            

            dealer__Technician_Job_Time__c tt = [SELECT Id, dealer__Service_Job_Line__c FROM dealer__Technician_Job_Time__c WHERE dealer__Service_Job_Line__r.dealer__Service_Repair_Order__r.dealer__Posted_Date_Time__c = null LIMIT 1];

            dealer__Service_Misc_Charge__c smc = new dealer__Service_Misc_Charge__c();
            smc.Type__c = 'test';
            smc.Service_Job_Lines__c = [Select Id from dealer__Service_Job__c limit 1].Id;
            smc.Amount__c = 11;
            insert smc;

            System.currentPageReference().getParameters().put('Id', tt.Id);
            System.currentPageReference().getParameters().put('lid', tt.dealer__Service_Job_Line__c);
            System.currentPageReference().getParameters().put('dealer__Technician__c[Id]', u.Id);

            System.currentPageReference().getParameters().put('dealer__Actual_Time_Entry__c', '1');
            System.currentPageReference().getParameters().put('dealer__Book_Time_Entry__c', '1');
            System.currentPageReference().getParameters().put('dealer__Date__c', '09/05/2015');
            System.currentPageReference().getParameters().put('dealer__Payment_Method_Labor_Rate__c', '15');


            Test.startTest();

            ServiceROTransports srt = new ServiceROTransports();

            srt.createTechTime();

            Test.stopTest();
        }
    }

    @isTest
    static void testGetPicklistValues() {

        User u = [Select Id from User where username = 'testuser128@testorgx.com'];
        System.runAs(u) {

            System.currentPageReference().getParameters().put('object', 'dealer__Service_Job__c');
            System.currentPageReference().getParameters().put('field', 'dealer__Service_Type__c');
           
            Test.startTest();

            ServiceROTransports srt = new ServiceROTransports();

            srt.trans = 'PicklistValues';
            srt.getPicklistValues();

            Test.stopTest();
        }


    }
    

    /**
     * Verify status changes to Cashier after Declined
     * @note These routines are removed as they are not logically testing the business use case.  It was identified that forcing the status to cashier was not ideal for the clients who had custom triggers on RO Header.
     
    @isTest static void testCashierStatusDeclined() {
        Id sroId = [SELECT ID FROM dealer__Service_Repair_Order__c WHERE dealer__Mileage_In__c = 13 LIMIT 1].Id;
        dealer__Service_Job__c dsj = [Select Id from dealer__Service_Job__c WHERE dealer__Stat__c = 'Declined'
            LIMIT 1
        ];


        ServiceROTransports srt = new ServiceROTransports();

        System.currentPageReference().getParameters().put('id', dsj.Id);
        System.currentPageReference().getParameters().put('rid', sroId);
        System.currentPageReference().getParameters().put('dealer__Repair_Order_Id__c', sroId);
        System.currentPageReference().getParameters().put('dealer__Stat__c', 'Declined');

        Test.startTest();
        srt.updateLine();
        Test.stopTest();

        List < dealer__Service_Repair_Order__c > sro = [SELECT ID, dealer__Status__c FROM
            dealer__Service_Repair_Order__c WHERE dealer__Mileage_In__c = 13 LIMIT 1
        ];
        // System.assertEquals('Cashier', sro[0].dealer__Status__c);

    }

    /**
     * Verify status changes to Cashier after Completed
     * @note These routines are removed as they are not logically testing the business use case.  It was identified that forcing the status to cashier was not ideal for the clients who had custom triggers on RO Header.
     
    @isTest static void testCashierStatusComplete() {
        Id sroId = [SELECT Id, dealer__RO_Number__c FROM dealer__Service_Repair_Order__c WHERE dealer__Mileage_In__c = 16 LIMIT 1].Id;
        dealer__Service_Job__c dsj = [Select Id from dealer__Service_Job__c WHERE dealer__Stat__c = 'Complete'
            LIMIT 1
        ];


        ServiceROTransports srt = new ServiceROTransports();

        System.currentPageReference().getParameters().put('id', dsj.Id);
        System.currentPageReference().getParameters().put('rid', sroId);
        System.currentPageReference().getParameters().put('dealer__Repair_Order_Id__c', sroId);

        System.currentPageReference().getParameters().put('dealer__Stat__c', 'Declined');
        Test.startTest();
        srt.updateLine();
        Test.stopTest();

        List < dealer__Service_Repair_Order__c > sro = [SELECT ID, dealer__RO_Number__c, dealer__Status__c
            FROM dealer__Service_Repair_Order__c WHERE
            dealer__Mileage_In__c = 16 LIMIT 1
        ];
        // System.assertEquals('Cashier', sro[0].dealer__Status__c);

    }
    */

}