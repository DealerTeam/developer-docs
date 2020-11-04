@isTest
public class OutboundFileTransferTest {
    @TestSetup
    static void makeData(){
        

        TestClassUtil util = new TestClassUtil();

        Profile prof = [select id from profile where name='system Administrator'];
        User usr = new User(alias = 'usr', email='us.name@vmail.com',
                  emailencodingkey='UTF-8', lastname='lstname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='testuser128@testorgx.com',
                  Division='DT1');
        insert usr; 

        //    Given user w/permissions
        PermissionSet ps = new PermissionSet(Label = 'mockPs', Name = 'mockPs');
        insert ps;        

        // Given custom permission associated with outbound file transwer
        SetupEntityAccess sea = new SetupEntityAccess(
                    ParentId = ps.Id,
                    SetupEntityId = [SELECT Id, DeveloperName FROM CustomPermission WHERE DeveloperName = 'UpdateOutboundFileTransfer'][0].Id
            );
        insert sea; 
        
        // Given mocked Permission Set assigned to user for test
        PermissionSetAssignment psa = new PermissionSetAssignment(
                    AssigneeId = usr.Id,
                    PermissionSetId = ps.Id
        );
        insert psa;
        
        // Given mocked Permission Set assigned to user for test
        PermissionSetAssignment psa2 = new PermissionSetAssignment(
                    AssigneeId = UserInfo.getUserId(),
                    PermissionSetId = ps.Id
        );
        insert psa2; 
        
        // Add the DMS Settings
        // DMS_Settings__c dms = DMS_Settings__c.getValues('ActiveSettings');
        // if(dms == null){
        //     util.insertDMSSettings();   
        // }
        


    }

    @isTest
    static void testSOQLValidation(){
        User u = [SELECT Id FROM User WHERE Username = 'testuser128@testorgx.com'];

        permissionSet permSet = [SELECT Id,Name FROM PermissionSet WHERE Name='Dealerteam_Administrator'];
        insert new PermissionSetAssignment(AssigneeId = u.Id, PermissionSetId = permSet.Id);

        system.runAs(u){

            OFTJob__c job = new OFTJob__c();
            job.DestinationFileName__c = 'test';
            job.ExportFileType__c = 'CSV';
            job.Password__c = 'test';
            job.SOQLStatement__c = 'SELECT Id, Name FROM Account';
            job.TransportProtocol__c = 'FTP';
            job.URN__c = 'test.something.test';
            job.Username__c = 'test';
            job.Active__c = true;
            insert job;

            OFTJob__c jobsaved = [SELECT Id, SOQLStatement__c FROM OFTJob__c];
            jobsaved.SOQLStatement__c = 'test';
            try{
                update jobsaved;
            }
            catch(Exception e){
                System.assert(e.getMessage().contains('Invalid SOQL Statement'), 'Invalid query was not caught.');
            }
        }
        
    }

    @isTest
    static void testUpdateLastRun(){
        User u = [SELECT Id FROM User WHERE Username = 'testuser128@testorgx.com'];

        permissionSet permSet = [SELECT Id,Name FROM PermissionSet WHERE Name='Dealerteam_Administrator'];
        insert new PermissionSetAssignment(AssigneeId = u.Id, PermissionSetId = permSet.Id);

        system.runAs(u){

            OFTJob__c job = new OFTJob__c();
            job.DestinationFileName__c = 'test';
            job.ExportFileType__c = 'CSV';
            job.Password__c = 'test';
            job.SOQLStatement__c = 'SELECT Id, Name FROM Account';
            job.TransportProtocol__c = 'FTP';
            job.URN__c = 'test.something.test';
            job.Username__c = 'test';
            job.Active__c = true;
            insert job;

            OFTJob__c jobsaved = [SELECT Id, LastRunStatus__c, LastRunDate__c FROM OFTJob__c];
            jobsaved.LastRunStatus__c = 'Success';
            update jobsaved;

            jobsaved = [SELECT Id, LastRunStatus__c, LastRunDate__c FROM OFTJob__c];
            System.assert(jobsaved.LastRunDate__c != null, 'LastRunDate__c was not populated on run success.');
        }
    }

    @isTest
    static void testOFTCallout(){
        User u = [SELECT Id FROM User WHERE Username = 'testuser128@testorgx.com'];

        permissionSet permSet = [SELECT Id,Name FROM PermissionSet WHERE Name='Dealerteam_Administrator'];
        insert new PermissionSetAssignment(AssigneeId = u.Id, PermissionSetId = permSet.Id);

        system.runAs(u){

            OFTJob__c job = new OFTJob__c();
            job.DestinationFileName__c = 'test';
            job.DynamicFileName__c = 'test2';
            job.ColumnEncapsulation__c = 'Double Quote';
            job.ExportFileType__c = 'CSV';
            job.Password__c = 'test';
            job.SOQLStatement__c = 'SELECT Id, Name FROM Account';
            job.TransportProtocol__c = 'FTP';
            job.URN__c = 'test.something.test';
            job.Username__c = 'test';
            job.Active__c = true;
            insert job;

            OFTJob__c jobsaved = [SELECT Id, LastRunStatus__c, LastRunDate__c FROM OFTJob__c];
            OutboundFileTransferAPI.runOFT(jobsaved.Id);
        }
        

    }
}