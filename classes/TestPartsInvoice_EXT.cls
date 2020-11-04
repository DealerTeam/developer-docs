@isTest
private class TestPartsInvoice_EXT {
        
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
        
        dealer__Dealer_Location_User__c locUser = new dealer__Dealer_Location_User__c(dealer__User__c = usr.Id, dealer__Dealer_Location__c = loc.Id);
        insert locUser;

        // Create example pricing strategy
        dealer__Parts_Service_Pricing_Strategy__c ps = new dealer__Parts_Service_Pricing_Strategy__c(
                                                                dealer__Active__c=true,
                                                                dealer__Parts_Forumula_Base__c='LIST',
                                                                dealer__Description__c='List Plus',
                                                                dealer__Company_Number__c='DT1',
                                                                dealer__Default__c=true,
                                                                dealer__Formula_Operand__c='+',
                                                                dealer__Method__c='Cost',
                                                                dealer__Minimum_Parts_Gross_Proft__c=0.25,
                                                                dealer__Order__c=9,
                                                                dealer__Parts_Variable_Amount__c=35
                                                            );
        insert ps;

    }

    static testmethod void testPartInvoiceAPI() {

        dealer__Dealer_Location__c loc = [Select Id from dealer__Dealer_Location__c limit 1];

        // Create contact for invoice
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

        // Create a Parts Master Entry
        dealer__Parts_Master__c pm = new dealer__Parts_Master__c();
        pm.Name = 'FL1A__TEST_PART';
        pm.dealer__Retail_Price__c = 99.99;
        pm.Manufacturer__c = 'FD';
        insert pm;

        // Create a Test Part
        dealer__Parts_Inventory__c part = new dealer__Parts_Inventory__c();
        part.dealer__Description__c = 'Oil Filter';
        part.dealer__Cost__c = 10;
        part.dealer__Source__c = 'Stocking';
        part.dealer__On_Hand__c = 0;
        part.dealer__Part_No__c = 'FL1A__TEST_PART';
        part.dealer__List__c = 22;
        part.dealer__Parts_Master__c = pm.Id;
        part.dealer__Location__c=loc.Id;

        insert part; 

        dealer__Parts_Invoice__c pi = new dealer__Parts_Invoice__c(
                                                                    Name='INV1234',
                                                                    dealer__Customer_Contact__c=c.Id,
                                                                    dealer__Invoice_Number__c='1234',
                                                                    dealer__Location__c=loc.id
                                                                   );
                                                                   
        insert pi;
        
        // Invoice Getter
        dealer__Parts_Invoice__c ivoice = PartInvoiceAPI.invoice(pi.Id);

        // Invoice Line Add
        dealer__Parts_Invoice_Line__c pl = PartInvoiceAPI.addInvoiceLine(pi.Id, null, part.Id, 1, 295.95, '');

        // Invoice Update Line
        PartInvoiceAPI.updateInvoiceLine(pl.Id, 2, 299.00, 'Random comment');

        // Get Lines
        PartInvoiceAPI.invoiceLines(pi.Id);

        // Invoice Line Remove for Null
        try{
            // PartInvoiceAPI.removeInvoiceLine(null); method no longer supports null signature. 
        }
        catch(Exception e){}

        // Invoice Line Remove with line Id
        try{ 
            PartInvoiceAPI.removeInvoiceLine(pl.id);
        }
        catch(Exception e){}

        try
        {
        // Invoice Line Add to throw exception
        dealer__Parts_Invoice_Line__c plA = PartInvoiceAPI.addInvoiceLine(null, null, part.Id, 1, 295.95, '');
        }
        catch(Exception e){}

        try 
        {
        // Invoice Line Add
        dealer__Parts_Invoice_Line__c plB = PartInvoiceAPI.addInvoiceLine(pi.Id, null, part.Id, 1, 295.95, '');
        }
        catch(Exception e){}

    }

    static testmethod void testPartsInvoiceEXT() {

        dealer__Dealer_Location__c loc = [Select Id, Name from dealer__Dealer_Location__c limit 1];

        // Create contact for invoice
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

        // Create a Parts Master Entry
        dealer__Parts_Master__c pm = new dealer__Parts_Master__c();
        pm.Name = 'FL1A__TEST_PART';
        pm.dealer__Retail_Price__c = 99.99;
        pm.Manufacturer__c = 'FD';
        insert pm;

        // Create a Test Part
        dealer__Parts_Inventory__c part = new dealer__Parts_Inventory__c();
        part.dealer__Description__c = 'Oil Filter';
        part.dealer__Cost__c = 10;
        part.dealer__Source__c = 'Stocking';
        part.dealer__On_Hand__c = 0;
        part.dealer__Part_No__c = 'FL1A__TEST_PART';
        part.dealer__List__c = 22;
        part.dealer__Parts_Master__c = pm.Id;
        part.dealer__Location__c=loc.Id;

        insert part;
        
        
        
        dealer__Parts_Invoice__c pi = new dealer__Parts_Invoice__c(
                                                                    Name='INV1234',
                                                                    dealer__Customer_Contact__c=c.Id,
                                                                    dealer__Invoice_Number__c='1234',
                                                                    dealer__Location__c=loc.id
                                                                   );
                                                                   
        insert pi;
        

        dealer__Parts_Invoice_Line__c pl = PartInvoiceAPI.addInvoiceLine(pi.Id, null, part.Id, 1, 295.95, '');

        
        PageReference invPage = Page.PartsInvoice;
        Test.setCurrentPage(invPage);
        ApexPages.currentPage().getParameters().put('id', pi.Id);
         
        ApexPages.Standardcontroller pir = new ApexPages.Standardcontroller(pi);
        PartsInvoice_EXT ctl = new PartsInvoice_EXT(pir);

        Test.startTest();

        ctl.getPriceLevels();
        ctl.lookupCurrentOrders();
        ctl.AttachPDF();
        ctl.reopenInvoice();    
        
        ctl.email = 'jarrett@dealerteam.com';
        ctl.subject = 'email invoice';
        ctl.body = 'test body <br />';
        
        ctl.emailInvoice();
        ctl.sendPdf();
    
        ctl.closeInvoice();
        ctl.cashierInvoice();
        
        // Remote Actions
        PartsInvoice_EXT.getMaster('AS3432');
        PartsInvoice_EXT.getInventory('FL1234');
        PartsInvoice_EXT.updateShipToAddress('{"Id":"'+pi.Id+'","Street":"123 Test St.","City":"Redding","State":"CA","Zip":"96001","Country":""} ');

        dealer__Parts_Kit__c pk = new dealer__Parts_Kit__c();
        pk.Name = 'Test part kit';
        pk.dealer__Description__c = 'This is a test pk description';
        insert pk;        

        dealer__Parts_Service_Pricing_Strategy__c ps = [Select Id from dealer__Parts_Service_Pricing_Strategy__c limit 1];

        String accountIdStr = [SELECT Id FROM Account LIMIT 1].Id;
        String createInvoiceXML = '<invoice><customer>'+accountIdStr+'</customer><contact></contact><location>'+loc.Name+'</location><counterman>'+UserInfo.getUserId()+'</counterman><comments></comments><taxexempt>true</taxexempt><pricelevel>'+ps.Id+'</pricelevel><lines><Id>'+part.Id+'</Id><dealer__PartName>FD:FL-400-S</dealer__PartName><dealer__Part_No__c>FL-400-S</dealer__Part_No__c><dealer__Drop_Ship__c>false</dealer__Drop_Ship__c><dealer__Description__c>OIL FILTER</dealer__Description__c><dealer__List__c>7.22</dealer__List__c><dealer__Price__c>7.22</dealer__Price__c><dealer__Quantity_Sold__c>1</dealer__Quantity_Sold__c><dealer__On_Hand__c>1</dealer__On_Hand__c><dealer__Bin__c>112</dealer__Bin__c><dealer__Source__c>Bulk</dealer__Source__c><dealer__Cost__c>3.25</dealer__Cost__c><dealer__Core__c>0</dealer__Core__c><dealer__Net__c>7.22</dealer__Net__c><dealer__Extended_Total>7.22</dealer__Extended_Total><dealer__Sold_Via__c>In Stock</dealer__Sold_Via__c><dealer__MFG__c>OT</dealer__MFG__c><sold_In_Stock>1</sold_In_Stock><sold_Order>0</sold_Order><OrderType></OrderType><sold_OP>0</sold_OP><sold_NP>0</sold_NP><dealer__Service_Repair_Order__c></dealer__Service_Repair_Order__c><dealer__PL>'+ps.Id+'</dealer__PL><dealer__PLName>Retail</dealer__PLName></lines></invoice> ';
        PartsInvoice_EXT.CreateInvoice(createInvoiceXML);   
        
        PartsInvoice_EXT.loadPartsQuoteLines(pi.Id);
        PartsInvoice_EXT.loadPartsInvoiceLines(pi.Id);
        PartsInvoice_EXT.invoicePricing(pi.Id);
        PartsInvoice_EXT.invoiceLine(pl.Id);
        PartsInvoice_EXT.getPartsKitItems(pk.Id);
        PartsInvoice_EXT.InvoiceAddPartLine('<invoice><Id>'+part.Id+'</Id><InvoiceName>INV#50084</InvoiceName><counterman>'+UserInfo.getUserId()+'</counterman><InvoiceId>'+pi.Id+'</InvoiceId><dealer__PartName>FD:F5RZ17260D</dealer__PartName><dealer__Job_Line__c></dealer__Job_Line__c><dealer__Part_No__c>F5RZ17260D</dealer__Part_No__c><dealer__Part_Number__c>FD:F5RZ17260D</dealer__Part_Number__c><dealer__Description__c>SHAFT ASY - SPEEDOMETER CABLE</dealer__Description__c><dealer__Part_Description__c>SHAFT ASY - SPEEDOMETER CABLE</dealer__Part_Description__c><dealer__List__c>23.3</dealer__List__c><dealer__Price__c>23.3</dealer__Price__c><dealer__Quantity_Sold__c>1</dealer__Quantity_Sold__c><dealer__On_Hand__c>0</dealer__On_Hand__c><dealer__Bin__c>SP-ORD</dealer__Bin__c><dealer__Source__c>4</dealer__Source__c><dealer__Cost__c>13.98</dealer__Cost__c><dealer__Core__c>0</dealer__Core__c><dealer__Net__c>23.3</dealer__Net__c><dealer__Extended_Total>23.3</dealer__Extended_Total><dealer__Sold_Via__c>Special Order</dealer__Sold_Via__c><dealer__MFG__c>FD</dealer__MFG__c><dealer__Drop_Ship__c>false</dealer__Drop_Ship__c><sold_In_Stock>0</sold_In_Stock><sold_Order>1</sold_Order><OrderType>Special Order</OrderType><sold_OP>0</sold_OP><sold_NP>0</sold_NP><dealer__Service_Repair_Order__c></dealer__Service_Repair_Order__c><dealer__PL>'+ps.Id+'</dealer__PL><dealer__PLName>Retail</dealer__PLName></invoice>');
        // PartsInvoice_EXT.setPLonInvoice(pi.Id+'-'+ps.Id);
        
        // Must Fix
        // PartsInvoice_EXT.InvoiceAddPartLine('<invoice><Id>a05E0000000pqZgIAI</Id><InvoiceName>INV#50022</InvoiceName><counterman>005E0000000iCElIAM</counterman><InvoiceId>a06E0000008IyjDIAS</InvoiceId><dealer__Description__c>TANK ASY - RADIATOR OVERFLOW</dealer__Description__c><dealer__List__c>222.13</dealer__List__c><dealer__Price__c>222.13</dealer__Price__c><dealer__Part_No__c>F5HZ8A080AA</dealer__Part_No__c><dealer__Bin__c>SP-ORD</dealer__Bin__c><dealer__Source__c>4</dealer__Source__c><dealer__Cost__c>133.28</dealer__Cost__c><dealer__Core__c>0</dealer__Core__c><dealer__Net__c></dealer__Net__c><dealer__MFG__c>FD</dealer__MFG__c><dealer__Quantity_Sold__c>1</dealer__Quantity_Sold__c><dealer__Quantity_Ordered__c>0</dealer__Quantity_Ordered__c><dealer__Sold_Via__c>Negative On-Hand</dealer__Sold_Via__c><dealer__Order_Type__c>Special Order</dealer__Order_Type__c></invoice> ');
        PartsInvoice_EXT.CreatePartsQuote(createInvoiceXML);
        
        PartsInvoice_EXT.updateLineQty(pl.Id+'-1-0-special order-false');
        PartsInvoice_EXT.setLinePrice(pl.Id+'-99.99');

        ctl.directView();
        Test.stopTest();
    }

    static testmethod void testPartsInvoiceOnSRO() {

        // Create Repair Order to Test Service Parts Invoice
        // Create contact for invoice

        dealer__Dealer_Location__c loc = [Select Id from dealer__Dealer_Location__c limit 1];
        
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
                                                                                    Company__c=loc.Id,
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
        

        dealer__Parts_Invoice__c pinew = new dealer__Parts_Invoice__c(Name='INV1234',
                                                                    dealer__Customer_Contact__c=c.Id,
                                                                    dealer__Location__c=loc.id,
                                                                    dealer__Service_Repair_Order__c=sro.id);
        insert pinew;
        
        ApexPages.Standardcontroller piro = new ApexPages.Standardcontroller(pinew);
        PartsInvoice_EXT ctlRO = new PartsInvoice_EXT(piro);
        
        ctlRO.roId = sro.Id;
        ctlRO.roData=sro;
        // ctlRO.createInvoicefromRO();
        
        ctlRO.directView();         
    }
    
    static testmethod void testPartsOrderCreation() {

        dealer__Dealer_Location__c loc = [Select Id from dealer__Dealer_Location__c limit 1];

        PartsOrderCreation ctl = new PartsOrderCreation();
        ctl.lookupCurrentOrders();
        ctl.CurrentOrders = new List<dealer__Stock_Order__c>();

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

        // Create Parts Master, Part
        dealer__Parts_Master__c pm = new dealer__Parts_Master__c();
        pm.Name = 'FL1A__TEST_PART';
        pm.dealer__Retail_Price__c = 99.99;
        pm.Manufacturer__c = 'FD';
        insert pm;

        dealer__Parts_Inventory__c part = new dealer__Parts_Inventory__c();
        part.dealer__Description__c = 'Oil Filter';
        part.dealer__Cost__c = 10;
        part.dealer__Source__c = 'Stocking';
        part.dealer__On_Hand__c = 0;
        part.dealer__Part_No__c = 'FL1A__TEST_PART';
        part.dealer__List__c = 22;
        part.dealer__Parts_Master__c = pm.Id;
        part.dealer__Location__c=loc.Id;

        insert part;

        dealer__Parts_Invoice__c pi = new dealer__Parts_Invoice__c(
                                                                    Name='INV1234',
                                                                    dealer__Customer_Contact__c=c.Id,
                                                                    dealer__Invoice_Number__c='1234',
                                                                    dealer__Location__c=loc.id
                                                                   );
                                                                   
        insert pi;
        
        dealer__Parts_Invoice_Line__c pl = new dealer__Parts_Invoice_Line__c(
                                                                              Name='Line1',
                                                                              dealer__Parts_Invoice__c=pi.Id,
                                                                              dealer__Bin__c='123',
                                                                              dealer__Cost__c=Decimal.valueOf('123.00'),
                                                                              dealer__Part_Number__c='A12354',
                                                                              dealer__Price__c=Decimal.valueOf('295.95'),
                                                                              dealer__Quantity_Sold__c=1,
                                                                              dealer__Part__c=part.Id
                                                                             );
        insert pl;        

        PartsOrderCreation.PartsOrderLine(part.Id, pi.Id, pl.Id, 1, UserInfo.getUserId(), 'Special Order', 'FD');
    }
    
    static testmethod void testPartsOrderReceiving() {

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

        // Create an Example Stock Order
        dealer__Service_Repair_Order__c sro = new dealer__Service_Repair_Order__c(  Name='testRO',
                                                                                    dealer__Vehicle__c=vehicle.Id,
                                                                                    dealer__Mileage_In__c=1234,
                                                                                    dealer__Customer_Contact__c=c.Id,
                                                                                    dealer__RO_Number__c='RO#123456'
                                                                                );
                                                                                
        insert sro;

        dealer__Stock_Order__c so = new dealer__Stock_Order__c(
              dealer__Status__c='Incomplete',
              dealer__Company__c=[Select Id from dealer__Dealer_Location__c limit 1].Id,
              dealer__Service_Repair_Order__c=sro.Id,
              dealer__Date_Ordered__c=Date.Today(),
              dealer__Order_Type__c='Special Order'
            );
        
        insert so;

        PageReference porPage = Page.ReceiptPartsOrder;
        Test.setCurrentPage(porPage);
        ApexPages.currentPage().getParameters().put('id', so.Id);
        
        PartsOrderReceiving por = new PartsOrderReceiving();
        por.saveOrderReceipt();
    }

    static testmethod void testPartsMasterEXT() {

        dealer__Parts_Master__c m = new dealer__Parts_Master__c(Name='test', 
                                                                dealer__Part_No__c='FD:Test', 
                                                                // dealer__Raw_Part_Number__c='test',
                                                                dealer__Price_Tape_Date__c=Date.today(), 
                                                                dealer__Cost__c=Decimal.valueOf('5.50'),
                                                                dealer__Retail_Price__c=Decimal.valueOf('9.12'),
                                                                dealer__Manufacturer__c='FD'
                                                                );  
                                                                
        insert m;
        
        dealer__Parts_Master__c mNew = new dealer__Parts_Master__c();
        
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(mNew);
        PartsMaster_EXT controller = new PartsMaster_EXT(sc);
        mNew.dealer__Part_No__c='FD:Test-A';
        mNew.Name='Test-A';
        // mNew.dealer__Raw_Part_Number__c='test';
        mNew.dealer__Price_Tape_Date__c=Date.today();
        mNew.dealer__Cost__c=Decimal.valueOf('5.50');
        mNew.dealer__Retail_Price__c=Decimal.valueOf('9.12');
        mNew.dealer__Manufacturer__c='FD';
        controller.save();                                                      

        // Test Supersession
        controller.newPartNumber = 'Test-A';
        controller.supercede();
    }   
    
    @isTest public static void testPartInvoiceUpdateAccount(){
        
         // Create Repair Order to Test Service Parts Invoice
        // Create contact for invoice
        dealer__Dealer_Location__c loc = [Select Id from dealer__Dealer_Location__c limit 1];
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        
        Contact c = new Contact(
                    FirstName='James',
                    LastName='Rowland',
                    AccountId=acc.Id,
                    Birthdate=date.parse('01/01/1970'),
                    Email='none@blackhole.org',
                    Salutation='Mr.',
                    Phone='5302221234',
                    MailingStreet='555 Cypress Ave',
                    MailingCity='Redding',
                    MailingState='CA',
                    MailingPostalCode='96001',
            		MailingCountry='United States'
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
        

        dealer__Parts_Invoice__c pinew = new dealer__Parts_Invoice__c(Name='INV1234',
                                                                    dealer__Customer_Contact__c=c.Id,
                                                                    dealer__Invoice_Number__c='1234',
                                                                    dealer__Location__c=loc.id,
                                                                    dealer__Service_Repair_Order__c=sro.id);
        
        
        Test.startTest();
        insert pinew;
        Test.stopTest();
        
		dealer__Parts_Invoice__c partInvoice = [SELECT Id, dealer__Customer_Contact__c, dealer__Invoice_Number__c, 
                                               dealer__Location__c, dealer__Service_Repair_Order__c, dealer__Customer_ShipTo_Street__c,
                                               dealer__Customer_ShipTo_City__c, dealer__Customer_Shipto_State__c, dealer__Customer_ShipTo_Zip__c 
                                               FROM dealer__Parts_Invoice__c LIMIT 1];       
        
        system.assertEquals(c.MailingStreet, partInvoice.dealer__Customer_ShipTo_Street__c);
    }
    
     @isTest public static void testPartInvoiceUpdateTaxExempt(){
        
         // Create Repair Order to Test Service Parts Invoice
        // Create contact for invoice
        dealer__Dealer_Location__c loc = [Select Id from dealer__Dealer_Location__c limit 1];
        Account acc = new Account(Name = 'Test Account');
        acc.dealer__Tax_Exempt__c = true;
        insert acc;
        
        Contact c = new Contact(
                    FirstName='James',
                    LastName='Rowland',
                    AccountId=acc.Id,
                    Birthdate=date.parse('01/01/1970'),
                    Email='none@blackhole.org',
                    Salutation='Mr.',
                    Phone='5302221234',
                    OtherStreet='555 Cypress Ave',
                    OtherCity='Redding',
                    OtherState='CA',
                    OtherPostalCode='96001',
            		OtherCountry='United States'
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
        

        dealer__Parts_Invoice__c pinew = new dealer__Parts_Invoice__c(Name='INV1234',
                                                                    dealer__Customer_Contact__c=c.Id,
                                                                    dealer__Invoice_Number__c='1234',
                                                                    dealer__Location__c=loc.id,
                                                                    dealer__Service_Repair_Order__c=sro.id);
        
        insert pinew;
 
        pinew.dealer__Customer__c = acc.Id;
         
        Test.startTest();
		update pinew;        
        Test.stopTest();
        
        dealer__Parts_Invoice__c partInvoice = [SELECT Id, dealer__Customer_Contact__c, dealer__Invoice_Number__c, 
                                               dealer__Location__c, dealer__Service_Repair_Order__c, dealer__Customer_ShipTo_Street__c,
                                               dealer__Customer_ShipTo_City__c, dealer__Customer_Shipto_State__c, dealer__Customer_ShipTo_Zip__c,
                                               dealer__Tax_Exempt__c
                                               FROM dealer__Parts_Invoice__c WHERE dealer__Invoice_Number__c = '1234' LIMIT 1];       
        
        system.assert(partInvoice.dealer__Tax_Exempt__c);
    }
}