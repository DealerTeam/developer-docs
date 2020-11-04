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
private class ContactsMassTransfer_TC {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='user@testmail.com', 
        EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', UserName='contactsMassTransfer_TC@testmail.com');
        insert u;
        Contact conId = new Contact(lastName = 'Test',Transfer_From__c = u.Id,OwnerId = u.Id);
        insert conId;
        ContactsMassTransfer ContactsMassTransferTest = new ContactsMassTransfer();
        
        ContactsMassTransfer.Contacts ConList = new ContactsMassTransfer.Contacts();
        conList.Email = 'test@test.com';
        conList.isChecked = true;
        ContactsMassTransferTest.ContactList.add(conList);
        ContactsMassTransferTest.Cancel();
        ContactsMassTransferTest.getCon();
        ContactsMassTransferTest.getContactList();
        ContactsMassTransferTest.getParticipant();
        ContactsMassTransferTest.getParticipants();
        ContactsMassTransferTest.search();
        ContactsMassTransferTest.setCon(u.Id);
        ContactsMassTransferTest.setParticipant(new List<String>());
        ContactsMassTransferTest.AvailableParticipantList.add(u.id);
        ContactsMassTransferTest.search();
        ContactsMassTransferTest.Transfer();
    }
}