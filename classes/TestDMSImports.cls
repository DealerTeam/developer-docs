@isTest
public with sharing class TestDMSImports {
    static testmethod void testDMSIMports(){
        TestClassUtil util = new TestClassUtil();
        dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        if(dms == null){
            util.insertDMSSettings();   
        }
        String accJSON = '[{"LastName":"Test", "dealer__External_ID__c": "acctest1"}]';
        String locJSON = '[{"Name":"Test", "dealer__Company_Number__c": "loc1"}]';
        String sopcodeJSON = '[{"Name":"opcodetest1", "dealer__Op_Code__c": "opcodetest1"}]';
        String vehJSON = '[{"Name":"Vehtest1","dealer__Make__c":"Make", "dealer__MOdel__c":"Model","dealer__Stock_Number__c":"StockNum", "dealer__Year__c":"2003", "dealer__VIN__c": "1FUJA6BG62LJ39929"}]';
        String sroJSON = '[{"Name": "SROtest1","dealer__Mileage_In__c":"0","dealer__RO_Number__c":"rotest1"}]';
        String dealJSON ='[{"Name":"dealtest1","dealer__Deal_Id__c":"dealtest1Id"}]';
        String partsMasterJSON ='[{"Name":"testpm","dealer__Retail_Price__c": "100", "dealer__Manufacturer__c":"manu"}]';
        Test.startTest();
        System.enqueueJob(new DMSImportsQueable('Account',accJSON));
        System.enqueueJob(new DMSImportsQueable('dealer__Dealer_Location__c',locJSON));
        System.enqueueJob(new DMSImportsQueable('dealer__StandardOpCode__c',sopcodeJSON));
        System.enqueueJob(new DMSImportsQueable('dealer__Vehicle_Inventory__c',vehJSON));
        System.enqueueJob(new DMSImportsQueable('dealer__Service_Repair_Order__c',sroJSON));
        System.enqueueJob(new DMSImportsQueable('dealer__Deal__c',dealJSON));
        System.enqueueJob(new DMSImportsQueable('dealer__Parts_Master__c',partsMasterJSON));
        
        Service_Vehicle__c[] sv = New List<Service_Vehicle__c>{new Service_Vehicle__c(Vin__c = '1G6KD54Y4YU221294', Customer_Key__c = 'acctest1')};
        System.enqueueJob(new DMSImportsQueable('dealer__Service_Vehicle__c',JSON.serialize(sv)));

        Service_Repair_Order__c sro = new Service_Repair_Order__c(RO_Number__c='1000', Mileage_In__c = 100);
        insert sro;

        String sroLineJSON = '[{"Service_Repair_Order__c":"1000"}]';
        System.enqueueJob(new DMSImportsQueable('dealer__Service_Job__c',sroLineJSON));
        
        Deal__c deal = new Deal__c(Deal_Id__c='1000');
        insert deal;
        
        String salesFeeJSON = '[{"dealer__Car_Deal__c":"1000"}]';
        System.enqueueJob(new DMSImportsQueable('dealer__Sales_Fee__c',salesFeeJSON));

        String tradeJSON = '[{"dealer__Car_Deal__c":"1000"}]';
        System.enqueueJob(new DMSImportsQueable('dealer__Trade_In__c',salesFeeJSON));

        Parts_Master__c pm = new Parts_Master__c(Name='testpi',Manufacturer__c='mfg', Retail_Price__c= 100);
        insert pm;

        String partsInventoryJSON = '[{"dealer__Parts_Master__c":"'+pm.Id+'"}]';
        System.enqueueJob(new DMSImportsQueable('dealer__Parts_Inventory__c',partsInventoryJSON));

        

        Test.stopTest();
    }
    static testmethod void testDMSImportsPUT(){
        RestRequest request = new RestRequest();
        RestContext.request = request;
        RestContext.response = new System.RestResponse();
        request.requestUri = '/dms/import/';
        request.httpMethod = 'PUT';
        request.requestBody=Blob.valueOf('{"objectApiName": "Account", "objectJSON": "[{\'AccountNumber\':\'3\',\'dealer__External_Id__c\':\'43\',\'FirstName\':\'Anita\',\'LastName\':\'Ciotte\'}]"}');
        Test.startTest();
        DMSImportsRESTService.createRecords();
        Test.stopTest();
    }

    static testmethod void testDMSImportsDELETE(){
        Vehicle_Inventory__c [] vehInv = new List<Vehicle_Inventory__c>{new Vehicle_Inventory__c(VIN__c = '12345678901234567', Stock_Number__c = 'a123', Year__c = '2020', Make__c = 'Make', Model__c = 'Model')};
        insert vehInv;

        DMSImportsRestService.objectWrapper wrapper = new DMSImportsRestService.objectWrapper();
        wrapper.objectApiName = 'dealer__Vehicle_Inventory__c';
        wrapper.objectJSON = JSON.serialize(vehInv);
        wrapper.recordCount = 1;
        wrapper.action = 'action';

        RestRequest request = new RestRequest();
        RestContext.request = request;
        RestContext.response = new System.RestResponse();
        request.requestUri = '/dms/import/';
        request.addParameter('body', JSON.serialize(wrapper));
        request.httpMethod = 'DELETE';
        Test.startTest();
        DMSImportsRESTService.deleteRecord();
        Test.stopTest();

        Vehicle_Inventory__c [] vList = [SELECT Id FROM Vehicle_Inventory__c];
        System.assertEquals(0, vList.size(), 'Vehicle Inventory record should have been deleted');
    }

    static testmethod void testBatchCleanRecords() {
        Account acct = new Account(FirstName = 'Test', LastName = 'Test', External_Id__c='123');
        insert acct;
        Test.startTest();
        String accountJSON = '[{"dealer__External_Id__c": "456"}]';
        DMSBatchCleanRecords b = new DMSBatchCleanRecords('Account',accountJSON);
		Id batchId = Database.executeBatch(b, 1);
        Test.stopTest(); 
        system.assert([SELECT Id, External_Id__c FROM Account LIMIT 1].External_Id__c == null, 'Account External Id should have been nulled out.');
    }
}