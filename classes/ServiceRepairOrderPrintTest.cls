@isTest
public class ServiceRepairOrderPrintTest {
	
    @TestSetup static void testInitData() {
        
		// Insert DMS Settings
        TestClassUtil tu = new TestClassUtil();
        tu.insertDMSSettings();
        
        // Create the location
        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
    
        // Create the user
        Profile prof = [select id from profile where name='system Administrator'];
        User usr = new User(alias = 'usr', email='us.name@vmail.com',
                  emailencodingkey='UTF-8', lastname='lstname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='testuserxm@testorgx.com',
                  Division='DT1');
                  insert usr;

    }
    
    @isTest static void testServiceRepairOrderPrint(){
        
        User u = [Select Id from User where username = 'testuserxm@testorgx.com' limit 1];
        
        dealer__Dealer_Location__c ddl = [Select Id, dealer__Company_Number__c from dealer__Dealer_Location__c limit 1];
        
        dealer__Dealer_Location_User__c objUserLocation = new dealer__Dealer_Location_User__c();
        objUserLocation.dealer__Dealer_Location__c = ddl.Id;
        objUserLocation.dealer__User__c = u.Id;
        insert objUserLocation;   
        
        System.runAs(u) {

            contact con = new contact();
            con.Phone = '8888888';
            con.LastName = 'Test';
            insert con;

            Account a = new Account();
            a.Name ='Test';
            a.AccountSource ='Dealer';
            insert a;

            dealer__Service_Repair_Order__c dsr = new dealer__Service_Repair_Order__c();
            dsr.dealer__Customer__c =a.id;
            dsr.dealer__Mileage_In__c =12;
            dsr.dealer__RO_Number__c ='111982';
            dsr.Company__c = ddl.Id;
            insert dsr;

            dealer__Service_Job__c dsj = new dealer__Service_Job__c();
            dsj.dealer__Cause__c ='Test';
            dsj.dealer__Labor_Charges__c =12;
            dsj.dealer__Service_Repair_Order__c =dsr.id;
            dsj.dealer__Labor_Type__c='c';
            dsj.dealer__Labor_Rate__c='Test';
            dsj.dealer__Misc_Charges__c=11;
            dsj.dealer__Concern__c='test';
            dsj.dealer__CustomerConcern__c='test';
            dsj.dealer__Correction__c='test';
            dsj.dealer__Op_Code__c='71232';
            dsj.dealer__Parts_Total__c=7;
            dsj.dealer__Service_Type__c='MR';
            dsj.dealer__Line_Number__c=1;
            dsj.dealer__Stat__c='Te';
            dsj.dealer__Technician__c=userinfo.getuserid();
            dsj.dealer__Book_Time__c=11;
            dsj.dealer__Line_Number__c=1;                    
            insert dsj;
			
            Test.startTest();
            ApexPages.StandardController sc = new ApexPages.StandardController(dsr);
            ApexPages.currentPage().getParameters().put('id', dsr.id);

            ServiceRepairOrderPrint sp = new ServiceRepairOrderPrint(new ApexPages.StandardController(dsr));
            ServiceRepairOrderPrint.ServiceRepairOrder sroWrap = sp.getServiceRepairOrder();
            Test.stopTest();
            
            System.assert(sroWrap.serviceJobList.size() == 1);

        }
    }
}