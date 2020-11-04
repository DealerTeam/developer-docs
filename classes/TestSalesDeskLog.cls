@isTest
private class TestSalesDeskLog {
  
    static testmethod void testDL() { 

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
        VI.dealer__Model__c = 'SA2014';
        VI.dealer__Stock_Number__c = 'SA2014';
        VI.dealer__VIN__c = 'SA2014';
        VI.dealer__Company_Number__c = 'Location 1';
        VI.dealer__Year__c = '2014';
        VI.dealer__Make__c = 'SA2014';
        insert VI;
        dealer__Sales_Up__c up = new dealer__Sales_Up__c();
        up.Name = 'Test SalesUP';
        up.dealer__Buyer_Contact__c = conRec.Id;
        //up.dealer__Desired_Stock_Num__c = VI.Id;
        up.dealer__Make__c = 'Telsa';
        up.dealer__FirstName__c = 'TestFirstName';
        up.dealer__LastName__c = 'LastName';
        up.dealer__Salesperson_1__c = userinfo.getUserId();
        insert up;

        dealer__Deal__c Deal = new dealer__Deal__c();
        Deal.dealer__Broker__c = accRec.Id;
        Deal.dealer__Buyer_Contact__c = conRec.Id;
        Deal.dealer__Buyer__c = accRec.Id;
        Deal.dealer__Co_Buyer_Contact__c = conRec.Id;
        Deal.dealer__Co_Buyer__c = accRec.Id;
        Deal.dealer__Deal_ID__c = '12345';
        Deal.dealer__Deal_Date__c = system.today();
        Deal.dealer__Licence__c = '100';
        Deal.dealer__Vehicle__c = VI.Id;
        Deal.Name = '12342';
        insert Deal;

        test.startTest();

        SalesDeskLog sdl = new SalesDeskLog();
        sdl.getTrafficTypes();
        sdl.getTrafficType();
        sdl.getCompanies();
        sdl.getManager();
        sdl.getFinance();
        sdl.setCompanyNumber();
        sdl.getS1List();
        sdl.getS2List();
        sdl.getUpBoard();
        sdl.getdeskEntries();
        sdl.trafficFilter();
        sdl.getCategories();
        sdl.updateUserSettings();
        sdl.userFilter();

        sdl.generateDeskLog();

        sdl.dropActiveSalesperson();
        
        //Remote Access
        //dealer__Sales_Up__c up = [Select Id from dealer__Sales_Up__c where dealer__Buyer_Contact__c  != null limit 1];    
        SalesDeskLog.updateInStore(up.Id);
        SalesDeskLog.updateSalesStep(up.Id+':dealer__Write_Up__c');
        SalesDeskLog.updateSalesStep(up.Id+':dealer__Demo__c');
        // SalesDeskLog.updateSalesStep(up.Id+':dealer__Greet_Meet__c');
        //SalesDeskLog.updateSalesStep(up.Id+':dealer__Present_Vehicle__c'); 

        // random variable coverage - DR 

        Boolean tBool = sdl.setToTrue;
        tBool = sdl.setToFalse;

        test.stopTest();  

        } 
    }

    @isTest static void Test2() {
        SalesDeskLog sdl = new SalesDeskLog();
        sdl.config = null;
        sdl.updateUserSettings();

        SalesDeskLog.deskLogEntry entry = new SalesDeskLog.deskLogEntry(new dealer__Sales_Up__c(), new dealer__Deal__c(), 'null', 'null');
        SalesDeskLog.salesRotation rot = new SalesDeskLog.salesRotation(new User(), new Sales_Up__c());
    }
    
    
    static testmethod void testDLAppointment() {
        //Insert dms settings needed for linked sales appointments
        TestClassUtil util = new TestClassUtil();
        dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        if(dms == null){
            util.insertDMSSettings();   
        }
        dms = [SELECT Id, dealer__SalesAppointmentLinkedEvent__c FROM dealer__DMS_Settings__c WHERE Name = 'ActiveSettings' LIMIT 1];
        dms.dealer__SalesAppointmentLinkedEvent__c = true;
        update dms;

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

        dealer__Sales_Up__c up = new dealer__Sales_Up__c();
        up.Name = 'Test SalesUP';
        up.dealer__Buyer_Contact__c = conRec.Id;
        //up.dealer__Desired_Stock_Num__c = VI.Id;
        up.dealer__Make__c = 'Telsa';
        up.dealer__FirstName__c = 'TestFirstName';
        up.dealer__LastName__c = 'LastName';
        up.dealer__Salesperson_1__c = userinfo.getUserId();
        insert up;


        dealer__Sales_Appointment__c sa = new dealer__Sales_Appointment__c();
        //sa.dealer__Vehicle__c = VI.Id;
        sa.dealer__Customer__c = conRec.Id;
        sa.dealer__Assigned_To__c = [Select Id from User where isActive = true limit 1].Id;
        sa.dealer__Sales_Up__c = up.Id;
        sa.dealer__Confirmed__c = true;
        sa.dealer__Date__c = system.today();
        sa.dealer__Time__c = '12:00';
        sa.dealer__DateTime__c = system.now();
        insert sa;
        test.startTest();

        SalesDeskLog sdl = new SalesDeskLog();

        sdl.updateUserSettings();
        
        SalesDeskLog.setAppointmentStatus(sa.Id+':Show'); 
        SalesDeskLog.setAppointmentStatus(sa.Id+':No-Show'); 
        
        test.stopTest();   

    }

    static testmethod void testDLv2() {

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

        test.startTest();
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
        VI.dealer__Model__c = 'SA2014';
        VI.dealer__Stock_Number__c = 'SA2014';
        VI.dealer__VIN__c = 'SA2014';
        VI.dealer__Company_Number__c = 'Location 1';
        VI.dealer__Year__c = '2014';
        VI.dealer__Make__c = 'SA2014';
        VI.In_Stock__c = true;
        insert VI;
        dealer__Sales_Up__c up = new dealer__Sales_Up__c();
        up.dealer__Buyer_Contact__c = conRec.Id;
        up.dealer__Desired_Stock_Num__c = VI.Id;
        up.Name = 'Test SalesUP';
        up.dealer__Make__c = 'Telsa';
        up.dealer__FirstName__c = 'TestFirstName';
        up.dealer__LastName__c = 'LastName';
        up.dealer__Salesperson_1__c = userinfo.getUserId();
        insert up;
        if(dealer__CRMSettings__c.getValues(UserInfo.getUserId()) == null){
            dealer__CRMSettings__c crm = new dealer__CRMSettings__c();
            crm.dealer__Desk_Log_Deal_Types__c = 'A,U';
            insert crm;  
        }
        SalesDeskLogV2 sdlv2 = new SalesDeskLogV2();
        sdlv2.getTrafficTypes();
        sdlv2.getTrafficType();
        
        sdlv2.getCompanies();
        sdlv2.getManager();
        
        //sdlv2.setCompanyNumber();  
        sdlv2.getS1List();
        sdlv2.getS2List();
        
        sdlv2.getUpBoard();

        // ----------------------
        Integer s1 = sdlv2.soldCount;
        Integer s2 = sdlv2.feGross;
        Integer s3 = sdlv2.beGross;
        Integer s4 = sdlv2.totalGross;
        Integer s5 = sdlv2.soldMTD;
        Integer s6 = sdlv2.feMTD;
        Integer s7 = sdlv2.beMTD;
        Integer s8 = sdlv2.tgMTD;

        Integer w1 = sdlv2.walkinCount;
        Integer w2 = sdlv2.phoneCount;
        Integer w3 = sdlv2.emailCount;
        Integer w4 = sdlv2.faxCount;
        Integer w5 = sdlv2.listCount;
        Integer w6 = sdlv2.referralCount;
        Integer w7 = sdlv2.otherCount;        

        Boolean c1 = sdlv2.walkInUps;
        Boolean c2 = sdlv2.phoneUps;
        Boolean c3 = sdlv2.emailUps;
        Boolean c4 = sdlv2.faxUps;
        Boolean c5 = sdlv2.otherUps;
        Boolean c6 = sdlv2.listUps;
        Boolean c7 = sdlv2.referralUps;
        Boolean c8 = sdlv2.setToTrue;
        Boolean c9 = sdlv2.setToFalse;

        String d1 = sdlv2.selectedDivision;
        String d2 = sdlv2.userFilterSOQL;
        String d3 = sdlv2.userDealFilterSOQL;
        String d4 = sdlv2.trafficFilterSOQL;
        String d5 = sdlv2.filterUserID;
        String d6 = sdlv2.filterUserType;
        String d7 = sdlv2.filterInStore;

        List<User> lu = sdlv2.loggedInSalesAssociates;
        List<selectOption> ls = sdlv2.getCategories();

        sdlv2.deskLogJSON();
        sdlv2.getDeskLogJSON();
        sdlv2.getUserSettingsJSON();
        sdlv2.setTrafficType('walk-in');

        sdlv2.dropActiveSalesperson();
        sdlv2.getFinance();

        sdlv2.generateDeskLog();

        sdlv2.userFilter();

        /*sdlv2.getdeskEntries();
        
        sdlv2.trafficFilter();
        sdlv2.loadUserLists();
        String desklogjson = sdlv2.getDeskLogJSON();
        
        sdlv2.itemKeys();
        
        sdlv2.rotationLogGenerate();
        
        //Remote Access
        //dealer__Sales_Up__c up = [Select Id from dealer__Sales_Up__c where dealer__Buyer_Contact__c != null limit 1];
        
        SalesDeskLogV2.updateInStore(up.Id);
        SalesDeskLogV2.updateSalesStep(up.Id+':dealer__Write_Up__c');
        SalesDeskLogV2.updateSalesStep(up.Id+':dealer__Demo__c');
        SalesDeskLogV2.updateSalesStep(up.Id+':dealer__Greet_Meet__c');
        SalesDeskLogV2.updateSalesStep(up.Id+':dealer__Present_Vehicle__c');
        */
        test.stopTest();

        }
    }
    
    static testmethod void testRemoteActionDL2() {

        //Account accRec = new Account();
        //accRec.Name = 'Test Account';
        //accRec.Type = 'Customer - Direct';
        //insert accRec;
        //Contact conRec = new Contact();
        //conRec.AccountId = accRec.Id;
        //conRec.LastName = 'TestContact';
        //conRec.FirstName = 'testFirstName';
        //conRec.Email = 'nicki.allen@me.com';
        //conRec.HomePhone = '8099306664';
        //conRec.MobilePhone = '8099306664';
        //insert conRec;
        //dealer__Vehicle_Inventory__c VI = new dealer__Vehicle_Inventory__c();
        //VI.Name = 'Test Vehicle Inventory';
        //VI.dealer__Model__c = '2014';
        //VI.dealer__Stock_Number__c = '2014';
        //VI.dealer__VIN__c = '100';
        //VI.dealer__Company_Number__c = 'Location 1';
        //VI.dealer__Year__c = '2014';
        //VI.dealer__Make__c = '2014';
        //insert VI;
        //dealer__Sales_Up__c SU = new dealer__Sales_Up__c();
        //SU.Name = 'Test SalesUP';
        //SU.dealer__Buyer_Contact__c = conRec.Id;
        //SU.dealer__Co_Buyer_Contact__c = conRec.Id;
        //SU.dealer__Desired_Stock_Num__c = VI.Id;
        //SU.dealer__Make__c = 'Telsa';
        //SU.dealer__FirstName__c = 'TestFirstName';
        //SU.dealer__LastName__c = 'LastName';
        //insert SU;
        //User u = [select Id from User where IsActive = true limit 1];
        
        //test.startTest();

        //SalesDeskLogV2.setTeamMemberSalesUp(SU.Id+':'+u.Id+':S1');
        //SalesDeskLogV2.setTeamMemberSalesUp(SU.Id+':'+u.Id+':S2');
        //SalesDeskLogV2.setTeamMemberSalesUp(SU.Id+':'+u.Id+':DM');
        //SalesDeskLogV2.setTeamMemberSalesUp(SU.Id+':'+u.Id+':FM');

        
        //SalesDeskLogV2.updateSalesStep(SU.Id+':dealer__Greet_Meet__c');
        //SalesDeskLogV2.updateSalesStep(SU.Id+':dealer__Demo__c');
        //SalesDeskLogV2.updateSalesStep(SU.Id+':dealer__Write_Up__c');
        //SalesDeskLogV2.updateSalesStep(SU.Id+':dealer__Present_Vehicle__c');

        //test.stopTest();
    }
    
    static testmethod void testRemoteActionDealsDL2() {

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

        test.startTest();
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
        insert VI;
        dealer__Deal__c Deal = new dealer__Deal__c();
        Deal.dealer__Broker__c = accRec.Id;
        Deal.dealer__Buyer_Contact__c = conRec.Id;
        Deal.dealer__Buyer__c = accRec.Id;
        Deal.dealer__Co_Buyer_Contact__c = conRec.Id;
        Deal.dealer__Co_Buyer__c = accRec.Id;
        Deal.dealer__Deal_ID__c = '12345';
        Deal.dealer__Licence__c = '100';
        Deal.dealer__Vehicle__c = VI.Id;
        Deal.Name = '12342';
        insert Deal;
        User u = [select Id from User where username='testuser128@testorgx.com'];
        SalesDeskLogV2.setTeamMemberDeal(Deal.Id+':'+u.Id+':S1');
        SalesDeskLogV2.setTeamMemberDeal(Deal.Id+':'+u.Id+':S2');
        SalesDeskLogV2.setTeamMemberDeal(Deal.Id+':'+u.Id+':S3');
        SalesDeskLogV2.setTeamMemberDeal(Deal.Id+':'+u.Id+':S4');

        test.stopTest();

        
    }
    
    static testmethod void testRemoteSalesApptStatus() {

        //Insert dms settings needed for linked sales appointments
        TestClassUtil util = new TestClassUtil();
        dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        if(dms == null){
            util.insertDMSSettings();   
        }
        dms = [SELECT Id, dealer__SalesAppointmentLinkedEvent__c FROM dealer__DMS_Settings__c WHERE Name = 'ActiveSettings' LIMIT 1];
        dms.dealer__SalesAppointmentLinkedEvent__c = true;
        update dms;

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
        dealer__Sales_Appointment__c sa = new dealer__Sales_Appointment__c();
        sa.dealer__Vehicle__c = VI.Id;
        sa.dealer__Customer__c = conRec.Id;
        sa.dealer__Assigned_To__c = [Select Id from User where isActive = true limit 1].Id;
        sa.dealer__Sales_Up__c = SU.Id;
        sa.dealer__Confirmed__c = true;
        sa.dealer__Date__c = system.today();
        sa.dealer__Time__c = '12:00';
        sa.dealer__DateTime__c = system.now();
        insert sa;
        test.startTest();
        
        SalesDeskLogV2.setAppointmentStatus(sa.Id+':Show'); 
        SalesDeskLogV2.setAppointmentStatus(sa.Id+':No-Show');  
        test.stopTest();

        }
    }
    /*
    static testmethod void testupdateUserSettingsRemote() {
        User u = [Select Id from User where FirstName = 'Jarrett' limit 1];
        dealer__SalesDeskLogSettings__c config = dealer__SalesDeskLogSettings__c.getValues(u.Id);
        SalesDeskLogV2.updateUserSettingsRemote(JSON.serialize(config));
    }
    */  
}