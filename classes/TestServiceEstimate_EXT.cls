/**
* Date            |Developer            |Work#
* Notes
* --
* 2017.01.23      |Gaurav               |W-000903
* Modified to increase coverage of ServiceEstimateControl Trigger on  Service Estimate object
**/

@isTest 
private class TestServiceEstimate_EXT { 
    
    static testmethod void testServiceEXT() {

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
            dms.dealer__Service_Current_Invoice_Number__c = 30093;
            dms.dealer__Service_Job_Line_Number__c = 8;
            //dms.dealer__State_Tax_Rate__c = 7.75;
            dms.dealer__Parts_Current_Invoice_Number__c = 50115;
            dms.dealer__Parts_Current_Quote_Number__c = 20028;
            dms.dealer__Default_Tax_Rate__c = 7.75;
            dms.dealer__Service_Appointment_Sequence_Number__c=2000;
            insert dms;   
        }        
       
        dealer__Vehicle_Inventory__c VI = new dealer__Vehicle_Inventory__c();
        VI.Name = 'Test Vehicle Inventory';
        VI.dealer__Model__c = '2014';
        VI.dealer__Stock_Number__c = '17271737';
        VI.dealer__VIN__c = '100';
        VI.dealer__Company_Number__c = 'Location 1';
        VI.dealer__Year__c = '2014';
        VI.dealer__Make__c = '2014';
        insert VI;
        
        Account acc = new Account(Name='Redding Motors');
        insert acc;
            
       /* Service_vehicle__c sv = [SELECT Id FROM Service_Vehicle__c LIMIT 1];
        sv.Veh_Owner__c = acc.Id;
        update sv;*/
        
        ServiceEstimateCreateController.Company(usr.Id);
        
        RecordType rselected = [Select Id, Name, DeveloperName  from RecordType where DeveloperName = 'X4_Square' limit 1];
        
        dealer__Service_Estimate__c se = new dealer__Service_Estimate__c(
                                                                dealer__Cosmetic_Notes__c='Repair / Repaint Bumper', 
                                                                RecordTypeId=rselected.Id
                                            );
        insert se;
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(se);
        ServiceEstimate_EXT controller = new ServiceEstimate_EXT(sc);
        // Test Record Type
        RecordType r = [Select Id, Name, DeveloperName  from RecordType where Id = :se.RecordTypeId limit 1];
        System.assertEquals(se.RecordTypeId, r.Id);
        controller.addPart();
        controller.addService();
        controller.addSublet();
        controller.noRefresh();
        controller.emailButton();
        //controller.finalize();
        controller.addCosmetic();
        controller.Save();
        controller.saveEstimate();
        controller.getROJobLines();
        System.assertEquals(controller.ShowRecord, '4-Square');
        System.assertEquals(controller.RecordID, se.Id);
        Messaging.EmailFileAttachment myAttachment = controller.AttachPDF();
        // Test Send withouth a receipient
        controller.sendPdf();
        // Insert user account with email address
        User u = [Select Id, Email from User where Username = 'testuser128@testorgx.com' limit 1];
        // Test Send with a receipient
        se.dealer__EmailApprover__c = u.Id;
        controller.subject = 'Test Email';
        controller.body = 'Test <B>Body</B>';
        controller.sendPdf();
        // Test alternate Record Type
        Account a = new Account(Name='Test User', dealer__Billing_Email__c='test@test.com');
        insert a;
        RecordType r2 = [Select Id, Name, DeveloperName  from RecordType where Name = 'Service Estimate' limit 1];
        dealer__Service_Estimate__c se2 = new dealer__Service_Estimate__c(
                                                                dealer__Cosmetic_Notes__c='Repair / Repaint Bumper', 
                                                                RecordTypeId=r2.Id,
                                                                dealer__Customer__c=a.Id
                                            );

