@isTest
private class Sup2Deal_TEST {
    

    @testSetup static void testDataInit() {

        Profile prof = [select id from profile where name='system Administrator'];
        User usr = new User(alias = 'usr', email='us.name@vmail.com',
                  emailencodingkey='UTF-8', lastname='lstname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='testuser128@testorgx.com',
                  Division='DT1');
        insert usr; 

        dealer__Dealer_Location__c location = new dealer__Dealer_Location__c();
        location.name = 'Test Location';
        location.dealer__Company_Number__c=usr.Division;
        location.dealer__City__c='ABSD';
        location.dealer__State__c='NY';
        location.dealer__Postal_Code__c='96001';

        //location.dealer__Default_Days_to_First_Payment__c = 45;
        location.dealer__Default_Rate__c = 9.9;
        //location.dealer__Default_Term__c = 72;
        upsert location;

        System.runAs(usr) {
            dealer__Vehicle_Inventory__c VI = new dealer__Vehicle_Inventory__c();
            VI.Name = 'Test Vehicle Inventory';
            VI.dealer__Model__c = '2014';
            VI.dealer__Stock_Number__c = '2014';
            VI.dealer__VIN__c = '100';
            VI.dealer__Company_Number__c = 'DT1';
            VI.dealer__Year__c = '2014';
            VI.dealer__Make__c = '2014';
            VI.In_Stock__c = true;
            insert VI;
        }

        Account accRec = new Account();
        accRec.FirstName = 'Test';
        accRec.LastName = 'Account';
        accRec.Type = 'Customer - Direct';
        accRec.BillingCountry = 'CA';
        accRec.BillingStreet = 'street';
        accRec.BillingCity = 'city';
        accRec.BillingState = 'State';
        accRec.BillingPostalCode = '151656';

        accRec.PersonMailingStreet = '123 Win Tu Way';
        accRec.PersonMailingCity = 'Redding';
        accRec.PersonMailingState = 'CA';
        accRec.PersonMailingPostalCode = '96001';

        insert accRec;

    }

