@isTest
public with sharing class Test_VehicleEquipmentViewControl {
    @testSetup static void insertData(){
        Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
        Profile prof = [select id from profile where name='system Administrator'];
        User usr = new User(alias = 'usr', email='us.name@vmailtest342s.com',
        emailencodingkey='UTF-8', lastname='lstname',
        timezonesidkey='America/Los_Angeles',
        languagelocalekey='en_US',
        localesidkey='en_US', profileid = prof.Id,
        username='testuser128@testorgvmailtest342s.com',
        Division='DT1');
        insert usr;  

        System.runAs(usr) {
            Vehicle_Inventory__c vehInv = (Vehicle_Inventory__c)TestFactory.createSObject(new Vehicle_Inventory__c( Name = 'Test Vehicle Inventory',
                    Model__c = '2014',Stock_Number__c = '2014',VIN__c = '100',Company_Number__c = 'Location 1',
                    Year__c = '2014',Make__c = '2014' ), true);
        }
    }
    @isTest
    static void testClassicMethods(){
        //if we pass either a service vehicle Id or Vehicle Inventory Id no errors should be thrown
        //Service Vehicle Standard Controller
        Service_Vehicle__c sv = [SELECT Id FROM Service_Vehicle__c Limit 1];
        pageReference pr = page.VehicleEquipmentView_SV;
        pr.getParameters().put('id',sv.Id);
        test.setCurrentPage(pr);
        VehicleEquipmentViewControl controller = new VehicleEquipmentViewControl();
        system.assertEquals(0,controller.totalRecords);//Test data for big objects needs to be done via a mock Object. See StubAPI.

        // Vehicle Inventory
        Vehicle_Inventory__c vi = [SELECT ID From Vehicle_Inventory__c LIMIT 1];
        pr = page.VehicleEquipmentView_VI;
        pr.getParameters().put('id',vi.Id);
        test.setCurrentPage(pr);
        controller = new VehicleEquipmentViewControl();
        system.assertEquals(0,controller.totalRecords);

        //Invalid id should throw friendly error 
        Id badId = [SELECT Id FROM Dealer_Location__c LIMIT 1].Id;
        pr = page.VehicleEquipmentView_VI;
        pr.getParameters().put('id',badId);
        try{
            test.setCurrentPage(pr);
            controller = new VehicleEquipmentViewControl();
        } catch (Exception e){
            system.assertEquals('Invalid Id with type: dealer__Dealer_Location__c. Expected either a dealer__Vehicle__Inventory__c or dealer__Service_Vehicle__c Id.',e.getMessage());
        }
    }
    @isTest
    static void testLEXMethods(){
        Service_Vehicle__c sv = [SELECT Id FROM Service_Vehicle__c Limit 1];
        String resJSON = VehicleEquipmentViewControl.CreateEquipmentTable(sv.Id);
        VehicleEquipmentViewControl.DataTableResponse dataTable = (VehicleEquipmentViewControl.DataTableResponse)JSON.deserialize(resJSON,VehicleEquipmentViewControl.DataTableResponse.class);
        system.assertEquals(0,dataTable.data.size()); // Not utilizing Big object data yet.
        system.assertEquals(5,dataTable.columns.size());  
    }
}