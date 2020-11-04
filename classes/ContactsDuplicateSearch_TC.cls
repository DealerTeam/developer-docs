/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class ContactsDuplicateSearch_TC {

    static testMethod void myUnitTest() {
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
      User u = new User(Alias = 'stxxx', Email='standarduser@dealerTeam.com', 
      EmailEncodingKey='UTF-8', LastName='DealerTesting', LanguageLocaleKey='en_US', 
      LocaleSidKey='en_US', ProfileId = p.Id, 
      TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@dealerTeam.com');

     insert u;
      System.runAs(u) {
        
        if(dealer__VINDecoderCS__c.getValues('ActiveSettings') == null){
            dealer__VINDecoderCS__c VINDecod = new dealer__VINDecoderCS__c();
            VINDecod.Name = 'ActiveSettings';
            VINDecod.dealer__DecoderAPI_URL__c = 'https://api.dataonesoftware.com/webservices/vindecoder/decode';
            VINDecod.dealer__DecoderClientID__c = '6310';
            VINDecod.dealer__DecoderKey__c = '1de4cab15a94d80a33f07d19ecb7eff44032bde7';
            VINDecod.dealer__DecoderName__c = 'Data One Software';
            insert VINDecod;
        }
      
       Contact Con=new Contact(FirstName='Test',LastName='Test');
       insert Con;
        PageReference pgRef = Page.ContactsDuplicateSearch;
        Test.setCurrentPage(pgRef);
        
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(Con);
        ContactsDuplicateSearch sl = new ContactsDuplicateSearch(sc);
        
        sl.getUserId();
        sl.getUserName();
        sl.FindDupes();
        
        ApexPages.currentPage().getParameters().put('id', Con.Id);        
              
        ContactsDuplicateSearch.searchUps usup = new ContactsDuplicateSearch.searchUps(true, true, false, false, false, 'test', 'test', '', '', '');
        Contact c = new Contact(FirstName='John', LastName='Test');
        insert c;
         ApexPages.Standardcontroller sc1 = new ApexPages.Standardcontroller(C);
        ContactsDuplicateSearch sdls2 = new ContactsDuplicateSearch(sc);
        ContactsDuplicateSearch.AvaliableContacts Ac=new ContactsDuplicateSearch.AvaliableContacts();
        sdls2.getUserName();
        sdls2.getUserId();
        sdls2.searchExistingContacts('','','','','');
        sdls2.isBlank('');
        sdls2.FindDupes();
        sdls2.selectedCustomerId=c.Id; 
        String sid = sdls2.getSelectedStyleId();
        sdls2.setSelectedStyleId(sid);
        sdls2.mergeRecords();
        
      }
    }
      
}