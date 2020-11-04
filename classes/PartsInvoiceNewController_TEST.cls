@isTest
public with sharing class PartsInvoiceNewController_TEST {

    @TestSetup
    static void makeData(){

        TestClassUtil tu = new TestClassUtil();
        tu.insertDMSSettings();

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

        Parts_Service_Pricing_Strategy__c ps = new Parts_Service_Pricing_Strategy__c(
            Name = 'Pricing',
            Method__c = 'Schedule', 
            Description__c = 'This is a pricing strategy', 
            Parts_Variable_Amount__c = 2,
            Default__c = true
        );
        insert ps;

        dealer__Dealer_Location__c objLocation = new dealer__Dealer_Location__c();
            objLocation.Name = 'Test Location';
            objLocation.dealer__Company_Number__c=usr.Division;
            objLocation.dealer__City__c='ABSD';
            objLocation.dealer__State__c='NY';
            objLocation.dealer__Postal_Code__c='1234';
            objLocation.dealer__Default_Rate__c = 9.9;
        upsert objLocation;

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
            LastName = 'TestContact',
            AccountId = objAccount.Id
        );
        insert objContact;

        dealer__Parts_Invoice__c pi = new dealer__Parts_Invoice__c(
            Name = 'INV1234',
            dealer__Customer__c = objAccount.Id,
            dealer__Invoice_Number__c = '1234',
            dealer__Location__c = objLocation.id,
            dealer__Wholesale_Pricing_Strategy__c = ps.Id
        );                                                         
        insert pi;
    }

    static testMethod void testInvoiceController() {

        User u = [SELECT Id FROM User WHERE Email = 'us.name@vmail.com' LIMIT 1];
        Id locId = [SELECT Id FROM Dealer_Location__c WHERE Name = 'Test Location' LIMIT 1].Id;
        Id acctId = [SELECT Id FROM Account WHERE Name = 'Test Account' LIMIT 1].Id;

        Test.startTest();
        
        System.runAs(u) {
            Parts_Invoice__c testPi = PartsInvoiceNewController.getDefaultInvoice();
            System.assertEquals(locId, testPi.Location__c);
        }

        List<Contact> contacts = PartsInvoiceNewController.getBusinessContacts(acctId);
        System.assertEquals('TestFirst TestContact', contacts.get(0).Name);

        Test.stopTest();
    }
}