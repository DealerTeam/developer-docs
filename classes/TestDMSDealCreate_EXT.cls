@isTest
//Todo: add service contract
private class TestDMSDealCreate_EXT {
    
    @testSetup static void setUpMethod() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('ZE7', 'OpenTrack Testing');
        loc.OT_Company_Number__c = 'ZE7';
        loc.OT_Enterprise_Code__c = 'ZE';
        loc.OT_Server_Name__c = 'arkdevp.arkona.com';
        update loc;

        Profile prof = [select id from profile where name='system Administrator'];

        //Users
            User usr1 = new User(alias = 'usr', email='us.name@vmail.com',
                                emailencodingkey='UTF-8', lastname='lstname',
                                timezonesidkey='America/Los_Angeles',
                                languagelocalekey='en_US',
                                localesidkey='en_US', profileid = prof.Id,
                                username='testuser128@testorgx.com',
                                isActive=true,
                                Division='ZE7',
                                EmployeeNumber = 'SP1');
            User usr2 = new User(alias = 'usr2', email='us2.name@vmail.com',
                                emailencodingkey='UTF-8', lastname='lstname2',
                                timezonesidkey='America/Los_Angeles',
                                languagelocalekey='en_US',
                                localesidkey='en_US', profileid = prof.Id,
                                username='testuser1282@testorg.com',
                                isActive=true,
                                Division='ZE7',
                                EmployeeNumber = 'SP2');
            User usr3 = new User(alias = 'usr3', email='us3.name@vmail.com',
                                emailencodingkey='UTF-8', lastname='lstname3',
                                timezonesidkey='America/Los_Angeles',
                                languagelocalekey='en_US',
                                localesidkey='en_US', profileid = prof.Id,
                                username='testuser1283@testorg.com',
                                isActive=true,
                                Division='ZE7',
                                EmployeeNumber = 'FI1');
            User usr4 = new User(alias = 'usr4', email='us4.name@vmail.com',
                                emailencodingkey='UTF-8', lastname='lstname',
                                timezonesidkey='America/Los_Angeles',
                                languagelocalekey='en_US',
                                localesidkey='en_US', profileid = prof.Id,
                                username='testuser1284@testorg.com',
                                isActive=true,
                                Division='ZE7',
                                EmployeeNumber = '');
            User usr5 = new User(alias = 'usr5', email='us5.name@vmail.com',
                                emailencodingkey='UTF-8', lastname='lstname5',
                                timezonesidkey='America/Los_Angeles',
                                languagelocalekey='en_US',
                                localesidkey='en_US', profileid = prof.Id,
                                username='testuser1285@testorg.com',
                                isActive=true,
                                Division='ZE7',
                                EmployeeNumber = 'SP2');

            List<User> users = new List<User>{usr1, usr2, usr3, usr4, usr5};
        insert users;
        
        //Vehicle
            dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c();
                inv.Name = 'Test Vehicle Inventory';
                inv.dealer__Model__c = 'Legacy';
                inv.dealer__Stock_Number__c = 'P64913';
                inv.dealer__VIN__c = '4S3BL616X87217418';
                inv.dealer__Company_Number__c = 'DT1'; 
                inv.dealer__Year__c = '2008';
                inv.dealer__Make__c = 'Subaru';
                inv.dealer__Retail_Price__c = 2000;
                inv.dealer__Store_Location__c = loc.Id;
                inv.dealer__Status_Code__c = 'I';
                inv.In_Stock__c = true;
        insert inv;

        //Account and cobuyer account
            Account a = new Account(
                FirstName     =   'Jack',
                LastName      =   'Eichenberg',
                PersonEmail   =   'jack@test.com',
                PersonMobilePhone  = '9172255960'
                );
            Account a2 = new Account(
                FirstName     =   'Rosa',
                LastName      =   'Chilowsky',
                PersonEmail   =   'rosabanana@test.com',
                PersonMobilePhone  = '9177448343'
                );
            Account a3 = new Account(
                FirstName     =   'OldTesting',
                LastName      =   'OldCustNum',
                PersonEmail   =   'oldtestingcustnum@test.com',
                PersonMobilePhone  = '8158675309',
                dealer__External_Id__c = '9999999999'
                );
            Account a4 = new Account(
                FirstName     =   'NewTesting',
                LastName      =   'NewCustNum',
                PersonEmail   =   'newtestingcustnum@test.com'
                );

            List<Account> accts = new List<Account>{a, a2, a3, a4};
        insert accts;

        

