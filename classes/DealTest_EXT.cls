@isTest
private class DealTest_EXT {
    static testmethod void mytestMethod() { 
 
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
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(Deal);
        Deal_EXT dealCon = new Deal_EXT(sc);
        dealCon.getdealTitle();
        Deal_EXT.lookupBuyer(string.valueof(conRec.Id));
        dealCon.populateBuyerData(conRec);
        dealCon.save();
        Deal_EXT.selectStockNumber(VI.Id);
        dealer__Deal__c Deal1 = new dealer__Deal__c();
        Deal1.dealer__Broker__c = accRec.Id;
        Deal1.dealer__Buyer_Contact__c = conRec.Id;
        Deal1.dealer__Buyer__c = accRec.Id;
        Deal1.dealer__Co_Buyer_Contact__c = conRec.Id;
        Deal1.dealer__Co_Buyer__c = accRec.Id;
        Deal1.dealer__Deal_ID__c = 'Deal1';
        Deal1.dealer__Licence__c = 'Deal1';
        Deal1.dealer__Vehicle__c = VI.Id;
        Deal1.Name = 'Deal1';
        Deal1.dealer__Doc_Fee__c = 9;
        Deal1.dealer__First_Payment_Date__c = System.today();
        Deal1.dealer__Payments_Per_Year__c = 10;
        Deal1.dealer__Days__c = 10;
        Deal1.dealer__Term__c = 2;
        Deal1.Dealer__Rate__c = 2;
        Deal1.Dealer__Deal_Date__c = system.today();

       
        
        //insert Deal1;
        ApexPages.Standardcontroller sc1 = new ApexPages.Standardcontroller(Deal1);
        Deal_EXT dealCon1 = new Deal_EXT(sc1);

        Date ddate = dealCon1.DealDate;
        Decimal drate = dealCon1.Rate;
        Decimal dterm = dealCon1.Term;
        Decimal dppy = dealCon1.PPY;
        Date dfp = dealCon1.DateofFirstPayment;
        Decimal ddfee = dealCon1.DocFee;
        Decimal ddays = dealCon1.Days;

        }
        
    }

    static testmethod void testupdateSalesUp() { 

        TestFactory.createSObject(new DMS_Settings__c(), true);
        Deal__c deal = (Deal__c)TestFactory.createSObject(new deal__c(Deal_ID__c = '1'), true);

        ApexPages.Standardcontroller sc1 = new ApexPages.Standardcontroller(deal);
        Deal_EXT dealCon1 = new Deal_EXT(sc1);

        TestFactory.createSObjectList(new Sales_Up__c(), 1, true);
        List<Id> slist = new List<Id>(new Map<Id, Sales_Up__c>([select Id from Sales_Up__c]).keySet());

        Deal_EXT.updateSalesUp(slist);
    }
    
    @istest
    static void testGetDealTitle(){
        TestFactory.createSObject(new DMS_Settings__c(), true);
        
        dealer__Deal__c Deal = new dealer__Deal__c();
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(Deal);
        Deal_EXT dealCon = new Deal_EXT(sc);
        String ret = dealCon.getdealTitle();
        system.assertEquals('New Deal', ret,'Title of a null Deal should be New Deal');

        Deal__c Deal2 = (Deal__c)TestFactory.createSObject(new deal__c(Deal_ID__c = '1', Stock_Number__c = '123', Buyer_Last_Name__c = 'Smith', Buyer_First_Name__c = 'John'), true);
        ApexPages.Standardcontroller sc2 = new ApexPages.Standardcontroller(Deal2);
        Deal_EXT dealCon2 = new Deal_EXT(sc2);
        ret = dealCon2.getdealTitle();
        system.assertEquals('123 Smith, John', ret, 'Title of Deal should display stock number + Last Name, First Name');
    }
}