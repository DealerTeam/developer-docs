@isTest
public class Desking_Ext_Test{

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
                  
        dealer__Dealer_Location_User__c locU = new dealer__Dealer_Location_User__c();
        locU.dealer__Dealer_Location__c = Loc.id;
        locU.dealer__User__c = usr.id;
        insert locU;

    }

    static testMethod void testMethodOne(){

            User u = [Select Id from User where Username = 'testuser128@testorgx.com'];
            System.runAs(u) {

            TestClassUtil tu = new TestClassUtil();
            //inserting record into finance company.
            dealer__Finance_Company__c fc = new  dealer__Finance_Company__c();
            fc.Name = 'Test Finance Company';
            fc.dealer__Active__c = True;
            insert fc;
            
            dealer__Deal__c Deal = new dealer__Deal__c();
            Deal.dealer__Broker__c = tu.insertAccount();
            Deal.dealer__Buyer_Contact__c = tu.insertContact();
            Deal.dealer__Buyer__c = tu.insertAccount();
            Deal.dealer__Co_Buyer_Contact__c = tu.insertContact();
            Deal.dealer__Co_Buyer__c = tu.insertAccount();
            Deal.dealer__Deal_ID__c = '9251';
            Deal.dealer__Licence__c = 'TL1100';
            Deal.dealer__Vehicle__c = tu.insertVehicleInventory();
            Deal.Name = '12342';  
            Deal.dealer__Maintenance_Gross__c = 100;
            Deal.dealer__Wrnty_Mileage__c = 100;
            Deal.dealer__Maintenance_Gross__c = 100;
            Deal.dealer__Aftermarket_Gross__c = 100;
            Deal.dealer__Finance_Gross__c = 100;     
            insert Deal;
            
            dealer__Trade_In__c tradeIn = new dealer__Trade_In__c();
            tradeIn.Name = 'Test trade in';
            tradeIn.dealer__ACV__c = 100;
            tradeIn.dealer__Appraisal_Date__c = System.Today();
            //tradeIn.dealer__Appraised_By__c
            tradeIn.dealer__Black_Book_Retail__c = 100;
            tradeIn.dealer__Black_Book_Wholesale__c = 100;
            
            tradeIn.dealer__Car_Deal__c = deal.Id;
            //tradeIn.dealer__Inventory_Vehicle__c = tu.insertVehicleInventory();
            tradeIn.dealer__K_B_B_Retail__c = 100;
            tradeIn.dealer__K_B_B_Wholesale_Value__c = 100;
            tradeIn.dealer__Lost_Trade__c = False;
            tradeIn.dealer__Make__c = 'India';
            tradeIn.dealer__Model__c = 'Hyundai';
            tradeIn.dealer__NADA_Retail__c = 100;
            tradeIn.dealer__NADA_Wholesale__c = 100;
            tradeIn.dealer__Odometer_at_Trade_In__c = 125;
            //tradeIn.dealer__Pay_Off_Account__c = 100;
            tradeIn.dealer__Pay_Off_Expiration_Date__c = System.Today() + 10;
            tradeIn.dealer__Pay_Off_To__c = 'Test Person';
            tradeIn.dealer__Position__c = 1;
            tradeIn.dealer__Service_Vehicle__c = tu.insertServiceVehicle();
            tradeIn.dealer__Stock_Number__c = 'Test Stock';
            tradeIn.dealer__Trade_Allowance__c = 250;
            tradeIn.dealer__VIN__c = '1HGCR2F87DA284126';
            tradeIn.dealer__Year__c = '2015';
            insert tradeIn;
            
            dealer__Parts_Kit__c pk = new dealer__Parts_Kit__c();
            pk.Name = 'Test part kit';
            pk.dealer__Description__c = 'This is a test pk description';
            //pk.dealer__Kit_Cost__c = 10;
            //pk.dealer__Kit_List__c = 'Test List';
            insert pk;
         
            //inserting record into after market object.
            dealer__After_Market__c am = new dealer__After_Market__c();
            am.Name = 'Test Name';
            am.dealer__Car_Deal__c = deal.Id;
            am.dealer__Cost__c = 100;
            am.dealer__Sale_Price__c = 100;
            am.dealer__List_Price__c = 100;
            am.dealer__Labor_Sale__c = 100;
            am.dealer__Parts_Kit__c = tu.insertPartsKit();
            am.dealer__Company_Number__c = '123';
            am.dealer__Description__c = 'Test Desc'; 
            insert am;
            
            dealer__Service_Vehicle__c SV = new dealer__Service_Vehicle__c();
            SV.dealer__Year__c = '2014';
            SV.dealer__Veh_Owner_Contact__c = tu.insertContact();
            SV.dealer__VIN__c = 'B54999';
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
            serviceContract.dealer__Customer_Contact__c = tu.insertContact();
            serviceContract.dealer__Customer__c = tu.insertAccount();
            serviceContract.dealer__Deductable__c = 25;
            serviceContract.dealer__Description__c = 'Test desc';
            serviceContract.dealer__Plan_Code__c = 'Test Plan';
            serviceContract.dealer__Product_Code__c = 'Code 1';
            serviceContract.dealer__Sale_Price__c = 200;
            serviceContract.dealer__Service_Vehicle__c = SV.Id;
            serviceContract.dealer__Start_Date__c = System.today();
            serviceContract.dealer__Vehicle_Inventory__c = tu.insertVehicleInventory();
            serviceContract.dealer__Type__c = 'GAP';
            insert serviceContract; 
            

            Test.startTest();
            
                  ApexPages.StandardController sc = new ApexPages.standardController(deal);
                  Desking_Ext deskingExt = new Desking_Ext(sc);
                  deskingExt.escSelectedId = serviceContract.Id;
                  deskingExt.deleteProductId = serviceContract.Id;
                  deskingExt.fetchInventoryVehicle();
                  Desking_Ext.setApplicationCache();
                  deskingExt.createInventory();
                  deskingExt.returnToDeal();
                  deskingExt.getInvoiceLogo();
                  deskingExt.selectedPartNumber = pk.Id;
                  deskingExt.saveWeOweLineItem();
                  deskingExt.insertTradeIn(1);
                  deskingExt.findTotalRollup();
                  deskingExt.selectProduct();
                  deskingExt.deleteProduct();

            Test.stopTest();

            }
    }

    @isTest
    static void testNotLostTradeIn(){
        Deal__c Deal = new Deal__c();
        ApexPages.StandardController sc = new ApexPages.standardController(Deal);
        String dealID;
        dealer__Trade_In__c ret = new dealer__Trade_In__c();
        ret = Desking_EXT.notLostTradeIn(dealID);
        System.assertEquals(null, ret.dealer__Car_Deal__c,'testNotLostTradeIn should return null when passed a null deal.');
        
        Deal__c Deal2 = (Deal__c)TestFactory.createSObject(new Deal__c(Deal_ID__c = '1'), true);
        ApexPages.StandardController sc2 = new ApexPages.standardController(Deal2);
        dealID = Deal2.Id;
        Service_Vehicle__c veh = (Service_Vehicle__c)TestFactory.createSObject(new Service_Vehicle__c(), true);
        dealer__Trade_In__c trade = (dealer__Trade_In__c)TestFactory.createSObject(new dealer__Trade_In__c(dealer__Car_Deal__c = Deal2.Id, dealer__Lost_Trade__c = false, dealer__Service_Vehicle__c = veh.Id, dealer__Inventory_Vehicle__c = null), true);
        ret = Desking_EXT.notLostTradeIn(dealID);
        System.assertEquals(dealID, ret.dealer__Car_Deal__c, 'Trade In associated with deal was not returned');
    }

    @isTest
    static void testGetDealTitle(){        
        dealer__Deal__c Deal = new dealer__Deal__c();
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(Deal);
        Desking_EXT desk = new Desking_EXT(sc);
        String ret = desk.getdealTitle();
        system.assertEquals('New Deal', ret,'Title of a null Deal should be New Deal');

        Deal__c Deal2 = (Deal__c)TestFactory.createSObject(new deal__c(Deal_ID__c = '1', Stock_Number__c = '123', Buyer_Last_Name__c = 'Smith', Buyer_First_Name__c = 'John'), true);
        ApexPages.Standardcontroller sc2 = new ApexPages.Standardcontroller(Deal2);
        Desking_EXT desk2 = new Desking_EXT(sc2);
        ret = desk2.getdealTitle();
        system.assertEquals('123 Smith, John', ret, 'Title of Deal should display stock number + Last Name, First Name');
    }

    @isTest
    static void testGetTaxZoneCountyList(){
        dealer__Deal__c Deal = new dealer__Deal__c();
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(Deal);
        Desking_EXT desk = new Desking_EXT(sc);
        dealer__Tax_Zones__c[] ZoneList = new dealer__Tax_Zones__c[]{};
        dealer__Tax_Zones__c Zone = new dealer__Tax_Zones__c();
        
        for(Integer i=0; i<10; i++){
            Zone = (dealer__Tax_Zones__c)TestFactory.createSObject(new dealer__Tax_Zones__c(dealer__County__c = 'County ' + i),true);
            ZoneList.add(Zone);
    }
        String[] retList = desk.getTaxZoneCountyList();
        system.assertEquals(10, retList.size());
    }

    @isTest
    static void testPopulateCompany(){
        dealer__Deal__c Deal = new dealer__Deal__c();
        system.debug('Business Contracting Name = ' + Deal.dealer__Business_Contracting_Name__c);
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(Deal);
        Desking_EXT desk = new Desking_EXT(sc);
        Account a = (Account)TestFactory.createSObject(new Account(Name='John Smith', BillingStreet='1234 Main St', BillingCity='Redding', BillingState='CA', BillingPostalCode='96001', Phone='5305559211' ), true);
        desk.populateCompany(a);
        
        system.assertEquals(Deal.dealer__Business_Contracting_Name__c, a.Name, 'Business Contracting Name and Account Name should match');
        system.assertEquals(Deal.dealer__Business_Address__c, a.BillingStreet, 'Business Address and Account Billing Street should match');
        system.assertEquals(Deal.dealer__Business_City__c, a.BillingCity,'Business City and Account Billing City should match');
        system.assertEquals(Deal.dealer__Business_State__c, a.BillingState,'Business State and Account Billing State should match');
        system.assertEquals(Deal.dealer__Business_Postal_Code__c, a.BillingPostalCode,'Business Postal Code and Account Billing Postal Code should match');
        system.assertEquals(Deal.dealer__Business_Phone__c, a.Phone, 'Business Phone and Account Phone should match');
    }

    @isTest
    static void testGetTaxZone(){
        String state = 'CA:Shasta';
        dealer__Tax_Zones__c Zone = (dealer__Tax_Zones__c)TestFactory.createSObject(new dealer__Tax_Zones__c(dealer__State__c = 'CA', dealer__County__c = 'Shasta'),true);
        dealer__Tax_Zones__c retZone = Desking_EXT.getTaxZone(state);

        system.assertEquals(Zone.dealer__State__c, retZone.dealer__State__c, 'State does not match the information provided.');
        system.assertEquals(Zone.dealer__County__c, retZone.dealer__County__c, 'County does not match the information provided.');
    }

    @isTest
    static void testLookupContact(){
        Contact con = (Contact)TestFactory.createSObject(new Contact(LastName = 'TestContact', FirstName = 'testFirstName'), true);
        String conId = con.Id;
        Contact retCon = Desking_EXT.lookupContact(conId);

        system.assertEquals(con.Id, retCon.Id, 'Contact returned does not match contact provided.');
    }

    @isTest
    static void testLookupAccount(){
        Account acc = (Account)TestFactory.createSObject(new Account( Name = 'AccountTest'), true);
        String accId = acc.Id;
        Account retAcc = Desking_EXT.lookupAccount(accId);

        system.assertEquals(acc.Id, retAcc.Id, 'Account returned does not match account provided.');
    }
}