        insert se2;
        ApexPages.Standardcontroller sc2 = new ApexPages.Standardcontroller(se2);
        ServiceEstimate_EXT controller_after_RChange = new ServiceEstimate_EXT(sc2);
        controller_after_RChange.subject = 'Test Email';
        controller_after_RChange.body = 'Test <B>Body</B>';
        controller_after_RChange.sendPdf();
        // Test Record Type
        RecordType rAfter = [Select Id, Name from RecordType where Id = :se.RecordTypeId limit 1];
        System.assertEquals(se.RecordTypeId, rAfter.Id);

        }        
    }
    
    static testMethod void TestServiceEstimateWithInventoryVehicle() {

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
            dms.dealer__Service_Current_Invoice_Number__c = 30093;
            dms.dealer__Service_Job_Line_Number__c = 8;
            //dms.dealer__State_Tax_Rate__c = 7.75;
            dms.dealer__Parts_Current_Invoice_Number__c = 50115;
            dms.dealer__Parts_Current_Quote_Number__c = 20028;
            dms.dealer__Default_Tax_Rate__c = 7.75;
            dms.dealer__Service_Appointment_Sequence_Number__c=2000;
            insert dms;   
        }
        dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c(
                                                Name='test',
                                                dealer__VIN__c='3GNEK12Z15G244588',
                                                dealer__Make__c='Chevrolet',
                                                dealer__Model__c='1500',
                                                dealer__Stock_Number__c='VT100',
                                                dealer__Year__c='2012'
                                            );
        Contact c1=new Contact(FirstName='test',lastName='test');
        insert c1;
        insert inv;
        RecordType rselected = [Select Id, Name, DeveloperName from RecordType where DeveloperName = 'X4_Square' limit 1];
        dealer__Service_Estimate__c se = new dealer__Service_Estimate__c(
                                                                dealer__Cosmetic_Notes__c='Repair / Repaint Bumper', 
                                                                RecordTypeId=rselected.Id,dealer__Customer_Contact__c=c1.id
                                            );
        
                                                
        PageReference pageRef = Page.Inventory_Mobile_4SquareNew;
        pageRef.getParameters().put('vId', String.valueOf(inv.Id));
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(se);
        ServiceEstimate_EXT c = new ServiceEstimate_EXT(sc);
        c.getEstimateLines();  
        c.convertToRO();    
        c.setInventoryVehicleId(ApexPages.currentPage().getParameters().get('vId'));
        System.assertEquals(c.getInventoryVehicleId(), ApexPages.currentPage().getParameters().get('vId'));
        c.getVehicle();
        System.assert(inv.Id!=null);  
        c.saveMobile4Square();    
        System.assert(true, c.getHasEstimateLines());
        System.assert(true, c.getHasActivityHistories());    

        }   
    }
    
    static testmethod void TestServiceLineController() {

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

        if(dealer__TaxSettings__c.getValues('ActiveSettings') == null){
            dealer__TaxSettings__c taxSettings = new dealer__TaxSettings__c();
            taxSettings.Name = 'ActiveSettings';
            taxSettings.dealer__State_Tax_Rate__c = 7.75;
            taxSettings.dealer__State_Code__c = 'PP';
            insert taxSettings;
        }
        RecordType rselected = [Select Id, Name, DeveloperName  from RecordType where DeveloperName = 'X4_Square' limit 1];
        dealer__Service_Estimate__c se = new dealer__Service_Estimate__c(
                                                                dealer__Cosmetic_Notes__c='Repair / Repaint Bumper', 
                                                                RecordTypeId=rselected.Id
                                            );
        insert se;   
        dealer__Service_Estimate_Line__c sel = new dealer__Service_Estimate_Line__c(
                                                        dealer__Service_Estimate__c=se.Id,
                                                        dealer__Labor__c=100,
                                                        dealer__Parts__c=50
                                                    );
        insert sel;
        ApexPages.Standardcontroller sl = new ApexPages.Standardcontroller(sel);
        ServiceEstimateLine_EXT lineController = new ServiceEstimateLine_EXT(sl); 
        lineController.getlopName();
        System.assertEquals(null, lineController.getlopName());
        // False Test
        lineController.setlopName('LOP');  
        lineController.setLaborOpValues();
        System.assertEquals(null, lineController.setLaborOpValues());
        // True Test
        lineController.setlopName('00VTNITRO');
        lineController.setLaborOpValues();
        // System.assertEquals(Decimal.valueOf('34.95'), lineController.sel.dealer__Labor__c);
        lineController.save();

        }
    }
    // Test ServiceEstimate Trigger
    static testmethod void testSETrigger() {

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
                  
        System.runAs(usr){ 

        dealer__Service_Estimate__c se = new dealer__Service_Estimate__c();
        //dealer__Vehicle_Inventory__c inv = [Select Id from dealer__Vehicle_Inventory__c limit 1];
        dealer__Vehicle_Inventory__c VI = new dealer__Vehicle_Inventory__c();
        VI.Name = 'Test Vehicle Inventory';
        VI.dealer__Model__c = '2014';
        VI.dealer__Stock_Number__c = '17271737';
        VI.dealer__VIN__c = '100';
        VI.dealer__Company_Number__c = 'Location 1';
        VI.dealer__Year__c = '2014';
        VI.dealer__Make__c = '2014';
        insert VI;
        se.dealer__Inventory_Vehicle__c = VI.Id;
        se.dealer__Status__c = 'Open';
        // se.Company__c = loc.Id;
        //W-000903
        se.dealer__Current_Mileage__c = 50;
        insert se;
        se.dealer__Status__c = 'Finalized';
        se.dealer__Current_Mileage__c = 100;
        // update se;
        }
    }

    // test service estimate API
    static testmethod void testServiceEstimateAPI() {
       
       TestClassUtil tcu = new TestClassUtil();
       dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
       loc.dealer__Tax_Service__c = false;
       loc.dealer__Tax_Parts__c = false;
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
                dms.dealer__Service_Current_Invoice_Number__c = 30093;
                dms.dealer__Service_Job_Line_Number__c = 8;
                //dms.dealer__State_Tax_Rate__c = 7.75;
                dms.dealer__Parts_Current_Invoice_Number__c = 50115;
                dms.dealer__Parts_Current_Quote_Number__c = 20028;
                dms.dealer__Default_Tax_Rate__c = 7.75;
                dms.dealer__Service_Appointment_Sequence_Number__c=2000;
                insert dms;   
            } 

            Account a = new Account(Firstname='John', LastName='Wilson');
            insert a;


            // Create the Estimate Header
            Service_Estimate__c se = new Service_Estimate__c();
            se.Store_Location__c = loc.Id;
            se.Customer__c = a.Id;
            se.Current_Mileage__c = 19000;
            se.Service_Vehicle__c = tcu.insertServiceVehicle();

            insert se;

            // Create / Update lines and sublines
            Service_Estimate_Line__c newLine = ServiceEstimateAPI.createEstimateLine(
                new Service_Estimate_Line__c(
                        Description__c='Test Line Header', 
                        Labor_Operation__c=tcu.insertStdOpcode(),
                        Labor_Type__c='C',
                        Service_Estimate__c=se.Id
                    )
                );

            ServiceEstimateAPI.updateEstimateLine(
                new Service_Estimate_Line__c(
                    Id=newLine.Id,
                    Description__c='Test Line Header Update',
                    Labor_Type__c='W'
                )
            );

            // Sub Lines
            Service_Estimate_SubLine__c newSubLine = ServiceEstimateAPI.createSubLine(
                new Service_Estimate_SubLine__c(
                    Book_Time__c=1.2,
                    Labor_Rate__c=90,
                    Line_Type__c='Labor',
                    Service_Estimate_Line__c=newLine.Id
                )
            );


            ServiceEstimateAPI.updateSubLine(
                new Service_Estimate_SubLine__c(
                    Id=newSubLine.Id,
                    Book_Time__c=1.9
                )               
            );

            // Read Events
            List<MiscChargeCode__c> chargeCodes = ServiceEstimateAPI.miscChargeCodes(loc.Id);
            List<Service_Estimate_Line__c> estLines = ServiceEstimateAPI.estimateLines(se.Id);
            List<Service_Estimate_SubLine__c> subLines = ServiceEstimateAPI.estimateSubLines(newSubLine.Id);
            List<Service_Estimate_SubLine__c> readsl = ServiceEstimateAPI.readSubLines(newSubLine.Id);
            List<Service_Estimate_SubLine__c> readsl2 = ServiceEstimateAPI.readSubLines(new Set<Id>{ newSubLine.Id });
            List<Service_Estimate_SubLine__c> readsl3 = ServiceEstimateAPI.readSubLines(newLine.Id, 'Labor');

            // Delete Events
            ServiceEstimateAPI.deleteSubLine(newSubLine.Id);
            ServiceEstimateAPI.deleteEstimateLine(newLine.Id);

        }
    }

    static testmethod void testServiceEstimateWorksheet_EXT() {
        
       TestClassUtil tcu = new TestClassUtil();
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
                dms.dealer__Service_Current_Invoice_Number__c = 30093;
                dms.dealer__Service_Job_Line_Number__c = 8;
                //dms.dealer__State_Tax_Rate__c = 7.75;
                dms.dealer__Parts_Current_Invoice_Number__c = 50115;
                dms.dealer__Parts_Current_Quote_Number__c = 20028;
                dms.dealer__Default_Tax_Rate__c = 7.75;
                dms.dealer__Service_Appointment_Sequence_Number__c=2000;
                insert dms;   
            } 

            Account a = new Account(Firstname='John', LastName='Wilson');
            insert a;

            // create an opeartion code
            Id opCode = tcu.insertStdOpcode();

            // Create the Estimate Header
            Service_Estimate__c se = new Service_Estimate__c();
            se.Store_Location__c = loc.Id;
            se.Customer__c = a.Id;
            se.Current_Mileage__c = 19000;
            // se.Service_Vehicle__c = tcu.insertServiceVehicle();

            insert se;

            // Test the Controller

            // Test.StartTest();
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(se);
            ServiceEstimateWorksheet_EXT sew = new ServiceEstimateWorksheet_EXT(sc);

            // PageReferences
            sew.reloadDetail();

            // Test the remotes.    
            List<StandardOpCode__c> ops = ServiceEstimateWorksheet_EXT.operationCodes();
            List<MiscChargeCode__c> mcodes = ServiceEstimateWorksheet_EXT.miscChargeCodes(loc.Id);

            Service_Estimate_Line__c sel = ServiceEstimateWorksheet_EXT.createEstimateLine(JSON.serialize(
                new Service_Estimate_Line__c(
                    Description__c='Test Line Header', 
                    Labor_Operation__c=opCode,
                    Labor_Type__c='C',
                    Service_Estimate__c=se.Id
                )
            ));      
            
            // SubLines
          /*  Service_Estimate_SubLine__c subl = ServiceEstimateWorksheet_EXT.createSubLine(JSON.serialize(
                new Service_Estimate_SubLine__c(
                    Book_Time__c=1.2,
                    Labor_Rate__c=90,
                    Line_Type__c='Labor',
                    Service_Estimate_Line__c=sel.Id
                )
            ));

            ServiceEstimateWorksheet_EXT.updateSubLine(JSON.serialize(
                new Service_Estimate_SubLine__c(
                    Id=subl.Id,
                    Book_Time__c=1.9
                )
            ));

            // SubLine Errors
            // ServiceEstimateWorksheet_EXT.updateSubLine(JSON.serialize(new Service_Estimate_Line__c(Description__c='Bad Record'))); // Expecting JSON of SubLine Object
            ServiceEstimateWorksheet_EXT.readSubLines('NoParts'); //Expecting Id+'~Labor' <id> ~ <labortype>


            // Reads
            ServiceEstimateWorksheet_EXT.readSubLines(sel.Id+'~Labor');
            ServiceEstimateWorksheet_EXT.estimateLines(se.Id);

            // Deletes
            //ServiceEstimateWorksheet_EXT.deleteSubLine(subl2.Id);
           // ServiceEstimateWorksheet_EXT.deleteEstimateLine(sel2.Id);*/

            Test.startTest();
            // Convert Method
           	 Id ro = ServiceEstimateWorksheet_EXT.convertToRepairOrder(se.Id);

            Test.stopTest(); 
        }     
    } 

    static testmethod void testServicePrintDocument() {

       TestClassUtil tcu = new TestClassUtil();
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
        
         // Add default application logo
        if([Select Id from Document Where DeveloperName = 'InvoiceLogo'].size() == 0) {
            Document doc = new Document();
            doc.Name = 'InvoiceLogo';
            doc.DeveloperName = 'InvoiceLogo';
            doc.FolderId = userinfo.getUserId();
            doc.Body = Blob.valueOf('DT Logo');
            insert doc;                
        }
        
                  
        System.runAs(usr){ 

            if(dealer__DMS_Settings__c.getValues('ActiveSettings') == null){
                dealer__DMS_Settings__c dms = new dealer__DMS_Settings__c();
                dms.Name = 'ActiveSettings';
                dms.dealer__Service_Current_Invoice_Number__c = 30093;
                dms.dealer__Service_Job_Line_Number__c = 8;
                //dms.dealer__State_Tax_Rate__c = 7.75;
                dms.dealer__Parts_Current_Invoice_Number__c = 50115;
                dms.dealer__Parts_Current_Quote_Number__c = 20028;
                dms.dealer__Default_Tax_Rate__c = 7.75;
                dms.dealer__Service_Appointment_Sequence_Number__c=2000;
                insert dms;   
            } 

            Account a = new Account(Firstname='John', LastName='Wilson');
            insert a;

            // create an opeartion code
            Id opCode = tcu.insertStdOpcode();

            // Create the Estimate Header
            Service_Estimate__c se = new Service_Estimate__c();
            se.Store_Location__c = loc.Id;
            se.Customer__c = a.Id;
            se.Current_Mileage__c = 19000;
            se.Service_Vehicle__c = tcu.insertServiceVehicle();

            insert se;

            // Test the Controller

            Service_Estimate_Line__c sel = ServiceEstimateWorksheet_EXT.createEstimateLine(JSON.serialize(
                new Service_Estimate_Line__c(
                    Description__c='Test Line Header', 
                    Labor_Operation__c=opCode,
                    Labor_Type__c='C',
                    Service_Estimate__c=se.Id
                )
            ));

           Service_Estimate_Line__c sel2 = ServiceEstimateWorksheet_EXT.createEstimateLine(JSON.serialize(
                new Service_Estimate_Line__c(
                    Description__c='Test Line Header', 
                    Labor_Operation__c=opCode,
                    Labor_Type__c='C',
                    Service_Estimate__c=se.Id
                )
            ));            

            ServiceEstimateWorksheet_EXT.updateEstimateLine(JSON.serialize(
                new Service_Estimate_Line__c(
                    Id=sel.Id,
                    Description__c='Test Update Line Desc.'
                )
            ));

            // SubLines
         /*   Service_Estimate_SubLine__c subl = ServiceEstimateWorksheet_EXT.createSubLine(JSON.serialize(
                new Service_Estimate_SubLine__c(
                    Book_Time__c=1.2,
                    Labor_Rate__c=90,
                    Line_Type__c='Labor',
                    Service_Estimate_Line__c=sel.Id
                )
            ));

            Service_Estimate_SubLine__c subl2 = ServiceEstimateWorksheet_EXT.createSubLine(JSON.serialize(
                new Service_Estimate_SubLine__c(
                    Book_Time__c=1.2,
                    Labor_Rate__c=90,
                    Line_Type__c='Labor',
                    Service_Estimate_Line__c=sel.Id
                )
            ));            

            ServiceEstimateWorksheet_EXT.updateSubLine(JSON.serialize(
                new Service_Estimate_SubLine__c(
                    Id=subl.Id,
                    Book_Time__c=1.9
                )
            ));*/

        
            Test.startTest();

                // Test service estimate print functionality
                ApexPages.Standardcontroller standardPrintController = new ApexPages.Standardcontroller(se);
                ServiceEstimatePrint printController = new ServiceEstimatePrint(standardPrintController);

                // Prepare the document
                printController.getEstimate();

            Test.stopTest(); 

        }       
    }
}