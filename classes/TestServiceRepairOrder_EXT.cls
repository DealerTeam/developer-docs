/**
* Date            |Developer            |Work#
* Notes
* --
* 2016.12.15      |Gaurav               |#W-000811
* Modified class failing because of SRO location
**/

@isTest
private class TestServiceRepairOrder_EXT {
    
    @testSetup static void testSetup() {
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

        tu.insertAccount();
        tu.insertContact();

    }     

    static testmethod void testSRO() {
    
        TestClassUtil tu = new TestClassUtil();
        tu.insertCRMSettings();
        dealer__CRMSettings__c crm = dealer__CRMSettings__c.getOrgDefaults();
        crm.dealer__DisablePersonAccounts__c=true;
        update crm;

        if(dealer__DMS_Settings__c.getValues('ActiveSettings') == null){
            dealer__DMS_Settings__c dms = new dealer__DMS_Settings__c();
            dms.Name = 'ActiveSettings';
            dms.dealer__Service_Current_Invoice_Number__c = 30093;
            dms.dealer__Service_Job_Line_Number__c = 8;
            dms.dealer__Parts_Current_Invoice_Number__c = 50115;
            dms.dealer__Parts_Current_Quote_Number__c = 20028;
            dms.dealer__Default_Tax_Rate__c = 7.75;
            dms.dealer__Service_Appointment_Sequence_Number__c=2000;
            insert dms;  
        }
        
        if([Select Id from Document Where DeveloperName = 'InvoiceLogo'].size() == 0){
            Document doc = new Document();
            doc.DeveloperName = 'InvoiceLogo';
            doc.Name = 'InvoiceLogo';
            doc.FolderId = UserInfo.getUserId();
            insert doc;
        }
        
        Id locId = [Select Id from dealer__Dealer_Location__c limit 1].Id;


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
                   

        Account a = new Account(
            Name='James Rowland'
        );

        insert a;

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
                                                                                    dealer__RO_Number__c='RO#123456' //,    //W-000811
                                                                                    //dealer__Company__c = locId            //W-000811
                                                                                );
                                                                                
        insert sro;
        dealer__Service_Job__c sjl = new dealer__Service_Job__c(
                                                                Name='Line1',
                                                                dealer__Service_Repair_Order__c=sro.Id,
                                                                dealer__Line_Number__c=1,
                                                                dealer__Op_Code__c='A123'
                                                                );
        insert sjl;                     
    
        //String appointId = TestClassUtil.insertServiceAppointment()
        dealer__Service_Appointment__c SA = new dealer__Service_Appointment__c();
        SA.Name = 'Test Appointment';
        SA.dealer__Date_Time__c = System.now();
        SA.dealer__External_Id__c = '12345';
        SA.dealer__Vehicle__c = vehicle.Id;
        SA.dealer__Mileage__c = 100;
        
        insert SA;


        PageReference sroPage = page.ServiceRepairOrder;
        sroPage.getParameters().put('id', sro.Id);
        sroPage.getParameters().put('vehicle', vehicle.Id);
        sroPage.getParameters().put('customer', c.Id);
        sroPage.getParameters().put('aptId', SA.Id);
        Test.setCurrentPage(sroPage);
        
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(sro);
        ServiceRepairOrder_EXT ctl = new ServiceRepairOrder_EXT(sc);

        Test.startTest();
        //ctl.serviceHistoryJSON(vehicle.Id);
        System.assert(ctl.ro!=null);
        ctl.getDMSDefaults();
        ctl.getInvoiceLogo();
        List<dealer__Parts_Invoice_Line__c> inlines = ctl.getServicePartsList();
        ctl.getUserName();
        ctl.getUserId();
        ctl.getestimateApprovalMethod();
        ctl.setestimateApprovalMethod('Email');
        ctl.redirectInit();
        ctl.addCustomer();
        ctl.techTimeEntry();
        ctl.invoiceRO();
        ctl.reopenInvoice();
        ctl.cashierInvoice();
        ctl.searchCustomerInput='Angela';
        ctl.SearchCustomer();
        ctl.searchVehicleInput='Honda';
        ctl.SearchVehicle();
        ctl.getNewVehicleResource();
        ctl.updateEstimate();
        ctl.estimateApprovalMethod='email';
        ctl.estimateApprovedBy='Jarrett';
        ctl.estimateNotes='test';
        ctl.newEstimate=Decimal.valueOf('99.99');
        ctl.updateEstimate();
        ctl.updateEstaimtePageReference();

        ctl.buildJobList();
        ctl.save();
        System.assertEquals(datetime.now().format('MM/dd/yyyy HH:mm a'),ctl.printDateTime);
        dealer__FixedOperationsSettings__c fixedOpsSettings = ctl.fixedOpsSettings;

        // Remote Actions
        //dealer__StandardOpCode__c sop = [Select Id,Name from dealer__StandardOpCode__c where isDeleted = false limit 1];
        
        dealer__StandardOpCode__c sop = new dealer__StandardOpCode__c();
        sop.dealer__Op_Code__c = '01VTZXX';
        sop.dealer__Concern__c = 'Test';
        sop.Name = 'Test Op Code';
        sop.dealer__Op_Code_Description__c = 'RECOMMENDED MAINT';
        sop.dealer__Concern__c = 'Test';
        sop.dealer__Active__c = true;
        sop.dealer__Pay_Type__c = 'C';
        sop.dealer__Book_Time__c = 0.0;
        sop.dealer__Labor_Estimate__c = .00;
        sop.dealer__Parts_Estimate__c = .00;
        sop.dealer__Company_Number__c = '1';
        insert sop;
        
        ServiceRepairOrder_EXT.getOpCode(sop.Name);
       // ServiceRepairOrder_EXT.CreateRepairOrder('{"data":[{"lId":"'+sop.Id+'-1","Id":"'+sop.Id+'","OpCode":"01VTZXX","Description":"RECOMMENDED MAINT","Concern":"Test","PayMethod":"C","BookTime":"0.0","Est":".00","LineNumber":1}],"Advisor":"'+userinfo.getUserId()+'","Customer":"'+a.Id+'","Vehicle":"'+vehicle.Id+'","Tag":"","Mileage":"123","PromiseDate":"","PromiseTime":"","Comments":"","Waiter":"false"}');
        ServiceRepairOrder_EXT.loadServiceJobLines(sro.Id);
        ServiceRepairOrder_EXT.addServiceLine('<invoice><serviceroid>'+sro.Id+'</serviceroid><servicename>RO#30017</servicename><lId>'+sop.Id+'-5</lId><Id>'+sop.Id+'</Id><OpCode>00VTUCCL</OpCode><Description>PERFORM USED CAR SHAKE AND REPORT</Description><Concern></Concern><PayMethod>I</PayMethod><BookTime>1.70</BookTime><Est>55.00</Est><LineNumber>5</LineNumber></invoice> ');
        // Test IF
        ctl.addVehicle();
        ctl.redirectInit();
        ctl.addCustomer();
        ctl.techTimeEntry();
        ctl.cashierInvoice();
        ctl.getInventoryStatusOptions();
        ctl.getServiceJobList();
        ctl.getJobList();

        ctl.techJobCard();

        ctl.assignTech();
        ctl.techId = UserInfo.getUserId();
        ctl.assignTech();
        ctl.openTechCard();
        ctl.getServiceHistoryJSON();


        Test.stopTest();
    }
}