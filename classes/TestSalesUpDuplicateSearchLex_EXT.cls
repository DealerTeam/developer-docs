@isTest
private class TestSalesUpDuplicateSearchLex_EXT {
    
     
    @testSetup static void testinsertdata() {
        TestClassUtil tu = new TestClassUtil();
        tu.insertCRMSettings();
        tu.insertDMSSettings();

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
                            isActive=true,UserPreferencesLightningExperiencePreferred=true,
                            Division='ZE7',
                            EmployeeNumber = 'SP1');
        insert usr1;

        
        
        if(dealer__VINDecoderCS__c.getValues('ActiveSettings') == null){
            dealer__VINDecoderCS__c VINDecod = new dealer__VINDecoderCS__c();
            VINDecod.Name = 'ActiveSettings';
            VINDecod.dealer__DecoderAPI_URL__c = 'https://api.dataonesoftware.com/webservices/vindecoder/decode';
            VINDecod.dealer__DecoderClientID__c = '6310';
            VINDecod.dealer__DecoderKey__c = '8d8d8d8d8d8d8dd8d8';
            VINDecod.dealer__DecoderName__c = 'Data One Software';
            insert VINDecod;
        }  

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
                FirstName     =   'Lisa',
                LastName      =   'Roserson',
                PersonEmail   =   'lisa@lisa.com',
                PersonMobilePhone  = '2129831223'
                );

        List<Account> accts = new List<Account>{a, a2, a3};
        insert accts; 

        Contact c = [SELECT Id, FirstName, LastName, Email, Phone FROM Contact WHERE AccountID=:a.Id];
        Contact c2 = [SELECT Id, FirstName, LastName, Email, Phone FROM Contact WHERE AccountID=:a2.Id];

        dealer__Sales_Up__c sup = new dealer__Sales_Up__c(
                dealer__Customer_Account__c = a.Id,
                dealer__Buyer_Contact__c = c.Id,
                dealer__FirstName__c='Jack', 
                dealer__LastName__c='Eichenberg',
                dealer__Lead_Status__c='Open',
                dealer__Mobile__c='9172255960',
                dealer__Email__c='jack@test.com',
                OwnerID = usr1.Id
                );  

        dealer__Sales_Up__c sup2 = new dealer__Sales_Up__c(
                dealer__Customer_Account__c = a2.Id,
                dealer__Buyer_Contact__c = c2.Id,
                dealer__FirstName__c='Rosa', 
                dealer__LastName__c='Chilowsky',
                dealer__Lead_Status__c='Sold',
                dealer__Mobile__c='9177448343',
                dealer__Email__c='rosabanana@test.com',
                OwnerID = usr1.Id
                );

        dealer__Sales_Up__c sup3 = new dealer__Sales_Up__c(
                dealer__Customer_Account__c = a2.Id,
                dealer__Buyer_Contact__c = c2.Id,
                dealer__FirstName__c='Rosa', 
                dealer__LastName__c='Chilowsky',
                dealer__Lead_Status__c='Open',
                dealer__Mobile__c='9177448343',
                dealer__Email__c='rosabanana@test.com',
                OwnerID = usr1.Id
                );    

        List<dealer__Sales_Up__c> sups = new List<dealer__Sales_Up__c>{sup, sup2, sup3};
        insert sups;
    }

    //MKS 8/29/16
    //ensure that when a Sales Up is created from a Contact or an Account, the Search Page is not displayed
    static testmethod void testCreateFromAccountorContact(){

        //Set De-dupe to Non-Native
        TestClassUtil tu = new TestClassUtil();
        tu.insertCRMSettings();
        dealer__CRMSettings__c crm = dealer__CRMSettings__c.getOrgDefaults();
        crm.dealer__Native_or_Non_Native_Dupe_Catching__c = 'Non-Native';

        update crm;

        PageReference returnRef;

        //Get an existing Account and create a new Sales Up from it
        Account aX = [SELECT Id FROM Account WHERE PersonMobilePhone  = '2129831223' LIMIT 1];
        dealer__Sales_Up__c newSup = new dealer__Sales_Up__c(
                dealer__FirstName__c='Lisa', 
                dealer__LastName__c='Roserson',
                dealer__Lead_Status__c='Open',
                dealer__Mobile__c='2129831223',
                dealer__Email__c='lisa@lisa.com',
                dealer__Customer_Account__c = aX.Id
                );    

        //Set the SOSL results
        Id [] fixedSearchResults = new Id[]{aX.Id};
        Test.setFixedSearchResults(fixedSearchResults);

        User u = [SELECT Id FROM User WHERE username='testuser128@testorgx.com' LIMIT 1];

        //Set the current page and insert the lkid as a parameter
        PageReference pageRef = Page.SalesUpNew;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('_lkid', aX.Id);
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newSup);
        
        //Instantiate the controller extension and call the CreateSU() method
        Test.startTest();
        System.runAs(u){
            SalesUpDuplicateSearchLex_EXT ext = new SalesUpDuplicateSearchLex_EXT(sc);
            returnRef = ext.CreateSU();
            ext.getLexPreference();
        }
        Test.stopTest();


        for(ApexPages.Message msg :  ApexPages.getMessages()) {
            System.debug(msg.getSummary());
        }

        //Make sure that the page reference returned is the detail page of the new Sales Up
        System.assertNotEquals(null, returnRef, 'The Page Reference returned by CreateSU() is null.');
        System.debug('The page URL returned is: '+returnRef.getUrl());
        System.assertNotEquals('/apex/dealer__SalesUpDuplicateSearchLex',returnRef.getUrl(),returnRef.getUrl());

        dealer__Sales_Up__c supX = [SELECT dealer__Customer_Account__c, dealer__Buyer_Contact__c FROM dealer__Sales_Up__c WHERE Id=:newSup.Id LIMIT 1];
        System.assertNotEquals(null, supX.dealer__Customer_Account__c, 'Account is null on inserted Sales Up');
        System.assertNotEquals(null, supX.dealer__Buyer_Contact__c, 'Contact is null on inserted Sales Up');
    }
    
    //MKS 8/29/16
    //Test that SalesUpNewLex.page properly displays validation errors
    static testmethod void testSalesUpNewLexValidation(){
        dealer__Sales_Up__c newSup = new dealer__Sales_Up__c(
                dealer__FirstName__c='Jack', 
                dealer__LastName__c='Eichenberg',
                dealer__Lead_Status__c='Open',
                dealer__Mobile__c='9172255960',
                dealer__Email__c='jack@test.com',
                dealer__VIN__c = '1234567890'
                );  
        User u = [SELECT Id FROM User WHERE username='testuser128@testorgx.com' LIMIT 1];
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newSup);
        PageReference pageRef = Page.SalesUpNewLex;
        Test.setCurrentPage(pageRef);

        Test.startTest();
        System.runAs(u){
            SalesUpDuplicateSearchLex_EXT ext = new SalesUpDuplicateSearchLex_EXT(sc);
            PageReference returnRef = ext.CreateSU();
            System.assertEquals(null, returnRef, 'CreateSU did not return null when a Sales Up with VIN<17 inserted.');

            System.assertNotEquals(0,ApexPages.getMessages().size(), 'The page should have messages, and it does not.');

            ext.createSalesUp();
            ext.performSearch();

        }
        Test.stopTest();
    }

    //MKS 8/26/16
    //ensure that the CRM field Duplicate_Check_Statuses__c correctly filters results from Dupe Search
    //important: Rosa Chilowsky, Status Sold AND Rosa Chilowsky, Status Open needs to be in test setup
    static testmethod void testCRMStatuses(){
        //select user that is owner of records for "run as"
        User u = [SELECT Id FROM User WHERE username='testuser128@testorgx.com' LIMIT 1];

        //make sure CRM has statuses for dupe checking
        dealer__CRMSettings__c crm = dealer__CRMSettings__c.getOrgDefaults();
        if(crm.Duplicate_Check_Statuses__c != 'Open, Duplicate'){
            crm.Duplicate_Check_Statuses__c = 'Open, Duplicate';
            update crm;
        }
        
        List<dealer__Sales_Up__c> soslSups = [SELECT Id, dealer__Customer_Account__c, dealer__Buyer_Contact__c 
        FROM dealer__Sales_Up__c WHERE dealer__FirstName__c = 'Rosa'];



        //get the open sales up that matches 
        //all of the fields are included in the query because they are referenced in the controller extension
        List<dealer__Sales_Up__c> openSupList = [SELECT Id, dealer__FirstName__c, dealer__LastName__c, dealer__Email__c, 
        dealer__Phone__c, dealer__Mobile__c, dealer__Salesperson_1__c, dealer__Store_Location__c, dealer__Buyer_Contact__c 
        FROM dealer__Sales_Up__c 
            WHERE dealer__Lead_Status__c = 'Open'
            AND dealer__FirstName__c='Rosa'
            AND dealer__LastName__c = 'Chilowsky'];


        //SOSL returns nothing unles you include this
        Id [] fixedSearchResults = new Id[]{};
        for(dealer__Sales_Up__c s : soslSups){ 
            fixedSearchResults.add(s.Id);
            fixedSearchResults.add(s.dealer__Customer_Account__c);
            fixedSearchResults.add(s.dealer__Buyer_Contact__c);
        }

        //set up the page, controller, SalesUpDuplicateSearchLex_EXT instance
        PageReference pgRef = Page.SalesUpDuplicateSearchLex;
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(openSupList[0]);

        Test.setFixedSearchResults(fixedSearchResults);
        Test.startTest();
        Test.setCurrentPage(pgRef);
        System.runAs(u){

            

            SalesUpDuplicateSearchLex_EXT ext = new SalesUpDuplicateSearchLex_EXT(sc);

            
            //examine public list searchUpsResults
            List<dealer__Sales_Up__c> searchUps = ext.searchUpsResults;
            System.debug('The list of sups found:'+searchUps);
            System.assertNotEquals(0, searchUps.size(), 'No Sales Ups were found in search');

            //Make sure that only Open or Duplicate sups are included
            for(dealer__Sales_Up__c s : searchUps){
                System.debug('Sales Up '+s.Id+' has status '+s.dealer__Lead_Status__c);
                System.assert(s.dealer__Lead_Status__c == 'Open' || s.dealer__Lead_Status__c == 'Duplicate', 
                    'Sales Up '+s.Id+' has status '+s.dealer__Lead_Status__c+' and should have been excluded from search results');
            }
        }

        Test.stopTest();
    }

    //MKS 8/26/16
    //ensure that the CRM field Duplicate_Check_Statuses__c doesn't fail when crm status is blank
    //important: Rosa Chilowsky, Status Sold AND Rosa Chilowsky, Status Open needs to be in test setup
    static testmethod void testBlankCRMStatuses(){
        //select user that is owner of records for "run as"
        User u = [SELECT Id FROM User WHERE username='testuser128@testorgx.com' LIMIT 1];

        //make sure CRM has statuses for dupe checking
        dealer__CRMSettings__c crm = dealer__CRMSettings__c.getOrgDefaults();
        if(crm.Duplicate_Check_Statuses__c != null || crm.Duplicate_Check_Statuses__c != ''){
            crm.Duplicate_Check_Statuses__c = '';
            update crm;
        }
        
        List<dealer__Sales_Up__c> soslSups = [SELECT Id, dealer__Customer_Account__c, dealer__Buyer_Contact__c 
        FROM dealer__Sales_Up__c WHERE dealer__FirstName__c = 'Rosa'];



        //get the open sales up that matches 
        //all of the fields are included in the query because they are referenced in the controller extension
        List<dealer__Sales_Up__c> openSupList = [SELECT Id, dealer__FirstName__c, dealer__LastName__c, dealer__Email__c, 
        dealer__Phone__c, dealer__Mobile__c, dealer__Salesperson_1__c, dealer__Store_Location__c, dealer__Buyer_Contact__c 
        FROM dealer__Sales_Up__c 
            WHERE dealer__Lead_Status__c = 'Open'
            AND dealer__FirstName__c='Rosa'
            AND dealer__LastName__c = 'Chilowsky'];


        //SOSL returns nothing unles you include this
        Id [] fixedSearchResults = new Id[]{};
        for(dealer__Sales_Up__c s : soslSups){ 
            fixedSearchResults.add(s.Id);
            fixedSearchResults.add(s.dealer__Customer_Account__c);
            fixedSearchResults.add(s.dealer__Buyer_Contact__c);
        }

        //set up the page, controller, SalesUpDuplicateSearchLex_EXT instance
        PageReference pgRef = Page.SalesUpDuplicateSearchLex;
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(openSupList[0]);

        Test.setFixedSearchResults(fixedSearchResults);
        Test.startTest();
        Test.setCurrentPage(pgRef);
        System.runAs(u){
            SalesUpDuplicateSearchLex_EXT ext = new SalesUpDuplicateSearchLex_EXT(sc);
            
            //examine public list searchUpsResults
            List<dealer__Sales_Up__c> searchUps = ext.searchUpsResults;
            System.debug('The list of sups found:'+searchUps);
            System.assertEquals(soslSups.size(), searchUps.size(), 'Some Sales Ups were eliminated even though the CRM statuses is blank');
        }

        Test.stopTest();

    }

    static testmethod void testSelectExistingAccount(){
        dealer__Sales_Up__c newSup = new dealer__Sales_Up__c(
                dealer__FirstName__c='Lisa', 
                dealer__LastName__c='Roserson',
                dealer__Lead_Status__c='Open',
                dealer__Mobile__c='2129831223',
                dealer__Email__c='lisa@lisa.com'
                );    
        
        Account aX = [SELECT Id FROM Account WHERE PersonMobilePhone  = '2129831223' LIMIT 1];

        User u = [SELECT Id FROM User WHERE username='testuser128@testorgx.com' LIMIT 1];
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(newSup);

        
        Test.startTest();
        System.runAs(u){
            PageReference pgRef = Page.SalesUpDuplicateSearchLex;
            Test.setCurrentPage(pgRef);
            SalesUpDuplicateSearchLex_EXT ext = new SalesUpDuplicateSearchLex_EXT(sc);
            
            ext.selectedAccountId = aX.Id;
            ext.attachLead();

        }
        Test.stopTest();

        dealer__Sales_Up__c supX = [Select Id, dealer__Customer_Account__c, dealer__Buyer_Contact__c from dealer__Sales_Up__c where dealer__LastName__c='Roserson' limit 1];
        System.debug('The Sales Up after Account & Contact attached: '+supX);
        System.assertNotEquals(null, supX.dealer__Buyer_Contact__c, 'Contact not attached to Sales Up');
    }


    static testmethod void testSalesUp() {
        
      Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
      User u = new User(Alias = 'stxxx', Email='standarduser@dealerTeam.com', 
      EmailEncodingKey='UTF-8', LastName='DealerTesting', LanguageLocaleKey='en_US', 
      LocaleSidKey='en_US', ProfileId = p.Id, 
      TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@dealerTeam.com');
      TestClassUtil tu = new TestClassUtil();
      tu.insertCRMSettings();
      dealer__CRMSettings__c crm = dealer__CRMSettings__c.getOrgDefaults();


      System.runAs(u) {
        
      
       //inserting record into traffic log
        dealer__Traffic_Log__c tLog = new dealer__Traffic_Log__c();
        tlog.Name = 'T Log Name';
        tlog.dealer__First_Name__c = 'F Name';
        tlog.dealer__First_Name__c = 'L Name'; 
        tlog.dealer__Type__c = 'TL Pick';
        tlog.dealer__Salesperson_1__c = u.Id;
        insert tlog;
      
        dealer__Sales_Up__c sup = new dealer__Sales_Up__c(
                                                            dealer__FirstName__c='John', 
                                                            dealer__LastName__c='Test',
                                                            dealer__Lead_Status__c='Open',
                                                            dealer__Traffic_Log_Entry__c = tlog.Id,
                                                            dealer__Mobile__c = '(123) 456-7890'
                                                        );
        

        dealer__Sales_Up__c sup2 = new dealer__Sales_Up__c(
                                                    dealer__FirstName__c='John', 
                                                    dealer__LastName__c='Test',
                                                    dealer__Lead_Status__c='Open',
                                                    dealer__Mobile__c='5302110981',
                                                    dealer__Phone__c='5302321214',
                                                    dealer__Email__c='john@test.com'
                                                );
        List<dealer__Sales_Up__c> sups = new List<dealer__Sales_Up__c>();
        sups.add(sup);
        sups.add(sup2);

        insert sups;
        
        Account a2 = [SELECT Id FROM Account WHERE PersonMobilePhone  = '2129831223' LIMIT 1];
        Contact c2 = [SELECT Id, FirstName, LastName, Email, Phone FROM Contact WHERE AccountID=:a2.Id];
        dealer__Sales_Up__c supBlank = new dealer__Sales_Up__c(dealer__FirstName__c='John', dealer__LastName__c='Frankston', dealer__Trade_VIN__c='1N4AL21E49N510178');
        
        PageReference pgRef = Page.SalesUpNew;
        Test.setCurrentPage(pgRef);
        ApexPages.currentPage().getParameters().put('traffic',tlog.Id);
        ApexPages.currentPage().getParameters().put('_lkid',c2.Id);
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(sup);
        SalesUpDuplicateSearchLex_EXT sl = new SalesUpDuplicateSearchLex_EXT(sc);
        
        Test.startTest();

        sl.getUserId();
        sl.getUserName();

        sl.skipSearch = false;
        sl.Create();
        sl.FindDupes();
        sl.redirectLex();
        sl.customDoDecode();
        sl.FindFromCreatePage();
        sl.FindDupesFromFD();
        sl.NativeFindDupes();
        
        ApexPages.currentPage().getParameters().put('id', sup.Id);
        sl.lookUp(sup.Id);
        
        SalesUpDuplicateSearchLex_EXT.searchUps usup = new SalesUpDuplicateSearchLex_EXT.searchUps(true, true, true, true, true, '', '', '', '', '');
        
        // Test duplicate search class
                                                                
        PageReference pgSearchRef = Page.SalesUpDuplicateSearchLex;
        test.setCurrentPage(pgSearchRef);
        
        ApexPages.Standardcontroller sd = new ApexPages.Standardcontroller(sup2);
        SalesUpDuplicateSearchLex_EXT sdls = new SalesUpDuplicateSearchLex_EXT(sd);
        
        System.assert(sdls.searchContactResults.size()==0);
        System.assert(sdls.searchCustomerSize>=0);
        System.assert(sdls.searchUpsSize>=0);
        
        PageReference pgSearchRef2 = Page.SalesUpDuplicateSearchLex;
        test.setCurrentPage(pgSearchRef2);
        
        ApexPages.Standardcontroller sd2 = new ApexPages.Standardcontroller(supBlank);
        SalesUpDuplicateSearchLex_EXT sdls2 = new SalesUpDuplicateSearchLex_EXT(sd2);
        //SalesUpDuplicateSearchLex_EXT.searchUps(true, true, true, true, true, 'John', 'Test', '', '', '');
        Contact c = new Contact(FirstName='John', LastName='Test');
        insert c;
        
        sdls2.getUserName();
        sdls2.getUserId();
        //sdls2.searchExistingContacts(usup);
        sdls2.isBlank('');
        sdls2.Create();
        sdls2.FindDupes();
        sdls2.noMatch();
        sdls2.selectedCustomerId=c.Id;
        sdls2.attachLead();
        sdls2.doDecode();
        sdls2.decodeTradePage();
        sdls2.editTradeVINPage();
        sdls2.getModelKeyList();
        sdls2.getDecode();
        String sid = sdls2.getSelectedStyleId();
        sdls2.setSelectedStyleId(sid);
        sdls2.mergeRecords();
        SalesUpDuplicateSearchLex_EXT.searchUps iClass= new SalesUpDuplicateSearchLex_EXT.searchUps(true,true,true,true,true,'John','Doe','email@email.com','9999999999','8888888888');

        //Test coverage stuff
        sdls.hasDuplicateResult = false;
        System.assertEquals(false, sdls.hasDuplicateResult);
        
        List<sObject> dupes = sdls.getDuplicateRecords();
        
        List<Account> accts = new List<Account>();
        sdls.searchAccountResults = accts;
        System.assertEquals(accts, sdls.searchAccountResults);

        System.assertEquals(Utility.personsAccountsEnabled(), sdls.isPersonsAccountsEnabled);

        Test.stopTest();
      }
    }
    
    static testmethod void testReAssignSalesUps() {
        
        PageReference p = Page.ReAssignSalesUps;
        test.setCurrentPage(p);
        
        List<dealer__Sales_Up__c> sup = [select Id from dealer__Sales_Up__c limit 5];
        List<User> ul   =   [select Id, Name from User where IsActive = true limit 3];
        System.debug('SUPSIZE>>>'+sup.size());
        
        ApexPages.Standardsetcontroller ssc = new ApexPages.Standardsetcontroller(sup);
        ssc.setSelected(sup);
        RoundRobinSalesUps rsup = new RoundRobinSalesUps(ssc);
        
        rsup.updateContactRecord=true;
        rsup.notifyRecipient=true;
        
        for(User u : ul) {
            rsup.selectedUsers.add(new SelectOption(u.Id, u.Name));
        }
        
        rsup.receivingUsers = [Select Id from User where IsActive=true and  UserType = 'Standard' limit 5];
        rsup.ReAssign();
        //rsup.reAssignBlock();
        rsup.buildHTMLTableOfResults();
        rsup.emailMeResults();
        
    }

    static testmethod void testSalesLead() {
        
        User u = [Select Id from User where IsActive = true limit 1];
        
        Apexpages.currentPage().getParameters().put('Id', u.Id);
        
        SalesWorkPlanPDF ctl = new SalesWorkPlanPDF();
        ctl.SalesLeads();
        
        ctl.getUserName();
        ctl.getBeBacks();
        ctl.getDemos();
        ctl.getEmails();
        ctl.getPhonepops();
        ctl.getWalkins();
        ctl.getWriteups();
        ctl.getTurns();
        ctl.getUps();
        ctl.getTotalSales();
        
        ctl.TaskIDs();
        ctl.getLeads();
        ctl.getSales();
        ctl.getCustomers();
        ctl.getServiceAppointments();
    }

    static testmethod void testSalesLeadPersonsAccount() {
       
       dealer__Sales_Up__c sup = new dealer__Sales_Up__c(
                                                            dealer__FirstName__c='John', 
                                                            dealer__LastName__c='Test',
                                                            dealer__Lead_Status__c='Open'
                                                        );

        PageReference pgRef = Page.SalesUpNew;
        Test.setCurrentPage(pgRef);

        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(sup);
        SalesUpDuplicateSearchLex_EXT sl = new SalesUpDuplicateSearchLex_EXT(sc);


        Integer i = sl.searchUpCount;
        Integer is= sl.searchContactCount;
        dealer__Sales_Up__c gup = sl.getup();
        List<dealer__Sales_Up__c> lgup = sl.getUpList();

    }

    static testmethod void testWorkPlanList() {
        WorkPlanList controller = new WorkPlanList();
    } 
    
    static testmethod void testSalesUpTwo() {
        
      Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
      User u = new User(Alias = 'stxxx', Email='standarduser@dealerTeam.com', 
      EmailEncodingKey='UTF-8', LastName='DealerTesting', LanguageLocaleKey='en_US', 
      LocaleSidKey='en_US', ProfileId = p.Id, 
      TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@dealerTeam.com');


      System.runAs(u) {
        
        TestClassUtil tu = new TestClassUtil();
        dealer__Sales_Up__c sup = new dealer__Sales_Up__c(
                                                            dealer__FirstName__c='John', 
                                                            dealer__LastName__c='Test',
                                                            dealer__Lead_Status__c='Open', 
                                                            dealer__Trade_VIN__c='1N4AL21E49N510178',
                                                            dealer__Service_Vehicle__c = tu.insertServiceVehicle()
                                                        );
        

        dealer__Sales_Up__c sup2 = new dealer__Sales_Up__c(
                                                    dealer__FirstName__c='John', 
                                                    dealer__LastName__c='Test',
                                                    dealer__Lead_Status__c='Open',
                                                    dealer__Mobile__c='5302110981',
                                                    dealer__Phone__c='5302321214',
                                                    dealer__Email__c='john@test.com'
                                                );
        

        List<dealer__Sales_Up__c> sups = new List<dealer__Sales_Up__c>();
        sups.add(sup);
        sups.add(sup2);

        insert sups;
        
        dealer__Sales_Up__c supBlank = new dealer__Sales_Up__c(dealer__FirstName__c='John', dealer__LastName__c='Frankston', dealer__Trade_VIN__c='1N4AL21E49N510178');
        
        PageReference pgRef = Page.SalesUpNew;
        Test.setCurrentPage(pgRef);
        
        //inserting record into traffic log
        dealer__Traffic_Log__c tLog = new dealer__Traffic_Log__c();
        tlog.Name = 'T Log Name';
        tlog.dealer__First_Name__c = 'F Name';
        tlog.dealer__First_Name__c = 'L Name'; 
        tlog.dealer__Type__c = 'TL Pick';
        tlog.dealer__Salesperson_1__c = u.Id;

        insert tlog;
        
        Contact c = new Contact();
        //c.Name = 'Contact Name';
        c.FirstName = 'F Name';
        c.LastName = 'L Name';
        c.phone = '12345';
        c.mobilePhone = '9889';
        c.homePhone = '123456';
        c.email = 'test@gmail.com';
        insert c ;
        
        ApexPages.currentPage().getParameters().put('customer', c.Id);        
        ApexPages.currentPage().getParameters().put('traffic',tlog.Id);
        
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(sup);
        SalesUpDuplicateSearchLex_EXT sl = new SalesUpDuplicateSearchLex_EXT(sc);
        
        Test.startTest();

        //sl.comparision();
        //sl.updateTradeFields();
        sl.saveDuplicateOverride();
        sl.customSave();
        sl.getRecordTypeName();
        sl.getInventoryVehicle();
        sl.createInventory();
        sl.getKeyPrefix();
        sl.saveDuplicateOverride();
        Test.stopTest();
      }
    }   

    static testmethod void testDupeCatching(){
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        User u = new User(Alias = 'stxxx', Email='standarduser@dealerTeam.com', 
        EmailEncodingKey='UTF-8', LastName='DealerTesting', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@dealerTeam.com');
        TestClassUtil tu = new TestClassUtil();
        tu.insertCRMSettings();
        dealer__CRMSettings__c crm = dealer__CRMSettings__c.getOrgDefaults();


      System.runAs(u) {
        dealer__Sales_Up__c s1 = new dealer__Sales_Up__c(
                                                            dealer__FirstName__c='JohnFirstName', 
                                                            dealer__LastName__c='Test',
                                                            dealer__Lead_Status__c='Open'
                                                        );
        

        dealer__Sales_Up__c s2 = new dealer__Sales_Up__c(
                                                    dealer__FirstName__c='John', 
                                                    dealer__LastName__c='Test',
                                                    dealer__Lead_Status__c='Open',
                                                    dealer__Mobile__c='5302110981',
                                                    dealer__Phone__c='5302321214',
                                                    dealer__Email__c='john@test.com'
                                                );
        dealer__Sales_Up__c s3 = new dealer__Sales_Up__c(
                                                            dealer__FirstName__c='John', 
                                                            dealer__LastName__c='Test',
                                                            dealer__Lead_Status__c='Open'
                                                        );
        

        dealer__Sales_Up__c s4 = new dealer__Sales_Up__c(
                                                    dealer__FirstName__c='John', 
                                                    dealer__LastName__c='Test',
                                                    dealer__Lead_Status__c='Open',
                                                    dealer__Mobile__c='5302110981',
                                                    dealer__Phone__c='5302321214',
                                                    dealer__Email__c='john@test.com'
                                                );
        List<dealer__Sales_Up__c> sups = new List<dealer__Sales_Up__c>();
        sups.add(s1);
        sups.add(s2);
        sups.add(s3);
        sups.add(s4);

        insert sups;
        

        TestClassUtil tutil = new TestClassUtil();
        tu.insertCRMSettings();
        dealer__CRMSettings__c crm2 = dealer__CRMSettings__c.getOrgDefaults();
        crm2.dealer__Native_or_Non_Native_Dupe_Catching__c = 'Native';

        update crm2;


        PageReference pgRef2 = Page.SalesUpDuplicateSearchLex;
        Test.setCurrentPage(pgRef2);
        
        ApexPages.Standardcontroller sc2 = new ApexPages.Standardcontroller(s1);
        SalesUpDuplicateSearchLex_EXT sl2 = new SalesUpDuplicateSearchLex_EXT(sc2);

        System.debug('url: '+ApexPages.currentPage().getUrl());
        System.debug('first name: '+((dealer__Sales_Up__c)sc2.getRecord()).dealer__FirstName__c);

        sl2.FindDupes();

        crm2.dealer__Native_or_Non_Native_Dupe_Catching__c = 'Non';

        update crm2;

        sl2.FindDupes();

        sl2.NonNativeFindDupes();

        Account testacct = new Account(
                                FirstName = 'TestFN',
                                LastName = 'TestLN',
                                PersonEmail = 'test@email.com',
                                PersonMailingStreet = 'test st',
                                PersonMailingCity = 'test city',
                                PersonMailingPostalCode = '10075'
            );

        //sl2.searchExistingAccounts(testacct);


        sl2.cancel();

      }

    }

    static testmethod void testnonnativeCreateSU(){
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'stxxx', Email='standarduser@dealerTeam.com', 
        EmailEncodingKey='UTF-8', LastName='DealerTesting', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@dealerTeam.com');
        TestClassUtil tu = new TestClassUtil();
        tu.insertCRMSettings();
        dealer__CRMSettings__c crm = dealer__CRMSettings__c.getOrgDefaults();
        crm.dealer__Native_or_Non_Native_Dupe_Catching__c = 'Non-Native';
        update crm;


        System.runAs(u) {
            dealer__Sales_Up__c s1 = new dealer__Sales_Up__c(
                                    dealer__FirstName__c='John', 
                                    dealer__LastName__c='Test',
                                    dealer__Lead_Status__c='Open',
                                    dealer__Phone__c = '5555555555'
                                );

            insert s1;

            dealer__Sales_Up__c s2 = new dealer__Sales_Up__c(
                                    dealer__FirstName__c='John', 
                                    dealer__LastName__c='Test',
                                    dealer__Lead_Status__c='Open',
                                    dealer__Phone__c = '5555555555'
                                );

            PageReference pgRef2 = Page.SalesUpDuplicateSearchLex;
            Test.setCurrentPage(pgRef2);

            ApexPages.Standardcontroller sc2 = new ApexPages.Standardcontroller(s2);
            SalesUpDuplicateSearchLex_EXT sl2 = new SalesUpDuplicateSearchLex_EXT(sc2);

            sl2.CreateSU();
        }
    }

    static testmethod void testnativeCreateSU(){
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'stxxx', Email='standarduser@dealerTeam.com', 
        EmailEncodingKey='UTF-8', LastName='DealerTesting', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@dealerTeam.com');
        TestClassUtil tu = new TestClassUtil();
        tu.insertCRMSettings();
        dealer__CRMSettings__c crm = dealer__CRMSettings__c.getOrgDefaults();
        crm.dealer__Native_or_Non_Native_Dupe_Catching__c = 'Native';
        update crm;


        System.runAs(u) {
            dealer__Sales_Up__c s1 = new dealer__Sales_Up__c(
                                    dealer__FirstName__c='John', 
                                    dealer__LastName__c='Test',
                                    dealer__Lead_Status__c='Open',
                                    dealer__Phone__c = '5555555555'
                                );

            insert s1;

            dealer__Sales_Up__c s2 = new dealer__Sales_Up__c(
                                    dealer__FirstName__c='John', 
                                    dealer__LastName__c='Test',
                                    dealer__Lead_Status__c='Open',
                                    dealer__Phone__c = '5555555555'
                                );

            PageReference pgRef2 = Page.SalesUpDuplicateSearchLex;
            Test.setCurrentPage(pgRef2);

            ApexPages.Standardcontroller sc2 = new ApexPages.Standardcontroller(s2);
            SalesUpDuplicateSearchLex_EXT sl2 = new SalesUpDuplicateSearchLex_EXT(sc2);

            sl2.CreateSU();
        }
    }

    static testmethod void testAddActiveSalesUp(){
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator']; 
        User u = new User(Alias = 'stxxx', Email='standarduser@dealerTeam.com', 
        EmailEncodingKey='UTF-8', LastName='DealerTesting', LanguageLocaleKey='en_US', 
        LocaleSidKey='en_US', ProfileId = p.Id, 
        TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@dealerTeam.com');
        TestClassUtil tu = new TestClassUtil();
        tu.insertCRMSettings();

        System.runAs(u) {
            dealer__Sales_Up__c s1 = new dealer__Sales_Up__c(
                                    dealer__FirstName__c='John', 
                                    dealer__LastName__c='Test',
                                    dealer__Lead_Status__c='Open',
                                    dealer__Phone__c = '5555555555'
                                );
            insert s1;
            
            dealer__Sales_Up__c s2 = new dealer__Sales_Up__c(
                                    dealer__FirstName__c='John', 
                                    dealer__LastName__c='Test',
                                    dealer__Lead_Status__c='Open',
                                    dealer__Phone__c = '5555555555'
                                );

            PageReference pgRef2 = Page.SalesUpDuplicateSearchLex;
            Test.setCurrentPage(pgRef2);

            ApexPages.Standardcontroller sc2 = new ApexPages.Standardcontroller(s2);
            SalesUpDuplicateSearchLex_EXT sl2 = new SalesUpDuplicateSearchLex_EXT(sc2);
        }
    }
}