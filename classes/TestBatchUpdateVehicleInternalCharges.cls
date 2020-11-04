@isTest 
private class TestBatchUpdateVehicleInternalCharges {
    
     @testSetup static void setup(){
         
        TestClassUtil util = new TestClassUtil();
  		dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        if(dms == null){
            util.insertDMSSettings();   
        }
         
        //User, Profile, Location
        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
        dealer__Dealer_Location__c loc2 = TestClassUtil.insertDealerLocation('DT2', 'DealerTeam Vehicles');
        Profile prof = [select id from profile where name='system Administrator'];
        User usr = new User(alias = 'usr', email='us.name@vmail.com',
                            emailencodingkey='UTF-8', lastname='lstname',
                            timezonesidkey='America/Los_Angeles',
                            languagelocalekey='en_US',
                            localesidkey='en_US', profileid = prof.Id,
                            username='testuser128@testorgx.com',
                            isActive=true,
                            Division='DT1');
        insert usr; 

         
        //Vehicle
        dealer__Vehicle_Inventory__c vi = new dealer__Vehicle_Inventory__c();
        vi.Name = 'Test Vehicle Inventory';
        vi.dealer__Model__c = 'F150';
        vi.dealer__Stock_Number__c = 'TestUniqueStockNum';
        vi.dealer__VIN__c = '1N6AD0EV6CC459269';
        vi.dealer__Company_Number__c = 'DT1'; 
        vi.dealer__Year__c = '1994';
        vi.dealer__Make__c = 'Ford';
        vi.dealer__Retail_Price__c = 2000;
        vi.dealer__Store_Location__c = null;
        vi.dealer__Status_Code__c = 'I';
        insert vi;
         
        Account a = new Account(Name='Business Account');
        insert a;
        
        //Status Open
        dealer__Service_Repair_Order__c SRO = new dealer__Service_Repair_Order__c(dealer__Vehicle_Inventory__c = vi.Id, 
                                                                                  dealer__Customer__c = a.Id,
                                                                                  dealer__Internal_Charges__c = 1000,
                                                                                  dealer__Status__c = 'Open',
                                                                                  dealer__Mileage_In__c=10, 
                                                                                  dealer__RO_Number__c='10001');
        insert SRO;
        
        //Status Posted
        dealer__Service_Repair_Order__c sr = new dealer__Service_Repair_Order__c(dealer__Vehicle_Inventory__c = vi.Id, 
                                                                                  dealer__Customer__c = a.Id,
                                                                                  dealer__Internal_Charges__c = 2000,
                                                                                  dealer__Status__c = 'Posted',
                                                                                  dealer__Mileage_In__c=10, 
                                                                                  dealer__RO_Number__c='10002');
        insert sr;

     }
    
    @isTest static void testPopulateInternalCharges(){
        
        Test.startTest();
        BatchUpdateVehicleInternalCharges bvi = new BatchUpdateVehicleInternalCharges();
		database.executeBatch(bvi);
        Test.stopTest();
        
       	List<dealer__Vehicle_Inventory__c> viList = [Select Id, dealer__Work_in_Process__c, dealer__Internal_Charges__c From dealer__Vehicle_Inventory__c Where dealer__VIN__c = '1N6AD0EV6CC459269' LIMIT 1];
        System.assertEquals(viList[0].dealer__Work_in_Process__c, 1000);
        System.assertEquals(viList[0].dealer__Internal_Charges__c, 2000);

    }

}