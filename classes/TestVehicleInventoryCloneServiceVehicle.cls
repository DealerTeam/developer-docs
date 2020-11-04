@isTest 
private class TestVehicleInventoryCloneServiceVehicle{
    
    
    @testSetup static void setup(){
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
        dealer__Vehicle_Inventory__c VI = new dealer__Vehicle_Inventory__c();
        VI.Name = 'Test Vehicle Inventory';
        VI.dealer__Model__c = 'F150';
        VI.dealer__Stock_Number__c = 'TestUniqueStockNum';
        VI.dealer__VIN__c = '1N6AD0EV6CC459269';
        VI.dealer__Company_Number__c = 'DT1'; 
        VI.dealer__Year__c = '1994';
        VI.dealer__Make__c = 'Ford';
        VI.dealer__Retail_Price__c = 2000;
        VI.dealer__Store_Location__c = null;
        VI.dealer__Status_Code__c = 'I';
        VI.dealer__In_Stock__c = true;
        insert VI;

        //Sales Up
        dealer__Sales_Up__c sup = new dealer__Sales_Up__c(
                                dealer__FirstName__c='John', 
                                dealer__LastName__c='Test',
                                dealer__Lead_Status__c='Open',
                                dealer__Mobile__c='9172255960',
                                dealer__Email__c='john@test.com',
                                dealer__Disposition__c = 'Open',
                                OwnerID=usr.Id);
        insert sup;
        
        dealer__Service_Vehicle__c sv = new dealer__Service_Vehicle__c(
                                dealer__Sales_Inventory__c = vi.Id
        );
        insert sv;

        //Desired Vehicle
        dealer__Desired_Vehicle__c dv = new dealer__Desired_Vehicle__c(
                                dealer__Make__c = 'Ford',
                                dealer__Year__c = '1994',
                                dealer__Model__c = 'F150',
            					dealer__Sales_Up__c = sup.Id,
            					dealer__Vehicle_Inventory__c = VI.Id
                                );
        insert dv;
        
        //Make sure CRM Settings correct
        dealer__CRMSettings__c crm = dealer__CRMSettings__c.getOrgDefaults();
        crm.Inv_Match_Alert__c = true;
        crm.Enable_Price_Change_Alert__c = true;
        
        insert crm;

        Boolean flag;
        VehicleInventoryTriggerHandler v= new VehicleInventoryTriggerHandler(true,1);
        flag = v.IsTriggerContext;
        flag = v.IsVisualforcePageContext;
        flag = v.IsWebServiceContext;
        flag = v.IsExecuteAnonymousContext;
    }
    
    @isTest static void testPriceChange(){
        dealer__Vehicle_Inventory__c vinv = [SELECT Id, dealer__Retail_Price__c 
                                            FROM dealer__Vehicle_Inventory__c 
                                            WHERE dealer__Stock_Number__c = 'TestUniqueStockNum' 
                                            LIMIT 1];
        User u = [SELECT Id FROM User WHERE Username = 'testuser128@testorgx.com' LIMIT 1];
        
        vinv.dealer__Retail_Price__c = 1500;
        vinv.dealer__Trim_Level__c = 'XLT';
        update vinv;
        
        List<Task> priceChangeTasks = [SELECT Id, Subject 
                                      FROM Task
                                      WHERE OwnerId =:u.Id];
        // System.assertEquals(1, priceChangeTasks.size());
    }
    
    @isTest static void testInvMatch(){
        
        dealer__Vehicle_Inventory__c VI = new dealer__Vehicle_Inventory__c();
        VI.Name = 'Test Vehicle';
        VI.dealer__Model__c = 'F150';
        VI.dealer__Stock_Number__c = 'DifferentUniqueNum';
        VI.dealer__VIN__c = '1N6AD0EV6CC458765';
        VI.dealer__Company_Number__c = 'DT1'; 
        VI.dealer__Year__c = '1994';
        VI.dealer__Make__c = 'Ford';
        VI.dealer__Retail_Price__c = 2000;
        VI.dealer__Store_Location__c = null;
        VI.dealer__Status_Code__c = 'I';
        insert VI;
        
        User u = [SELECT Id FROM User WHERE Username = 'testuser128@testorgx.com' LIMIT 1];
        List<Task> priceChangeTasks = [SELECT Id, Subject 
                                      FROM Task
                                      WHERE OwnerId =:u.Id];
        // System.assertEquals(1, priceChangeTasks.size());
    }
    
    @isTest static void testVISCH(){
        dealer__Vehicle_Inventory__c inv = [SELECT Id FROM dealer__Vehicle_Inventory__c
                                           WHERE dealer__Stock_Number__c = 'TestUniqueStockNum'
                                           LIMIT 1];
        inv.dealer__Status_Code__c = 'X';
        update inv;
        
        inv.dealer__Status_Code__c = 'Y';
        update inv;
        
        List<dealer__Vehicle_Inventory_Status_Code_History__c > VISCH 
            = [SELECT Id, dealer__Status_Code__c FROM dealer__Vehicle_Inventory_Status_Code_History__c
              WHERE dealer__Inventoried_Vehicle__c =:inv.Id];

        System.debug(VISCH);

        System.debug(VISCH.size());

        System.assertEquals(3, VISCH.size()); //Refactored recursive check, this now produces 3 history items as expected.

        // Insert history record
        insert(new dealer__Vehicle_Inventory_Status_Code_History__c(Inventoried_Vehicle__c=inv.Id, Status_Code__c='A'));
    }

    @isTest static void testUpdateLocation(){
        dealer__Dealer_Location__c loc = [SELECT Id, dealer__Company_Number__c from dealer__Dealer_Location__c WHERE dealer__Company_Number__c = 'DT2' LIMIT 1];

        dealer__Vehicle_Inventory__c vinv = [SELECT Id, dealer__Store_Location__c 
                                            FROM dealer__Vehicle_Inventory__c 
                                            WHERE dealer__Stock_Number__c = 'TestUniqueStockNum' 
                                            LIMIT 1];

        vinv.dealer__Store_Location__c = loc.Id;
        update vinv;

        dealer__Vehicle_Inventory__c vinvX = [SELECT Id, dealer__Company_Number__c 
                                            FROM dealer__Vehicle_Inventory__c 
                                            WHERE dealer__Stock_Number__c = 'TestUniqueStockNum' 
                                            LIMIT 1];

        System.assertEquals(loc.dealer__Company_Number__c, vinvX.dealer__Company_Number__c);


    }

    @isTest
    static void testUpdateVehicleConversion(){
        dealer__Vehicle_Inventory__c vi = [SELECT Id, Conversion__c, Service_Vehicle__C, In_Stock__c FROM dealer__Vehicle_Inventory__c WHERE dealer__VIN__c = '1N6AD0EV6CC459269'];
        dealer__Service_Vehicle__c sv = [SELECT Id, Conversion__c FROM dealer__Service_Vehicle__c WHERE Sales_Inventory__c =: vi.Id LIMIT 1];

        Parts_Kit__c pk = new Parts_Kit__c();
        pk.Name = 'Test Kit';
        pk.Description__c = 'Custom description about the kit.';
        insert pk;

        vi.In_Stock__c = true;
        update vi;

        sv.Conversion__c = pk.Id;
        update sv;

        vi = [SELECT Id, Conversion__c FROM dealer__Vehicle_Inventory__c WHERE VIN__c = '1N6AD0EV6CC459269'];
        System.assertEquals(vi.Conversion__c, sv.Conversion__c, 'updateVehicleConversion did not update VI conversion from SV record.');
    }
}