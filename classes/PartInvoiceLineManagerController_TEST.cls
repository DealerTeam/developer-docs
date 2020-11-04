@isTest
public with sharing class PartInvoiceLineManagerController_TEST {

    @TestSetup
    static void makeData(){

        TestClassUtil tu = new TestClassUtil();
        tu.insertDMSSettings();

        Parts_Service_Pricing_Strategy__c ps = new Parts_Service_Pricing_Strategy__c();
        ps.Method__c = 'Jobber';
        ps.Active__c = true;
        ps.Description__c = 'test';
        ps.Default__c = true;
        ps.dealer__Parts_Variable_Amount__c = 10;
        ps.dealer__Formula_Operand__c = '+';
        insert ps;

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

        dealer__Dealer_Location__c objLocation2 = new dealer__Dealer_Location__c();
            objLocation2.Name = 'Dos Loc';
            objLocation2.dealer__Company_Number__c='DT2';
            objLocation2.dealer__City__c='Redding';
            objLocation2.dealer__State__c='CA';
            objLocation2.dealer__Postal_Code__c='96001';
            objLocation2.dealer__Default_Rate__c = 8;
        upsert objLocation2;

        Account objAccount = new Account();
            objAccount.Name = 'Test Account';
            objAccount.Phone = '13256446';
            objAccount.BillingCountry = 'CA';
            objAccount.BillingStreet = 'street';
            objAccount.BillingCity = 'city';
            objAccount.BillingState = 'State';
            objAccount.BillingPostalCode = '151656';
            objAccount.dealer__Active__c = 'Yes';
            objAccount.dealer__Vendor__c = true;
        insert objAccount;

        Contact objContact = new Contact(
            FirstName = 'TestFirst', 
            Phone = '315616566', 
            MobilePhone = '16565656', 
            Email = 'test@demo.com', 
            MailingStreet = 'testStreet', 
            MailingCity = 'testCity', 
            MailingPostalCode = 'ds1f56565', 
            MailingState = 'testState',
            LastName = 'TestContact'
        );
        insert objContact;

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
        upsert inventory;

        dealer__Parts_Invoice__c pi = new dealer__Parts_Invoice__c(
            Name = 'INV1234',
            dealer__Customer__c = objAccount.Id,
            dealer__Invoice_Number__c = '1234',
            dealer__Location__c = objLocation.id
        );                                                         
        insert pi;
    }

    static testMethod void testSearchPart() {
       
        Id partId = [SELECT Id FROM dealer__Parts_Inventory__c WHERE Part_No__c = 'DT1:FD:FL1A__TEST_PART'].Id;
        Id locLookupId1 = [SELECT Id FROM dealer__Dealer_Location__c WHERE dealer__Company_Number__c = 'DT1' LIMIT 1].Id;

        // Setup SOSL query resusld
        Id [] fixedSearchResults= new Id[1];
        fixedSearchResults[0] = partId;
        Test.setFixedSearchResults(fixedSearchResults);
        
        Test.startTest();

        dealer__Parts_Inventory__c testSearchPart = PartInvoiceLineManagerController.getPartDetails(partId);
        List<LookupSearchResult> testSearch = PartInvoiceLineManagerController.partSearchByLocation('FL', locLookupId1);

        Test.stopTest();

        System.assertEquals(partId, testSearchPart.Id);
        System.assertEquals(1, testSearch.size());
    }

    static testMethod void testSearchPartMaster() {
       
        Id partId = [SELECT Id FROM dealer__Parts_Master__c WHERE dealer__Retail_Price__c = 99.99].Id;

        // Setup SOSL query resusld
        Id [] fixedSearchResults= new Id[1];
        fixedSearchResults[0] = partId;
        Test.setFixedSearchResults(fixedSearchResults);
        
        Test.startTest();
        List<LookupSearchResult> testSearch = PartInvoiceLineManagerController.partsMasterSearchByMfg('FL', 'FD');
        Test.stopTest();

        System.assertEquals(1, testSearch.size());
    }

    static testMethod void testPartsByMaster() {

        dealer__Parts_Master__c m = new dealer__Parts_Master__c();
        m.Name = 'SECOND_Test_Part';
        m.dealer__Retail_Price__c = 24.99;
        m.Manufacturer__c = 'LG';
        m.Cost__c = 12.99;
        insert m;
       
        Id locId = [SELECT Id FROM dealer__Dealer_Location__c WHERE dealer__Company_Number__c = 'DT1' LIMIT 1].Id;
        Id masterId = [SELECT Id FROM dealer__Parts_Master__c WHERE dealer__Retail_Price__c = 99.99].Id;

        List<Parts_Inventory__c> existingParts = [SELECT Id FROM Parts_Inventory__c];

        // Only one part should exist from testSetup
        System.assertEquals(1, existingParts.size());
        
        Test.startTest();
        Parts_Inventory__c part = PartInvoiceLineManagerController.getPartByMasterLocation(m.Id, locId);
        Test.stopTest();

        System.assertEquals('LG:SECOND_Test_Part', part.dealer__Part_No__c);
        existingParts = [SELECT Id FROM Parts_Inventory__c];
        
        System.assertEquals(2, existingParts.size());
    }

    static testMethod void testPartLineActions() {
        Parts_Invoice__c[] invoices = [SELECT Id, Name, Invoice_Number__c FROM Parts_Invoice__c];
        Id invId = invoices.get(0).Id;
        Id partId = [SELECT Id FROM dealer__Parts_Inventory__c WHERE Part_No__c = 'DT1:FD:FL1A__TEST_PART'].Id;

        Test.startTest();

        List<Parts_Invoice_Line__c> partLines1 = PartInvoiceLineManagerController.getPartLinesByInvoice(invId);
        System.assertEquals(0, partLines1.size());
        
        List<Parts_Invoice_Line__c> partLines2 = PartInvoiceLineManagerController.addInvoicePartLine(invId, partId, 1, 99.99);
        System.assertEquals(1, partLines2.size());
        Parts_Invoice_Line__c ogLine = partLines2.get(0);
        System.assertEquals(1, ogLine.dealer__Quantity_Sold__c);

        Parts_Invoice_Line__c updateLine = PartInvoiceLineManagerController.updatePartLine( ogLine.Id, 2, 1000);
        System.assertEquals(2, updateLine.dealer__Quantity_Sold__c);

        updateLine.dealer__Quantity_Sold__c = 5;
        Parts_Invoice_Line__c editLine = PartInvoiceLineManagerController.editPartLine(updateLine);
        System.assertEquals(5, editLine.dealer__Quantity_Sold__c);

        Boolean deleted = PartInvoiceLineManagerController.deletePartLine(editLine.Id);
        System.assert(deleted);

        List<Parts_Invoice_Line__c> finalLines = PartInvoiceLineManagerController.getPartLinesByInvoice(invId);
        System.assertEquals(0, finalLines.size());
        
        Test.stopTest();
    }
}