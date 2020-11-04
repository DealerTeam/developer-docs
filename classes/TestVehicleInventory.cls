@isTest 
private class TestVehicleInventory {
    static testmethod void TestVehicleInventoryClone() { 

       dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
    
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

            dealer__CRMSettings__c crm = new dealer__CRMSettings__c(Inv_Match_Alert__c = true, dealer__Enable_Price_Change_Alert__c = true);
            insert crm;

            dealer__Sales_Up__c sup = new dealer__Sales_Up__c(dealer__Disposition__c = 'Open');
            insert sup;

            dealer__Desired_Vehicle__c dv = new dealer__Desired_Vehicle__c(
                                                    dealer__Make__c='Chevrolet',
                                                    dealer__Model__c='1500',
                                                    dealer__Year__c='2012',
                                                    dealer__Sales_Up__c = sup.Id
            );
            insert dv;

            dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c(
                                                    Name='test',
                                                    dealer__VIN__c='3GNEK12Z15G244588',
                                                    dealer__Make__c='Chevrolet',
                                                    dealer__Model__c='1500',
                                                    dealer__Stock_Number__c='VT100',
                                                    dealer__Year__c='2012'
                                                );
                                                
            insert inv;
            
            //dealer__Service_Vehicle__c sv = [Select Id, dealer__VIN__c, dealer__Sales_Inventory__c from dealer__Service_Vehicle__c where dealer__Sales_Inventory__c = :inv.Id limit 1];
            //System.assertEquals(sv.dealer__Sales_Inventory__c, inv.Id);

        }                                             
    }
    
    static testmethod void TestVehicleStatusCodeUpdate() {

       dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
    
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
        
        dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c(
                                                Name='test',
                                                dealer__VIN__c='3GNEK12Z15G244588',
                                                dealer__Make__c='Chevrolet',
                                                dealer__Model__c='1500',
                                                dealer__Stock_Number__c='VT100',
                                                dealer__Year__c='2012',
                                                dealer__Status_Code__c='I'
                                            );
                                            
        insert inv;
         
        dealer__Vehicle_Inventory_Status_Code_History__c[] visch = [Select Id from dealer__Vehicle_Inventory_Status_Code_History__c 
                                                                where dealer__Inventoried_Vehicle__c = :inv.Id];
                                                                 
        //System.assertEquals(1, visch.size());
         
        inv.dealer__Status_Code__c='X';
         
        update inv;
        
        dealer__Vehicle_Inventory_Status_Code_History__c[] visch_after = [Select Id from dealer__Vehicle_Inventory_Status_Code_History__c where dealer__Inventoried_Vehicle__c = :inv.Id];   
                                                                      
        // System.assertEquals(2, visch_after.size());


        }                                                                
     } 
    
    static testmethod void testVehicleInventoryAlerts() {

        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
    
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

        dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c(
                                                Name='test',
                                                dealer__VIN__c='3GNEK12Z15G244588',
                                                dealer__Make__c='Chevrolet',
                                                dealer__Model__c='1500',
                                                dealer__Stock_Number__c='VT100',
                                                dealer__Year__c='2012',
                                                dealer__Status_Code__c='I'
                                            );
                                            
        insert inv; 

        }       
    }

    static testmethod void testInventorySyndication() {

        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
    
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

        // Class contains static methods, no constructor testing at this time.
        VehicleInventorySyndication vs = new VehicleInventorySyndication();

        // Insert a Record
        dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c(
                                                Name='test',
                                                dealer__VIN__c='3GNEK12Z15G244588',
                                                dealer__Make__c='Chevrolet',
                                                dealer__Model__c='1500',
                                                dealer__Stock_Number__c='VT100',
                                                dealer__Year__c='2012'
                                            );
                                            
        insert inv;

        dealer.VehicleInventorySyndication.publishFeed();      

        // Method for on server XML Export (currently not in use)
        String xml = dealer.VehicleInventorySyndication.XMLFeed();

        }
    }

    static testmethod void testInventorysyncSchedulable() {
        
        Test.startTest();

            dealer.VehicleSyndicationScheduler vsc = new dealer.VehicleSyndicationScheduler();
            System.schedule('Inventory Feed', '0 5 * * * ?', vsc);

        Test.stopTest();

    }

    @isTest
    static void testAfterInsertStockBookUpdate(){

        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
    
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

            if(dealer__DMS_Settings__c.getValues('ActiveSettings') == null){
            dealer__DMS_Settings__c dms = new dealer__DMS_Settings__c();
            dms.Name = 'ActiveSettings';
            dms.dealer__Assign_Stock_Number__c = true;
            dms.dealer__Assign_Stock_Number_By_Stock_Book__c = true;
            dms.dealer__Service_Current_Invoice_Number__c = 30093;
            dms.dealer__Parts_Current_Quote_Number__c = 20028;
            dms.dealer__Default_Tax_Rate__c = 7.75;
            dms.dealer__Parts_Current_Invoice_Number__c = 50115;
            insert dms;  
            }

            dealer__Sales_Up__c sup = new dealer__Sales_Up__c(dealer__Disposition__c = 'Open');
            insert sup;

            dealer__Desired_Vehicle__c dv = new dealer__Desired_Vehicle__c(
                                                    dealer__Make__c='Chevrolet',
                                                    dealer__Model__c='1500',
                                                    dealer__Year__c='2012',
                                                    dealer__Sales_Up__c = sup.Id
            );
            insert dv;

            dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c(
                                                    Name='test',
                                                    dealer__VIN__c='3GNEK12Z15G244588',
                                                    dealer__Make__c='Chevrolet',
                                                    dealer__Model__c='1500',
                                                    dealer__Stock_Number__c='VT100',
                                                    dealer__Year__c='2012'
                                                );
                                                
            insert inv;
        }
    }

    static testmethod void testCreateServiceVehicle() {

        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
    
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

            List<dealer__Vehicle_Inventory__c> vehToUpdate = new List<dealer__Vehicle_Inventory__c>();
            Service_Vehicle__c veh = (Service_Vehicle__c)TestFactory.createSObject(new Service_Vehicle__c(dealer__VIN__C = '3GNEK12Z15G244588'), true);

            // Insert a Record
            dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c(
                                                    Name='test',
                                                    dealer__VIN__c='3GNEK12Z15G244588',
                                                    dealer__Make__c='Chevrolet',
                                                    dealer__Model__c='1500',
                                                    dealer__Stock_Number__c='VT100',
                                                    dealer__Year__c='2012',
                                                    dealer__Service_Vehicle__c = veh.Id
                                                );
                                                

            // Insert a second Record
            dealer__Vehicle_Inventory__c inv2 = new dealer__Vehicle_Inventory__c(
                                                    Name='test',
                                                    dealer__VIN__c='3GNEK12Z15G244555',
                                                    dealer__Make__c='Chevrolet',
                                                    dealer__Model__c='2500',
                                                    dealer__Stock_Number__c='VT101',
                                                    dealer__Year__c='2014'
                                                );


            vehToUpdate.add(inv);
            vehToUpdate.add(inv2);
            upsert vehToUpdate;

            //We want to verify that both vehicles end up wiht a related service vehicle
            List<dealer__Service_Vehicle__c> svList = [SELECT Id FROM dealer__Service_Vehicle__c];
            system.assertEquals(2, svList.size());

        }
    }

    @isTest
    static void testBulkCreateServiceVehicle(){
        List<vehicle_inventory__c> invList = new List<vehicle_Inventory__c>();
        List<service_vehicle__c> svList = new List<service_Vehicle__c>();
        for(integer x= 0; x < 400; x++){
            string vin = '3GNEK12Z15G24454' + x;
            dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c(
                Name='test',
                dealer__VIN__c=vin.right(17),
                dealer__Make__c='Chevrolet',
                dealer__Model__c='1500',
                dealer__Stock_Number__c='VT' + x,
                dealer__Year__c='2012'
            );
            invList.add(inv);
            if(x < 50){
                dealer__Service_Vehicle__c sv = new dealer__Service_Vehicle__c(
                    Name='test',
                    dealer__VIN__c=vin.right(17),
                    dealer__Make__c='Chevrolet',
                    dealer__Carline__c='1500',
                    dealer__Year__c='2012');
                svList.add(sv);
            }
            
        }

        test.startTest();
        insert svList;
        insert invList;

        test.stopTest();

        invList = [SELECT Id, dealer__Service_Vehicle__c FROM dealer__Vehicle_Inventory__c];
        svList = [SELECT Id FROM dealer__Service_Vehicle__c];

        Integer svCount = 0;

        for(dealer__Vehicle_Inventory__c v : invList){
            if(v.dealer__Service_Vehicle__c != null){
                svCount++;
            }
        }

        system.assertEquals(400, svList.size(), 'Did not return expected 400 service vehicles.');
        system.assertEquals(400, svCount, 'There was not a service vehicle attached to every vehicle inventory record.');
    }

}