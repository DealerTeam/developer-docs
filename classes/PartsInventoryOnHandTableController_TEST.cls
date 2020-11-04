@isTest
public with sharing class PartsInventoryOnHandTableController_TEST {

    @TestSetup
    static void makeData(){

        dealer.installScriptOrgAPI.createVdcSetting();

        Profile prof = [select id from profile where name='system Administrator'];
        User usr = new User(alias = 'usr', email='us.name@vmail.com',
                  emailencodingkey='UTF-8', lastname='lstname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='testuser128@testorgx.com',
                  Division='DT1');
        insert usr; 

        dealer__Dealer_Location__c objLocation = new dealer__Dealer_Location__c();
            objLocation.Name = 'Test Location';
            objLocation.dealer__Company_Number__c=usr.Division;
            objLocation.dealer__City__c='ABSD';
            objLocation.dealer__State__c='NY';
            objLocation.dealer__Postal_Code__c='1234';
            objLocation.dealer__Default_Rate__c = 9.9;
        upsert objLocation;

        dealer__Parts_Master__c pm = new dealer__Parts_Master__c();
            pm.Name = 'FL1A__TEST_PART';
            pm.dealer__Retail_Price__c = 99.99;
            pm.Manufacturer__c = 'FD';
            pm.Cost__c = 1;
        insert pm;

        dealer__Parts_Inventory__c inventory = new dealer__Parts_Inventory__c();
            inventory.dealer__Part_No__c = '9963777777';
            inventory.dealer__Description__c = 'FL1A Test Part';
            inventory.dealer__Cost__c = 5;
            inventory.dealer__List__c = 10;
            inventory.dealer__MFG__c = 'FD';
            inventory.dealer__Parts_Master__c = pm.Id;
            inventory.dealer__Location__c= objLocation.Id;      
            inventory.dealer__On_Hand__c = 60;
        upsert inventory;
    }

    static testMethod void testSearchPart() {

        Id masterId = [SELECT Id FROM Parts_Master__c WHERE Manufacturer__c = 'FD'].Id;
        Id partId = [SELECT Id FROM dealer__Parts_Inventory__c WHERE Part_No__c = 'DT1:FD:FL1A__TEST_PART'].Id;

        Test.startTest();

        List<Parts_Inventory__c> parts = PartsInventoryOnHandTableController.getInventoryLocationOnHand(partId);
        System.assertEquals(60, parts.get(0).On_Hand__c);

        Test.stopTest();
    }
}