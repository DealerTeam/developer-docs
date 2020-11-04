@isTest
private class ServiceMiscChargeControlTest {
    
    @testSetup static void testDataInsert() {
        
        TestClassUtil util = new TestClassUtil();
        util.insertDMSSettings();
        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
        loc.Tax_Misc__c ='Respect Misc. Charge Code Record';
        update loc;
        
        Id VI = util.insertVehicleInventory();
        
        Profile prof = [select id from profile where name='system Administrator'];
        User u = new User(alias = 'usr', email='us.name@vmail.com',
                          emailencodingkey='UTF-8', lastname='lstname',
                          timezonesidkey='America/Los_Angeles',
                          languagelocalekey='en_US',
                          localesidkey='en_US', profileid = prof.Id,
                          username='testuser128@testorgx.com',
                          Division='DT1');
        
        insert u;
        
        dealer__CRMSettings__c cs = new dealer__CRMSettings__c();
        cs.dealer__Rewards_Program_Enabled__c = true;
        cs.dealer__Rewards_OilChange_OpCodes__c = 'Test1,Test2,Test3';
        cs.dealer__Rewards_FreeService_OpCodes__c = 'Test4,Test5,Test6';
        cs.dealer__Rewards_Discount_Code__c ='SROTest';
        insert cs;   
        
        dealer__Rewards__c objReward = new dealer__Rewards__c();
        objReward.Name = 'Test';
        insert objReward;
        
       
        Account a = new Account();
        a.Name ='Test';
        a.AccountSource ='Dealer';
        a.Type = 'Customer - Direct';

        insert a;
        
        Contact c = new Contact(AccountId = a.Id, LastName='Test', dealer__Rewards_Number__c = objReward.Id);
         insert c;


        
        dealer__MiscChargeCode__c miscCharges = New dealer__MiscChargeCode__c();
        miscCharges.Name = 'Test';
        miscCharges.dealer__Location__c = loc.Id;
        miscCharges.dealer__ApplicablePayType__c = 'w';
        miscCharges.dealer__BaseCharge__c = 'Labor Sale';
        miscCharges.dealer__Description__c = 'test';
        insert miscCharges;
        
        dealer__MiscChargeCode__c miscCharges1 = New dealer__MiscChargeCode__c();
        miscCharges1.Name = 'Parts';
        miscCharges1.dealer__Location__c = loc.Id;
        miscCharges1.dealer__ApplicablePayType__c = 'c';
        miscCharges1.dealer__BaseCharge__c = 'Parts Sale';
        miscCharges1.dealer__PercentageBasedAmount__c = 10;
        miscCharges1.dealer__Description__c = 'test';
        miscCharges1.dealer__Active__c = true;
        miscCharges1.dealer__Taxable__c = true;
        
        insert miscCharges1;
        
        dealer__Service_Repair_Order__c dsr = new dealer__Service_Repair_Order__c();
        dsr.dealer__Customer__c =a.id;
        dsr.dealer__Customer_Contact__c= c.Id;
        dsr.dealer__Mileage_In__c =12;
        dsr.dealer__RO_Number__c ='111982';
        dsr.dealer__Vehicle_Inventory__c= VI;
        dsr.dealer__Company__c = loc.Id;
        dsr.dealer__location__c = loc.Id;
        dsr.dealer__Internal_Charges__c=1;
        dsr.dealer__Discount_Code__c= 'SROTest';
        dsr.dealer__Discount_Total__c= 10;
        dsr.dealer__Internal_Misc_Charges__c =1;
        dsr.dealer__Customer_Sublet_Charges__c=1;
        dsr.dealer__Status__c = 'Posted';
        dsr.Discount_Type__c ='25%';
        dsr.dealer__Invoiced_Date_Time__c = Date.today();
        //dsr.dealer__Rewards_ID__c ='8675309' ;
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
        dsj.dealer__Technician__c=u.Id;
        dsj.dealer__Book_Time__c=11;
        dsj.dealer__Line_Number__c=1;                    
        insert dsj;
        
        dealer__Service_Misc_Charge__c smc = new dealer__Service_Misc_Charge__c();
        smc.Type__c = 'Freight';
        smc.Service_Job_Lines__c  =dsj.id;
        smc.Amount__c =11;
        insert smc;
    }
    
    @isTest static void testSROControlHandlerMiscCharges(){
        dealer__Service_Repair_Order__c sro = [SELECT dealer__Mileage_In__c,dealer__RO_Number__c,dealer__location__c,dealer__Customer_Contact__c FROM dealer__Service_Repair_Order__c Limit 1];
        sro.dealer__Mileage_In__c = 104;
        Test.startTest();
        upsert sro;
        Test.stopTest();
    }
    
    @isTest static void testDeleteMultiple(){
        
        dealer__Service_Misc_Charge__c smc = [Select Id, Amount__c, Service_Job_Lines__c from dealer__Service_Misc_Charge__c
                                              Where Type__c = 'Freight' limit 1];
        
        Id sjl = smc.Service_Job_Lines__c;
        
        dealer__Service_Misc_Charge__c mc = new dealer__Service_Misc_Charge__c();
        mc.Type__c = 'Freight';
        mc.Service_Job_Lines__c  =sjl;
        mc.Amount__c =10;
        insert mc;
        
        Service_Job__c sj = [Select Id, Misc_Charges__c FROM Service_Job__c Where Id =: sjl];
      //   dealer__Service_Repair_Order__c sro = [SELECT dealer__Mileage_In__c,dealer__RO_Number__c,dealer__location__c FROM dealer__Service_Repair_Order__c Limit 1];
       // sro.dealer__Mileage_In__c = 104;
        Test.startTest();
        //upsert sro;
        delete smc;
        Test.stopTest();
        
        Service_Job__c sjob = [Select Id, Misc_Charges__c FROM Service_Job__c Where Id =: sjl];
        system.assertEquals(10, sjob.Misc_Charges__c);
    }
    
    @isTest static void testDelete(){
        
        dealer__Service_Misc_Charge__c smc = [Select Id, Amount__c, Service_Job_Lines__c from dealer__Service_Misc_Charge__c
                                              Where Type__c = 'Freight' limit 1];
        
        Id sjl = smc.Service_Job_Lines__c;
        Service_Job__c sj = [Select Id, Misc_Charges__c FROM Service_Job__c Where Id =: sjl];
        
        Test.startTest();
        delete smc;
        Test.stopTest();
        
        Service_Job__c sjob = [Select Id, Misc_Charges__c FROM Service_Job__c Where Id =: sjl];
        system.assertEquals(0, sjob.Misc_Charges__c);
    }
    
}