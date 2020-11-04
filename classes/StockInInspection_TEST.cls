@isTest
private class StockInInspection_TEST {

    @testSetup static void testDataInit() {
        
        TestClassUtil tu = new TestClassUtil();
        tu.insertDMSSettings();

        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
        Profile prof = [select id from profile where name='system Administrator'];
        User usr = new User(alias = 'usr', email='us.name@vmail.com',
                  emailencodingkey='UTF-8', lastname='lstname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='testuser128@testorgx.com',
                  Division='DT1');
        insert usr; 

    }
    
    @isTest static void test_method_one() {
        
        User u = [Select Id from User where Username = 'testuser128@testorgx.com' limit 1];
        System.runAs(u) {

        dealer__Appraisal__c appraisal = new dealer__Appraisal__c();
        
        dealer__Service_Vehicle__c svcVeh = new dealer__Service_Vehicle__c();
        svcVeh.dealer__Vin__c = '2C4RDGCG4DR687666';
        svcVeh.dealer__Year__c = '2013';
        svcVeh.dealer__Make__c = 'Dodge';
        svcVeh.dealer__Carline__c = 'Grand Caravan';
        svcVeh.dealer__Trim_Level__c = 'SXT';
        svcVeh.dealer__Last_Odometer__c = 123456;
        svcVeh.dealer__Body_Type__c = 'Mini-Van';
        svcVeh.dealer__Licence__c = '123dfd';
        try{
            insert svcVeh;
        }catch(Exception e){
        
        }
        
        dealer__Sales_Up__c salesUp = new dealer__Sales_Up__c();
        salesUp.dealer__LastName__c = 'Test SUP';
        salesUp.dealer__Lead_Status__c = 'Open';
        salesUp.dealer__Lead_Type__c = 'Phone';
        salesUp.dealer__Lead_Date__c = System.today();
        salesUp.dealer__Trade_VIN__c = '2C4RDGCG4DR687666';
        salesUp.dealer__Trade_Year__c = '2056';
        salesUp.dealer__Trade_Make__c = 'MARS';
        salesUp.dealer__Trade_Model__c = 'THING';
        try{
            insert salesUp;
        }catch(Exception e){
        
        }
        
        dealer__Appraisal_Vehicle__c apprVeh = new dealer__Appraisal_Vehicle__c();
        apprVeh.dealer__Sales_Up__c = salesUp.id;
        apprVeh.dealer__Service_Vehicle__c = svcVeh.id;
        apprVeh.dealer__VIN__c = salesUp.dealer__Trade_VIN__c;
        apprVeh.dealer__Year__c = salesUp.dealer__Trade_Year__c;
        apprVeh.dealer__Make__c = salesUp.dealer__Trade_Make__c;
        apprVeh.dealer__Model__c = salesUp.dealer__Trade_Model__c;
        
        try{
            insert apprVeh;
        }catch(Exception e){
        
        }
        
        Account acc = new Account();
        acc.Name = 'Test Account';
        try{
            insert acc;
        }catch(Exception e){
        
        }
        
        
        PageReference pageRef = Page.vehicleInspection;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('sid',salesUp.id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(appraisal);
        StockInInspection stockAppraisal = new StockInInspection(sc);
        
        stockAppraisal.stockNumber = '123321';
        stockAppraisal.door = 'Test Door';
        stockAppraisal.tire = 'Test Tire';
        stockAppraisal.brake = 'Test Brake';
        stockAppraisal.interior = 'Test Int';
        stockAppraisal.mechanical = 'Test Mech';
        stockAppraisal.wheel = 'Test Wheel';
        stockAppraisal.passengerrear_wheel = 'Test FW';
        
        
        test.startTest();   
        
        stockAppraisal.saveInspection();
        
        stockAppraisal.getFields();
        stockAppraisal.getServiceVehicles();
        stockAppraisal.getPreviousAppraisals();
        
        stockAppraisal.saveInspectionReportLine();
        stockAppraisal.calcAppraialValue();
        stockAppraisal.getInspectionReportLines();
        stockAppraisal.saveAndCloseInspection();

        stockAppraisal.serviceVeh = svcVeh;
        stockAppraisal.stockInServiceVehicle();
        stockAppraisal.pOrder.Vendor__c = acc.id;
        stockAppraisal.createPurchaseOrder();
        stockAppraisal.getContactPhone();
        stockAppraisal.changeVehicle();
        stockAppraisal.getInvoiceLogo();
        
        try{
            StockInInspection.decodedVin('2C4RDGCG4DR687666');
        }catch(Exception e){
        
        }
        
        test.stopTest();

        }
    }
    
    @isTest static void test_method_two() {

        User u = [Select Id from User where Username = 'testuser128@testorgx.com' limit 1];
        System.runAs(u) {        
        
        test.startTest();
        
        dealer__Service_Vehicle__c svcVeh = new dealer__Service_Vehicle__c();
        svcVeh.dealer__Vin__c = '2C4RDGCG4DR687666';
        svcVeh.dealer__Year__c = '2013';
        svcVeh.dealer__Make__c = 'Dodge';
        svcVeh.dealer__Carline__c = 'Grand Caravan';
        svcVeh.dealer__Trim_Level__c = 'SXT';
        svcVeh.dealer__Last_Odometer__c = 123456;
        svcVeh.dealer__Body_Type__c = 'Mini-Van';
        svcVeh.dealer__Licence__c = '123dfd';
        try{
            insert svcVeh;
        }catch(Exception e){
        
        }
        
        Account acc = new Account();
        acc.Name = 'Test Account';
        try{
            insert acc;
        }catch(Exception e){
        
        }
        
        dealer__Inspection_Report__c inspection = new dealer__Inspection_Report__c();
        insert inspection;
        
        dealer__Inspection_Report_Lines__c inspectionReportLine1 = new dealer__Inspection_Report_Lines__c();
        inspectionReportLine1.dealer__Inspection_Report__c = inspection.Id;
        inspectionReportLine1.dealer__Repair_Type__c = 'Body/Glass';
        insert inspectionReportLine1;
        
        dealer__Inspection_Report_Lines__c inspectionReportLine2 = new dealer__Inspection_Report_Lines__c();
        inspectionReportLine2.dealer__Inspection_Report__c = inspection.Id;
        inspectionReportLine2.dealer__Repair_Type__c = 'Doors';
        insert inspectionReportLine2;
        
        dealer__Inspection_Report_Lines__c inspectionReportLine3 = new dealer__Inspection_Report_Lines__c();
        inspectionReportLine3.dealer__Inspection_Report__c = inspection.Id;
        inspectionReportLine3.dealer__Repair_Type__c = 'Wheels';
        insert inspectionReportLine3;
        
        dealer__Inspection_Report_Lines__c inspectionReportLine4 = new dealer__Inspection_Report_Lines__c();
        inspectionReportLine4.dealer__Inspection_Report__c = inspection.Id;
        inspectionReportLine4.dealer__Repair_Type__c = 'Tires';
        insert inspectionReportLine4;
        
        dealer__Inspection_Report_Lines__c inspectionReportLine5 = new dealer__Inspection_Report_Lines__c();
        inspectionReportLine5.dealer__Inspection_Report__c = inspection.Id;
        inspectionReportLine5.dealer__Repair_Type__c = 'Brakes';
        insert inspectionReportLine5;
        
        dealer__Inspection_Report_Lines__c inspectionReportLine6 = new dealer__Inspection_Report_Lines__c();
        inspectionReportLine6.dealer__Inspection_Report__c = inspection.Id;
        inspectionReportLine6.dealer__Repair_Type__c = 'Interior';
        insert inspectionReportLine6;
        
        dealer__Inspection_Report_Lines__c inspectionReportLine7 = new dealer__Inspection_Report_Lines__c();
        inspectionReportLine7.dealer__Inspection_Report__c = inspection.Id;
        inspectionReportLine7.dealer__Repair_Type__c = 'Mechanical';
        insert inspectionReportLine7;
        
        
        dealer__Appraisal__c appraisal = new dealer__Appraisal__c();
        
        appraisal.dealer__Service_Vehicle__c = svcVeh.id;
        appraisal.dealer__Inspection_Report__c = inspection.id;
        insert appraisal;
        
        dealer__Sales_Up__c salesUp = new dealer__Sales_Up__c();
        salesUp.dealer__LastName__c = 'Test SUP';
        salesUp.dealer__Lead_Status__c = 'Open';
        salesUp.dealer__Lead_Type__c = 'Phone';
        salesUp.dealer__Lead_Date__c = System.today();
        salesUp.dealer__Trade_VIN__c = '2C4RDGCG4DR687666';
        salesUp.dealer__Trade_Year__c = '2056';
        salesUp.dealer__Trade_Make__c = 'MARS';
        salesUp.dealer__Trade_Model__c = 'THING';
        try{
            insert salesUp;
        }catch(Exception e){
        
        }
        
        
        ApexPages.StandardController sc = new ApexPages.StandardController(appraisal);
        StockInInspection stockAppraisal = new StockInInspection(sc);
        
        stockAppraisal.supId = salesUp.Id;
        stockAppraisal.getInspectionReportLines();
        stockAppraisal.getPreviousAppraisals();
        stockAppraisal.fetchServiceVehInfo();
        stockAppraisal.serviceVeh = svcVeh;
        stockAppraisal.pOrder.Vendor__c = acc.id;
        stockAppraisal.stockNumber = '1233211';
        stockAppraisal.stockInServiceVehicles();
        ApexPages.currentPage().getParameters().put('recEditId',inspectionReportLine1.Id);
        ApexPages.currentPage().getParameters().put('RecId',inspectionReportLine2.Id);
        stockAppraisal.EditLineItem();
        stockAppraisal.updateIRL();
        stockAppraisal.deleteLineItem();
        
        stockAppraisal.updateInspectionReportLine();
        stockAppraisal.saveInspectionRLPopup();
        
        
        test.stopTest();

        }
    }   
    
    @isTest static void test_method_three() {

        User u = [Select Id from User where Username = 'testuser128@testorgx.com' limit 1];
        System.runAs(u) {        
        
        test.startTest();
        
        dealer__Appraisal__c appraisal = new dealer__Appraisal__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(appraisal);
        StockInInspection stockAppraisal = new StockInInspection(sc);
        try{
            stockAppraisal.saveAndCloseInspection();
        }catch(Exception e){
        
        }
        
        stockAppraisal.vinNumber = '2C4RDGCG4DR687666';
        stockAppraisal.fetchServiceVehFromVIN();
        
        test.stopTest();

        }
    }
    
    @isTest static void test_method_four() {

        User u = [Select Id from User where Username = 'testuser128@testorgx.com' limit 1];
        System.runAs(u) {        
        
        test.startTest();
        
        dealer__Appraisal__c appraisal = new dealer__Appraisal__c();
        PageReference pageRef = Page.vehicleInspection;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(appraisal);
        StockInInspection stockAppraisal1 = new StockInInspection(sc);
        StockInInspection stockAppraisal2 = new StockInInspection(sc);
        StockInInspection stockAppraisal3 = new StockInInspection(sc);
        StockInInspection stockAppraisal4 = new StockInInspection(sc);
        StockInInspection stockAppraisal5 = new StockInInspection(sc);
        
        try{
            stockAppraisal1.saveInspection();
        }catch(Exception e){
        
        }
        
        stockAppraisal1.inspectionReportLine.dealer__Repair_Type__c = 'Body/Glass';
        stockAppraisal1.saveInspectionReportLine();
        
        stockAppraisal2.inspectionReportLine.dealer__Repair_Type__c = 'Tires';
        stockAppraisal2.saveInspectionReportLine();
        
        stockAppraisal3.inspectionReportLine.dealer__Repair_Type__c = 'Brakes';
        stockAppraisal3.saveInspectionReportLine();
        
        stockAppraisal4.inspectionReportLine.dealer__Repair_Type__c = 'Interior';
        stockAppraisal4.saveInspectionReportLine();
        
        stockAppraisal5.inspectionReportLine.dealer__Repair_Type__c = 'Mechanical';
        stockAppraisal5.saveInspectionReportLine();
        
        test.stopTest();

        }   
    }
}