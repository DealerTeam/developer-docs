@isTest
private class Test_DestLogEXT {

    static testmethod void deskLogExt() {
        
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
        
        List<dealer__Traffic_Log__c> tl = new List<dealer__Traffic_Log__c>();
        
        dealer__Traffic_Log__c tl1 = new dealer__Traffic_Log__c();
        tl1.dealer__Customer_Name__c = accRec.Id;
        tl1.dealer__CCC_Rep__c = [Select Id from User where isActive = true limit 1].Id;
        tl1.dealer__Customer_Contact__c = conRec.Id;
        tl1.dealer__Desk_Manager__c = [Select Id from User where isActive = true limit 1].Id;
        tl1.dealer__Date_In__c = system.today();
        tl1.dealer__Fresh_Call__c = true;
        
        
        dealer__Traffic_Log__c tl2 = new dealer__Traffic_Log__c();
        tl2.dealer__Customer_Name__c = accRec.Id;
        tl2.dealer__CCC_Rep__c = [Select Id from User where isActive = true limit 1].Id;
        tl2.dealer__Customer_Contact__c = conRec.Id;
        tl2.dealer__Desk_Manager__c = [Select Id from User where isActive = true limit 1].Id;
        tl2.dealer__Date_In__c = system.today();
        tl2.dealer__Fresh_Call__c = true;
        
        tl.add(tl1);
        tl.add(tl2);
        
        insert tl;
        
        /*List<dealer__Traffic_Log__c> tl = [select Id from dealer__Traffic_Log__c limit 100];*/
        ApexPages.Standardsetcontroller slc = new ApexPages.Standardsetcontroller(tl);
        DeskLog_EXT dext = new DeskLog_EXT(slc);
        
        dext.activateFilter();
        dext.dealItems();
        dext.filterAppointments=true;
        dext.filterDeals=true;
        dext.filterLeads=true;
        dext.filterTraffic=true;
        
        dext.generateDeskLog();
        
        dext.setProxyDate(new Event(dealer__Custom_Search_End_Date__c=Date.today(), dealer__Custom_Search_Start_Date__c=Date.today()));
        dext.setSearchDates();
        dext.getS1List();
        dext.getS2List();
        dext.getManager();
        dext.getCompanyNumbers();  
        dext.getDeskEntries();  
        
        dext.filterUserID = '005E0000000iaFl';
        dext.filterUserType = 'S1';
        dext.userFilter();
        
        dext.filterInStore = true;
        dext.getDeskEntries();
        
        dext.rotationLogGenerate();
        dext.salespersonResetId = '005E0000000iaFl';
        dext.dropActiveSalesperson();
        dext.getUpBoard();
        
        
    }
    
}