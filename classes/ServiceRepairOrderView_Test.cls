@isTest
private class ServiceRepairOrderView_Test{
    
    @testSetup static void testSetup() {
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
                  username='testuser128@testorgx.com',
                  Division='DT1');
        insert usr;  

        tu.insertAccount();
        tu.insertContact();

    }    

    static testMethod void testMethodOne(){

        TestClassUtil tu = new TestClassUtil();
        
        dealer__Service_Repair_Order__c spo = new dealer__Service_Repair_Order__c();
        spo.dealer__Customer__c = tu.insertAccount();
        spo.dealer__Deposit__c = 100;
        spo.dealer__Customer_Contact__c = tu.insertContact();
        spo.Name = 'Test Service Repair Order';
        spo.dealer__Customer_Charges__c = 50;
        spo.dealer__Company_Number__c = 'DT1';
        spo.dealer__Tax__c = 30;
        spo.dealer__Shop_Supplies__c = 20;
        spo.dealer__RO_Number__c = 'RO100';
        spo.dealer__Mileage_In__c = 10;
        spo.dealer__Mileage_Out__c = 5;
        spo.dealer__Vehicle__c = tu.insertServiceVehicle();
        
        insert spo;
        
        dealer__Service_Job__c  sj = new dealer__Service_Job__c ();
        
        sj.dealer__Service_Repair_Order__c = spo.Id;
        sj.dealer__Stat__c = 'Open';
        sj.dealer__Standard_Operation_Code__c = tu.insertStdOpcode();
        sj.dealer__Parts_Cost__c = 100;
        sj.dealer__Op_Code__c = 'Test opcode';
        sj.dealer__Line_Number__c = 100;
        sj.dealer__Labor_Type__c = 'C';
        sj.dealer__Labor_Rate__c = 'Test Rate';
        sj.dealer__Labor_Charges__c = 100;
        sj.dealer__Job_Start__c = System.Now();
        sj.dealer__Job_Finish__c = System.Now ()+ 10; 
        sj.dealer__Estimate__c = 100;
        sj.dealer__Correction__c = 'Test long text correction';
        sj.dealer__CustomerConcern__c = 'Test long text customer concern';
        sj.dealer__Cause__c = 'Test cause';
        sj.dealer__Book_Time__c = 3;
        sj.dealer__Actual_Time__c = 123;
        sj.Name = 'Test Name';
        sj.dealer__Parts_Total__c = 100;
        
        insert sj;        
        
        //String roId = tu.insertServiceRepairOrder();
        ApexPages.currentPage().getParameters().put('Id',spo.Id);
        // tu.insertServiceVehicle();
        
        ApexPages.StandardController sc = new ApexPages.standardController(spo);
        //Calling methods of the class.
        ServiceRepairOrderView sroView = new ServiceRepairOrderView(sc);
        
        String rId = sroView.rId;

        sroView.detailUpdate();
        sroView.returnToRo();
        sroView.save();

        // test Remotes
        List<dealer__Service_Job__c> jobLines = ServiceRepairOrderView.loadServiceJobLines(spo.Id);
        Decimal laborTotal = ServiceRepairOrderView.laborTotal(sj.Id);
    }
}