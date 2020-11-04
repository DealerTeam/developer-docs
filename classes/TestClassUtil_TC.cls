/**
* Date            |Developer            |Work#
* Notes
* --
* 2016.12.15      |Gaurav               |#W-000811
* Modified class failing because of SRO location
**/

@isTest
private class TestClassUtil_TC {

    @testSetup static void testDataInsert() {
 
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

      Parts_Service_Pricing_Strategy__c ps = new Parts_Service_Pricing_Strategy__c();
      ps.Method__c = 'Jobber';
      ps.Active__c = true;
      ps.Description__c = 'test';
      ps.Default__c = true;
      ps.dealer__Parts_Variable_Amount__c = 10;
      ps.dealer__Formula_Operand__c = '+';
      insert ps;

    }

    static testMethod void salesUnitTest() {

        User usr = [Select Id from User where username = 'testuser128@testorgx.com' ];
        
        /* #W-000811 Begin */
        dealer__Dealer_Location__c ddl = [Select Id, dealer__Company_Number__c from dealer__Dealer_Location__c limit 1];      
        
        dealer__Dealer_Location_User__c objUserLocation = new dealer__Dealer_Location_User__c();
        objUserLocation.dealer__Dealer_Location__c = ddl.Id;
        objUserLocation.dealer__User__c = usr.Id;
        insert objUserLocation; 
        /* #W-000811 End */         
        
        System.runAs(usr){         
        // TO DO: implement unit test
        
        TestClassUtil t= new TestClassUtil();
        t.insertAccount();
        t.insertContact();
        TestClassUtil.createLocation();

        //t.insertServiceAppointment();
        t.insertDMSSettings();
        System.debug('Created DMS Settings'); 
        
        t.insertCRMSettings();
        System.debug('Created CRM Settings');

        t.insertVINDecoderSetup();
        System.debug('Created VIN Decoder Settings');

        t.insertWeOweLines();
        System.debug('Created We-Owe Lines');

        t.insertForm();
        System.debug('Created Form');
          
        TestClassUtil.generateRandomString(5);
        
        }
    }

    static testMethod void salesUpUnitTest() {
       User usr = [Select Id from User where username = 'testuser128@testorgx.com' ];
        System.runAs(usr){         
        // TO DO: implement unit test
        
        TestClassUtil t= new TestClassUtil();
        t.insertAccount();
        t.insertContact();

        //t.insertServiceAppointment();
        t.insertDMSSettings();
        System.debug('Created DMS Settings'); 
        
        t.insertCRMSettings();
        System.debug('Created CRM Settings');

        t.insertSalesup();
        System.debug('Created Sales Up');  

        }    
    }

    static testMethod void inventoryUnitTest() {
        User usr = [Select Id from User where username = 'testuser128@testorgx.com' ];
        System.runAs(usr){         
        // TO DO: implement unit test
        
        TestClassUtil t= new TestClassUtil();
        t.insertAccount();
        t.insertContact();

          t.insertDMSSettings();
          System.debug('Created DMS Settings'); 
          
          t.insertCRMSettings();
          System.debug('Created CRM Settings');

          t.insertVINDecoderSetup();
          System.debug('Created VIN Decoder Settings');

          t.insertVehicleInventory();
          System.debug('Created Vehicle Inventory');
        }      
    }

    static testMethod void partsTests() {
        TestClassUtil t= new TestClassUtil();
        t.insertPartsKit();
        TestClassUtil.insertPartsMaster();

    }

    static testMethod void serviceUnitTests() {

      User usr = [Select Id from User where username = 'testuser128@testorgx.com' ];
      
      /* #W-000811 Begin */
      dealer__Dealer_Location__c ddl = [Select Id, dealer__Company_Number__c from dealer__Dealer_Location__c limit 1];      
    
      dealer__Dealer_Location_User__c objUserLocation = new dealer__Dealer_Location_User__c();
      objUserLocation.dealer__Dealer_Location__c = ddl.Id;
      objUserLocation.dealer__User__c = usr.Id;
      insert objUserLocation;      
      /* #W-000811 End */ 
      
      System.runAs(usr){ 

        TestClassUtil t= new TestClassUtil();
        t.insertDMSSettings();
        t.insertCRMSettings();        
        t.insertAccount();
        t.insertContact();

        t.insertPartsInvoice();
        t.insertInspectionReport();
        t.insertServiceAppointment();
        // t.insertServiceRepairOrder();      
        t.insertServiceJob();
      }
    }
}