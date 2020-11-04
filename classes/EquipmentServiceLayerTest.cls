@isTest
public class EquipmentServiceLayerTest {
    
    
    @testSetup static void insertData(){
        Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
        Profile prof = [select id from profile where name='system Administrator'];
        User usr = new User(alias = 'usr', email='us.name@vmailtest342s.com',
                            emailencodingkey='UTF-8', lastname='lstname',
                            timezonesidkey='America/Los_Angeles',
                            languagelocalekey='en_US',
                            localesidkey='en_US', profileid = prof.Id,
                            username='testuser128@testorgvmailtest342s.com',
                            Division='DT1');
        insert usr;  
        
        System.runAs(usr) {
            Vehicle_Inventory__c vehInv = (Vehicle_Inventory__c)TestFactory.createSObject(new Vehicle_Inventory__c( Name = 'Test Vehicle Inventory',
                                                                                                                   Model__c = '2014',Stock_Number__c = '2014',VIN__c = '100',Company_Number__c = 'Location 1',
                                                                                                                   Year__c = '2014',Make__c = '2014' ), true);
            
            
            dealer__Service_Vehicle__c sv = new dealer__Service_Vehicle__c(Name = 'test',
                                                                           dealer__Year__c = '2012',
                                                                           dealer__Make__c = 'Honda',
                                                                           dealer__Carline__c = 'Civic',
                                                                           dealer__VIN__c = '1GYFK63837R301368',
                                                                           dealer__Body_Type__c = 'Truck',
                                                                           dealer__Sales_Inventory__c = vehInv.Id,                                                          
                                                                           dealer__VIN_Not_Present__c = false);
            insert sv;
            
            
            //Create Equipment
            Equipment__c equipment = new Equipment__c(
                Name='test',
                Service_Vehicle__c = sv.id
            );
            insert equipment;
        }
    }
    @isTest
    static void  testReadEquipmentLEX(){
        List<Equipment__c> svEquipment= new List<Equipment__c>();
        List<Equipment__c> viEquipment= new List<Equipment__c>();
        
        //if we pass either a service vehicle Id or Vehicle Inventory Id no errors should be thrown
        //Service Vehicle Standard Controller
        Service_Vehicle__c sv = [SELECT Id FROM Service_Vehicle__c Limit 1];
        svEquipment = EquipmentTable_EXT.readEquipmentLEX(sv.Id);
        
        // Vehicle Inventory
        Vehicle_Inventory__c vi = [SELECT ID From Vehicle_Inventory__c LIMIT 1];
        viEquipment = EquipmentTable_EXT.readEquipmentLEX(vi.Id);
        System.assertEquals(1, viEquipment.size());
        
        
        //read equipment
        EquipmentTable_EXT.readEquipment(sv.Id);
        EquipmentTable_EXT.readEquipment(vi.Id);
        
        //read equipment
        EquipmentTable_EXT.readEquipmentTemplates();
        
        
        
        
    }
    
    @isTest
    static void  testGetServiceVehicleId(){
        
        //if we pass either a service vehicle Id or Vehicle Inventory Id no errors should be thrown
        //Service Vehicle Standard Controller
        Service_Vehicle__c sv = [SELECT Id FROM Service_Vehicle__c Limit 1];
        Equipment__c e = [Select Id,dealer__Service_Vehicle__c FROm Equipment__c Limit 1];
        
        EquipmentTable_EXT.getServiceVehicleId(sv.Id);
        
        // Vehicle Inventory
        Vehicle_Inventory__c vi = [SELECT Id From Vehicle_Inventory__c LIMIT 1];
        EquipmentTable_EXT.getServiceVehicleId(vi.Id);
        
        
        
        String line = '{"Id":"'+ e.Id +'","Name":"test","dealer__Description__c":"","dealer__Data_Source__c":"","dealer__Notes__c":"","dealer__Serial__c":"8675309","dealer__Confirmed__c":false,"dealer__Confirmed_Date_Time__c":"","dealer__Publish__c":false,"dealer__Featured__c":false,"dealer__Service_Vehicle__c":"'+ sv.Id +'"}';
        
        EquipmentTable_EXT.createEquipment(line);
        EquipmentTable_EXT.updateEquipment(line);
        EquipmentTable_EXT.deleteEquipment(line);

  
        User u = [Select Id From User where Email = 'us.name@vmailtest342s.com' Limit 1];
    
        Boolean exCatched = false;
        
        system.runAs(u){
            Test.startTest();
            //Create Equipment
            String InvalidId = Utility.getObjectKeyPrefix('dealer__Vehicle_Inventory__c');
            InvalidId += 'test1234567';
            try{
				 EquipmentTable_EXT.getServiceVehicleId(InvalidId);  
            }catch(Exception ex){
                exCatched = true;
            }
            Test.stopTest();
        }
        
        system.assertEquals( true,exCatched);        
        
        
        
    }
    
