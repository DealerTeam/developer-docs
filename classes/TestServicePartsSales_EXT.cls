/**
* Date            |Developer            |Work#
* Notes
* --
* 2016.12.15      |Gaurav               |#W-000811
* Modified class failing because of SRO location
**/

@isTest
private class TestServicePartsSales_EXT {

    @testSetup static void testDataInit() {
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

        Parts_Service_Pricing_Strategy__c ps = new Parts_Service_Pricing_Strategy__c();
        ps.Method__c = 'Jobber';
        ps.Active__c = true;
        ps.Description__c = 'test';
        ps.Default__c = true;
        ps.dealer__Parts_Variable_Amount__c = 10;
        ps.dealer__Formula_Operand__c = '+';
        insert ps;  
    }

    static testmethod void testPSEXT() {

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

        // Insertion of Invoice
        /* Commented out as it was causing a Too MAny sOQL 101 error and it did not appear to be necessary.
        util.insertPartsInvoice();
        util.insertServiceRepairOrder();
        util.insertInspectionReport();
        util.insertServiceAppointment();
        util.insertSalesup();
        //util.insertCarDeal();
        */

                // Create a Parts Master Entry
        dealer__Parts_Master__c pm = new dealer__Parts_Master__c();
        pm.Name = 'FL1A__TEST_PART';
        pm.dealer__Retail_Price__c = 99.99;
        pm.Manufacturer__c = 'FD';
        insert pm;
        dealer__Time_Clock__c dtc = new dealer__Time_Clock__c();
        dtc.dealer__Clock_In__c=system.today();
        dtc.dealer__User__c=UserInfo.getUserId(); 
        insert dtc;
        
        dealer__Parts_Inventory__c partsInventory = new dealer__Parts_Inventory__c(); 
        partsInventory.Name = 'MS-400-S';
        partsInventory.dealer__Online_Store_Id__c = 'SAT2727';
        partsInventory.dealer__Bin__c = 'Test Bin';
        partsInventory.dealer__Source__c = 'Dealer Source';
        partsInventory.dealer__Part_No__c = 'SAT2727';
        partsInventory.dealer__Comments__c = 'Test Comments';
        partsInventory.dealer__List__c = 9;
        partsInventory.dealer__Cost__c = 9;
        partsInventory.dealer__Description__c = 'Description';
        partsInventory.dealer__Pack_QTY__c = 4;
        partsInventory.dealer__On_Hand__c = 9;
        partsInventory.dealer__On_Order__c = 9;
        partsInventory.dealer__Core__c = 9;
        partsInventory.dealer__MFG__c = 'MFG';
        partsInventory.dealer__Parts_Master__c = pm.Id;
        partsInventory.dealer__Location__c=dealer.TestClassUtil.createLocation();        
        insert partsInventory;

        String pName = [Select Id, Name from dealer__Parts_Inventory__c where Id=:partsInventory.Id].Name;

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
        dealer__Technician_Job_Time__c tt = new dealer__Technician_Job_Time__c(
                                                                                dealer__Service_Job_Line__c=sjl.Id,
                                                                                dealer__Start_Time__c=DateTime.now()
                                                                              );
        // insert tt;
        
        Test.startTest();


        PageReference sps = Page.ServiceJobLineParts;
        sps.getParameters().put('id', sjl.Id);
        Test.setCurrentPage(sps);
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(sjl);
        ServicePartsSales_EXT spEXT = new ServicePartsSales_EXT(sc);
        ServicePartsSales_EXT.getInventory(pName);
        ServicePartsSales_EXT.loadPartsInvoiceLines(sjl.Id);
        String ctrmanName = spEXT.CounterManName;
        Id ctrMan = spEXT.Counterman;

        Test.stopTest();
        
    }

