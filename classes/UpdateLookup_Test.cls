@isTest
private class UpdateLookup_Test {

    static testMethod void myUnitTest() {

        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors'); 
        TestClassUtil util = new TestClassUtil();
        util.insertDMSSettings();
        Profile prof = [select id from profile where name='system Administrator'];
        User usr = new User(alias = 'usr', email='us.name@vmail.com',
                  emailencodingkey='UTF-8', lastname='lstname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='testuser128@testorgx.com',
                  Division='DT1');
                  insert usr;
        
                  
        System.runAs(usr){  
        
                // TO DO: implement unit test
                // Create contact for invoice
            Contact c = new Contact(
                  FirstName='James',
                  LastName='Rowland',
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
                  
            insert c;

            Parts_Service_Pricing_Strategy__c ps = new Parts_Service_Pricing_Strategy__c();
            ps.Method__c = 'Jobber';
            ps.Active__c = true;
            ps.Description__c = 'test';
            ps.Default__c = true;
            ps.dealer__Parts_Variable_Amount__c = 10;
            ps.dealer__Formula_Operand__c = '+';
            insert ps;
            
            dealer__Parts_Invoice__c pi = new dealer__Parts_Invoice__c(
                                          Name='INV1234',
                                          Location__c = loc.id,
                                          dealer__Customer_Contact__c=c.Id,
                                          dealer__Invoice_Number__c='1234'
                                              );
                                              
            insert pi;
            
            // Create GL Record
            dealer__GL__c d = new dealer__GL__c();
            d.dealer__Control_Number__c = '12345';
            d.dealer__Document_Number__c = '12345';
            d.dealer__Reference_Number__c = '1234';
            d.dealer__Document_Type_Code__c = 'p';
            d.dealer__Transaction_Date__c = System.today();
            
            insert d;
            
            dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c(
                                                Name='test',
                                                dealer__VIN__c='3GNEK12Z15G244588',
                                                dealer__Make__c='Chevrolet',
                                                dealer__Model__c='1500',
                                                dealer__Stock_Number__c='VT100',
                                                dealer__Year__c='2012'
                                            );
            insert inv;
                
            d.dealer__Document_Type_Code__c = 'i';
            d.dealer__Reference_Number__c = 'VT100';
            update d;
        
        }
    }
}