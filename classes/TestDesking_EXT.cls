@isTest 
private class TestDesking_EXT { 

    /*
    @isTest static void deskingTestOne() {

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
        // Implement test code
        if(dealer__DMS_Settings__c.getValues('ActiveSettings') == null){
            dealer__DMS_Settings__c dms = new dealer__DMS_Settings__c();
            dms.Name = 'ActiveSettings';
            dms.dealer__Service_Current_Invoice_Number__c = 30093;
            dms.dealer__Service_Job_Line_Number__c = 8;
            //dms.dealer__State_Tax_Rate__c = 7.75;
            dms.dealer__Parts_Current_Invoice_Number__c = 50115;
            dms.dealer__Parts_Current_Quote_Number__c = 20028;
            dms.dealer__Default_Tax_Rate__c = 7.75;
            dms.dealer__Deal_Number__c = 1;
            dms.dealer__Deal_Default_Rate__c = 9.9; 
            insert dms;   
        }
        dealer__Deal__c deal = new dealer__Deal__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(deal);
        dealer.Desking_EXT dsk = new dealer.Desking_EXT(sc);
        // Getter Methods
        // First Run Data
        dsk.loadDefaults();

                Desking_EXT.setApplicationCache();
                dsk.kitMFG='Ford';
                dsk.kitDescription='Test';
                dsk.searchEquipment();

        String dealTitle = dsk.getdealTitle();
        System.assertEquals(dealTitle, 'New Deal');

                String formId = dsk.formId;
                String kitMFG = dsk.kitMFG;
                String kitNumber = dsk.kitNumber;
                String kitDesc = dsk.kitDescription;
                List<dealer__Parts_Kit__c> plst = dsk.kitList;
                String kitResultSize = dsk.kitResultSize;
                String burl = dsk.baseURL;
                String nmBurl = dsk.baseURLNonManaged;
                List<dealer__Form__c> forms = dsk.forms;
                List<dealer__Service_Contract__c> avaialbleContracts = dsk.avaialbleContracts;
                List<dealer__Deal_Payment__c> dealPayments = dsk.dealPayments;
                String trades = dsk.trades;
                String aftermarket = dsk.aftermarket;
                String feedata = dsk.feedata;

        dsk.getTaxZoneCountyList();
        dsk.getFinanceCompanies();
        dsk.getLender();
        dsk.setLender('Wells Fargo');
        Account accRec = new Account();
        accRec.Name = 'Test Account';
        accRec.Type = 'Customer - Direct';
        insert accRec;
        
        Contact conRec = new Contact();
        conRec.AccountId = accRec.Id;
        conRec.LastName = 'TestContact';
        conRec.FirstName = 'testFirstName';
        conRec.Email = 'nicki.allen@me.com';
        conRec.HomePhone = '8099306664';
        conRec.MobilePhone = '8099306664';
        insert conRec;
        
        dealer.Desking_EXT.lookupBuyer(conRec.Id);
        dealer__Vehicle_Inventory__c vehicle = new dealer__Vehicle_Inventory__c();
        vehicle.Name = 'Test Vehicle Inventory';
        vehicle.dealer__Model__c = '2014';
        vehicle.dealer__Stock_Number__c = '2014';
        vehicle.dealer__VIN__c = '100';
        vehicle.dealer__Company_Number__c = 'Location 1';
        vehicle.dealer__Year__c = '2014';
        vehicle.dealer__Make__c = '2014';
        insert vehicle;
        
        dealer__Tax_Zones__c taxZone = new dealer__Tax_Zones__c();
        taxZone.dealer__City__c = 'Blore';
        taxZone.dealer__Postal_Code__c = '560050';
        taxZone.dealer__Rate__c = 100;
        taxZone.dealer__State__c = 'Ka';
        taxZone.dealer__County__c = 'Ind';
        insert taxZone;
        
        dealer__Service_Vehicle__c SV = new dealer__Service_Vehicle__c();
        SV.dealer__Year__c = '2014';
        SV.dealer__Veh_Owner_Contact__c = conRec.Id;
        SV.dealer__VIN__c = 'B549989';
        SV.dealer__Stock_Number__c = '1234';
        SV.dealer__Make__c = 'Test';
        SV.dealer__Licence__c = 'Test';
        SV.dealer__Last_Service__c = System.today();
        SV.dealer__Carline__c = '2014';
        SV.dealer__Last_6__c = 'B54998';
        
        insert SV;
        
        dealer__Service_Contract__c serviceContract = new dealer__Service_Contract__c();
        serviceContract.dealer__Contract_Template__c = true;
        serviceContract.dealer__Cost__c = 100;
        serviceContract.dealer__Customer_Contact__c = conRec.Id;
        serviceContract.dealer__Customer__c = accRec.Id;
        serviceContract.dealer__Deductable__c = 25;
        serviceContract.dealer__Description__c = 'Test desc';
        serviceContract.dealer__Plan_Code__c = 'Test Plan';
        serviceContract.dealer__Product_Code__c = 'Code 1';
        serviceContract.dealer__Sale_Price__c = 200;
        serviceContract.dealer__Service_Vehicle__c = SV.Id;
        serviceContract.dealer__Start_Date__c = System.today();
        // serviceContract.dealer__Vehicle_Inventory__c = SV.Id;  Wrong type, should be a vehicle inventory record.
        serviceContract.dealer__Type__c = 'GAP';
        serviceContract.dealer__Car_Deal__c = deal.Id;
        insert serviceContract;
        
        
        dsk.escSelectedId = serviceContract.Id;
        
        dsk.escCode = 'Test';
        dsk.escDescription = 'Test';
        dsk.findTotalRollup();
        dsk.selectProduct();
        List<dealer__Service_Contract__c> scList = dsk.soldOnProposal;
        
        dsk.lookupVehicle(vehicle.Id);
        dsk.populateVehicleById(vehicle.Id);
        dsk.populateBuyerData(conRec);
        dsk.populateCoBuyerData(conRec);
        dsk.populateCompany(accRec);
        // Remote Actions
        
        dealer.Desking_EXT.selectStockNumber(vehicle.dealer__Stock_Number__c);
        dealer.Desking_EXT.lookupContact(conRec.Id);
        dealer.Desking_EXT.lookupAccount(accRec.Id);
        dealer.Desking_EXT.getTaxZone('Ka:Ind');
        dealer.Desking_EXT.updateServiceContractSale(serviceContract.Id+'~100', 'saleprice');
        dealer.Desking_EXT.updateServiceContractSale(serviceContract.Id+'~150', 'costprice');
        // Page Reference Data
        dsk.newDeal();
        dsk.newDealPayment();
        dsk.save();
        dsk.getdealTitle();
        dsk.getContractTypes();
        dsk.searchESC();
        dsk.resetResult();
        dsk.deleteProductId = serviceContract.Id;
        dsk.deleteProduct();

                dealer__Deal__c d = new dealer__Deal__c(Name='Test', dealer__Deal_Id__c='1');
                insert d;
                // test Remote Actions

                        if(dealer__VINDecoderCS__c.getValues('ActiveSettings') == null){
                            dealer__VINDecoderCS__c VINDecod = new dealer__VINDecoderCS__c();
                            VINDecod.Name = 'ActiveSettings';
                            VINDecod.dealer__DecoderAPI_URL__c = 'https://api.dataonesoftware.com/webservices/vindecoder/decode';
                            VINDecod.dealer__DecoderClientID__c = '6310';
                            VINDecod.dealer__DecoderKey__c = '1de4cab15a94d80a33f07d19ecb7eff44032bde7';
                            VINDecod.dealer__DecoderName__c = 'Data One Software';
                            insert VINDecod;
                        }
        
                Desking_EXT.saveServiceContract('{"dealId":"'+d.Id+'", "price":"1000"}');
                dealer__After_Market__c amItem = Desking_EXT.addAfterMarketItem('{"dealId" : "'+d.Id+'", "parts" : "500", "labor" : "500", "description" : "Test Kit"}');
                Desking_EXT.deleteAftermarketItem(amItem.Id);
                Desking_EXT.saveFee('{"dealId":"'+d.Id+'", "feeAmount":"1000","feeName":"Test"}');
                Desking_EXT.saveImpactOnOff('false');
                Desking_EXT.saveImpactOnOff('true');
                Desking_EXT.saveImpactPrinterName('ML420');
                Desking_EXT.saveTrades('{"deal":"'+d.Id+'", "number":"1", "acv":"500", "allowance":"500", "payoff":"500", "vin":"JTKDE3B79A0310575", "stock":"A101", "odometer":"12345", "lost":"false", "year":"2005", "make":"Honda", "model":"Civic", "payoffExp":"12-12-2015"}');
                Desking_EXT.saveTrades('{"deal":"'+d.Id+'", "number":"1", "acv":"500", "allowance":"500", "payoff":"500", "vin":"JTKDE3B79A0310575", "stock":"A101", "odometer":"12345", "lost":"false",  "payoffExp":"12-12-2015"}');
               // Desking_EXT.saveTrades('{"deal":"'+d.Id+'", "number":"1", "acv":"500", "allowance":"500", "payoff":"500", "vin":"JTKDE3B79A0310575", "stock":"A101", "odometer":"12345", "lost":"false"}');

        Desking_EXT.notLostTradeIn(d.Id);

        dsk.mergeAndPrint();

        dealer__Trade_In__c tr = new dealer__Trade_In__c(
            dealer__Car_Deal__c = d.Id,
            dealer__Make__c = 'Honda',
            dealer__VIN__c = '123456AZSXDC',
            dealer__Year__c = '2012'
        );
        insert tr;

        dsk.fetchInventoryVehicle();

        dsk.createInventory();
        dsk.save();

        }
    }
    */
   
