@isTest
private class TestSMS {
    
    @testSetup static void testDataInsert() {
        TestClassUtil util = new TestClassUtil();
        dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        if(dms == null){
            util.insertDMSSettings();   
        }

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

    static testmethod void testSMSClass() {

        /*

            TO-DO - Write insertion of SaelsDeskLog hierarchy setting to remove the SeeAllData == TRUE Annotation. 

        */
       
        User u = [Select Id from User where Username = 'testuser128@testorgx.com' limit 1];
        System.runAs(u) {

        Contact c = new Contact(FirstName='Jarrett', LastName='Kuljis', MobilePhone='5309109988', dealer__Allow_SMS__c=true);
        insert c;

        Contact badId = new Contact(FirstName='Nathan', LastName='Grinch', MobilePhone='5309109988', dealer__Allow_SMS__c=false);
        Contact noC = new Contact(FirstName='Bob', LastName='Grinch', MobilePhone='5309109988', dealer__Allow_SMS__c=false);
        insert noC;

        TestClassUtil util = new TestClassUtil();
        util.insertSalesup();

        dealer__Sales_Up__c what = [select Id from dealer__Sales_Up__c limit 1];
        
        PageReference smsPage = Page.sendSMS;
        Test.setCurrentPage(smsPage);
        ApexPages.currentPage().getParameters().put('cid', c.Id);
        ApexPages.currentPage().getParameters().put('wid', what.Id);



        SMS s = new SMS();
        String cid = s.customerId;
        String jpayload = s.jsonPayload;
    
        dealer__SalesDeskLogSettings__c config = dealer__SalesDeskLogSettings__c.getValues(UserInfo.getUserId());
        if(config==null) {    
            if(dealer__SalesDeskLogSettings__c.getValues(UserInfo.getUserId())==null) {
                config =  new dealer__SalesDeskLogSettings__c();
                config.SetupOwnerId = UserInfo.getUserId();
                config.dealer__TrafficType__c = 'ALL';
                config.dealer__RunDate__c=Date.today();
                config.dealer__WalkIns__c=true;
                config.dealer__EmailUps__c=true;
                config.dealer__PhoneUps__c=true;
                config.dealer__faxUps__c=true;
                config.dealer__listUps__c=true;
                config.dealer__ReferralUps__c=true;
                config.dealer__OtherUps__c=true;
                insert config;
            }
        }

        dealer__SalesDeskLogSettings__c insValue = dealer__SalesDeskLogSettings__c.getValues(UserInfo.getUserId());
        insValue.dealer__SMS_Account_Code__c='1234';
        insValue.dealer__SMS_Phone_Number__c='11111';

        s.setContact(noC.Id);
        s.setContact(badId.Id);
        s.setContact(c.Id);
        s.message = 'Test Message';
        s.send();

        update insValue;

        s.send();
        
        s.cancel();
        s.getMessageHistory();
        s.templates();
        s.gettemplateSelect();
        s.getAllProspectFields();
        s.getcompiledMessage();

        // System.assertNotEquals(s.jsonPayload, null);

        // Genearte Message Class
        dealer__SalesDeskLogSettings__c DS = dealer__SalesDeskLogSettings__c.getValues(UserInfo.getUserId());        
        //s.msg(c.MobilePhone, s.message, DS.dealer__SMS_Account_Code__c, DS.dealer__SMS_Phone_Number__c, c.Id, what.Id);
        }
    }
}