    static testmethod void testStatics() {

        dealer__Dealer_Location__c loc = [Select Id from dealer__Dealer_Location__c limit 1];
        
        /* #W-000811 Begin */
        User usr = [SELECT Id FROM User WHERE UserName = 'testuser128@testorgx.com' LIMIT 1];
        
        dealer__Dealer_Location_User__c objUserLocation = new dealer__Dealer_Location_User__c();
        objUserLocation.dealer__Dealer_Location__c = loc.Id;
        objUserLocation.dealer__User__c = usr.Id;
        insert objUserLocation; 
        
        System.runAs(usr) { 
        /* #W-000811 End */
                       
            dealer__Parts_Master__c pm = new dealer__Parts_Master__c();
            pm.Name = 'FL1A__TEST_PART';
            pm.dealer__Retail_Price__c = 99.99;
            pm.Manufacturer__c = 'FD';
            insert pm;
    
            dealer__Time_Clock__c dtc = new dealer__Time_Clock__c();
            dtc.dealer__Clock_In__c=system.today();
            dtc.dealer__User__c=UserInfo.getUserId(); 
            insert dtc;

            Id locId = dealer.TestClassUtil.createLocation();
            
            dealer__Parts_Inventory__c partsInventory = new dealer__Parts_Inventory__c(); 
            partsInventory.Name = 'MS-400-S';
            partsInventory.dealer__Online_Store_Id__c = 'SAT2727';
            partsInventory.dealer__Bin__c = 'Test Bin';
            partsInventory.dealer__Source__c = 'Dealer Source';
            partsInventory.dealer__Part_No__c = 'SAT2727';
            partsInventory.dealer__Comments__c = 'Test Comments';
            partsInventory.dealer__List__c = 9;
            partsInventory.dealer__Cost__c = 9;
            partsInventory.dealer__Description__c = 'Description';
            partsInventory.dealer__Pack_QTY__c = 4;
            partsInventory.dealer__On_Hand__c = 9;
            partsInventory.dealer__On_Order__c = 9;
            partsInventory.dealer__Core__c = 9;
            partsInventory.dealer__MFG__c = 'MFG';
            partsInventory.dealer__Parts_Master__c = pm.Id;
            partsInventory.dealer__Location__c=locId;    
            insert partsInventory;
    
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
                                                                                        dealer__RO_Number__c='RO#123456',
                                                                                        dealer__Company__c = loc.Id
                                                                                    );
                                                                                    
            insert sro;
            dealer__Service_Job__c sjl = new dealer__Service_Job__c(
                                                                    Name='Line1',
                                                                    dealer__Service_Repair_Order__c=sro.Id,
                                                                    dealer__Line_Number__c=1,
                                                                    dealer__Op_Code__c='A123'
                                                                    );
            insert sjl; 
    
    
    
            Test.startTest();
            ServicePartsSales_EXT.InvoiceAddPartLine('<invoice><Id>'+partsInventory.Id+'</Id><RepairOrderId>'+sro.Id+'</RepairOrderId><customerId>'+c.Id+'</customerId><InvoiceName>INV#50022</InvoiceName><InvoiceNumber>59022</InvoiceNumber><LineNumber>1</LineNumber><LineId>'+sjl.Id+'</LineId><counterman>'+userinfo.getUserId()+'</counterman><InvoiceId></InvoiceId><dealer__Description__c>TANK ASY - RADIATOR OVERFLOW</dealer__Description__c><dealer__List__c>222.13</dealer__List__c><LocId>'+locId+'</LocId><dealer__Price__c>222.13</dealer__Price__c><dealer__Part_No__c>F5HZ8A080AA</dealer__Part_No__c><dealer__Bin__c>SP-ORD</dealer__Bin__c><dealer__Source__c>4</dealer__Source__c><dealer__Cost__c>133.28</dealer__Cost__c><dealer__Core__c>0</dealer__Core__c><dealer__Net__c></dealer__Net__c><dealer__MFG__c>FD</dealer__MFG__c><dealer__Quantity_Sold__c>1</dealer__Quantity_Sold__c><dealer__Quantity_Ordered__c>0</dealer__Quantity_Ordered__c><dealer__Sold_Via__c>Negative On-Hand</dealer__Sold_Via__c><dealer__Order_Type__c>Special Order</dealer__Order_Type__c></invoice>');
            Test.stopTest();
        }
    }
}