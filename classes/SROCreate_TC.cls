/**
* Date            |Developer            |Work#
* Notes
* --
* 2016.12.15      |Gaurav               |#W-000811
* Modified class failing because of SRO location
**/

@isTest
private class SROCreate_TC{

  @testSetup static void testDataInsert() {
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
                Division='DT1');
      insert usr;

  }  

  static testmethod Void Myunittest(){

      dealer__FixedOperationsSettings__c fixedSettings = dealer__FixedOperationsSettings__c.getOrgDefaults();
                 
      if(fixedSettings.dealer__Repair_Order_Index__c == null) 
      {
           fixedSettings.dealer__Repair_Order_Index__c = 7000;
      }
      fixedSettings.dealer__Repair_Order_Index__c += 1;
       
      insert fixedSettings;

      User u = [Select Id from User where username = 'testuser128@testorgx.com'];
      
      /* #W-000811 Begin */
      dealer__Dealer_Location__c ddl = [Select Id, dealer__Company_Number__c from dealer__Dealer_Location__c limit 1];      
      
      dealer__Dealer_Location_User__c objUserLocation = new dealer__Dealer_Location_User__c();
      objUserLocation.dealer__Dealer_Location__c = ddl.Id;
      objUserLocation.dealer__User__c = u.Id;
      insert objUserLocation; 
      
      /* #W-000811 End */          
      
      System.runAs(u) {

        Contact con = new Contact();
        con.Phone = '8888888';
        con.LastName = 'Test';
        insert con;

        RecordType rt = [select Id, Name from RecordType where isPersonType=true limit 1];
        Account a = new Account(RecordTypeId=rt.Id);
        a.LastName ='Test';
        a.AccountSource ='Dealer';
        a.FirstName='test';
        a.PersonHomePhone='1236536586';
        a.PersonMobilePhone='12345676796';
        a.PersonEmail='Test@gmail.com';
        insert a;                 

        dealer__Vehicle_Inventory__c dvi = new dealer__Vehicle_Inventory__c();
        dvi.dealer__VIN__c ='test';
        dvi.dealer__Vehicle_Order_Number__c ='Test';
        dvi.dealer__Make__c='Test';
        dvi.dealer__Model__c='Test';
        dvi.dealer__Stock_Number__c='1';
        dvi.dealer__Year__c='2014';
        insert dvi;

        dealer__Service_Vehicle__c  dsv = new dealer__Service_Vehicle__c ();
        dsv.Name='Test';
        //dsv.dealer__VIN__c ='Test';
        dsv.dealer__Body_Style__c = 'Test';
        dsv.dealer__Company_Number__c='12123';
        dsv.dealer__Veh_Owner_Contact__c = con.id;
        dsv.dealer__Carline__c ='Test';
        dsv.dealer__Make__c  ='Test';
        dsv.dealer__Year__c  ='2013';
        dsv.dealer__Last_Odometer__c =1;
        dsv.dealer__Sales_Inventory__c =dvi.id;
        insert dsv;

        dealer__Service_Repair_Order__c dsr = new dealer__Service_Repair_Order__c();
        dsr.dealer__Customer__c =a.id;
        dsr.dealer__Mileage_In__c =0;
        dsr.dealer__Vehicle_Inventory__c=dvi.id;
        //dsr.dealer__Vehicle__c ='';
        dsr.dealer__RO_Number__c ='TEMP';
        dsr.dealer__Company__c = ddl.Id;
        dsr.dealer__Company_Number__c = ddl.dealer__Company_Number__c;
        dsr.dealer__Service_Advisor__c = UserInfo.getUserId();
        dsr.dealer__RO_Number__c = 'TEMP';

        insert dsr;


        ApexPages.StandardController sc = new ApexPages.StandardController(dsr);
        ApexPages.currentPage().getParameters().put('id', dsr.id);
        SROCreate scr= new SROCreate(new ApexPages.StandardController(dsr));
        scr.save();

         ApexPages.currentPage().getParameters().put('customer',a.id);
          ApexPages.currentPage().getParameters().put('vehicle',dvi.id);

        Account acc=[Select PersonContactId from Account where LastName ='Test'];
        //scr.personsAccountReference='';
        Map<String, String> urlParameters = new Map<String, String>();
         
        //scr.lookupPersonsAccountId(con.id);
        scr.lookupPersonsAccountId(acc.PersonContactId );
        scr.lookupVehicleInventory(dvi.Id);



        RecordType rt2 = [select Id, Name from RecordType where isPersonType=false and Name like 'Bus%' limit 1];
        Account a2 = new Account(RecordTypeId=rt2.Id);
        a2.Name ='Test2 acct';
        //a2.AccountSource ='Dealer';
        a2.Phone='1236536589';
        a2.BillingState='OH';
        a2.BillingPostalCode='44641';
        insert a2;

        Contact con2 = new Contact();
        con2.Phone = '8888889';
        con2.LastName = 'Test9';
        con2.AccountId = a2.Id;
        insert con2;
      }
  }

  static testmethod void testROCreate() {

        dealer.TestClassUtil t = new dealer.TestClassUtil();
        
        Account a = new Account();
        a.LastName ='Test';
        a.AccountSource ='Dealer';
        insert a;
    
        dealer__Dealer_Location__c ddl = new dealer__Dealer_Location__c();
        ddl.Name ='Test';
        ddl.dealer__City__c ='Test';
        ddl.dealer__Postal_Code__c='301352';
        ddl.dealer__State__c='Te';
        ddl.dealer__Company_Number__c='SAN';
        ddl.dealer__Service_Director__c =Userinfo.getuserid();
        insert ddl;
    
        dealer__Service_Repair_Order__c dsr = new dealer__Service_Repair_Order__c();
        dsr.dealer__Customer__c =a.id;
        dsr.dealer__Mileage_In__c =12;
        dsr.dealer__RO_Number__c ='11';
        //dsr.dealer__Posted_Date_Time__c =system.today();
        //dsr.dealer__Status__c = 'Posted';
        dsr.dealer__Status__c = 'Open';
        //dsr.dealer__Customer_Invoice_Total__c =0;
        dsr.dealer__Customer_Charges__c =12;
        dsr.dealer__Tax__c =11;
        dsr.dealer__Hazardous_Materials__c =16;
        dsr.dealer__Shop_Supplies__c=12;
        dsr.dealer__Discount_Total__c =11;
        //dsr.dealer__Company__c = [Select Id from dealer__Dealer_Location__c where dealer__Company_Number__c = 'SAN' limit 1].Id;
        //dsr.dealer__Company__c=ddl.id;
        insert dsr;

  }


}