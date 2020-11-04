@isTest
private class TestServiceJobCard {

    @isTest
    static void testServiceJobCard() {
        
        User u = [ SELECT Id FROM User WHERE dealer__Technician__c = true LIMIT 1 ];
        System.runAs(u) {
            Test.setCurrentPageReference(new PageReference('Page.ServiceJobCard')); 
            System.currentPageReference().getParameters().put('techId', u.Id);
            ServiceJobCard sjc = new ServiceJobCard();
            PageReference pr = sjc.compileReport();
        }     
    }

    @isTest
    static void getTechsListTest() {

        ServiceJobCard sjc = new ServiceJobCard();
        SYSTEM.assert(sjc.getTechsList().size() > 0);
    }
     
    @testSetup
    static void setupMethod() {

        User u = createUser();
        System.runAs(u) {
            TestFactory.createSObject(new DMS_Settings__c(Name = 'ActiveSettings', Service_Current_Invoice_Number__c = 30093, Service_Job_Line_Number__c = 8, Parts_Current_Invoice_Number__c = 50115, Parts_Current_Quote_Number__c = 20028, Default_Tax_Rate__c = 7.75, Service_Appointment_Sequence_Number__c = 2000, Deal_Status_Controls_Sales_Up_Status__c = true), true);
            Account a = (Account)TestFactory.createSObject(new Account(), true);
            Contact c = (Contact)TestFactory.createSObject(new Contact(), true);
            Service_Vehicle__c veh = (Service_Vehicle__c)TestFactory.createSObject(new Service_Vehicle__c(), true);
            Service_Repair_Order__c sro = (Service_Repair_Order__c)TestFactory.createSObject(new Service_Repair_Order__c(dealer__Customer__c = a.Id, Customer_Contact__c = c.Id, Vehicle__c = veh.Id, dealer__Location__c = 'Main Shop', dealer__Status__c = 'Open', dealer__Mileage_In__c = 34), true);
            dealer__Service_Job__c sj = (dealer__Service_Job__c)TestFactory.createSObject(new dealer__Service_Job__c(dealer__Technician__c = u.Id, dealer__Stat__c = 'Open',  dealer__Service_Repair_Order__c = sro.Id), true);
        }
    }

    private static User createUser() {

        User u = new User();
        u.ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id;
        u.LastName = 'last';
        u.Email = 'DTUserTest@dealterTeamTest.com';
        u.Username = 'DTUserTest@dealterTeamTest.com' + System.currentTimeMillis();
        u.CompanyName = 'TEST';
        u.Title = 'title';
        u.Alias = 'alias';
        u.TimeZoneSidKey = 'America/Los_Angeles';
        u.EmailEncodingKey = 'UTF-8';
        u.LanguageLocaleKey = 'en_US';
        u.LocaleSidKey = 'en_US';
        u.dealer__Technician__c = true;

        insert u;
        return u;
    }
}