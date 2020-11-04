/**
* Date            |Developer            |Work#
* Notes
* ----------------------------------------------------------------------
*
* 2016.11.29      |Gaurav               |W-000732
* Increased test coverage of TechnicianJobTimeControl Trigger and TechnicianJobTimeControlHandler handler class on dealer__Technician_Job_Time__c object
*
**/

@isTest(seeAllData=false)

private class TestTechTime {
   static testmethod void testTechTimeEntryEXT() {

        TestClassUtil util = new TestClassUtil();
        dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        if(dms == null){
            util.insertDMSSettings();   
        }
        
        Contact c = new Contact(
                    FirstName='James',
                    LastName='Rowland',
                    AccountId=null,
                    Birthdate=date.parse('01/01/1970'),
                    Email='none@blackhole.org',
                    Salutation='Mr.',
                    Phone='5302221234',
                    MailingStreet='555 Cypress Ave',
                    MailingCity='Redding',
                    MailingState='CA',
                    MailingPostalCode='96001'
            );
                    
        insert c;
        
        dealer__Service_Vehicle__c vehicle = new dealer__Service_Vehicle__c( 
                                                                                Name='TestVehicle',
                                                                                dealer__Year__c='2011',
                                                                                dealer__Make__c='Ford',
                                                                                dealer__Carline__c='Escape'
                                                                            );
        insert vehicle;                                                                 
        
        dealer__Service_Repair_Order__c sro = new dealer__Service_Repair_Order__c(  Name='testRO',
                                                                                    dealer__Vehicle__c=vehicle.Id,
                                                                                    dealer__Mileage_In__c=1234,
                                                                                    dealer__Customer_Contact__c=c.Id,
                                                                                    dealer__RO_Number__c='RO#123456'
                                                                                );
                                                                                
        insert sro;
        
        
        dealer__Service_Job__c sjl = new dealer__Service_Job__c(
                                                                Name='Line1',
                                                                dealer__Service_Repair_Order__c=sro.Id,
                                                                dealer__Line_Number__c=1,
                                                                dealer__Op_Code__c='A123'
                                                                );
        insert sjl;
        
        //W-000732
        dealer__Time_Clock__c objTimeClock = new dealer__Time_Clock__c(dealer__User__c = UserInfo.getUserId(), dealer__Clock_In__c = Date.Today());
        insert objTimeClock;
                                                            
        
        dealer__Technician_Job_Time__c tt = new dealer__Technician_Job_Time__c(
                                                                                dealer__Service_Job_Line__c=sjl.Id,
                                                                                dealer__Start_Time__c=DateTime.now(),
                                                                                dealer__Labor_Total__c = 100.0
                                                                              );
        insert tt;
        
        sjl = [SELECT Id, Name, dealer__Labor_Charges__c, dealer__Line_Number__c, dealer__Op_Code__c, dealer__Service_Repair_Order__c 
               FROM dealer__Service_Job__c WHERE Id =: sjl.Id];  
        System.assertEquals(100.0,sjl.dealer__Labor_Charges__c);
        
        PageReference ttPage = page.TechTimeEntry;
        ttPage.getParameters().put('ro', sro.Id);
        Test.setCurrentPage(ttPage);
        
        ApexPages.standardController sc = new ApexPages.Standardcontroller(tt);
        TechTimeEntry_EXT controller = new TechTimeEntry_EXT(sc);
        
        Id recordId = controller.recordId;
        dealer__FixedOperationsSettings__c fixedSettings = controller.fixedOpsSettings;

        controller.jobId = sjl.Id;
        controller.getJobLines();
        controller.getRo();
        controller.getPartsLines();
        controller.startJobDiag();
        controller.startJobRepair();
        controller.endJobClock();
        controller.timeTechTime='test';
        controller.addActualTime();
        TechTimeEntry_EXT.techActualTime ttw=new TechTimeEntry_EXT.techActualTime();
       
          ttw.actualDate=system.today();
         // ttw.actualTechnician
          ttw.actualAmount=64564;
          
          controller.getServiceHistoryJSON();
          String s='2xhiadhfkdj';
          //TechTimeEntry_EXT.setTechTime(s);
        
        // Remote Actions
        boolean validateSFH = TechTimeEntry_EXT.saveFlatHours(tt.Id+'-1.1');
        system.assertEquals(validateSFH, false);
        
        boolean failSFH = TechTimeEntry_EXT.saveFlatHours('');
        system.assertEquals(failSFH, false);
        
        TechTimeEntry_EXT.saveJobStatus(tt.Id+'-open');
        
        TechTimeEntry_EXT.saveCCCLine('');

        TechTimeEntry_EXT.setTechTime('{"date":"2016-06-02", "roNumber":"123456", "jobId":"'+sjl.Id+'", "techId":"'+UserInfo.getUserId()+'", "actual":"1.5"}');
        
        TechTimeEntry_EXT.saveCCCLine('{"Id":"'+sjl.Id+'", "CCC":"Test CCC", "Type":"concern"}');

        dealer__Time_Clock__c dtc = new dealer__Time_Clock__c();
        dtc.dealer__Clock_In__c=system.today();
        dtc.dealer__User__c=UserInfo.getUserId(); 
        insert dtc;
        
    }
}