    @isTest static void testPageReferenceUp() {
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
        // Build from Sales Up
        if(dealer__DMS_Settings__c.getValues('ActiveSettings') == null){
            dealer__DMS_Settings__c dms = new dealer__DMS_Settings__c();
            dms.Name = 'ActiveSettings';
            dms.dealer__Service_Current_Invoice_Number__c = 30093;
            dms.dealer__Service_Job_Line_Number__c = 8;
            //dms.dealer__State_Tax_Rate__c = 7.75;
            dms.dealer__Parts_Current_Invoice_Number__c = 50115;
            dms.dealer__Parts_Current_Quote_Number__c = 20028;
            dms.dealer__Default_Tax_Rate__c = 7.75;
            dms.dealer__Deal_Number__c = 1;
            dms.dealer__Deal_Default_Rate__c = 9.9; 
            insert dms;   
        }
        Account accRec = new Account();
        accRec.Name = 'Test Account';
        accRec.Type = 'Customer - Direct';
        insert accRec;
        Contact conRec = new Contact();
        conRec.AccountId = accRec.Id;
        conRec.LastName = 'TestContact';
        conRec.FirstName = 'testFirstName';
        conRec.Email = 'nicki.allen@me.com';
        conRec.HomePhone = '8099306664';
        conRec.MobilePhone = '8099306664';
        insert conRec;
        dealer__Vehicle_Inventory__c VI = new dealer__Vehicle_Inventory__c();
        VI.Name = 'Test Vehicle Inventory';
        VI.dealer__Model__c = '2014';
        VI.dealer__Stock_Number__c = '2014';
        VI.dealer__VIN__c = '100';
        VI.dealer__Company_Number__c = 'Location 1';
        VI.dealer__Year__c = '2014';
        VI.dealer__Make__c = '2014';
        VI.In_Stock__c = true;
        insert VI;
        dealer__Sales_Up__c SU = new dealer__Sales_Up__c();
        SU.Name = 'Test SalesUP';
        SU.dealer__Buyer_Contact__c = conRec.Id;
        SU.dealer__Co_Buyer_Contact__c = conRec.Id;
        SU.dealer__Desired_Stock_Num__c = VI.Id;
        SU.dealer__Make__c = 'Telsa';
        SU.dealer__FirstName__c = 'TestFirstName';
        SU.dealer__LastName__c = 'LastName';
        insert SU;
        Test.setCurrentPageReference(new PageReference('Page.Desking'));
        System.currentPageReference().getParameters().put('salesup', SU.Id);
        dealer__Deal__c deal = new dealer__Deal__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(deal);
        dealer.Desking_EXT dsk = new dealer.Desking_EXT(sc);
        }
    }

    @isTest static void testPageReferenceBuyer() {
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
        // Build from Sales Up
        if(dealer__DMS_Settings__c.getValues('ActiveSettings') == null){
            dealer__DMS_Settings__c dms = new dealer__DMS_Settings__c();
            dms.Name = 'ActiveSettings';
            dms.dealer__Service_Current_Invoice_Number__c = 30093;
            dms.dealer__Service_Job_Line_Number__c = 8;
            //dms.dealer__State_Tax_Rate__c = 7.75;
            dms.dealer__Parts_Current_Invoice_Number__c = 50115;
            dms.dealer__Parts_Current_Quote_Number__c = 20028;
            dms.dealer__Default_Tax_Rate__c = 7.75;
            dms.dealer__Deal_Number__c = 1;
            dms.dealer__Deal_Default_Rate__c = 9.9; 
            insert dms;   
        }
        Account accRec = new Account();
        accRec.Name = 'Test Account';
        accRec.Type = 'Customer - Direct';
        insert accRec;
        Contact conRec = new Contact();
        conRec.AccountId = accRec.Id;
        conRec.LastName = 'TestContact';
        conRec.FirstName = 'testFirstName';
        conRec.Email = 'nicki.allen@me.com';
        conRec.HomePhone = '8099306664';
        conRec.MobilePhone = '8099306664';
        insert conRec;
        dealer__Vehicle_Inventory__c VI = new dealer__Vehicle_Inventory__c();
        VI.Name = 'Test Vehicle Inventory';
        VI.dealer__Model__c = '2014';
        VI.dealer__Stock_Number__c = '2014';
        VI.dealer__VIN__c = '100';
        VI.dealer__Company_Number__c = 'Location 1';
        VI.dealer__Year__c = '2014';
        VI.dealer__Make__c = '2014';
        VI.In_Stock__c = true;
        insert VI;
        dealer__Sales_Up__c SU = new dealer__Sales_Up__c();
        SU.Name = 'Test SalesUP';
        SU.dealer__Buyer_Contact__c = conRec.Id;
        SU.dealer__Co_Buyer_Contact__c = conRec.Id;
        SU.dealer__Desired_Stock_Num__c = VI.Id;
        SU.dealer__Make__c = 'Telsa';
        SU.dealer__FirstName__c = 'TestFirstName';
        SU.dealer__LastName__c = 'LastName';
        insert SU;
        Test.setCurrentPageReference(new PageReference('Page.Desking'));
        System.currentPageReference().getParameters().put('buyer', SU.dealer__Buyer_Contact__c);
        System.currentPageReference().getParameters().put('cobuyer', SU.dealer__Co_Buyer_Contact__c);
        System.currentPageReference().getParameters().put('vehicle', SU.dealer__Desired_Stock_Num__c);
        dealer__Deal__c deal = new dealer__Deal__c();
        ApexPages.StandardController sc = new ApexPages.StandardController(deal);
        dealer.Desking_EXT dsk = new dealer.Desking_EXT(sc);
        }
    }

        @isTest 
        static void testDealImpactFormCompiler() {

                // Create Form
                String frmBase64 = 'fHwyLDEwLERMRSMrMiwzMCx7IWRlYWwuZGVhbGVyX19EZWFsX0lEX19jfSsyLDUwLFJPUysyLDcwLHshZGVhbC5kZWFsZXJfX1N0b2NrX051bWJlcl9fY30rfHx8fDYsMix7IWRlYWwuZGVhbGVyX19CdXllcl9GaXJzdF9OYW1lX19jfSs2LDMwLHshZGVhbC5kZWFsZXJfX0NvX0J1eWVyX0ZpcnN0X05hbWVfX2N9KzYsNTYseyEkT3JnYW5pemF0aW9uLk5hbWV9K3w3LDIseyFkZWFsLmRlYWxlcl9fQnV5ZXJfQWRkcmVzc19fY30rNywzMCx7IWRlYWwuZGVhbGVyX19Db19CdXllcl9BZGRyZXNzX19jfSs3LDU2LHshJE9yZ2FuaXphdGlvbi5TdHJlZXR9K3w4LDIseyFkZWFsLmRlYWxlcl9fQnV5ZXJfQ2l0eV9fY30geyFkZWFsLmRlYWxlcl9fQnV5ZXJfU3RhdGVfX2N9IHshZGVhbC5kZWFsZXJfX0J1eWVyX0NvdW50eV9fY30geyFkZWFsLmRlYWxlcl9fQnV5ZXJfUG9zdGFsX0NvZGVfX2N9KzgsMzAseyFkZWFsLmRlYWxlcl9fQ29fQnV5ZXJfQ2l0eV9fY30geyFkZWFsLmRlYWxlcl9fQ29fQnV5ZXJfU3RhdGVfX2N9IHshZGVhbC5kZWFsZXJfX0NvX0J1eWVyX0NvdW50eV9fY30geyFkZWFsLmRlYWxlcl9fQ29fQnV5ZXJfUG9zdGFsX0NvZGVfX2N9KzgsNTYseyEkT3JnYW5pemF0aW9uLkNpdHl9IHshJE9yZ2FuaXphdGlvbi5TdGF0ZX0geyEkT3JnYW5pemF0aW9uLlBvc3RhbENvZGV9K3x8fHx8fDE0LDEzLHshZGVhbC5kZWFsZXJfX01ha2VfX2N9K3wxNSwyLHshZGVhbC5kZWFsZXJfX05VT19fY30rMTUsOCx7IWRlYWwuZGVhbGVyX19ZZWFyX19jfSsxNSwxMyx7IWRlYWwuZGVhbGVyX19Nb2RlbF9fY30rMTUsMjQseyFST1VORChkZWFsLmRlYWxlcl9fTWlsZWFnZV9fYywwKX0rMTUsMzYseyFkZWFsLmRlYWxlcl9fVklOX19jfSt8fHx8fHx8fHwyNCw0OCx7IVJPVU5EKGRlYWwuZGVhbGVyX19Eb3duX1B5bXRfX2MsMCl9K3wyNSw1LHshZGVhbC5kZWFsZXJfX1JhdGVfX2N9KzI1LDEzLHshZGVhbC5kZWFsZXJfX0FtdF9GaW5hbmNlZF9fY30rMjUsMjUseyFkZWFsLmRlYWxlcl9fQW10X0ZpbmFuY2VkX19jfSsyNSwzNSx7IWRlYWwuZGVhbGVyX19BbXRfRmluYW5jZWRfX2N9KzI1LDQ4LHshZGVhbC5kZWFsZXJfX0FtdF9GaW5hbmNlZF9fYytkZWFsLmRlYWxlcl9fRG93bl9QeW10X19jfSsyNSw1OCxOL0ErMjUsNzEsTi9BKzI1LDc3LE4vQSt8MjYsNTgsTi9BKzI2LDcxLE4vQSsyNiw3NyxOL0ErfDI3LDY3LE4vQSsyNyw3MSxOL0ErMjcsNzcsTi9BK3wyOCw2NyxOL0ErMjgsNzEsTi9BKzI4LDc3LE4vQSt8MjksNjcsTi9BKzI5LDcxLE4vQSsyOSw3NyxOL0ErfDMwLDY3LE4vQSszMCw3MSxOL0ErMzAsNzcsTi9BK3wzMSw3NyxOL0ErfHx8fHwzNiw1LHshZGVhbC5kZWFsZXJfX1Rlcm1fX2MtMX0rMzYsMjgseyFkZWFsLmRlYWxlcl9fTW9udGhseV9QeW10X19jfSszNiw0NSx7IWRlYWwuZGVhbGVyX19GaXJzdF9QYXltZW50X0RhdGVfX2N9K3x8fHx8fHx8fHx8fHx8fHx8fHw=';
                dealer__Form__c frm = new dealer__Form__c(Name='TestForm', dealer__Impact_Code__c=frmBase64, dealer__Print_Type__c='Impact');
                insert frm;

                // Create Deal
                if(dealer__DMS_Settings__c.getValues('ActiveSettings') == null){
                        dealer__DMS_Settings__c dms = new dealer__DMS_Settings__c();
                dms.Name = 'ActiveSettings';
                dms.dealer__Service_Current_Invoice_Number__c = 30093;
                dms.dealer__Service_Job_Line_Number__c = 8;
                //dms.dealer__State_Tax_Rate__c = 7.75;
                dms.dealer__Parts_Current_Invoice_Number__c = 50115;
                dms.dealer__Parts_Current_Quote_Number__c = 20028;
                dms.dealer__Default_Tax_Rate__c = 7.75;
                dms.dealer__Deal_Number__c = 1;
                dms.dealer__Deal_Default_Rate__c = 9.9; 
                insert dms;   
                }

                dealer__Deal__c deal = new dealer__Deal__c();
                deal.Name = 'Test';
                deal.dealer__Deal_Id__c = '1000';
                
                insert deal;

                DealImpactFormCompiler did = new DealImpactFormCompiler();
                did.formId = frm.Id;
                did.dealId = deal.Id;
                did.getCompiledForm();


        }  
        
         
}