        //Customer/Contacts
            Contact c  = [SELECT Id, FirstName, LastName, Email, Phone FROM Contact WHERE AccountID=:a.Id];
            Contact c2 = [SELECT Id, FirstName, LastName, Email, Phone FROM Contact WHERE AccountID=:a2.Id];
            Contact c3 = [SELECT Id, FirstName, LastName, Email, Phone FROM Contact WHERE AccountID=:a3.Id];
            Contact c4 = [SELECT Id, FirstName, LastName, Email, Phone FROM Contact WHERE AccountID=:a4.Id];

            c3.dealer__External_Id__c = a3.dealer__External_Id__c;
            update c3;

        //Service Vehicle - if you change values here, test classes will fail
            dealer__Service_Vehicle__c servVeh = new dealer__Service_Vehicle__c(
                dealer__Year__c = '1999',
                dealer__Veh_Owner_Contact__c = c.Id,
                dealer__VIN__c = '12345678909B54998',
                dealer__Stock_Number__c = '1234',
                dealer__Make__c = 'TestTradeMake',
                dealer__Licence__c = 'Test',
                dealer__Last_Service__c = System.today(),
                dealer__Carline__c = 'TestTradeModel',
                dealer__Last_6__c = 'B54998',
                dealer__Last_Odometer__c = 88888
            );
        insert servVeh;

        //Service Contract
            dealer__Service_Contract__c serCon = new dealer__Service_Contract__c(
                dealer__External_Id__c = '1',
                dealer__Expiration_Months__c = 12,
                dealer__SDRecordKey__c = 2,
                dealer__Contract_Template__c = true,
                dealer__Location__c = loc.Id,
                dealer__Default_on_Retail_Deals__c = true
                );
        insert serCon;

        //Sales Up
            dealer__Sales_Up__c sup = new dealer__Sales_Up__c(
                            dealer__Desired_Stock_Num__c = inv.Id,
                            dealer__Customer_Account__c = a.Id,
                            dealer__Buyer_Contact__c = c.Id,
                            dealer__FirstName__c='Jack', 
                            dealer__LastName__c='Eichenberg',
                            dealer__Lead_Status__c='Open',
                            dealer__Mobile__c='9172255960',
                            dealer__Email__c='jack@test.com',
                            dealer__Salesperson_1__c = usr1.Id,
                            dealer__F_I_Manager__c = usr3.Id,
                            dealer__CCC_Rep__c = usr2.Id,
                            dealer__Store_Location__c = loc.Id,
                            dealer__Service_Vehicle__c = servVeh.Id,
                            OwnerID = usr1.Id
                    );
            dealer__Sales_Up__c sup2 = new dealer__Sales_Up__c(
                            dealer__Desired_Stock_Num__c = inv.Id,
                            dealer__Customer_Account__c = a4.Id,
                            dealer__Buyer_Contact__c = c4.Id,
                            dealer__FirstName__c='NewTesting', 
                            dealer__LastName__c='NewCustNum',
                            dealer__Lead_Status__c='Open',
                            dealer__Salesperson_1__c = usr1.Id,
                            dealer__F_I_Manager__c = usr3.Id,
                            dealer__Store_Location__c = loc.Id,
                            OwnerID = usr1.Id
                    );
        List<dealer__Sales_Up__c> sups = new List<dealer__Sales_Up__c>{sup, sup2};
        insert sups;

        /*//Appraisal Vehicle
            dealer__Appraisal_Vehicle__c av = new dealer__Appraisal_Vehicle__c(
                dealer__Sales_Up__c = sup.Id,
                dealer__Service_Vehicle__c = servVeh.Id
                );

        insert av;*/

        //Desired Vehicle
            dealer__Desired_Vehicle__c dv = new dealer__Desired_Vehicle__c(
                                dealer__Make__c = 'Subaru',
                                dealer__Year__c = '2008',
                                dealer__Model__c = 'Legacy',
                                dealer__Sales_Up__c = sup.Id,
                                dealer__Vehicle_Inventory__c = inv.Id
                                );
        insert dv;

