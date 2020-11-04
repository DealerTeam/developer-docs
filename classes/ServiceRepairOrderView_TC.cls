/**
* Date            |Developer            |Work#
* Notes
* --
* 2016.12.15      |Gaurav               |#W-000811
* Modified class failing because of SRO location
**/

@isTest
private class ServiceRepairOrderView_TC{
    
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
                  username='testuser128@testorgx.com',
                  Division='DT1');
                  insert usr;

    }



    static testmethod Void testROview() {

        User u = [Select Id from User where username = 'testuser128@testorgx.com' limit 1];
        
        /* #W-000811 Begin */
        dealer__Dealer_Location__c ddl = [Select Id, dealer__Company_Number__c from dealer__Dealer_Location__c limit 1];      
        
        dealer__Dealer_Location_User__c objUserLocation = new dealer__Dealer_Location_User__c();
        objUserLocation.dealer__Dealer_Location__c = ddl.Id;
        objUserLocation.dealer__User__c = u.Id;
        insert objUserLocation; 
        
        /* #W-000811 End */                
        
        System.runAs(u) {

            Account a = new Account();
            a.LastName ='Test';
            a.AccountSource ='Dealer';
            a.BillingState = 'CA';
            insert a;

            contact con = new contact();
            con.Phone = '8888888';
            con.LastName = 'Test';
            insert con;

            dealer__Service_Vehicle__c  dsv = new dealer__Service_Vehicle__c ();
            dsv.dealer__VIN__c ='TestAAAA00001980';
            dsv.Name='Test';
            dsv.dealer__Body_Style__c = 'Test';
            dsv.dealer__Company_Number__c='DT1';
            dsv.dealer__Veh_Owner_Contact__c = con.id;
            dsv.dealer__Carline__c ='Test';
            dsv.dealer__Make__c  ='Test';
            dsv.dealer__Year__c  ='2013';
            insert dsv;

            dealer__Dealer_Location__c objLocation = new dealer__Dealer_Location__c();
            objLocation.Name = 'Test Location 003';
            objLocation.dealer__City__c = 'Test City';
            objLocation.dealer__Company_Number__c = '101';
            objLocation.dealer__Postal_Code__c = '1245632';
            objLocation.dealer__State__c = 'CA';
            insert objLocation;

            dealer__Service_Repair_Order__c dsr = new dealer__Service_Repair_Order__c();
            dsr.dealer__Customer__c =a.id;
            dsr.dealer__Mileage_In__c =12;
            dsr.dealer__RO_Number__c ='111979';
            dsr.dealer__VIN__c = dsv.dealer__VIN__c;
            dsr.dealer__Vehicle__c = dsv.Id;
            dsr.dealer__Company_Number__c='DT1';
            dsr.dealer__Company__c = objLocation.id;

            insert dsr;

            Attachment attach=new Attachment();     
            attach.Name='Unit Test Attachment';
            Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
            attach.body=bodyBlob;
            attach.parentId=dsr.id;
            insert attach;

            dealer__Service_Job__c dsj = new dealer__Service_Job__c();
             dsj.dealer__Cause__c ='Test';
             dsj.dealer__Labor_Charges__c =12;
             dsj.dealer__Service_Repair_Order__c =dsr.id;
            insert dsj;

            dealer__Time_Clock__c dtc = new dealer__Time_Clock__c();
             dtc.dealer__Clock_Out__c =system.today();
             dtc.dealer__Clock_In__c =system.today();
             dtc.dealer__User__c =UserInfo.getUserId();
             //dtc.Date__c =system.today(); 
            insert dtc;

            dealer__Technician_Job_Time__c  dtj = new dealer__Technician_Job_Time__c ();
                dtj.Name ='Test';
                dtj.dealer__Service_Job_Line__c =dsj.id;
                dtj.dealer__Start_Time__c=system.today();
                dtj.dealer__End_Time__c =system.today();
                dtj.Time_Clock_Entry__c =dtc.id;
                dtj.dealer__Time_Clock__c =dtc.id;
                dtj.Labor_Total__c =23;
            insert dtj;

            dealer__FixedOperationsSettings__c fops = dealer__FixedOperationsSettings__c.getOrgDefaults();
            fops.dealer__Service_Repair_Order_PDF__c = '/apex/ServiceRepairOrderPDF';
            upsert fops;

            ApexPages.StandardController sc = new ApexPages.StandardController(dsr);
            ApexPages.currentPage().getParameters().put('id', dsr.id);
            ServiceRepairOrderView sr = new ServiceRepairOrderView(new ApexPages.StandardController(dsr));
            List<ServiceRepairOrderView.AttachmentClass> newInner = new List<ServiceRepairOrderView.AttachmentClass>();
            ServiceRepairOrderView.AttachmentClass att = new ServiceRepairOrderView.AttachmentClass(attach);
            ServiceRepairOrderView.AttachmentClass att2 = new ServiceRepairOrderView.AttachmentClass(true, attach);
            att.selected = true;
            newInner.add(att);

            sr.listAttachment = newInner; 
            sr.save();
            PageReference pr = sr.updateVehicle();

            sr.detailUpdate();
            sr.upload();
            ServiceRepairOrderView.loadServiceJobLines(dsr.id);
            ServiceRepairOrderView.laborTotal(dsr.id);
            sr.TOADDRESS = 'testEmailRPOT432154@gmail.com';    
            PageReference  emailPage = sr.sendPDF();
            PageReference  emailSRO = sr.emailSRO();


            sr.returnToRo();
            sr.rId='Test';
        }
    }
}