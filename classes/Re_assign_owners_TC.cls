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
@isTest(seeAllData=true)
private class Re_assign_owners_TC {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'standt', Email='standarduserReassign@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduserReassign@testorg.com');
            insert u;

        
        List<Contact> con = new List<Contact>();
        con.add(new Contact(LastName = 'Test'));
        insert con;
        ApexPages.StandardSetController SSC = new ApexPages.StandardSetController(con);
        SSC.setSelected(con);
        Re_assign_owners reassign = new Re_assign_owners(SSC);
        reassign.addusers();
        reassign.Cancel();
        reassign.getAddPart();
        reassign.getaddParticipants();
        reassign.getParticipant();
        reassign.getParticipants();
        reassign.removeusers();
        reassign.setAddPart(new List<String>());
        reassign.setParticipant(new List<String>());
        reassign.getContactList();
        //reassign.addedUserList.add(new Selectoption(u.id,u.id));
        reassign.submit();
        
        reassign.addedUserList.add(new Selectoption(u.id,u.id));
        reassign.submit();
        
        reassign.addusers();
        reassign.AvailableParticipantList.add(Userinfo.getUserId());
        reassign.AvailableParticipantList.add(Userinfo.getUserId());
        reassign.addusers();
        reassign.selectedParticipantList.add(Userinfo.getUserId());
        reassign.removeusers();
        
    }
}