        List<dealer__Appraisal_Vehicle__c> aprvehs = [SELECT Id, dealer__VIN__c, dealer__Year__c, dealer__Make__c, dealer__Model__c, dealer__Body_Type__c from dealer__Appraisal_Vehicle__c];
        System.debug('the number of Appraisal Vehicles is: '+aprvehs.size());
        System.debug('the auto-created appraisal vehicle info: '+aprvehs[0]);
    }

    
    //Trade in fields can come from 2 different sources
    @isTest static void testTradeInFields(){
        dealer__Dealer_Location__c loc = [SELECT Id, dealer__Include_Trade_In__c FROM dealer__Dealer_Location__c 
            WHERE dealer__Company_Number__c = 'ZE7' LIMIT 1];
        System.debug('Initial include trade in value: '+loc.dealer__Include_Trade_In__c);
        loc.dealer__Include_Trade_In__c = true;
        update loc;
        //look at JSON string and ensure it is not blank
        //dont need to ensure that the mockhhtpresponsegenerator will return the correct thing.
        dealer__Sales_Up__c sup = [Select Id, OwnerId from dealer__Sales_Up__c where dealer__LastName__c='Eichenberg' limit 1];
        User u = [SELECT Id, Name, EmployeeNumber FROM User WHERE Id =:sup.OwnerId LIMIT 1];
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(sup);
        String payload;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        System.runAs(u){
            DMSDealCreate_EXT ext = new DMSDealCreate_EXT(sc);
            ext.sp2 = u;
            ext.dm = u;
            ext.validateFields();
            payload = ext.createPayloadSerialize();

            System.debug('payload here: '+payload);
        }

        Test.stopTest();

        //Make sure all of the fields are populated in the payload
        System.assert(payload.contains('\"TradeMake\":\"TestTradeMake\"'), 'Payload does not contain the Trade Make');
        System.assert(payload.contains('\"TradeModel\":\"TestTradeModel\"'), 'Payload does not contain the Trade Model');
        //body
        System.assert(payload.contains('\"Odometer\":\"88888\"'), 'Payload does not contain the Trade Model');
        //StockNumber
        System.assert(payload.contains('\"TradeYear\":\"1999\"'), 'Payload does not contain the Trade Year');
        System.assert(!payload.contains('\"TradeIn\":{\"VIN\":null'), 'Payload does not contain the VIN');
    }
    
    
    @isTest static void testSuccessDealCreate() {

        dealer__Sales_Up__c sup = [Select Id, OwnerId from dealer__Sales_Up__c where dealer__LastName__c='Eichenberg' limit 1];
        User u = [SELECT Id FROM User WHERE Id =:sup.OwnerId LIMIT 1];
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(sup);

        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        System.runAs(u){
            DMSDealCreate_EXT ext = new DMSDealCreate_EXT(sc);
            ext.create();

            ext.cancel();
            for(ApexPages.Message msg :  ApexPages.getMessages()) {
                System.debug(msg.getSummary());
            }
            
            System.assertNotEquals(null, ext.newDeal);
            ext.viewDeal();
        }
        Test.stopTest();
    }
    
    //Should fail if inv, con1 & acc1, sp1, or fi are null
    @isTest static void testNullInv() {

        PageReference pageRef = Page.DMSDealCreatePage;
        Test.setCurrentPage(pageRef);

        dealer__Sales_Up__c sup = [Select s.Id,
        s.dealer__Desired_Stock_Num__r.Id, s.dealer__Salesperson_1__r.Id
        from dealer__Sales_Up__c s where s.dealer__LastName__c='Eichenberg' limit 1];
        
        dealer__Vehicle_Inventory__c inv = sup.dealer__Desired_Stock_Num__r;
        User sp1 = sup.dealer__Salesperson_1__r;

        //*****************************************
        //Test null vehicle
        //*****************************************

        sup.dealer__Desired_Stock_Num__c = null;
        update sup;

        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(sup);

        System.runAs(sp1){
            DMSDealCreate_EXT ext = new DMSDealCreate_EXT(sc);
        }

        List<ApexPages.Message> msgList = ApexPages.getMessages();
        
        for(ApexPages.Message msg :  ApexPages.getMessages()) {
            System.assertEquals('Must have attached desired vehicle to the Sales Up', msg.getSummary());
            System.assertEquals(ApexPages.Severity.ERROR, msg.getSeverity()); 
        }
    }

    @isTest static void testNullCust() {

        PageReference pageRef = Page.DMSDealCreatePage;
        Test.setCurrentPage(pageRef);

        dealer__Sales_Up__c sup = [Select s.Id, s.dealer__Salesperson_1__r.Id,
        s.dealer__Buyer_Contact__r.Id, s.dealer__Customer_Account__r.Id
        from dealer__Sales_Up__c s where s.dealer__LastName__c='Eichenberg' limit 1];
        
        User sp1 = sup.dealer__Salesperson_1__r;
        Contact c = sup.dealer__Buyer_Contact__r;
        Account a = sup.dealer__Customer_Account__r;

        //*****************************************
        //Now test null contact and account
        //*****************************************

        sup.dealer__Buyer_Contact__c = null;
        sup.dealer__Customer_Account__c = null;
        update sup;

        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(sup);
        
        
        System.runAs(sp1){
            DMSDealCreate_EXT ext = new DMSDealCreate_EXT(sc);
        }

        List<ApexPages.Message> msgList = ApexPages.getMessages();
        
        for(ApexPages.Message msg :  ApexPages.getMessages()) {
            System.assertEquals('Must have attached Customer to the Sales Up', msg.getSummary());
            System.assertEquals(ApexPages.Severity.ERROR, msg.getSeverity()); 
        }
    }


    @isTest static void testNullSP1() {

        PageReference pageRef = Page.DMSDealCreatePage;
        Test.setCurrentPage(pageRef);

        dealer__Sales_Up__c sup = [Select s.Id, 
        s.dealer__Salesperson_1__r.Id
        from dealer__Sales_Up__c s where s.dealer__LastName__c='Eichenberg' limit 1];

        User sp1 = sup.dealer__Salesperson_1__r;

        //*****************************************
        //Now test null sp1
        //*****************************************

        sup.dealer__Salesperson_1__c = null;
        update sup;

        System.debug('purple: '+sup);
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(sup);
        
        System.runAs(sp1){
            DMSDealCreate_EXT ext = new DMSDealCreate_EXT(sc);
        }

        List<ApexPages.Message>msgList = ApexPages.getMessages();
        
        for(ApexPages.Message msg :  ApexPages.getMessages()) {
            System.assertEquals('Must have attached Salesperson to the Sales Up', msg.getSummary());
            System.assertEquals(ApexPages.Severity.ERROR, msg.getSeverity()); 
        }
    }


    @isTest static void testNullFI() {

        PageReference pageRef = Page.DMSDealCreatePage;
        Test.setCurrentPage(pageRef);

        dealer__Sales_Up__c sup = [Select s.Id,
        s.dealer__F_I_Manager__r.Id, s.dealer__Salesperson_1__r.Id
        from dealer__Sales_Up__c s where s.dealer__LastName__c='Eichenberg' limit 1];
        
        User fi = sup.dealer__F_I_Manager__r;
        User sp1 = sup.dealer__Salesperson_1__r;

        //*****************************************
        //Now test null fi manager
        //*****************************************

        sup.dealer__Salesperson_1__c = sp1.Id;
        sup.dealer__F_I_Manager__c = null;
        update sup;

        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(sup);
        
        System.runAs(sp1){
            DMSDealCreate_EXT ext = new DMSDealCreate_EXT(sc);
        }

        List<ApexPages.Message> msgList = ApexPages.getMessages();
        
        for(ApexPages.Message msg :  ApexPages.getMessages()) {
            System.assertEquals('Must have attached F & I Manager to the Sales Up', msg.getSummary());
            System.assertEquals(ApexPages.Severity.ERROR, msg.getSeverity()); 
        }
    }

    //Test the user's ability to create a new customer in dealertrack
    @isTest static void testCreateNewCust(){
        String pubval = '';

        Account a = new Account(
            FirstName     =   'toomany',
            LastName      =   'matches',
            PersonEmail   =   'lotsofpeople@test.com',
            PersonMobilePhone  = '9999999993'
            );
        insert a;

        Contact c = [SELECT Id FROM Contact WHERE AccountId =:a.Id LIMIT 1];

        dealer__Sales_Up__c sup = [Select s.Id, s.dealer__Salesperson_1__r.Id from dealer__Sales_Up__c s where s.dealer__LastName__c='Eichenberg' limit 1];

        User sp1 = sup.dealer__Salesperson_1__r;

        sup.dealer__Customer_Account__c = a.Id;
        sup.dealer__Buyer_Contact__c = c.Id;
        update sup;

        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(sup);
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
            System.runAs(sp1){
                DMSDealCreate_EXT ext = new DMSDealCreate_EXT(sc);
                ext.create();
                ext.createNewCust();
                pubval = ext.createNewValue;
            }
        Test.stopTest();

        System.assertEquals('buyer', pubval, 'The JSON payload variable to indicate bypass of customer selection was not set properly');
    }

    @isTest static void testDifferentNameSelectCustomer(){
        String returnedCustNum = '8906494';
        Account a = new Account(
            FirstName     =   'toomany',
            LastName      =   'matches',
            PersonEmail   =   'lotsofpeople@test.com',
            PersonMobilePhone  = '9999999993'
            );
        insert a;

        Contact c = [SELECT Id FROM Contact WHERE AccountId =:a.Id LIMIT 1];

        dealer__Sales_Up__c sup = [Select s.Id, s.dealer__Salesperson_1__r.Id from dealer__Sales_Up__c s where s.dealer__LastName__c='Eichenberg' limit 1];

        User sp1 = sup.dealer__Salesperson_1__r;

        sup.dealer__Customer_Account__c = a.Id;
        sup.dealer__Buyer_Contact__c = c.Id;
        update sup;

        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(sup);
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
            System.runAs(sp1){
                DMSDealCreate_EXT ext = new DMSDealCreate_EXT(sc);
                ext.create();

                ext.custName = 'doesntmatch';
                ext.custId = returnedCustNum;
                ext.addCustInfo();

                List<Object> cList = ext.customerList;
                List<Map<String, Object>> cFields = ext.custFields;
                Integer vehCount = ext.aprVehCount;
                String calloutError = ext.calloutError;
            }
        Test.stopTest();

        //what is failing? neither customer gets updated. 
        List<Account> aX = [SELECT Id FROM Account WHERE dealer__External_Id__c =:returnedCustNum];
        System.assertNotEquals(0, aX.size(), 'No Account got updated with the returned customer number');
    }


    @isTest static void testManyCustMatches(){
        Account a = new Account(
            FirstName     =   'toomany',
            LastName      =   'matches',
            PersonEmail   =   'lotsofpeople@test.com',
            PersonMobilePhone  = '9999999993'
            );
        insert a;

        Contact c = [SELECT Id FROM Contact WHERE AccountId =:a.Id LIMIT 1];

        dealer__Sales_Up__c sup = [Select s.Id, s.dealer__Salesperson_1__r.Id from dealer__Sales_Up__c s where s.dealer__LastName__c='Eichenberg' limit 1];

        User sp1 = sup.dealer__Salesperson_1__r;

        sup.dealer__Customer_Account__c = a.Id;
        sup.dealer__Buyer_Contact__c = c.Id;
        update sup;

        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(sup);
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
            System.runAs(sp1){
                DMSDealCreate_EXT ext = new DMSDealCreate_EXT(sc);
                ext.create();

            ext.custName = 'toomany';
            ext.custId = '8906494';
            ext.addCustInfo();
            }
        Test.stopTest();
    }
    
    @isTest static void testSP2_DM_Co_Buyer(){

        dealer__Sales_Up__c sup = [Select s.Id,
            s.dealer__F_I_Manager__r.Id, s.dealer__Salesperson_1__r.Id,
            s.dealer__CCC_Rep__r.Id
            from dealer__Sales_Up__c s where s.dealer__LastName__c='Eichenberg' limit 1];

        Account a2 = [Select Id from Account where LastName='Chilowsky' limit 1];
        Contact c2 = [Select Id from Contact where LastName='Chilowsky' limit 1];

        User sp1 = sup.dealer__Salesperson_1__r;
        User sp2 = sup.dealer__CCC_Rep__r;
        User dm = [SELECT Id from User where username='testuser1285@testorg.com' LIMIT 1];


        sup.dealer__CCC_Rep__c = null;
        sup.dealer__Salesperson_2__c = sp2.Id;
        sup.dealer__Desk_Manager_User__c = dm.Id;
        sup.dealer__Co_Buyer__c = a2.Id;
        sup.dealer__Co_Buyer_Contact__c = c2.Id;
        update sup;

        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(sup);
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
            System.runAs(sp1){
                DMSDealCreate_EXT ext = new DMSDealCreate_EXT(sc);
                ext.create();

            ext.custName = 'Rosa';
            ext.custId = '8906494';
            ext.addCustInfo();
            }
        Test.stopTest();
    }

    @isTest static void testNonUniqueSP() {

        PageReference pageRef = Page.DMSDealCreatePage;
        Test.setCurrentPage(pageRef);

        dealer__Sales_Up__c sup = [Select s.Id, 
        s.dealer__Salesperson_1__r.Id
        from dealer__Sales_Up__c s where s.dealer__LastName__c='Eichenberg' limit 1];

        User sp1 = sup.dealer__Salesperson_1__r;

        //*****************************************
        //Now test null sp1
        //*****************************************

        sup.dealer__Salesperson_2__c = sp1.Id;
        update sup;

        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(sup);

        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
            System.runAs(sp1){
                DMSDealCreate_EXT ext = new DMSDealCreate_EXT(sc);
                ext.create();

            }
        Test.stopTest();
        

        List<ApexPages.Message>msgList = ApexPages.getMessages();
        
        for(ApexPages.Message msg :  ApexPages.getMessages()) {
            System.assertEquals('Each employee assigned to the Sales Up must be unique.', msg.getSummary());
            System.assertEquals(ApexPages.Severity.ERROR, msg.getSeverity()); 
        }
    }

    //If an Account or Contact's customer number already exists in the system, remove it from the old Account/Contact and assign it to the new.
    @isTest static void testMoveCustNum(){

        Set<String> apexMes = new Set<String>();

        //get the sales up
        dealer__Sales_Up__c sup = [Select Id, OwnerId from dealer__Sales_Up__c where dealer__LastName__c='NewCustNum' limit 1];
        
        //create a deal for it
        User u = [SELECT Id FROM User WHERE Id =:sup.OwnerId LIMIT 1];
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(sup);

        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        System.runAs(u){
            DMSDealCreate_EXT ext = new DMSDealCreate_EXT(sc);
            ext.create();

            for(ApexPages.Message msg :  ApexPages.getMessages()) {
                System.debug(msg.getSummary());
                apexMes.add(msg.getSummary());
            }
            
            System.assertNotEquals(null, ext.newDeal);
        
            //ensure that the old account, contact does not have the external ID
            Account oldA = [SELECT Id, dealer__External_Id__c FROM Account WHERE FirstName = 'OldTesting' LIMIT 1];
            Contact oldC = [SELECT Id, dealer__External_Id__c FROM Contact WHERE FirstName = 'OldTesting' LIMIT 1];

            //ensure that the new account, contact has the external ID
            Account newA = [SELECT Id, dealer__External_Id__c FROM Account WHERE FirstName = 'NewTesting' LIMIT 1];
            Contact newC = [SELECT Id, dealer__External_Id__c FROM Contact WHERE FirstName = 'NewTesting' LIMIT 1];

            System.assertEquals(null, oldA.dealer__External_ID__c, 'Old Account external id not null');
            System.assertNotEquals(null, newA.dealer__External_ID__c, 'New Account external id null');
            
            System.assertEquals(null, oldC.dealer__External_ID__c, 'Old Contact external id not null');
            System.assertNotEquals(null, newC.dealer__External_ID__c, 'New Contact external id null');

            //ensure that the message is on the page
            System.assert(apexMes.contains('Customer Number belonged to OldTesting OldCustNum'));
            
        }

        Test.stopTest();    
    }

     @isTest static void testValidateFields(){

        dealer__Sales_Up__c sup = [Select s.Id,
            s.dealer__F_I_Manager__r.Id, s.dealer__Salesperson_1__r.Id,
            s.dealer__CCC_Rep__r.Id
            from dealer__Sales_Up__c s where s.dealer__LastName__c='Eichenberg' limit 1];

        Account a2 = [Select Id from Account where LastName='Chilowsky' limit 1];
        Contact c2 = [Select Id from Contact where LastName='Chilowsky' limit 1];

        User sp1 = sup.dealer__Salesperson_1__r;
        User sp2 = sup.dealer__CCC_Rep__r;
        User dm = [SELECT Id from User where username='testuser1285@testorg.com' LIMIT 1];


        sup.dealer__CCC_Rep__c = null;
        sup.dealer__Salesperson_2__c = sp2.Id;
        sup.dealer__Desk_Manager_User__c = dm.Id;
        sup.dealer__Co_Buyer__c = a2.Id;
        sup.dealer__Co_Buyer_Contact__c = c2.Id;
        update sup;
        
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(sup);
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
            System.runAs(sp1){
                DMSDealCreate_EXT ext = new DMSDealCreate_EXT(sc);
                ext.custName = 'Rosa';
                ext.custId = '8906494';
                ext.sp1.EmployeeNumber = null;
                ext.sp2.EmployeeNumber = null;
                ext.dm.EmployeeNumber = null;
                ext.fi.EmployeeNumber = null;
                ext.bdc = dm;
                ext.bdc.EmployeeNumber = null;
                
                ext.create();

                ext.addCustInfo();            
            }
        Test.stopTest();
    }
}