    public static testMethod void validateSup2Deal() {
    
        Account objAccount = new Account();
        objAccount.Name = 'Test Account';
        objAccount.Phone = '13256446';
        objAccount.BillingCountry = 'CA';
        objAccount.BillingStreet = 'street';
        objAccount.BillingCity = 'city';
        objAccount.BillingState = 'State';
        objAccount.BillingPostalCode = '151656';
        objAccount.dealer__Active__c = 'Yes';
        objAccount.dealer__Vendor__c = true;
        insert objAccount;
        
        Contact objContact = new Contact(FirstName = 'TestFirst',
         Phone = '315616566', MobilePhone = '16565656', 
         Email = 'test@demo.com', MailingStreet = 'testStreet', 
         MailingCity = 'testCity', MailingPostalCode = 'ds1f56565', 
         MailingState = 'testState',
         LastName = 'TestContact');

        insert objContact;
        
        dealer__Finance_Company__c objFinanceCompany = new dealer__Finance_Company__c(Name = 'Test Finance');
        insert objFinanceCompany;
        
        dealer__Dealer_Location__c objLocation = [Select Id from dealer__Dealer_Location__c WHERE name ='Test Location' LIMIT 1];
        
        // Add Tax Zones
        insert new dealer__Tax_Zones__c(
            dealer__City__c='Redding',
            dealer__County__c='Shasta',
            dealer__Postal_Code__c='96001',
            dealer__Rate__c=9,
            dealer__State__c='CA'
        );
  
        
        dealer__Deal__c objDeal = new dealer__Deal__c(Name = 'Test', dealer__Deal_ID__c = '1500', dealer__Buyer__c = objAccount.Id, dealer__Status__c = 'Pending', dealer__Buyer_Address__c = 'Address', dealer__Buyer_City__c = 'City',
            /*dealer__Vehicle__c = objVehicleInventory.Id,*/
            dealer__Buyer_County__c = 'Country', dealer__Buyer_Email__c = 'test@demo.com', dealer__Buyer_Postal_Code__c = '96001', dealer__Buyer_State__c = 'State',
            dealer__Buyer_Mobile_Phone__c = '1656566', dealer__Buyer_Home_Phone__c = '55666454', dealer__Co_Buyer__c = objAccount.Id, dealer__Co_Buyer_Address__c = 'Address',
            dealer__Conversion_Price__c = 1656516, dealer__Co_Buyer_City__c = 'City', dealer__Co_Buyer_County__c = 'Country', dealer__Co_Buyer_Email__c = 'test@demo.com', dealer__Co_Buyer_Home_Phone__c = '651656',
            dealer__Co_Buyer_Mobile_Phone__c = '16516565', dealer__Co_Buyer_State__c = 'State', dealer__Co_Buyer_Postal_Code__c = 'Code', dealer__Delivery_Date__c = System.Today(), dealer__Business_Department__c = 'Business',
            dealer__Deal_Date__c = system.today(), dealer__Deal_Close_Date__c = system.today(), dealer__Broker__c = objAccount.Id, dealer__Broker_Address__c = 'Address', dealer__Broker_City__c = 'City',
            dealer__Broker_County__c = 'Country', dealer__Broker_Postal_Code__c = 'Code', dealer__Broker_State__c = 'State', dealer__Business_Title__c = 'Title', dealer__Business_Address__c = 'Address',
            dealer__Business_Phone__c = '16656545', dealer__Business_Contracting_Name__c = 'Business', dealer__Business_City__c = 'City', dealer__Business_State__c = 'State', dealer__Business_Postal_Code__c = 'Code',
            dealer__Business_County__c = 'Country', dealer__Business_Email__c = 'test@demo.com', dealer__Desk_Manager__c = UserInfo.getUserId(),
            /*dealer__DeliveryRepairOrder__c = objServiceRepair.Id,*/
            dealer__Finance_Institution_Account__c = objFinanceCompany.Id, dealer__Term__c = 10, dealer__Days_to_First__c = 124, dealer__Payments_Per_Year__c = 6565,
            dealer__Rate__c = 80, dealer__Amt_Financed__c = 51156, dealer__Monthly_Pymt__c = 44554, dealer__F_I_Manager__c = USerInfo.getUserId(), dealer__Store_Location__c = objLocation.Id, dealer__Auto_Insurance_Phone__c = '65165165',
            dealer__Co_Buyer_Work_Phone__c = '545455', dealer__Salesperson_1__c = UserInfo.getUserId(), dealer__Salesperson_2__c = UserInfo.getUserId(), dealer__Service_Manager__c = UserInfo.getUserId(),
            dealer__Delivery_City__c = 'City', dealer__Delivery_Phone__c = '516566', dealer__Delivery_State__c = 'State', dealer__Delivery_Postal_Code__c = 656566, dealer__Delivery_Mobile__c = '455566', dealer__Delivery_County__c = 'Country',
            dealer__Delivery_Notes__c = 'Notes', dealer__Delivery_Email__c = 'test@demo.com', dealer__Delivery_Street__c = 'Street', dealer__Vehicle_Conversion_Gross__c = 6266566, dealer__Vehicle_Gross__c = 5516566,
            dealer__Deferred_1_Payee__c = objAccount.Id,
            dealer__Deferred_2_Payee__c = objAccount.Id, dealer__Deferred_3_Payee__c = objAccount.Id, dealer__Deferred_Date_1__c = System.Today(), dealer__Deferred_Date_2__c = System.Today(), dealer__Deferred_Date_3__c = System.Today(),
            dealer__Deferred_Down_1__c = 51665, dealer__Deferred_Down_2__c = 65655, dealer__Deferred_Down_3__c = 54555, dealer__Deferred_Note_1__c = 'Note 2', dealer__Deferred_Note_2__c = 'Note 2', dealer__Deferred_Note_3__c = 'Note 3',
            dealer__GVWR__c = 56656, dealer__Doc_Fee__c = 445, dealer__License_Fee__c = 55668, dealer__Registration_Title_Fee__c = 45416, dealer__Electronic_Filing_Fee__c = 55999, dealer__Tire_Fee__c = 55598,
            dealer__Smog_Cert__c = 54544);
        insert objDeal;
        
        Schema.DescribeSObjectResult salesUPSchema = Schema.SObjectType.dealer__Sales_Up__c; 
        Map<String,Schema.RecordTypeInfo> SalesUpRecordTypeInfo = salesUPSchema.getRecordTypeInfosByName();
        Id rtId = SalesUpRecordTypeInfo.get('Standard Sales Up').getRecordTypeId();

        User u = [Select Id from User where Username = 'testuser128@testorgx.com'];

        Contact contRec = [Select Id FROM Contact LIMIT 1];
        Account acctRec = [Select Id FROM Account LIMIT 1];

        System.runAs(u) {
            Test.startTest();
            dealer__Vehicle_Inventory__c InvVeh = [Select Id FROM dealer__Vehicle_Inventory__c LIMIT 1];


            dealer__Sales_Up__c objSalesUp = new dealer__Sales_up__c(
                dealer__LastName__c='Test Sales Up', 
                dealer__Desired_Stock_Num__c = InvVeh.Id,

                dealer__Co_Buyer__c = acctRec.Id,
                dealer__Customer_Account__c = acctRec.Id,
                dealer__Lead_Status__c='Open',
                dealer__Lead_Type__c='Phone',

                dealer__Store_Location__c = objLocation.Id,
                dealer__Lead_Date__c=System.today(),RecordTypeId=rtId
            );
            insert objSalesUp;
            
            dealer__Appraisal__c objAppraisal = new dealer__Appraisal__c(dealer__Appraised_Value__c = 651165,dealer__Appraisal_Date__c = system.today());
            insert objAppraisal;
            
            dealer__Appraisal_Vehicle__c objAppraisalVehicle = new dealer__Appraisal_Vehicle__c(dealer__VIN__c = 's455vdfasd745e5ef',dealer__Year__c = '',dealer__Model__c = '',dealer__Appraisal__c = objAppraisal.Id,dealer__Sales_Up__c = objSAlesUp.Id,dealer__Make__c = '');
            insert objAppraisalVehicle;
            
            List<dealer__Trade_In__c> tradeList = [SELECT Id, Name, dealer__VIN__c FROM dealer__Trade_In__c WHERE dealer__VIN__c = 's455vdfasd745e5ef'];
                
            Schema.DescribeSObjectResult vInventorySchema = Schema.SObjectType.dealer__Vehicle_Inventory__c; 
            Map<String,Schema.RecordTypeInfo> vInventoryRecordTypeInfo = vInventorySchema.getRecordTypeInfosByName();
            Id vInventoryRType = vInventoryRecordTypeInfo.get('Used').getRecordTypeId();            
            
            ApexPages.currentPage().getParameters().put('salesup',objSalesUp.Id);
            
            String conId = objContact.Id;
            Sup2Deal objSalesUpController = new Sup2Deal(new ApexPages.StandardController(objDeal));
            
            PageReference pageRefDealPage = objSalesUpController.dealPage();

            // Test dealPage DML Exception
			objSalesUpController.deal.dealer__County__c = 'A really long string value that will not allow saving.  This field is limited to a set value';
            PageReference pageRefDealPageFailed = objSalesUpController.dealPage();
            Test.stopTest();
        }

    }

