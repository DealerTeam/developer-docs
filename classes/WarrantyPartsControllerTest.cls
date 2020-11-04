@isTest
public with sharing class WarrantyPartsControllerTest {
   @TestSetup
   static void makeData(){
        
        Profile objProfile = [SELECT Id From Profile WHERE Name = 'Standard User' Limit 1];
        String RecTypeId = [select Id from RecordType where (Name='Person Account') and (SobjectType='Account') LIMIT 1].Id;

        Contact c = new Contact(
                    FirstName='Jamey',
                    LastName='Roland',
                    AccountId=null,
                    Birthdate=date.parse('01/01/1970'),
                    Email='none@blackhole.org',
                    Salutation='Mr.',
                    Phone='5302221234',
                    MailingStreet='555 Cypress Ave',
                    MailingCity='Redding',
                    MailingState='CA',
                    MailingPostalCode='96001'
            );
                   
 

            Account Accnt = new Account(

                RecordTypeID = RecTypeId,
                FirstName = ' FName',
                LastName = 'LName',
                PersonEmail = 'test@yahoo.com',
                Phone='6612724903',
                PersonHomePhone = '2221234567',
                PersonMobilePhone = '2221234568' 

            );

 

        insert Accnt;

        insert c;

        User servAdv = new User(
            Alias='LS',
        	FirstName = 'Luke',
        	Division = 'CR9',
            Email = 'newuser1234@testorg.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Skywalker',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US', // changed for to avoid: INVALID_OR_NULL_FOR_RESTRICTED_PICKLIST, Locale: bad value for restricted picklist field: America/Los_Angeles
            UserName = 'newuser12342@testorg.com',
            ProfileId = objProfile.Id,
            TimeZoneSidKey = 'America/Los_Angeles');
        insert servAdv;
        
        dealer__Claim__c claim = new dealer__Claim__c();
        	claim.dealer__ClaimNumber__c = '1337';
            claim.dealer__ServiceAdvisor__c = servAdv.Id;
            claim.dealer__Customer__c= Accnt.Id;
         insert claim;       
   }

    @isTest public static void testWarrantyPartsController(){

        dealer__Claim__c clm = [SELECT Id FROM dealer__Claim__c];
        Account per = [SELECT Id, PersonHomePhone, PersonMobilePhone, Phone FROM Account];
        String homephone = per.PersonHomePhone;
        String cellphone = per.PersonMobilePhone;
        String newhomephone;
        String newcellphone;

        Test.startTest();

            PageReference pageRef = Page.WarrantyPickTicketPDF;
            Test.setCurrentPage(pageRef);
            pageRef.getParameters().put('id', clm.Id);
            ApexPages.StandardController sc = new ApexPages.standardController(clm);
            WarrantyPartsController controller = new WarrantyPartsController(sc);

            newhomephone  = Utility.formatPhoneTen(homephone);
            newcellphone  = Utility.formatPhoneTen(cellphone);

        Test.stopTest();

        system.assertEquals(controller.claimWrapper.claimHeader.Id, clm.id);
        system.assertEquals(controller.custPhone , newhomephone);
        system.assertEquals(controller.custCell, newcellphone);

    }
}