        @isTest
    static void  deleteLine(){
        
        //if we pass either a service vehicle Id or Vehicle Inventory Id no errors should be thrown
        //Service Vehicle Standard Controller
        Service_Vehicle__c sv = [SELECT Id FROM Service_Vehicle__c Limit 1];
        Equipment__c e = [Select Id,dealer__Service_Vehicle__c FROm Equipment__c Limit 1];
        
      
       EquipmentTable_EXT.deleteEquipmentLine(e);
        
        User u = [Select Id From User where Email = 'us.name@vmailtest342s.com' Limit 1];
    
        Boolean exCatched = false;
        
        system.runAs(u){
            Test.startTest();
            //Create Equipment
            Equipment__c equipment = new Equipment__c(
                Name='test',
                Service_Vehicle__c = sv.id
            );
            
            
            try{
				 EquipmentTable_EXT.deleteEquipmentLine(equipment);  
            }catch(Exception ex){
                exCatched = true;
            }
            Test.stopTest();
        }
        
        system.assertEquals(exCatched, true);

        
        
        
    }
    
    @isTest
    static void  testCatchBlock1(){
        
        User u = [Select Id From User where Email = 'us.name@vmailtest342s.com' Limit 1];
        Service_Vehicle__c sv = [SELECT Id FROM Service_Vehicle__c Limit 1];
        Equipment__c e = [Select Id, dealer__Service_Vehicle__c FROm Equipment__c];
        String line = '{"Id":"'+ e +'","Name":"test","dealer__Description__c":"","dealer__Data_Source__c":"","dealer__Notes__c":"","dealer__Serial__c":"8675309","dealer__Confirmed__c":false,"dealer__Confirmed_Date_Time__c":"","dealer__Publish__c":false,"dealer__Featured__c":false,"dealer__Service_Vehicle__c":"'+ sv.Id +'"}';

        Boolean exCatched = false;
        
        system.runAs(u){
            Test.startTest();
            try{
				 EquipmentTable_EXT.updateEquipment(line);  
            }catch(Exception ex){
                exCatched = true;
            }
            Test.stopTest();
        }
        
        system.assertEquals(exCatched, true);

    }
    
    @isTest
    static void  testCatchBlock2(){
        
        User u = [Select Id From User where Email = 'us.name@vmailtest342s.com' Limit 1];
        Service_Vehicle__c sv = [SELECT Id FROM Service_Vehicle__c Limit 1];
        Equipment__c e = [Select Id, dealer__Service_Vehicle__c FROm Equipment__c];
        String line = '{"Id":"'+ e +'","Name":"test","dealer__Description__c":"","dealer__Data_Source__c":"","dealer__Notes__c":"","dealer__Serial__c":"8675309","dealer__Confirmed__c":false,"dealer__Confirmed_Date_Time__c":"","dealer__Publish__c":false,"dealer__Featured__c":false,"dealer__Service_Vehicle__c":"'+ sv.Id +'"}';

        Boolean exCatched = false;
        
        system.runAs(u){
            Test.startTest();
            try{
        		EquipmentTable_EXT.deleteEquipment(line);
            }catch(Exception ex){
                exCatched = true;
            }
            Test.stopTest();
        }
        
        system.assertEquals(exCatched, true);

    }
    
        @isTest
    static void  testCatchBlock3(){
        
        User u = [Select Id From User where Email = 'us.name@vmailtest342s.com' Limit 1];
        Service_Vehicle__c sv = [SELECT Id FROM Service_Vehicle__c Limit 1];
        Equipment__c e = [Select Id, dealer__Service_Vehicle__c FROm Equipment__c];
        String line = '"Id":"","Name":"test","dealer__Description__c":"","dealer__Data_Source__c":"","dealer__Notes__c":"","dealer__Serial__c":"8675309","dealer__Confirmed__c":false,"dealer__Confirmed_Date_Time__c":"","dealer__Publish__c":false,"dealer__Featured__c":false,"dealer__Service_Vehicle__c":"'+ sv.Id +'"}';

        Boolean exCatched = false;
        
        system.runAs(u){
            Test.startTest();
            try{
        		EquipmentTable_EXT.createEquipment(line);
            }catch(Exception ex){
                exCatched = true;
            }
            Test.stopTest();
        }
        
        system.assertEquals(exCatched, true);

    }
    
    
    
}