    public static testMethod void validateEquipmentDeal() {

        RecordType rt = [SELECT Id FROM RecordType WHERE DeveloperName='Equipment_Only'];
        dealer__Dealer_Location__c objLocation = [Select Id from dealer__Dealer_Location__c WHERE name ='Test Location' LIMIT 1];
        User u = [Select Id from User where Username = 'testuser128@testorgx.com'];

        //create records needed for aftermarket
        dealer__Parts_Master__c pm = new dealer__Parts_Master__c();
        pm.Name = 'Oil Filter';
        pm.dealer__Retail_Price__c = 99.99;
        pm.Manufacturer__c = 'FD';
        insert pm;

        // Create a Test Part
        dealer__Parts_Inventory__c part = new dealer__Parts_Inventory__c();
        part.dealer__Description__c = 'Oil Filter';
        part.dealer__Cost__c = 10;
        part.dealer__Source__c = 'Stocking';
        part.dealer__On_Hand__c = 1;
        part.dealer__Part_No__c = 'FL1A-XX';
        part.dealer__List__c = 22;
        part.dealer__Parts_Master__c = pm.Id;
        part.dealer__Location__c = objLocation.Id;
        insert part;

        Parts_Kit__c pk = new Parts_Kit__c();
        pk.Name = 'Test Kit';
        pk.Description__c = 'Custom description about the kit.';
        insert pk;

        Parts_Kit_Item__c pki = new Parts_Kit_Item__c();
        pki.Quantity__c = 1;
        pki.Parts_Kit__c = pk.Id;
        pki.Parts_Master__c = pm.Id;
        pki.Extended_List__c = 50;
        pki.ScheduledPrice__c = 75;
        insert pki;

        System.runAs(u) {
            // Insert SalesUp with Service_Vehicle of RecordType Equipment_Only
            Account a = new Account(FirstName='Jarrett', LastName='Kuljis');
            insert a;

            dealer__Service_Vehicle__c sv = new dealer__Service_Vehicle__c(dealer__Year__c='2009', dealer__Make__c='Honda', dealer__Carline__c='Civic', dealer__VIN__c='5FNRL5H90BB042364');
            Insert sv;

            dealer__Sales_up__c sup = new dealer__Sales_Up__c(
                dealer__Customer_Account__c=a.Id,
                RecordTypeId=rt.Id,
                dealer__Service_Vehicle__c=sv.Id,
                dealer__ConversionPartsKit__c = pk.Id
            );  
            insert sup;

            dealer__Deal__c objDeal = new dealer__Deal__c();

            ApexPages.currentPage().getParameters().put('salesup',sup.Id);
            Sup2Deal objSalesUpController = new Sup2Deal(new ApexPages.StandardController(objDeal));
                
            PageReference pageRefDealPage = objSalesUpController.dealPage();
        }
    }
    
}