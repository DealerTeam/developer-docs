/**
* Date            |Developer            |Work#
* --------------------------------------------------------------------
*
* 2017.01.05       |Gaurav               |W-000858
* Created TestServiceJobLinkParent class for coverage of trigger ServiceJobLinkParent and ServiceJobTriggerHandler class
**/

//W-000858 Begins
@isTest()
private class TestServiceJobLinkParent{
     
    @testSetup static void testDataInsert(){
    
        TestClassUtil util = new TestClassUtil();
        dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        if(dms == null){
            util.insertDMSSettings();   
        }

        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
        Profile prof = [select id from profile where name='system Administrator'];
        User usr = new User(alias = 'usr', email='us.name@vmail.com',
                  emailencodingkey='UTF-8', lastname='lstname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='testuser128@testorgx.com',
                  Division='DT1',
                  EmployeeNumber = 'TEST');
        insert usr;
    
    }
    
    static testmethod void testServiceJobTriggerHandlerInsert(){
    
        Account a = new Account(Name='Jarrett Kuljis');        
        insert a;
        
        Contact c = new Contact(LastName='Test', AccountId=a.Id);
        insert c;
        
        User objUser = [SELECT Id FROM User LIMIT 1];
        dealer__Dealer_Location__c locationOne = TestClassUtil.insertDealerLocation('DT007', 'DealerTeam Motors');
        
        dealer__Dealer_Location_User__c objUserLocation = new dealer__Dealer_Location_User__c();
        objUserLocation.dealer__Dealer_Location__c = locationOne.Id;
        objUserLocation.dealer__User__c = objUser.Id;
        insert objUserLocation;
        
        dealer__Service_Vehicle__c D = new dealer__Service_Vehicle__c(
            dealer__VIN__c='test111984',
            dealer__Veh_Owner_Contact__c = C.ID,
            dealer__Year__c='2014',
            dealer__Make__c='test',
            dealer__Carline__c='test');
        insert d;
        
        dealer__TaxSettings__c DTS = dealer__TaxSettings__c.getValues('ActiveSettings');
        if(DTS == null) {
            DTS = new dealer__TaxSettings__c(Name='ActiveSettings',dealer__State_Tax_Rate__c=1,dealer__State_Code__c='te');
            insert DTS;
        }

        dealer__DMS_Settings__c DMS = dealer__DMS_Settings__c.getValues('ActiveSettings');       
       
        dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c(
                                                Name='test',
                                                dealer__VIN__c='3GNEK12Z15G244588',
                                                dealer__Make__c='Chevrolet',
                                                dealer__Model__c='1500',
                                                dealer__Stock_Number__c='VT100',
                                                dealer__Year__c='2012',
                                                dealer__In_Stock__c = true
                                            );
                                            
        insert inv; 
                        
        dealer__Service_Repair_Order__c objSRO = new dealer__Service_Repair_Order__c();
        objSRO.dealer__Vehicle__c = D.ID;
        objSRO.dealer__Mileage_In__c = 10;
        objSRO.dealer__RO_Number__c = '10001';
        objSRO.dealer__VIN__c = '3GNEK12Z15G244588';
        objSRO.dealer__Customer_Number__c = 'Test Customer Number';
        objSRO.dealer__Service_Advisor_ID__c = 'TEST';
        objSRO.dealer__Company__c = locationOne.Id;
        objSRO.dealer__Taxable__c = true;
        insert objSRO; 
    
        dealer__Service_Job__c objService = new dealer__Service_Job__c();
        objService.dealer__Service_Repair_Order__c = objSRO.id;
        objService.dealer__Parent_Record__c= '40';
        objService.dealer__Technician_ID__c = 'Test';
        objService.dealer__Op_Code__c = 'Test2';
        insert objService;
        
    }
    
    static testmethod void testServiceJobTriggerHandlerUpdate(){
        
         Account a = new Account(Name='Jarrett Kuljis');        
        insert a;
        
        Contact c = new Contact(LastName='Test', AccountId=a.Id);
        insert c;
        
        User objUser = [SELECT Id FROM User LIMIT 1];
        dealer__Dealer_Location__c locationOne = TestClassUtil.insertDealerLocation('DT007', 'DealerTeam Motors');
        
        dealer__Dealer_Location_User__c objUserLocation = new dealer__Dealer_Location_User__c();
        objUserLocation.dealer__Dealer_Location__c = locationOne.Id;
        objUserLocation.dealer__User__c = objUser.Id;
        insert objUserLocation;
        
        dealer__Service_Vehicle__c D = new dealer__Service_Vehicle__c(
            dealer__VIN__c='test111984',
            dealer__Veh_Owner_Contact__c = C.ID,
            dealer__Year__c='2014',
            dealer__Make__c='test',
            dealer__Carline__c='test');
        insert d;
        
        dealer__TaxSettings__c DTS = dealer__TaxSettings__c.getValues('ActiveSettings');
        if(DTS == null) {
            DTS = new dealer__TaxSettings__c(Name='ActiveSettings',dealer__State_Tax_Rate__c=1,dealer__State_Code__c='te');
            insert DTS;
        }

        dealer__DMS_Settings__c DMS = dealer__DMS_Settings__c.getValues('ActiveSettings');       
       
        dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c(
                                                Name='test',
                                                dealer__VIN__c='3GNEK12Z15G244588',
                                                dealer__Make__c='Chevrolet',
                                                dealer__Model__c='1500',
                                                dealer__Stock_Number__c='VT100',
                                                dealer__Year__c='2012',
                                                dealer__In_Stock__c = true
                                            );
                                            
        insert inv; 
                        
        dealer__Service_Repair_Order__c objSRO = new dealer__Service_Repair_Order__c();
        objSRO.dealer__Vehicle__c = D.ID;
        objSRO.dealer__Mileage_In__c = 10;
        objSRO.dealer__RO_Number__c = '10003';
        objSRO.dealer__VIN__c = '3GNEK12Z15G244588';
        objSRO.dealer__Customer_Number__c = 'Test Customer Number';
        objSRO.dealer__Service_Advisor_ID__c = 'TEST';
        objSRO.dealer__Company__c = locationOne.Id;
        objSRO.dealer__Taxable__c = true;
        insert objSRO; 
    
        dealer__Service_Job__c objService = new dealer__Service_Job__c();
        objService.dealer__Service_Repair_Order__c = objSRO.id;
        objService.dealer__Parent_Record__c= '40';
        objService.dealer__Technician_ID__c = 'Test';
        objService.dealer__Op_Code__c = 'Test2';
        insert objService;
   
        objService.dealer__Parent_Record__c= '50';
        objService.dealer__Technician_ID__c = 'Test45';
        objService.dealer__Op_Code__c = 'Test30';
        update objService;
        
    
    }
}
//W-000858 End