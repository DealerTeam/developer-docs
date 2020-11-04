@isTest
private class DealTRSControllerTest {
    
    static testMethod void validateDealTRSController() {

        dealer.TestClassUtil testutil = new dealer.TestClassUtil();
        testutil.insertDMSSettings();

        // Insert Tax Region
        // SELECT Id, dealer__JurisdictionType__c, dealer__MaxTaxableAmount__c, dealer__MinTaxableAmount__c, dealer__ParentRegion__c, dealer__Rate_Type__c, dealer__Rate__c, dealer__RegionCode__c, Name FROM dealer__Tax_Region__c
        Tax_Region__c region = new Tax_Region__c(
            dealer__JurisdictionType__c='State',
            dealer__Rate_Type__c='General',
            dealer__Rate__c=5.0,
            dealer__RegionCode__c='CA'
        );

        insert region;

        // Insert Tax Zone
        // SELECT Id, dealer__City__c, dealer__Common_Name__c, dealer__County__c, dealer__Effective_Date__c, dealer__Expires_Date__c, dealer__Postal_Code__c, dealer__Rate__c, dealer__State__c FROM dealer__Tax_Zones__c
        Tax_Zones__c tz = new Tax_Zones__c(
            dealer__City__c='Redding',
            dealer__County__c='Shasta',
            dealer__Postal_Code__c='96001',
            dealer__Rate__c=7.25,
            dealer__State__c='CA'
        );

        insert tz;

        // Insert Junction
        // SELECT Id, dealer__TaxRegion__c, dealer__TaxZone__c FROM dealer__TaxJunction__c
        insert new TaxJunction__c(
            dealer__TaxRegion__c=region.Id,
            dealer__TaxZone__c=tz.Id
        );            

        List < SObject > sObjectList = new List < SObject > ();
        List < User > userList = new List < User > ();
        List < dealer__Form__c > formsList = new List < dealer__Form__c > ();
        Profile objProfile = [SELECT Id From Profile WHERE Name = 'Standard User'];

        User objUser = new User(Alias = 'newUser',
            Division = 'CR9',
            Email = 'newuser1234@testorg.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US', // changed for to avoid: INVALID_OR_NULL_FOR_RESTRICTED_PICKLIST, Locale: bad value for restricted picklist field: America/Los_Angeles
            UserName = 'newuser12342@testorg.com',
            ProfileId = objProfile.Id,
            TimeZoneSidKey = 'America/Los_Angeles');
        insert objUser;
        //userList.add(objUser);
        userList = [select id, Name from User where id =: objUser.id];

        Document document = new Document();
        document.Body = Blob.valueOf('Some Text');
        document.ContentType = 'image/png';
        document.DeveloperName = 'InvoiceLogo';
        document.IsPublic = true;
        document.Name = 'InvoiceLogo';
        document.FolderId = objUser.id;
        insert document;

        //System.runAs(new user(ID = UserInfo.getUserID())){

        Account objAccount = new Account();
        objAccount.FirstName = 'Test Account';
        objAccount.MiddleName = 'Test Account';
        objAccount.LastName = 'Test Account';
        objAccount.Phone = '13256446';
        objAccount.PersonMobilePhone = '65666871';
        objAccount.PersonMobilePhone = 'test@demo.com';
        objAccount.BillingCountry = 'CA';
        objAccount.BillingStreet = 'street';
        objAccount.BillingCity = 'city';
        objAccount.BillingState = 'State';
        objAccount.BillingPostalCode = '151656';
        objAccount.dealer__Active__c = 'Yes';
        objAccount.dealer__Vendor__c = true;
        objAccount.dealer__Tax_ID__c = '21132sdf';
        insert objAccount;

        Contact objContact = new Contact(LastName = 'TestContact');
        insert objContact;

        dealer__Appraisal_Vehicle__c objAppraisalVehicle = new dealer__Appraisal_Vehicle__c(dealer__Make__c = '2016');
        insert objAppraisalVehicle;
        sObjectList.add(objAppraisalVehicle);
        
        dealer__Appraisal_Vehicle__c objAppraisalVehicle1 = new dealer__Appraisal_Vehicle__c(dealer__Make__c = '2015');
        insert objAppraisalVehicle1;
        sObjectList.add(objAppraisalVehicle1);

        dealer__Finance_Company__c objFinanceCompany = new dealer__Finance_Company__c(Name = 'Test Finance');
        insert objFinanceCompany;

        dealer__Dealer_Location__c objLocation = new dealer__Dealer_Location__c(Name = 'Test Location', dealer__City__c = 'City', dealer__Company_Number__c = '561', dealer__Postal_Code__c = 'Code', dealer__State__c = 'ST');
        insert objLocation;

        dealer__Deal__c objDeal = new dealer__Deal__c(Name = 'Test', dealer__Deal_ID__c = 'a0B61000001w9kC', dealer__Buyer__c = objAccount.Id, dealer__Status__c = 'Pending', dealer__Buyer_Address__c = 'Address', dealer__Buyer_City__c = 'City',
            /*dealer__Vehicle__c = objVehicleInventory.Id,*/
            dealer__Buyer_County__c = 'Country', dealer__Buyer_Email__c = 'test@demo.com', dealer__Buyer_Postal_Code__c = '96002', dealer__Buyer_State__c = 'State',
            dealer__Buyer_Mobile_Phone__c = '1656566', dealer__Buyer_Home_Phone__c = '55666454', dealer__Co_Buyer__c = objAccount.Id, dealer__Co_Buyer_Address__c = 'Address',
            dealer__Conversion_Price__c = 1656516, dealer__Co_Buyer_City__c = 'City', dealer__Co_Buyer_County__c = 'Country', dealer__Co_Buyer_Email__c = 'test@demo.com', dealer__Co_Buyer_Home_Phone__c = '651656',
            dealer__Co_Buyer_Mobile_Phone__c = '16516565', dealer__Co_Buyer_State__c = 'State', dealer__Co_Buyer_Postal_Code__c = '96002', dealer__Delivery_Date__c = System.Today(), dealer__Business_Department__c = 'Business',
            dealer__Deal_Date__c = system.today(), dealer__Deal_Close_Date__c = system.today(), dealer__Broker__c = objAccount.Id, dealer__Broker_Address__c = 'Address', dealer__Broker_City__c = 'City',
            dealer__Broker_County__c = 'Country', dealer__Broker_Postal_Code__c = 'Code', dealer__Broker_State__c = 'State', dealer__Business_Title__c = 'Title', dealer__Business_Address__c = 'Address',
            dealer__Business_Phone__c = '16656545', dealer__Business_Contracting_Name__c = 'Business', dealer__Business_City__c = 'City', dealer__Business_State__c = 'State', dealer__Business_Postal_Code__c = 'Code',
            dealer__Business_County__c = 'Country', dealer__Business_Email__c = 'test@demo.com', dealer__Desk_Manager__c = UserInfo.getUserId(),
            /*dealer__DeliveryRepairOrder__c = objServiceRepair.Id,*/
            dealer__Finance_Institution_Account__c = objFinanceCompany.Id, dealer__Term__c = 10, dealer__Days_to_First__c = 124, dealer__Payments_Per_Year__c = 6565,
            dealer__Rate__c = 80, dealer__Amt_Financed__c = 51156, dealer__Monthly_Pymt__c = 44554, dealer__F_I_Manager__c = USerInfo.getUserId(), dealer__Store_Location__c = objLocation.Id, dealer__Auto_Insurance_Phone__c = '65165165',
            dealer__Co_Buyer_Work_Phone__c = '545455', dealer__Salesperson_1__c = UserInfo.getUserId(), dealer__Salesperson_2__c = UserInfo.getUserId(), dealer__Service_Manager__c = UserInfo.getUserId(),
            dealer__Delivery_City__c = 'City', dealer__Delivery_Phone__c = '516566', dealer__Delivery_State__c = 'State', dealer__Delivery_Postal_Code__c = 96002, dealer__Delivery_Mobile__c = '455566', dealer__Delivery_County__c = 'Country',
            dealer__Delivery_Notes__c = 'Notes', dealer__Delivery_Email__c = 'test@demo.com', dealer__Delivery_Street__c = 'Street', dealer__Vehicle_Conversion_Gross__c = 6266566, dealer__Vehicle_Gross__c = 5516566,
            dealer__Deferred_1_Payee__c = objAccount.Id,
            dealer__Deferred_2_Payee__c = objAccount.Id, dealer__Deferred_3_Payee__c = objAccount.Id, dealer__Deferred_Date_1__c = System.Today(), dealer__Deferred_Date_2__c = System.Today(), dealer__Deferred_Date_3__c = System.Today(),
            dealer__Deferred_Down_1__c = 51665, dealer__Deferred_Down_2__c = 65655, dealer__Deferred_Down_3__c = 54555, dealer__Deferred_Note_1__c = 'Note 2', dealer__Deferred_Note_2__c = 'Note 2', dealer__Deferred_Note_3__c = 'Note 3',
            dealer__GVWR__c = 0, dealer__Doc_Fee__c = 445, dealer__License_Fee__c = 55668, dealer__Registration_Title_Fee__c = 45416, dealer__Electronic_Filing_Fee__c = 55999, dealer__Tire_Fee__c = 55598,
            dealer__Smog_Cert__c = 54544, Tax_Zone__c=tz.Id, Standard_Taxable__c=5000);
        insert objDeal;


        dealer__PostingTemplate__c pt = new dealer__PostingTemplate__c(Name='Test',dealer__Object_Name__c='Deal',dealer__Active__c=true);
        insert pt;

        
        dealer__Trade_In__c objTradeIn = new dealer__Trade_In__c(dealer__Car_Deal__c = objDeal.Id, dealer__ACV__c = 50.50, Name = 'Test', dealer__Pay_Off_Amount__c = 16565, dealer__Appraisal_Vehicle__c = objAppraisalVehicle.Id,
            dealer__Year__c = '2016', dealer__Make__c = '2016', dealer__Model__c = 'Merc', dealer__VIN__c = 'd1fs36', dealer__Lost_Trade__c = true, dealer__Net__c = 155616,
            dealer__Odometer_at_Trade_In__c = 156, dealer__Pay_Off_Account__c = objAccount.Id, dealer__Trade_Allowance__c = 73254, dealer__Pay_Off_Account_Number__c = 'TestAmount',
            dealer__Pay_Off_Expiration_Date__c = System.Today());
        insert objTradeIn;

        dealer__Service_Contract__c objService = new dealer__Service_Contract__c(dealer__Car_Deal__c = objDeal.Id, dealer__Company_Number__c = 'Location 1', dealer__Contract_Template__c = true, dealer__Cost__c = 66656, dealer__Customer_Contact__c = objContact.Id,
            dealer__Customer__c = objAccount.Id, dealer__Deductable__c = 56565, dealer__Description__c = 'Test Desc', dealer__Taxable__c = true, dealer__Printable__c = true, dealer__End_Date__c = System.Today(),
            dealer__Expiration_Mileage__c = 56662, dealer__Expiration_Months__c = 562, dealer__Odometer_at_Sale__c = 32266, dealer__Order__c = 1656556, dealer__Plan_Code__c = 'Test Plan', dealer__Product_Code__c = 'Product Code',
            dealer__Sale_Price__c = 156615, /*dealer__Service_Vehicle__c = objServiceVehicle.Id,*/ dealer__Start_Date__c = System.Today(), dealer__Type__c = 'GAP' /*,dealer__Vehicle_Inventory__c = objVehicleInventory.Id*/ );
        insert objService;

        dealer__Parts_Kit__c objPartsKit = new dealer__Parts_Kit__c(Name = 'Test Part', dealer__Description__c = 'Test');
        insert objPartsKit;

        dealer__Kit_Category__c objKitCategory = new dealer__Kit_Category__c(Name = 'Kit Test');
        insert objKitCategory;

        dealer__Form__c objForm = new dealer__Form__c();
        objForm.name = 'TestForm';
        objForm.dealer__Page_Name__c = 'test1';
        objForm.dealer__Impact_Code__c = 'Test Impact Code';
        objForm.dealer__Print_Type__c = 'Laser';
        insert objForm;
        formsList.add(objForm);
        

        dealer__Form__c objForm1 = new dealer__Form__c();
        objForm1.name = 'TestForm1';
        objForm1.dealer__Page_Name__c = 'test2';
        objForm1.dealer__Impact_Code__c = 'Test Impact Code';
        objForm1.dealer__Print_Type__c = 'Impact';
        insert objForm1;
        formsList.add(objForm1);

        
        dealer__Deal_Form__c objDealForm = new dealer__Deal_Form__c(dealer__Deal__c = objDeal.id, dealer__Form__c = objForm.Id);
        insert objDealForm;
        
        dealer__Deal_Form__c objDealForm1 = new dealer__Deal_Form__c(dealer__Deal__c = objDeal.id, dealer__Form__c = objForm1.Id);
        insert objDealForm1;
        
        dealer__Discount_Rebate__c objDiscount = new dealer__Discount_Rebate__c(dealer__Type__c = 'Coupon', dealer__Desc__c = 'Test Description', dealer__Amount__c = 155462, dealer__Gross__c = 'FE', dealer__Taxable__c = true);
        insert objDiscount;

        Test.startTest();
        
        ApexPages.currentPage().getParameters().put('id', objDeal.Id);
        ApexPages.currentPage().getParameters().put('action', 'dealer__Approval_Status__c');
        ApexPages.currentPage().getParameters().put('dealId', objDeal.Id);
        ApexPages.currentPage().getParameters().put('dealer__Form__c', objForm.Id);
        ApexPages.currentPage().getParameters().put('fieldName', 'dealer__Kit_Category__c');
        ApexPages.currentPage().getParameters().put('pageSize', '3');
        ApexPages.currentPage().getParameters().put('page', '1');
        ApexPages.currentPage().getParameters().put('formId', objForm.Id);
        //ApexPages.currentPage().getParameters().put('custid',objVehicleInventory.Id);

        string value = '';
        string type = '';
        string body = '';
        boolean isSave = true;

        DealTRSController objDealController = new DealTRSController();
        DealTRSController objDealStandardController = new DealTRSController(new ApexPages.StandardController(objDeal));
    
        Id cashRecordedId = objDealStandardController.casheirRecordId;

        objDealController.getSubmitApproval();
        objDealController.getActiveApproval();
        objDealController.getApprovalIsLocked();

        PageReference pageRefRefresh = objDealController.refreshButtonPanels();
        objDealController.getDealContentDocuments();
        objDealController.getApprovalHistory();
        //objDealController.getSubmitApproval(); //Getting error no such Approval Process
        PageReference pageRefRecall = objDealController.recallApprovalProcess();
        objDealController.getRecordIds(sObjectList);

        objDealController.getFilters();
        objDealController.getFilterMap();
        objDealController.getPartKitSoql();
        objDealController.getPartKits();
        objDealController.getPartKitCount();
        objDealController.getAfterMarkets();
        
        objDealController.getAppraisalReadLookup();

        objDealController.getAppraisalsWithVehicle();
        ApexPages.currentPage().getParameters().put('filter[filters][0][value]', 'ABC');
        objDealController.getAppraisalRead();

        ApexPages.currentPage().getParameters().put('custid', objDeal.Id);
        objDealController.getAppraisalReadById(objAccount.Id);
        
        
        objDealController.getAccountReadLookup();


        ApexPages.currentPage().getParameters().put('filter[filters][0][value]', '');
        objDealController.getAccountReadLookup();
        ApexPages.currentPage().getParameters().put('custid', '');
        objDealController.getAccountReadLookup();
        objDealController.getAccountRead();
        ApexPages.currentPage().getParameters().put('filter[filters][0][value]', 'ABC');
        objDealController.getAccountRead();
        objDealController.getAccountReadById();
        ApexPages.currentPage().getParameters().put('custid', objAccount.Id);
        objDealController.getAccountReadById();
        objDealController.getBuyerAccount();
        objDealController.getUserJson(userList);

        PageReference pageRefAction = objDealController.crudAction();

        objDealController.deleteLaserDealForm();
        objDealController.deleteImpactDealForm();
        objDealController.getSelectedForm();
        ApexPages.currentPage().getParameters().put('id', '');
        objDealController.getDeal();
        ApexPages.currentPage().getParameters().put('id', objDeal.Id);
        objDealController.getDeal();
        objDealController.getDealRecord();
        objDealController.getTradeIns();
        ApexPages.currentPage().getParameters().put('id', objTradeIn.Id);
        objDealController.updateTradeIn();
        ApexPages.currentPage().getParameters().put('id', '');
        objDealController.updateDeal();
        /*
        objDealController.updateDeal();
        ApexPages.currentPage().getParameters().put('models', '[{"attributes":{"type":"dealer__After_Market__c","url":"/services/data/v36.0/sobjects/dealer__After_Market__c/a0061000005nFxWAAU"},"dealer__Car_Deal__c":"a0B61000000w9kCEAQ","dealer__Cost__c":0,"dealer__Description__c":"Base and bracket for an EZ Lock restraint system","Name":"EZLock Restraint","dealer__Taxable__c":false,"dealer__Sale_Price__c":"150","dealer__List_Price__c":0,"dealer__Manufacturer__c":"EZLock","dealer__Quantity__c":1,"dealer__Labor_Sale__c":50,"dealer__Part_Cost__c":0,"dealer__Type__c":"Part Kit","dealer__Parts_Sale__c":100,"Id":"a0061000005nFxWAAU","dealer__Gross__c":"130","dealer__Parts_Gross__c":0,"dealer__Labor_Gross__c":30,"dealer__Order__c":0,"dealer__Printable__c":false,"dealer__Hours__c":0,"dealer__Labor_Cost__c":20,"dealer__Car_Deal__r":{"attributes":{"type":"dealer__Deal__c","url":"/services/data/v36.0/sobjects/dealer__Deal__c/a0B61000000w9kCEAQ"},"Name":"1001","Id":"a0B61000000w9kCEAQ"},"dealer__Labor_Hours__c":null}]');
        ApexPages.currentPage().getParameters().put('id', objDeal.Id);
        ApexPages.currentPage().getParameters().put('locId', objLocation.Id);
        objDealController.upsertAfterMarket();


        objDealController.deleteAfterMarket(); //Commented below in test class
        
        ApexPages.currentPage().getParameters().put('id', '');
        objDealController.createTradeIn();
        ApexPages.currentPage().getParameters().put('id', objDeal.Id);
        ApexPages.currentPage().getParameters().put('dealer__ACV__c', '4000');
        ApexPages.currentPage().getParameters().put('dealer__Trade_Allowance__c', '4000');
        ApexPages.currentPage().getParameters().put('dealer__Recon__c', '1000');
        ApexPages.currentPage().getParameters().put('dealer__Pay_Off_Amount__c', '1000');
        ApexPages.currentPage().getParameters().put('dealer__Profit__c', '0');
        ApexPages.currentPage().getParameters().put('dealer__Net__c', '0');
        ApexPages.currentPage().getParameters().put('Name', 'Test Name');
        ApexPages.currentPage().getParameters().put('dealer__Car_Deal__c', objDeal.Id);
        ApexPages.currentPage().getParameters().put('dealer__Year__c', '2015');
        ApexPages.currentPage().getParameters().put('dealer__Make__c', 'Ford');
        ApexPages.currentPage().getParameters().put('dealer__Model__c', 'Focus');
        ApexPages.currentPage().getParameters().put('dealer__Trim_Level__c', 'SLT');
        ApexPages.currentPage().getParameters().put('dealer__VIN__c', '1HGCM82633A004352');
        ApexPages.currentPage().getParameters().put('dealer__Odometer_at_Trade_In__c', '1500');

        objDealController.createTradeIn();
        ApexPages.currentPage().getParameters().put('id', objTradeIn.Id);
        objDealController.deleteTradeIn();
        ApexPages.currentPage().getParameters().put('id', objDeal.Id);
        objDealController.getParts();
        objDealController.getPicklistFieldDescribe();
        objDealController.getPicklistValues();
      
        objDealController.getCategoryReadLookup();

        objDealController.getCategoryReadById('Category');
        objDealController.getCategoryReadById('Sub-category');
        objDealController.getCategoryReadById('Manufacturer');

        objDealController.getCategoryRead('Category');
        objDealController.getCategoryRead('Sub-category');
        objDealController.getCategoryRead('Manufacturer');

        ApexPages.currentPage().getParameters().put('fieldName', 'dealer__Company_Number__c');
        objDealController.getServiceContractPicklistValues();
        objDealController.getDealStatusValues();
        objDealController.getAvailableContractSoql();
        objDealController.getAvailableContracts();
        objDealController.getAvailableContractCount();
	 COMMENTED OUT DURING DTMOB MIGRATION TO AVOID SOQL QUERY LIMIT
        objDealController.getDiscountTemplates();
        objDealController.getDiscounts();
        ApexPages.currentPage().getParameters().put('dealer__Type__c', 'Coupon');
        ApexPages.currentPage().getParameters().put('dealer__Desc__c', 'Test Description');
        ApexPages.currentPage().getParameters().put('dealer__Amount__c', '155462');
        ApexPages.currentPage().getParameters().put('dealer__Gross__c', 'FE');
        ApexPages.currentPage().getParameters().put('dealer__Taxable__c', 'true');
        ApexPages.currentPage().getParameters().put('id', objDiscount.id);
        
        objDealController.updateDiscount();
        objDealController.destroyDiscount();
        objDealController.getDealMiscTaxes();
        objDealController.getGrossItems();
        objDealController.getMiscTaxCode();
        objDealController.getmiscChargeCodes();
        objDealController.getSelectedContracts();
        objDealController.insertContract();
        ApexPages.currentPage().getParameters().put('models', '[{"attributes":{"type":"dealer__Service_Contract__c","url":"/services/data/v36.0/sobjects/dealer__Service_Contract__c/a0v610000017aXCAAY"},"dealer__Car_Deal__c":"a0B61000000w9kCEAQ","Name":"160412-869","dealer__Contract_Template__c":false,"dealer__Cost__c":111,"dealer__Customer_Contact__c":"0036100000MhlJUAAZ","dealer__Customer__c":"0016100000Nb6WvAAJ","dealer__Deductable__c":"12","dealer__Description__c":"TEst New Contract","dealer__Taxable__c":false,"dealer__Printable__c":false,"Id":"a0v610000017aXCAAY","dealer__Expiration_Months__c":"34","dealer__Gross__c":333,"dealer__Plan_Code__c":"32","dealer__Sale_Price__c":444,"dealer__Start_Date__c":"2016-04-08","dealer__Type__c":"Extended Service Contract","dealer__Order__c":null}]');
        objDealController.insertContract();
        ApexPages.currentPage().getParameters().put('id', objAccount.Id);
        ApexPages.currentPage().getParameters().put('Phone', objAccount.Id);
        ApexPages.currentPage().getParameters().put('BillingCountry', objAccount.Id);
        ApexPages.currentPage().getParameters().put('BillingStreet', objAccount.Id);
        ApexPages.currentPage().getParameters().put('BillingCity', objAccount.Id);
        ApexPages.currentPage().getParameters().put('BillingState', objAccount.Id);
        ApexPages.currentPage().getParameters().put('BillingPostalCode', objAccount.Id);
        ApexPages.currentPage().getParameters().put('BillingStreet', objAccount.Id);
        
        ApexPages.currentPage().getParameters().put('IsPersonAccount','false' );
        ApexPages.currentPage().getParameters().put('dealer__buyer__r[ispersonaccount]','true' );
        ApexPages.currentPage().getParameters().put('dealer__buyer_mobile_phone__c','123' );
        ApexPages.currentPage().getParameters().put('dealer__buyer_home_phone__c','123' );
        ApexPages.currentPage().getParameters().put('dealer__buyer_email__c','123' );
        ApexPages.currentPage().getParameters().put('dealer__buyer_first_name__c','test' );
        ApexPages.currentPage().getParameters().put('dealer__buyer_last_name__c','test' );
        ApexPages.currentPage().getParameters().put('dealer__Buyer_Middle_Name__c','test' );
        ApexPages.currentPage().getParameters().put('dealer__buyer_birthdate__c','test' );
        ApexPages.currentPage().getParameters().put('dealer__buyer_address__c','test' );
        ApexPages.currentPage().getParameters().put('dealer__buyer_city__c','test' );
        ApexPages.currentPage().getParameters().put('dealer__buyer_state__c','test' );
        ApexPages.currentPage().getParameters().put('dealer__buyer_postal_code__c','test' );
        ApexPages.currentPage().getParameters().put('dealer__buyer_drivers_license__c','test' );
        ApexPages.currentPage().getParameters().put('dealer__buyer_drivers_lic_state__c','test' );
        ApexPages.currentPage().getParameters().put('dealer__buyer_drivers_license_exp_date__c','test' );

        objDealController.updateAccounts();
        objDealController.updateContract();
        objDealController.deleteContract(); //Commented below in test class



        ApexPages.currentPage().getParameters().put('models', '');
        objDealController.updateContract();
        objDealController.getFinanceCompany();
        ApexPages.currentPage().getParameters().put('filter[filters][0][value]', ' ');
        objDealController.getFinanceCompany();
        ApexPages.currentPage().getParameters().put('id', objDeal.Id);
        objDealController.getLaserForm();
        objDealController.getImpactForm();
        objDealController.getSelectedImpactForm();
        objDealController.getSelectedLaserForm();
        objDealController.doHttpRequest(body, isSave); // Need to insert fake body of response when running test
        objDealController.getPdfBody(formsList);
        objDealController.getSerVehicleReadLookup();
        objDealController.getSerVehicleRead();
        ApexPages.currentPage().getParameters().put('filter[filters][0][value]', 'ABC');
        objDealController.getSerVehicleRead();
        objDealController.getSerVehicleReadById();
        ApexPages.currentPage().getParameters().put('custid', '');
        objDealController.getSerVehicleReadById();
        objDealController.getcompiledFDF();
        objDealController.getPostingTemplates();
        objDealController.getTaxTemplates();
        objDealController.getRecentSalesUps();
        ApexPages.currentPage().getParameters().put('models', '[{"attributes":{"type":"dealer__Service_Contract__c","url":"/services/data/v36.0/sobjects/dealer__Service_Contract__c/a0v610000017aXCAAY"},"dealer__Car_Deal__c":"a0B61000000w9kCEAQ","Name":"160412-869","dealer__Contract_Template__c":false,"dealer__Cost__c":111,"dealer__Customer_Contact__c":"0036100000MhlJUAAZ","dealer__Customer__c":"0016100000Nb6WvAAJ","dealer__Deductable__c":"12","dealer__Description__c":"TEst New Contract","dealer__Taxable__c":false,"dealer__Printable__c":false,"Id":"a0v610000017aXCAAY","dealer__Expiration_Months__c":"34","dealer__Gross__c":333,"dealer__Plan_Code__c":"32","dealer__Sale_Price__c":444,"dealer__Start_Date__c":"2016-04-08","dealer__Type__c":"Extended Service Contract","dealer__Order__c":null}]');
        objDealController.updateContract();
        objDealController.deleteDeal();
        objDealController.getAccountsForNewDeal();
        objDealController.getmyDeskingSettings();
        DealTRSController.setDisplayAsGross('true');
        DealTRSController.setCustomDisplay(); */

        Test.stopTest();
        
    }
    static testMethod void testLookupMethods() {
         DealTRSController objDealController = new DealTRSController();
        dealer.TestClassUtil testutil = new dealer.TestClassUtil();
        testutil.insertDMSSettings();

        List < SObject > sObjectList = new List < SObject > ();
        List < User > userList = new List < User > ();
        List < dealer__Form__c > formsList = new List < dealer__Form__c > ();
        Profile objProfile = [SELECT Id From Profile WHERE Name = 'Standard User'];

        User objUser = new User(Alias = 'newUser',
            Division = 'CR9',
            Email = 'newuser1234@testorg.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US', // changed for to avoid: INVALID_OR_NULL_FOR_RESTRICTED_PICKLIST, Locale: bad value for restricted picklist field: America/Los_Angeles
            UserName = 'newuser12343@testorg.com',
            ProfileId = objProfile.Id,
            TimeZoneSidKey = 'America/Los_Angeles');
        insert objUser;
        //userList.add(objUser);
        userList = [select id, Name from User where id =: objUser.id];

        Document document = new Document();
        document.Body = Blob.valueOf('Some Text');
        document.ContentType = 'image/png';
        document.DeveloperName = 'InvoiceLogo';
        document.IsPublic = true;
        document.Name = 'InvoiceLogo';
        document.FolderId = objUser.id;
        insert document;

        //System.runAs(new user(ID = UserInfo.getUserID())){

        Account objAccount = new Account();
        objAccount.FirstName = 'Test Account';
        objAccount.MiddleName = 'Test Account';
        objAccount.LastName = 'Test Account';
        objAccount.Phone = '13256446';
        objAccount.PersonMobilePhone = '65666871';
        objAccount.PersonMobilePhone = 'test@demo.com';
        objAccount.BillingCountry = 'CA';
        objAccount.BillingStreet = 'street';
        objAccount.BillingCity = 'city';
        objAccount.BillingState = 'State';
        objAccount.BillingPostalCode = '151656';
        objAccount.dealer__Active__c = 'Yes';
        objAccount.dealer__Vendor__c = true;
        objAccount.dealer__Tax_ID__c = '21132sdf';
        insert objAccount;

        Contact objContact = new Contact(LastName = 'TestContact');
        insert objContact;

        dealer__Appraisal_Vehicle__c objAppraisalVehicle = new dealer__Appraisal_Vehicle__c(dealer__Make__c = '2016');
        insert objAppraisalVehicle;
        sObjectList.add(objAppraisalVehicle);
        
        dealer__Appraisal_Vehicle__c objAppraisalVehicle1 = new dealer__Appraisal_Vehicle__c(dealer__Make__c = '2015');
        insert objAppraisalVehicle1;
        sObjectList.add(objAppraisalVehicle1);
        /*dealer__Vehicle_Inventory__c objVehicleInventory = new dealer__Vehicle_Inventory__c(Name = 'Test Vehicle',dealer__Exterior_Color__c = 'Exterior',dealer__Vehicle_Type__c = 'Vehicle Type',dealer__Coded_Cost__c = 54542,dealer__Mileage__c = 54545,dealer__VIN__c = 'dvs65b65',
                                                           dealer__Trim_Level__c = 'Trim Level',dealer__Invoice_Price__c = 113363,dealer__Conversion_Cost__c = 515656,dealer__Status_Code__c = 'Detail',dealer__Model_Code__c = 'Model Code',dealer__MV_Ranp_Operation__c = 'Automatic',
                                                           dealer__MV_Ramp_Type__c = 'In Floor',dealer__Ramp_Location__c = 'Rear Entry',dealer__Work_in_Process__c = 165656,dealer__Year__c = '2016',dealer__Make__c = 'Make',dealer__Model__c = 'ds2d33232',dealer__Vehicle_Cost__c = 561655,
                                                           dealer__Purchase_Price__c = 511123,dealer__Conversion_Price__c = 6156565);
        insert objVehicleInventory;*/

        /*dealer__Service_Repair_Order__c objServiceRepair = new dealer__Service_Repair_Order__c(Name = 'Test Repair');
        insert objServiceRepair;*/

        dealer__Finance_Company__c objFinanceCompany = new dealer__Finance_Company__c(Name = 'Test Finance');
        insert objFinanceCompany;

        dealer__Dealer_Location__c objLocation = new dealer__Dealer_Location__c(Name = 'Test Location', dealer__City__c = 'City', dealer__Company_Number__c = '561', dealer__Postal_Code__c = 'Code', dealer__State__c = 'ST');
        insert objLocation;

        dealer__Deal__c objDeal = new dealer__Deal__c(Name = 'Test', dealer__Deal_ID__c = 'a0B61000001w9kC', dealer__Buyer__c = objAccount.Id, dealer__Status__c = 'Pending', dealer__Buyer_Address__c = 'Address', dealer__Buyer_City__c = 'City',
            /*dealer__Vehicle__c = objVehicleInventory.Id,*/
            dealer__Buyer_County__c = 'Country', dealer__Buyer_Email__c = 'test@demo.com', dealer__Buyer_Postal_Code__c = '96002', dealer__Buyer_State__c = 'State',
            dealer__Buyer_Mobile_Phone__c = '1656566', dealer__Buyer_Home_Phone__c = '55666454', dealer__Co_Buyer__c = objAccount.Id, dealer__Co_Buyer_Address__c = 'Address',
            dealer__Conversion_Price__c = 1656516, dealer__Co_Buyer_City__c = 'City', dealer__Co_Buyer_County__c = 'Country', dealer__Co_Buyer_Email__c = 'test@demo.com', dealer__Co_Buyer_Home_Phone__c = '651656',
            dealer__Co_Buyer_Mobile_Phone__c = '16516565', dealer__Co_Buyer_State__c = 'State', dealer__Co_Buyer_Postal_Code__c = '96002', dealer__Delivery_Date__c = System.Today(), dealer__Business_Department__c = 'Business',
            dealer__Deal_Date__c = system.today(), dealer__Deal_Close_Date__c = system.today(), dealer__Broker__c = objAccount.Id, dealer__Broker_Address__c = 'Address', dealer__Broker_City__c = 'City',
            dealer__Broker_County__c = 'Country', dealer__Broker_Postal_Code__c = 'Code', dealer__Broker_State__c = 'State', dealer__Business_Title__c = 'Title', dealer__Business_Address__c = 'Address',
            dealer__Business_Phone__c = '16656545', dealer__Business_Contracting_Name__c = 'Business', dealer__Business_City__c = 'City', dealer__Business_State__c = 'State', dealer__Business_Postal_Code__c = 'Code',
            dealer__Business_County__c = 'Country', dealer__Business_Email__c = 'test@demo.com', dealer__Desk_Manager__c = UserInfo.getUserId(),
            /*dealer__DeliveryRepairOrder__c = objServiceRepair.Id,*/
            dealer__Finance_Institution_Account__c = objFinanceCompany.Id, dealer__Term__c = 10, dealer__Days_to_First__c = 124, dealer__Payments_Per_Year__c = 6565,
            dealer__Rate__c = 80, dealer__Amt_Financed__c = 51156, dealer__Monthly_Pymt__c = 44554, dealer__F_I_Manager__c = USerInfo.getUserId(), dealer__Store_Location__c = objLocation.Id, dealer__Auto_Insurance_Phone__c = '65165165',
            dealer__Co_Buyer_Work_Phone__c = '545455', dealer__Salesperson_1__c = UserInfo.getUserId(), dealer__Salesperson_2__c = UserInfo.getUserId(), dealer__Service_Manager__c = UserInfo.getUserId(),
            dealer__Delivery_City__c = 'City', dealer__Delivery_Phone__c = '516566', dealer__Delivery_State__c = 'State', dealer__Delivery_Postal_Code__c = 96002, dealer__Delivery_Mobile__c = '455566', dealer__Delivery_County__c = 'Country',
            dealer__Delivery_Notes__c = 'Notes', dealer__Delivery_Email__c = 'test@demo.com', dealer__Delivery_Street__c = 'Street', dealer__Vehicle_Conversion_Gross__c = 6266566, dealer__Vehicle_Gross__c = 5516566,
            dealer__Deferred_1_Payee__c = objAccount.Id,
            dealer__Deferred_2_Payee__c = objAccount.Id, dealer__Deferred_3_Payee__c = objAccount.Id, dealer__Deferred_Date_1__c = System.Today(), dealer__Deferred_Date_2__c = System.Today(), dealer__Deferred_Date_3__c = System.Today(),
            dealer__Deferred_Down_1__c = 51665, dealer__Deferred_Down_2__c = 65655, dealer__Deferred_Down_3__c = 54555, dealer__Deferred_Note_1__c = 'Note 2', dealer__Deferred_Note_2__c = 'Note 2', dealer__Deferred_Note_3__c = 'Note 3',
            dealer__GVWR__c = 0, dealer__Doc_Fee__c = 445, dealer__License_Fee__c = 55668, dealer__Registration_Title_Fee__c = 45416, dealer__Electronic_Filing_Fee__c = 55999, dealer__Tire_Fee__c = 55598,
            dealer__Smog_Cert__c = 54544);
        insert objDeal;
        
        dealer__Trade_In__c objTradeIn = new dealer__Trade_In__c(dealer__Car_Deal__c = objDeal.Id, dealer__ACV__c = 50.50, Name = 'Test', dealer__Pay_Off_Amount__c = 16565, dealer__Appraisal_Vehicle__c = objAppraisalVehicle.Id,
            dealer__Year__c = '2016', dealer__Make__c = '2016', dealer__Model__c = 'Merc', dealer__VIN__c = 'd1fs36', dealer__Lost_Trade__c = true, dealer__Net__c = 155616,
            dealer__Odometer_at_Trade_In__c = 156, dealer__Pay_Off_Account__c = objAccount.Id, dealer__Trade_Allowance__c = 73254, dealer__Pay_Off_Account_Number__c = 'TestAmount',
            dealer__Pay_Off_Expiration_Date__c = System.Today());
        insert objTradeIn;
        dealer__Service_Contract__c objService = new dealer__Service_Contract__c(dealer__Car_Deal__c = objDeal.Id, dealer__Company_Number__c = 'Location 1', dealer__Contract_Template__c = true, dealer__Cost__c = 66656, dealer__Customer_Contact__c = objContact.Id,
            dealer__Customer__c = objAccount.Id, dealer__Deductable__c = 56565, dealer__Description__c = 'Test Desc', dealer__Taxable__c = true, dealer__Printable__c = true, dealer__End_Date__c = System.Today(),
            dealer__Expiration_Mileage__c = 56662, dealer__Expiration_Months__c = 562, dealer__Odometer_at_Sale__c = 32266, dealer__Order__c = 1656556, dealer__Plan_Code__c = 'Test Plan', dealer__Product_Code__c = 'Product Code',
            dealer__Sale_Price__c = 156615, /*dealer__Service_Vehicle__c = objServiceVehicle.Id,*/ dealer__Start_Date__c = System.Today(), dealer__Type__c = 'GAP' /*,dealer__Vehicle_Inventory__c = objVehicleInventory.Id*/ );
        insert objService;

        dealer__Parts_Kit__c objPartsKit = new dealer__Parts_Kit__c(Name = 'Test Part', dealer__Description__c = 'Test');
        insert objPartsKit;

        dealer__Kit_Category__c objKitCategory = new dealer__Kit_Category__c(Name = 'Kit Test');
        insert objKitCategory;

        dealer__Form__c objForm = new dealer__Form__c();
        objForm.name = 'TestForm';
        objForm.dealer__Page_Name__c = 'test1';
        objForm.dealer__Impact_Code__c = 'Test Impact Code';
        objForm.dealer__Print_Type__c = 'Laser';
        insert objForm;
        formsList.add(objForm);

        dealer__Form__c objForm1 = new dealer__Form__c();
        objForm1.name = 'TestForm1';
        objForm1.dealer__Page_Name__c = 'test2';
        objForm1.dealer__Impact_Code__c = 'Test Impact Code';
        objForm1.dealer__Print_Type__c = 'Impact';
        insert objForm1;
        formsList.add(objForm1);

        dealer__Deal_Form__c objDealForm = new dealer__Deal_Form__c(dealer__Deal__c = objDeal.id, dealer__Form__c = objForm.Id);
        insert objDealForm;
        
        dealer__Deal_Form__c objDealForm1 = new dealer__Deal_Form__c(dealer__Deal__c = objDeal.id, dealer__Form__c = objForm1.Id);
        insert objDealForm1;
        
        dealer__Discount_Rebate__c objDiscount = new dealer__Discount_Rebate__c(dealer__Type__c = 'Coupon', dealer__Desc__c = 'Test Description', dealer__Amount__c = 155462, dealer__Gross__c = 'FE', dealer__Taxable__c = true);
        insert objDiscount;

        Test.startTest();
            ApexPages.currentPage().getParameters().put('filter[filters][0][field]', objPartsKit.dealer__Description__c);
        ApexPages.currentPage().getParameters().put('filter[filters][0][value]', 'ABC');
        objDealController.getFilters();
        objDealController.getFilterMap();
        objDealController.getUserReadLookup();
        ApexPages.currentPage().getParameters().put('custid', objDeal.Id);
        objDealController.getUserReadLookup();
        ApexPages.currentPage().getParameters().put('filter[filters][0][value]', '');
        objDealController.getUserRead();
        ApexPages.currentPage().getParameters().put('filter[filters][0][value]', 'ABC');
        objDealController.getUserRead();
        objDealController.getUserReadById();
        ApexPages.currentPage().getParameters().put('custid', '');
        objDealController.getUserReadById();
        ApexPages.currentPage().getParameters().put('filter[filters][0][value]', '');
        objDealController.getLocationReadLookup();
        ApexPages.currentPage().getParameters().put('custid', objLocation.Id);
        objDealController.getLocationReadLookup();
        ApexPages.currentPage().getParameters().put('filter[filters][0][value]', 'ABC');
        objDealController.getLocationReadLookup();
        objDealController.getLocationRead();
        ApexPages.currentPage().getParameters().put('filter[filters][0][value]', 'ABC');
        objDealController.getLocationRead();
        ApexPages.currentPage().getParameters().put('custid', '');
        objDealController.getLocationRead();
        objDealController.getLocationReadById();
        ApexPages.currentPage().getParameters().put('custid', objLocation.Id);
        objDealController.getLocationReadById();
        objDealController.getImageVehicle();
        objDealController.getVehicleReadLookup();
        ApexPages.currentPage().getParameters().put('custid', '');
        objDealController.getVehicleReadLookup();
        ApexPages.currentPage().getParameters().put('custid', objDeal.Id);
        objDealController.getVehicleReadLookup();
        objDealController.getVehicleRead();
        ApexPages.currentPage().getParameters().put('filter[filters][0][value]', '');
        objDealController.getVehicleRead();
        ApexPages.currentPage().getParameters().put('custid', '');
        objDealController.getVehicleReadById();
        ApexPages.currentPage().getParameters().put('custid', objDeal.Id);
        objDealController.getVehicleReadById();
        Test.stopTest();

    }
    static testMethod void testFees() {

        dealer.TestClassUtil testutil = new dealer.TestClassUtil();
        testutil.insertDMSSettings();

        List < SObject > sObjectList = new List < SObject > ();
        List < User > userList = new List < User > ();
        List < dealer__Form__c > formsList = new List < dealer__Form__c > ();
        Profile objProfile = [SELECT Id From Profile WHERE Name = 'Standard User'];

        User objUser = new User(Alias = 'newUser',
            Division = 'CR9',
            Email = 'newuser1234@testorg.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US', // changed for to avoid: INVALID_OR_NULL_FOR_RESTRICTED_PICKLIST, Locale: bad value for restricted picklist field: America/Los_Angeles
            UserName = 'newuser12344@testorg.com',
            ProfileId = objProfile.Id,
            TimeZoneSidKey = 'America/Los_Angeles');
        insert objUser;

        userList = [select id, Name from User where id =: objUser.id];

        Document document = new Document();
        document.Body = Blob.valueOf('Some Text');
        document.ContentType = 'image/png';
        document.DeveloperName = 'InvoiceLogo';
        document.IsPublic = true;
        document.Name = 'InvoiceLogo';
        document.FolderId = objUser.id;
        insert document;

        Account objAccount = new Account();
        objAccount.FirstName = 'Test Account';
        objAccount.MiddleName = 'Test Account';
        objAccount.LastName = 'Test Account';
        objAccount.Phone = '13256446';
        objAccount.PersonMobilePhone = '65666871';
        objAccount.PersonMobilePhone = 'test@demo.com';
        objAccount.BillingCountry = 'CA';
        objAccount.BillingStreet = 'street';
        objAccount.BillingCity = 'city';
        objAccount.BillingState = 'State';
        objAccount.BillingPostalCode = '151656';
        objAccount.dealer__Active__c = 'Yes';
        objAccount.dealer__Vendor__c = true;
        objAccount.dealer__Tax_ID__c = '21132sdf';
        insert objAccount;

        Contact objContact = new Contact(LastName = 'TestContact');
        insert objContact;

        dealer__Appraisal_Vehicle__c objAppraisalVehicle = new dealer__Appraisal_Vehicle__c(dealer__Make__c = '2016');
        insert objAppraisalVehicle;
        sObjectList.add(objAppraisalVehicle);
        
        dealer__Appraisal_Vehicle__c objAppraisalVehicle1 = new dealer__Appraisal_Vehicle__c(dealer__Make__c = '2015');
        insert objAppraisalVehicle1;
        sObjectList.add(objAppraisalVehicle1);

        dealer__Finance_Company__c objFinanceCompany = new dealer__Finance_Company__c(Name = 'Test Finance');
        insert objFinanceCompany;

        dealer__Dealer_Location__c objLocation = new dealer__Dealer_Location__c(Name = 'Test Location', dealer__City__c = 'City', dealer__Company_Number__c = '561', dealer__Postal_Code__c = 'Code', dealer__State__c = 'ST');
        objLocation.dealer__Deal_Fees__c = '[{"feeName":"Fee1","feeDescription":"asdflasdf","feeDefaultAmount":5,"feeDefaultOnDeals":true,"feeTaxable":true},{"feeName":"Fee2","feeDescription":"asdflasdf","feeDefaultAmount":5,"feeDefaultOnDeals":true,"feeTaxable":true,"unkknown_key_value_pair":false}]';
        insert objLocation;

        dealer__Deal__c objDeal = new dealer__Deal__c(Name = 'Test', dealer__Deal_ID__c = 'a0B61000001w9kC', dealer__Buyer__c = objAccount.Id, dealer__Status__c = 'Pending', dealer__Buyer_Address__c = 'Address', dealer__Buyer_City__c = 'City',
            /*dealer__Vehicle__c = objVehicleInventory.Id,*/
            dealer__Buyer_County__c = 'Country', dealer__Buyer_Email__c = 'test@demo.com', dealer__Buyer_Postal_Code__c = '96002', dealer__Buyer_State__c = 'State',
            dealer__Buyer_Mobile_Phone__c = '1656566', dealer__Buyer_Home_Phone__c = '55666454', dealer__Co_Buyer__c = objAccount.Id, dealer__Co_Buyer_Address__c = 'Address',
            dealer__Conversion_Price__c = 1656516, dealer__Co_Buyer_City__c = 'City', dealer__Co_Buyer_County__c = 'Country', dealer__Co_Buyer_Email__c = 'test@demo.com', dealer__Co_Buyer_Home_Phone__c = '651656',
            dealer__Co_Buyer_Mobile_Phone__c = '16516565', dealer__Co_Buyer_State__c = 'State', dealer__Co_Buyer_Postal_Code__c = '96002', dealer__Delivery_Date__c = System.Today(), dealer__Business_Department__c = 'Business',
            dealer__Deal_Date__c = system.today(), dealer__Deal_Close_Date__c = system.today(), dealer__Broker__c = objAccount.Id, dealer__Broker_Address__c = 'Address', dealer__Broker_City__c = 'City',
            dealer__Broker_County__c = 'Country', dealer__Broker_Postal_Code__c = 'Code', dealer__Broker_State__c = 'State', dealer__Business_Title__c = 'Title', dealer__Business_Address__c = 'Address',
            dealer__Business_Phone__c = '16656545', dealer__Business_Contracting_Name__c = 'Business', dealer__Business_City__c = 'City', dealer__Business_State__c = 'State', dealer__Business_Postal_Code__c = 'Code',
            dealer__Business_County__c = 'Country', dealer__Business_Email__c = 'test@demo.com', dealer__Desk_Manager__c = UserInfo.getUserId(),
            /*dealer__DeliveryRepairOrder__c = objServiceRepair.Id,*/
            dealer__Finance_Institution_Account__c = objFinanceCompany.Id, dealer__Term__c = 10, dealer__Days_to_First__c = 124, dealer__Payments_Per_Year__c = 6565,
            dealer__Rate__c = 80, dealer__Amt_Financed__c = 51156, dealer__Monthly_Pymt__c = 44554, dealer__F_I_Manager__c = USerInfo.getUserId(), dealer__Store_Location__c = objLocation.Id, dealer__Auto_Insurance_Phone__c = '65165165',
            dealer__Co_Buyer_Work_Phone__c = '545455', dealer__Salesperson_1__c = UserInfo.getUserId(), dealer__Salesperson_2__c = UserInfo.getUserId(), dealer__Service_Manager__c = UserInfo.getUserId(),
            dealer__Delivery_City__c = 'City', dealer__Delivery_Phone__c = '516566', dealer__Delivery_State__c = 'State', dealer__Delivery_Postal_Code__c = 96002, dealer__Delivery_Mobile__c = '455566', dealer__Delivery_County__c = 'Country',
            dealer__Delivery_Notes__c = 'Notes', dealer__Delivery_Email__c = 'test@demo.com', dealer__Delivery_Street__c = 'Street', dealer__Vehicle_Conversion_Gross__c = 6266566, dealer__Vehicle_Gross__c = 5516566,
            dealer__Deferred_1_Payee__c = objAccount.Id,
            dealer__Deferred_2_Payee__c = objAccount.Id, dealer__Deferred_3_Payee__c = objAccount.Id, dealer__Deferred_Date_1__c = System.Today(), dealer__Deferred_Date_2__c = System.Today(), dealer__Deferred_Date_3__c = System.Today(),
            dealer__Deferred_Down_1__c = 51665, dealer__Deferred_Down_2__c = 65655, dealer__Deferred_Down_3__c = 54555, dealer__Deferred_Note_1__c = 'Note 2', dealer__Deferred_Note_2__c = 'Note 2', dealer__Deferred_Note_3__c = 'Note 3',
            dealer__GVWR__c = 0, dealer__Doc_Fee__c = 445, dealer__License_Fee__c = 55668, dealer__Registration_Title_Fee__c = 45416, dealer__Electronic_Filing_Fee__c = 55999, dealer__Tire_Fee__c = 55598,
            dealer__Smog_Cert__c = 54544);
        insert objDeal;
        
        dealer__Trade_In__c objTradeIn = new dealer__Trade_In__c(dealer__Car_Deal__c = objDeal.Id, dealer__ACV__c = 50.50, Name = 'Test', dealer__Pay_Off_Amount__c = 16565, dealer__Appraisal_Vehicle__c = objAppraisalVehicle.Id,
            dealer__Year__c = '2016', dealer__Make__c = '2016', dealer__Model__c = 'Merc', dealer__VIN__c = 'd1fs36', dealer__Lost_Trade__c = true, dealer__Net__c = 155616,
            dealer__Odometer_at_Trade_In__c = 156, dealer__Pay_Off_Account__c = objAccount.Id, dealer__Trade_Allowance__c = 73254, dealer__Pay_Off_Account_Number__c = 'TestAmount',
            dealer__Pay_Off_Expiration_Date__c = System.Today());
        insert objTradeIn;

        dealer__Service_Contract__c objService = new dealer__Service_Contract__c(dealer__Car_Deal__c = objDeal.Id, dealer__Company_Number__c = 'Location 1', dealer__Contract_Template__c = true, dealer__Cost__c = 66656, dealer__Customer_Contact__c = objContact.Id,
            dealer__Customer__c = objAccount.Id, dealer__Deductable__c = 56565, dealer__Description__c = 'Test Desc', dealer__Taxable__c = true, dealer__Printable__c = true, dealer__End_Date__c = System.Today(),
            dealer__Expiration_Mileage__c = 56662, dealer__Expiration_Months__c = 562, dealer__Odometer_at_Sale__c = 32266, dealer__Order__c = 1656556, dealer__Plan_Code__c = 'Test Plan', dealer__Product_Code__c = 'Product Code',
            dealer__Sale_Price__c = 156615, /*dealer__Service_Vehicle__c = objServiceVehicle.Id,*/ dealer__Start_Date__c = System.Today(), dealer__Type__c = 'GAP' /*,dealer__Vehicle_Inventory__c = objVehicleInventory.Id*/ );
        insert objService;

        dealer__Parts_Kit__c objPartsKit = new dealer__Parts_Kit__c(Name = 'Test Part', dealer__Description__c = 'Test');
        insert objPartsKit;

        dealer__Kit_Category__c objKitCategory = new dealer__Kit_Category__c(Name = 'Kit Test');
        insert objKitCategory;

        dealer__Form__c objForm = new dealer__Form__c();
        objForm.name = 'TestForm';
        objForm.dealer__Impact_Code__c = 'Test Impact Code';
        objForm.dealer__Print_Type__c = 'Laser';
        insert objForm;
        formsList.add(objForm);
        
        dealer__Form__c objForm1 = new dealer__Form__c();
        objForm1.name = 'TestForm';
        objForm1.dealer__Impact_Code__c = 'Test Impact Code';
        objForm1.dealer__Print_Type__c = 'Impact';
        insert objForm1;
        formsList.add(objForm1);
        
        dealer__Deal_Form__c objDealForm = new dealer__Deal_Form__c(dealer__Deal__c = objDeal.id, dealer__Form__c = objForm.Id);
        insert objDealForm;
        
        dealer__Deal_Form__c objDealForm1 = new dealer__Deal_Form__c(dealer__Deal__c = objDeal.id, dealer__Form__c = objForm1.Id);
        insert objDealForm1;
        
        dealer__Discount_Rebate__c objDiscount = new dealer__Discount_Rebate__c(dealer__Type__c = 'Coupon', dealer__Desc__c = 'Test Description', dealer__Amount__c = 155462, dealer__Gross__c = 'FE', dealer__Taxable__c = true);
        insert objDiscount;
        
        
		PageReference trsPage = Page.DealTRS;
        Test.setCurrentPage(trsPage);
        
        ApexPages.currentPage().getParameters().put('id', objDeal.Id);
        ApexPages.currentPage().getParameters().put('dealer__Fee_Name__c[Name]', 'Tire Tax');
        ApexPages.currentPage().getParameters().put('dealer__Fee_Amount__c', '199');
        ApexPages.currentPage().getParameters().put('dealer__Fee_Code__c', 'a123');
        ApexPages.currentPage().getParameters().put('dealer__Taxable__c', 'true');
        ApexPages.currentPage().getParameters().put('dealer__Description__c', 'State required tire tax');
        ApexPages.currentPage().getParameters().put('dealer__Default_Amount_Formula_Field__c', 'dealer__Standard_Tax__c');
        
        
        //DealTRSController.createDefaultFees(new List<dealer__Deal__c>{objDeal});
        DealTRSController objDealStandardController = new DealTRSController();        
        Test.startTest();
        objDealStandardController.getFeeTemplates();
        objDealStandardController.getDealFees();
        objDealStandardController.createFee();
        objDealStandardController.updateDealFeeTotal(objDeal.Id);
        
        FeeMaster__c fm = new FeeMaster__c(Name='test', InvoiceType__c='dealer__Deal__c');
		insert fm;
		LocationFee__c lFee = new LocationFee__c(Location__c=objLocation.Id, FEeMaster__c = fm.Id, DefaultOnInvoice__c=true, DefaultPrice__c = '100', DefaultCost__c = '100', InvoiceType__c='dealer__Deal__c', Taxable__c=true,Active__c=true, Description__c ='test');
		insert lFee;

        DealTRSController.refreshDefaultFees(objDeal.Id);
        
        //objDealStandardController.getDealFees();
        Test.stopTest();
        // Update Fee
        List < dealer__Sales_Fee__c > fees = [SELECT Id FROM dealer__Sales_Fee__c WHERE dealer__Car_Deal__c =:objDeal.Id];
        ApexPages.currentPage().getParameters().put('Id', fees[0].Id);
        ApexPages.currentPage().getParameters().put('dealer__Fee_Amount__c', '210');
        objDealStandardController.updateFee();
        
        // Delete Fee
        ApexPages.currentPage().getParameters().put('dealId', objDeal.Id);
		objDealStandardController.destroyFee();
        
    }
    
    static testMethod void testCashierMethods() {
        
        dealer.TestClassUtil testutil = new dealer.TestClassUtil();
        testutil.insertDMSSettings();

        List < SObject > sObjectList = new List < SObject > ();
        List < User > userList = new List < User > ();
        List < dealer__Form__c > formsList = new List < dealer__Form__c > ();
        Profile objProfile = [SELECT Id From Profile WHERE Name = 'Standard User'];
        
        dealer__Dealer_Location__c objLocation = new dealer__Dealer_Location__c(Name = 'Test Location', dealer__City__c = 'City', dealer__Company_Number__c = '561', dealer__Postal_Code__c = 'Code', dealer__State__c = 'ST');
        objLocation.dealer__Deal_Fees__c = '[    {       "feeName":"Fee1",       "feeDescription":"asdflasdf",       "feeDefaultAmount":5,       "feeDefaultOnDeals":true,       "feeTaxable":true     },     {       "feeName":"Fee2",       "feeDescription":"asdflasdf",       "feeDefaultAmount":5,       "feeDefaultOnDeals":true,       "feeTaxable":true,       "bullshit":false     } ]';
        insert objLocation; 

        User objUser = new User(Alias = 'newUser',
            Division = '561',
            Email = 'newuser1234@testorg.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US', // changed for to avoid: INVALID_OR_NULL_FOR_RESTRICTED_PICKLIST, Locale: bad value for restricted picklist field: America/Los_Angeles
            UserName = 'newuser12345555@testorg.com',
            ProfileId = objProfile.Id,
            TimeZoneSidKey = 'America/Los_Angeles');
        insert objUser;  

        Account objAccount = new Account();
        objAccount.FirstName = 'Test Account';
        objAccount.MiddleName = 'Test Account';
        objAccount.LastName = 'Test Account';
        objAccount.Phone = '13256446';
        objAccount.PersonMobilePhone = '65666871';
        objAccount.PersonMobilePhone = 'test@demo.com';
        objAccount.BillingCountry = 'CA';
        objAccount.BillingStreet = 'street';
        objAccount.BillingCity = 'city';
        objAccount.BillingState = 'State';
        objAccount.BillingPostalCode = '151656';
        objAccount.dealer__Active__c = 'Yes';
        objAccount.dealer__Vendor__c = true;
        objAccount.dealer__Tax_ID__c = '21132sdf';
        insert objAccount;

		dealer__Deal__c deal = new dealer__Deal__c(Name='TestDeal', dealer__Deal_ID__c='DealID3', dealer__Store_Location__c=objLocation.Id, dealer__Buyer__c=objAccount.Id);        
        insert deal;
        
		PageReference trsPage = Page.DealTRS;
        Test.setCurrentPage(trsPage);
        
        ApexPages.currentPage().getParameters().put('dealId', deal.Id);
        ApexPages.currentPage().getParameters().put('dealer__Payment_Method__c', 'Cash');
        ApexPages.currentPage().getParameters().put('dealer__Amount__c', '199');
        ApexPages.currentPage().getParameters().put('dealer__Description__c', 'Cash Receipt');
        ApexPages.currentPage().getParameters().put('dealer__Credit_Card_Authorization_Code__c', 'A-0000');
        ApexPages.currentPage().getParameters().put('dealer__Customer__c[Id]', objAccount.Id);
            
        DealTRSController objDealStandardController = new DealTRSController();         

        objDealStandardController.createCashierEntry();
        ApexPages.currentPage().getParameters().put('id',[SELECT Id From dealer__Cashering__c LIMIT 1].Id);
        objDealStandardController.updateCashierEntry();
        
        ApexPages.currentPage().getParameters().put('recordId',[SELECT Id From dealer__Cashering__c LIMIT 1].Id);
        objDealStandardController.getCashierAccountRead();
        ApexPages.currentPage().getParameters().put('filter[filters][0][value]','a123');
        objDealStandardController.getCashierAccountRead();
        objDealStandardController.deleteCashierEntry();
        

    }
    
    static testmethod void testBOS() {
        Profile objProfile = [SELECT Id From Profile WHERE Name = 'Standard User'];
        User objUser = new User(Alias = 'newUser',
            Division = 'CR9',
            Email = 'newuser1234@testorg.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US', // changed for to avoid: INVALID_OR_NULL_FOR_RESTRICTED_PICKLIST, Locale: bad value for restricted picklist field: America/Los_Angeles
            UserName = 'newuser12346@testorg.com',
            ProfileId = objProfile.Id,
            TimeZoneSidKey = 'America/Los_Angeles');
        insert objUser;

        Document document = new Document();
        document.Body = Blob.valueOf('Some Text');
        document.ContentType = 'image/png';
        document.DeveloperName = 'InvoiceLogo';
        document.IsPublic = true;
        document.Name = 'InvoiceLogo';
        document.FolderId = objUser.id;
        insert document;

        Account objAccount = new Account(FirstName='Bill', LastName='Thomas');
        insert objAccount;

        dealer__Finance_Company__c objFinanceCompany = new dealer__Finance_Company__c(Name = 'Test Finance');
        insert objFinanceCompany;

        dealer__Dealer_Location__c objLocation = new dealer__Dealer_Location__c(Name = 'Test Location', dealer__City__c = 'City', dealer__Company_Number__c = '561', dealer__Postal_Code__c = 'Code', dealer__State__c = 'ST');
        objLocation.dealer__Deal_Fees__c = '[    {       "feeName":"Fee1",       "feeDescription":"asdflasdf",       "feeDefaultAmount":5,       "feeDefaultOnDeals":true,       "feeTaxable":true     },     {       "feeName":"Fee2",       "feeDescription":"asdflasdf",       "feeDefaultAmount":5,       "feeDefaultOnDeals":true,       "feeTaxable":true,       "bullshit":false     } ]';
        insert objLocation;

        dealer__Deal__c objDeal = new dealer__Deal__c(Name = 'Test', dealer__Deal_ID__c = 'a0B61000001w9kC', dealer__Buyer__c = objAccount.Id, dealer__Status__c = 'Pending', dealer__Buyer_Address__c = 'Address', dealer__Buyer_City__c = 'City',
            /*dealer__Vehicle__c = objVehicleInventory.Id,*/
            dealer__Buyer_County__c = 'Country', dealer__Buyer_Email__c = 'test@demo.com', dealer__Buyer_Postal_Code__c = '96002', dealer__Buyer_State__c = 'State',
            dealer__Buyer_Mobile_Phone__c = '1656566', dealer__Buyer_Home_Phone__c = '55666454', dealer__Co_Buyer__c = objAccount.Id, dealer__Co_Buyer_Address__c = 'Address',
            dealer__Conversion_Price__c = 1656516, dealer__Co_Buyer_City__c = 'City', dealer__Co_Buyer_County__c = 'Country', dealer__Co_Buyer_Email__c = 'test@demo.com', dealer__Co_Buyer_Home_Phone__c = '651656',
            dealer__Co_Buyer_Mobile_Phone__c = '16516565', dealer__Co_Buyer_State__c = 'State', dealer__Co_Buyer_Postal_Code__c = '96002', dealer__Delivery_Date__c = System.Today(), dealer__Business_Department__c = 'Business',
            dealer__Deal_Date__c = system.today(), dealer__Deal_Close_Date__c = system.today(), dealer__Broker__c = objAccount.Id, dealer__Broker_Address__c = 'Address', dealer__Broker_City__c = 'City',
            dealer__Broker_County__c = 'Country', dealer__Broker_Postal_Code__c = 'Code', dealer__Broker_State__c = 'State', dealer__Business_Title__c = 'Title', dealer__Business_Address__c = 'Address',
            dealer__Business_Phone__c = '16656545', dealer__Business_Contracting_Name__c = 'Business', dealer__Business_City__c = 'City', dealer__Business_State__c = 'State', dealer__Business_Postal_Code__c = 'Code',
            dealer__Business_County__c = 'Country', dealer__Business_Email__c = 'test@demo.com', dealer__Desk_Manager__c = UserInfo.getUserId(),
            /*dealer__DeliveryRepairOrder__c = objServiceRepair.Id,*/
            dealer__Finance_Institution_Account__c = objFinanceCompany.Id, dealer__Term__c = 10, dealer__Days_to_First__c = 124, dealer__Payments_Per_Year__c = 6565,
            dealer__Rate__c = 80, dealer__Amt_Financed__c = 51156, dealer__Monthly_Pymt__c = 44554, dealer__F_I_Manager__c = USerInfo.getUserId(), dealer__Store_Location__c = objLocation.Id, dealer__Auto_Insurance_Phone__c = '65165165',
            dealer__Co_Buyer_Work_Phone__c = '545455', dealer__Salesperson_1__c = UserInfo.getUserId(), dealer__Salesperson_2__c = UserInfo.getUserId(), dealer__Service_Manager__c = UserInfo.getUserId(),
            dealer__Delivery_City__c = 'City', dealer__Delivery_Phone__c = '516566', dealer__Delivery_State__c = 'State', dealer__Delivery_Postal_Code__c = 96002, dealer__Delivery_Mobile__c = '455566', dealer__Delivery_County__c = 'Country',
            dealer__Delivery_Notes__c = 'Notes', dealer__Delivery_Email__c = 'test@demo.com', dealer__Delivery_Street__c = 'Street', dealer__Vehicle_Conversion_Gross__c = 6266566, dealer__Vehicle_Gross__c = 5516566,
            dealer__Deferred_1_Payee__c = objAccount.Id,
            dealer__Deferred_2_Payee__c = objAccount.Id, dealer__Deferred_3_Payee__c = objAccount.Id, dealer__Deferred_Date_1__c = System.Today(), dealer__Deferred_Date_2__c = System.Today(), dealer__Deferred_Date_3__c = System.Today(),
            dealer__Deferred_Down_1__c = 51665, dealer__Deferred_Down_2__c = 65655, dealer__Deferred_Down_3__c = 54555, dealer__Deferred_Note_1__c = 'Note 2', dealer__Deferred_Note_2__c = 'Note 2', dealer__Deferred_Note_3__c = 'Note 3',
            dealer__GVWR__c = 0, dealer__Doc_Fee__c = 445, dealer__License_Fee__c = 55668, dealer__Registration_Title_Fee__c = 45416, dealer__Electronic_Filing_Fee__c = 55999, dealer__Tire_Fee__c = 55598,
            dealer__Smog_Cert__c = 54544);
        insert objDeal;

        // Test BOS
        ApexPages.StandardController sc = new ApexPages.StandardController(objDeal);
        ApexPages.currentPage().getParameters().put('id', objDeal.id);
        DealForm_EXT mob = new DealForm_EXT(new ApexPages.StandardController(objDeal));
        DealForm_EXT mobNoArgs = new DealForm_EXT();
        mob.getInvoiceLogo();
        
        List<dealer__After_Market__c> selectedKits = mob.selectedKits;
        List<dealer__Trade_In__c> tradeInList = mob.tradeInList;

        Decimal totalTradeGross = mob.getTotalTradeGross();        
    }

    static testMethod void validateDealTRSController1() {

        dealer.TestClassUtil testutil = new dealer.TestClassUtil();
        testutil.insertDMSSettings();

        // Insert Tax Region
        // SELECT Id, dealer__JurisdictionType__c, dealer__MaxTaxableAmount__c, dealer__MinTaxableAmount__c, dealer__ParentRegion__c, dealer__Rate_Type__c, dealer__Rate__c, dealer__RegionCode__c, Name FROM dealer__Tax_Region__c
        Tax_Region__c region = new Tax_Region__c(
            dealer__JurisdictionType__c='State',
            dealer__Rate_Type__c='General',
            dealer__Rate__c=5.0,
            dealer__RegionCode__c='CA'
        );

        insert region;

        // Insert Tax Zone
        // SELECT Id, dealer__City__c, dealer__Common_Name__c, dealer__County__c, dealer__Effective_Date__c, dealer__Expires_Date__c, dealer__Postal_Code__c, dealer__Rate__c, dealer__State__c FROM dealer__Tax_Zones__c
        Tax_Zones__c tz = new Tax_Zones__c(
            dealer__City__c='Redding',
            dealer__County__c='Shasta',
            dealer__Postal_Code__c='96001',
            dealer__Rate__c=7.25,
            dealer__State__c='CA'
        ); 

        insert tz;

        // Insert Junction
        // SELECT Id, dealer__TaxRegion__c, dealer__TaxZone__c FROM dealer__TaxJunction__c
        insert new TaxJunction__c(
            dealer__TaxRegion__c=region.Id,
            dealer__TaxZone__c=tz.Id
        );    

        List < SObject > sObjectList = new List < SObject > ();
        List < User > userList = new List < User > ();
        List < dealer__Form__c > formsList = new List < dealer__Form__c > ();
        Profile objProfile = [SELECT Id From Profile WHERE Name = 'Standard User'];

        User objUser = new User(Alias = 'newUser',
            Division = 'CR9',
            Email = 'newuser1234@testorg.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US', // changed for to avoid: INVALID_OR_NULL_FOR_RESTRICTED_PICKLIST, Locale: bad value for restricted picklist field: America/Los_Angeles
            UserName = 'newuser12347@testorg.com',
            ProfileId = objProfile.Id,
            TimeZoneSidKey = 'America/Los_Angeles');
        insert objUser;
        userList = [select id, Name from User where id =: objUser.id];


        Document document = new Document();
        document.Body = Blob.valueOf('Some Text');
        document.ContentType = 'image/png';
        document.DeveloperName = 'InvoiceLogo';
        document.IsPublic = true;
        document.Name = 'InvoiceLogo';
        document.FolderId = objUser.id;
        insert document;

        //System.runAs(new user(ID = UserInfo.getUserID())){

        Account objAccount = new Account();
        objAccount.FirstName = 'Test Account';
        objAccount.MiddleName = 'Test Account';
        objAccount.LastName = 'Test Account';
        objAccount.Phone = '13256446';
        objAccount.PersonMobilePhone = '65666871';
        objAccount.PersonMobilePhone = 'test@demo.com';
        objAccount.BillingCountry = 'CA';
        objAccount.BillingStreet = 'street';
        objAccount.BillingCity = 'city';
        objAccount.BillingState = 'State';
        objAccount.BillingPostalCode = '151656';
        objAccount.dealer__Active__c = 'Yes';
        objAccount.dealer__Vendor__c = true;
        objAccount.dealer__Tax_ID__c = '21132sdf';
        objAccount.dealer__Drivers_License_Number__pc = '21';
        objAccount.dealer__Drivers_License_Expiration_Date__pc = System.today();
        insert objAccount;

        Account objCoBuyer = new Account();
        objCoBuyer.FirstName = 'Jarrett';
        objCoBuyer.LastName = 'Johnson';
        insert objCoBuyer;
        

        Contact objContact = new Contact(LastName = 'TestContact');
        insert objContact;

        dealer__Appraisal_Vehicle__c objAppraisalVehicle = new dealer__Appraisal_Vehicle__c(dealer__Make__c = '2016');
        insert objAppraisalVehicle;
        sObjectList.add(objAppraisalVehicle);
        
        dealer__Appraisal_Vehicle__c objAppraisalVehicle1 = new dealer__Appraisal_Vehicle__c(dealer__Make__c = '2015');
        insert objAppraisalVehicle1;
        sObjectList.add(objAppraisalVehicle1);
        
        /*dealer__Vehicle_Inventory__c objVehicleInventory = new dealer__Vehicle_Inventory__c(Name = 'Test Vehicle',dealer__Exterior_Color__c = 'Exterior',dealer__Vehicle_Type__c = 'Vehicle Type',dealer__Coded_Cost__c = 54542,dealer__Mileage__c = 54545,dealer__VIN__c = 'dvs65b65',
                                                           dealer__Trim_Level__c = 'Trim Level',dealer__Invoice_Price__c = 113363,dealer__Conversion_Cost__c = 515656,dealer__Status_Code__c = 'Detail',dealer__Model_Code__c = 'Model Code',dealer__MV_Ranp_Operation__c = 'Automatic',
                                                           dealer__MV_Ramp_Type__c = 'In Floor',dealer__Ramp_Location__c = 'Rear Entry',dealer__Work_in_Process__c = 165656,dealer__Year__c = '2016',dealer__Make__c = 'Make',dealer__Model__c = 'ds2d33232',dealer__Vehicle_Cost__c = 561655,
                                                           dealer__Purchase_Price__c = 511123,dealer__Conversion_Price__c = 6156565,dealer__New_Used_Other__c=true);
        insert objVehicleInventory;

        dealer__Service_Repair_Order__c objServiceRepair = new dealer__Service_Repair_Order__c(Name = 'Test Repair');
        insert objServiceRepair;*/

        dealer__Finance_Company__c objFinanceCompany = new dealer__Finance_Company__c(Name = 'Test Finance');
        insert objFinanceCompany;

        dealer__Dealer_Location__c objLocation = new dealer__Dealer_Location__c(Name = 'Test Location', dealer__City__c = 'City', dealer__Company_Number__c = '561', dealer__Postal_Code__c = 'Code', dealer__State__c = 'ST');
        insert objLocation;

        dealer__Deal__c objDeal = new dealer__Deal__c(Name = 'Test', dealer__Deal_ID__c = 'a0B61000001w9kC', dealer__Buyer__c = objAccount.Id, dealer__Status__c = 'Pending', dealer__Buyer_Address__c = 'Address', dealer__Buyer_City__c = 'City',
            //dealer__Vehicle__c = objVehicleInventory.Id,
            dealer__Buyer_County__c = 'Country', dealer__Buyer_Email__c = 'test@demo.com', dealer__Buyer_Postal_Code__c = '96002', dealer__Buyer_State__c = 'State',
            dealer__Buyer_Mobile_Phone__c = '1656566', dealer__Buyer_Home_Phone__c = '55666454', dealer__Co_Buyer__c = objAccount.Id, dealer__Co_Buyer_Address__c = 'Address',
            dealer__Conversion_Price__c = 1656516, dealer__Co_Buyer_City__c = 'City', dealer__Co_Buyer_County__c = 'Country', dealer__Co_Buyer_Email__c = 'test@demo.com', dealer__Co_Buyer_Home_Phone__c = '651656',
            dealer__Co_Buyer_Mobile_Phone__c = '16516565', dealer__Co_Buyer_State__c = 'State', dealer__Co_Buyer_Postal_Code__c = '96002', dealer__Delivery_Date__c = System.Today(), dealer__Business_Department__c = 'Business',
            dealer__Deal_Date__c = system.today(), dealer__Deal_Close_Date__c = system.today(), dealer__Broker__c = objAccount.Id, dealer__Broker_Address__c = 'Address', dealer__Broker_City__c = 'City',
            dealer__Broker_County__c = 'Country', dealer__Broker_Postal_Code__c = 'Code', dealer__Broker_State__c = 'State', dealer__Business_Title__c = 'Title', dealer__Business_Address__c = 'Address',
            dealer__Business_Phone__c = '16656545', dealer__Business_Contracting_Name__c = 'Business', dealer__Business_City__c = 'City', dealer__Business_State__c = 'State', dealer__Business_Postal_Code__c = 'Code',
            dealer__Business_County__c = 'Country', dealer__Business_Email__c = 'test@demo.com', dealer__Desk_Manager__c = UserInfo.getUserId(),
            /*dealer__DeliveryRepairOrder__c = objServiceRepair.Id,*/
            dealer__Finance_Institution_Account__c = objFinanceCompany.Id, dealer__Term__c = 10, dealer__Days_to_First__c = 124, dealer__Payments_Per_Year__c = 6565,
            dealer__Rate__c = 80, dealer__Amt_Financed__c = 51156, dealer__Monthly_Pymt__c = 44554, dealer__F_I_Manager__c = USerInfo.getUserId(), dealer__Store_Location__c = objLocation.Id, dealer__Auto_Insurance_Phone__c = '65165165',
            dealer__Co_Buyer_Work_Phone__c = '545455', dealer__Salesperson_1__c = UserInfo.getUserId(), dealer__Salesperson_2__c = UserInfo.getUserId(), dealer__Service_Manager__c = UserInfo.getUserId(),
            dealer__Delivery_City__c = 'City', dealer__Delivery_Phone__c = '516566', dealer__Delivery_State__c = 'State', dealer__Delivery_Postal_Code__c = 96002, dealer__Delivery_Mobile__c = '455566', dealer__Delivery_County__c = 'Country',
            dealer__Delivery_Notes__c = 'Notes', dealer__Delivery_Email__c = 'test@demo.com', dealer__Delivery_Street__c = 'Street', dealer__Vehicle_Conversion_Gross__c = 6266566, dealer__Vehicle_Gross__c = 5516566,
            dealer__Deferred_1_Payee__c = objAccount.Id,
            dealer__Deferred_2_Payee__c = objAccount.Id, dealer__Deferred_3_Payee__c = objAccount.Id, dealer__Deferred_Date_1__c = System.Today(), dealer__Deferred_Date_2__c = System.Today(), dealer__Deferred_Date_3__c = System.Today(),
            dealer__Deferred_Down_1__c = 51665, dealer__Deferred_Down_2__c = 65655, dealer__Deferred_Down_3__c = 54555, dealer__Deferred_Note_1__c = 'Note 2', dealer__Deferred_Note_2__c = 'Note 2', dealer__Deferred_Note_3__c = 'Note 3',
            dealer__GVWR__c = 56656, dealer__Doc_Fee__c = 445, dealer__License_Fee__c = 55668, dealer__Registration_Title_Fee__c = 45416, dealer__Electronic_Filing_Fee__c = 55999, dealer__Tire_Fee__c = 55598,
            dealer__Smog_Cert__c = 54544);
        insert objDeal;
        
        dealer__Trade_In__c objTradeIn = new dealer__Trade_In__c(dealer__Car_Deal__c = objDeal.Id, dealer__ACV__c = 50.50, Name = 'Test', dealer__Pay_Off_Amount__c = 16565, dealer__Appraisal_Vehicle__c = objAppraisalVehicle.Id,
            dealer__Year__c = '2016', dealer__Make__c = '2016', dealer__Model__c = 'Merc', dealer__VIN__c = 'd1fs36', dealer__Lost_Trade__c = true, dealer__Net__c = 155616,
            dealer__Odometer_at_Trade_In__c = 156, dealer__Pay_Off_Account__c = objAccount.Id, dealer__Trade_Allowance__c = 73254, dealer__Pay_Off_Account_Number__c = 'TestAmount',
            dealer__Pay_Off_Expiration_Date__c = System.Today());
        insert objTradeIn;

        /*dealer__Service_Vehicle__c objServiceVehicle = new dealer__Service_Vehicle__c(Name= 'Test Service');
        insert objServiceVehicle;*/

        dealer__Service_Contract__c objService = new dealer__Service_Contract__c(dealer__Car_Deal__c = objDeal.Id, dealer__Company_Number__c = 'Location 1', dealer__Contract_Template__c = true, dealer__Cost__c = 66656, dealer__Customer_Contact__c = objContact.Id,
            dealer__Customer__c = objAccount.Id, dealer__Deductable__c = 56565, dealer__Description__c = 'Test Desc', dealer__Taxable__c = true, dealer__Printable__c = true, dealer__End_Date__c = System.Today(),
            dealer__Expiration_Mileage__c = 56662, dealer__Expiration_Months__c = 562, dealer__Odometer_at_Sale__c = 32266, dealer__Order__c = 1656556, dealer__Plan_Code__c = 'Test Plan', dealer__Product_Code__c = 'Product Code',
            dealer__Sale_Price__c = 156615, /*dealer__Service_Vehicle__c = objServiceVehicle.Id,*/ dealer__Start_Date__c = System.Today(), dealer__Type__c = 'GAP' /*,dealer__Vehicle_Inventory__c = objVehicleInventory.Id*/ );
        insert objService;

        dealer__Parts_Kit__c objPartsKit = new dealer__Parts_Kit__c(Name = 'Test Part', dealer__Description__c = 'Test');
        insert objPartsKit;

        dealer__Kit_Category__c objKitCategory = new dealer__Kit_Category__c(Name = 'Kit Test');
        insert objKitCategory;

        /*dealer__After_Market__c objAfterMarket = new dealer__After_Market__c(dealer__Car_Deal__c = objDeal.Id, dealer__Cost__c = 51653, dealer__Description__c = 'Test description', Name = 'Test After',dealer__Taxable__c = true,dealer__Sale_Price__c = 165656, 
                                                 dealer__List_Price__c = 51651, dealer__Vendor__c = objAccount.Id,dealer__Manufacturer__c = 'Manufacturer 1',dealer__Quantity__c = 1655665,dealer__Company_Number__c = 'Location 1',dealer__Parts_Kit__c = objPartsKit.Id, 
                                                 dealer__Labor_Sale__c = 1323, dealer__Part_Cost__c = 45456,dealer__Type__c = 'Part Kit',dealer__Parts_Sale__c = 45566,dealer__Order__c = 565489,dealer__Kit_Notes__c = 'Notes',dealer__Printable__c = true,
                                                 dealer__Sub_Category__c = objKitCategory.Id,dealer__Category__c = objKitCategory.Id,dealer__Hours__c = 65115,dealer__Labor_Cost__c = 651656,dealer__Labor_Hours__c = 54565);
        insert objAfterMarket;*/

        dealer__Form__c objForm = new dealer__Form__c();
        objForm.name = 'TestForm';
        objForm.dealer__Impact_Code__c = 'Test Impact Code';
        objForm.dealer__Print_Type__c = 'Laser';
        insert objForm;
        formsList.add(objForm);
        
        dealer__Form__c objForm1 = new dealer__Form__c();
        objForm1.name = 'TestForm';
        objForm1.dealer__Impact_Code__c = 'Test Impact Code';
        objForm1.dealer__Print_Type__c = 'Impact';
        insert objForm1;
        formsList.add(objForm1);
        
        dealer__Deal_Form__c objDealForm = new dealer__Deal_Form__c(dealer__Deal__c = objDeal.id, dealer__Form__c = objForm.Id);
        insert objDealForm;
        
        dealer__Deal_Form__c objDealForm1 = new dealer__Deal_Form__c(dealer__Deal__c = objDeal.id, dealer__Form__c = objForm1.Id);
        insert objDealForm1;
        
        dealer__Discount_Rebate__c objDiscount = new dealer__Discount_Rebate__c(dealer__Type__c = 'Coupon', dealer__Desc__c = 'Test Description', dealer__Amount__c = 155462, dealer__Gross__c = 'FE', dealer__Taxable__c = true);
        insert objDiscount;

        ApexPages.currentPage().getParameters().put('id', objDeal.Id);
        ApexPages.currentPage().getParameters().put('action', 'dealer__Approval_Status__c');
        ApexPages.currentPage().getParameters().put('dealId', objDeal.Id);
        ApexPages.currentPage().getParameters().put('dealer__Form__c', objForm.Id);
        ApexPages.currentPage().getParameters().put('fieldName', 'dealer__Kit_Category__c');
        ApexPages.currentPage().getParameters().put('pageSize', '3');
        ApexPages.currentPage().getParameters().put('page', '1');
        ApexPages.currentPage().getParameters().put('formId', objForm.Id);

        //ApexPages.currentPage().getParameters().put('custid',objVehicleInventory.Id);

        string value = '';
        string type = '';
        string body = '';
        boolean isSave = true;

        

        DealTRSController objDealController = new DealTRSController();

        objDealController.getDealKeyPrefix();

        DealTRSController objDealStandardController = new DealTRSController(new ApexPages.StandardController(objDeal));
        objDealController.getSubmitApproval(); 
        objDealController.getActiveApproval();
        objDealController.getApprovalIsLocked();
        PageReference pageRefRefresh = objDealController.refreshButtonPanels();
        objDealController.getDealContentDocuments();
        objDealController.getApprovalHistory();

        PageReference pageRefRecall = objDealController.recallApprovalProcess();
        objDealController.getRecordIds(sObjectList);
        Test.startTest();
        objDealController.getFilters();
        objDealController.getFilterMap();
        ApexPages.currentPage().getParameters().put('custid', '');
        ApexPages.currentPage().getParameters().put('filter[filters][0][value]', '');
        ApexPages.currentPage().getParameters().put('filter[filters][0][value]', 'ABC');
        ApexPages.currentPage().getParameters().put('custid', objDeal.Id);
        objDealController.getAccountReadLookup();
        ApexPages.currentPage().getParameters().put('filter[filters][0][value]', '');
        objDealController.getAccountReadLookup();
        ApexPages.currentPage().getParameters().put('custid', '');
        objDealController.getAccountReadLookup();
        objDealController.getAccountRead();
        ApexPages.currentPage().getParameters().put('filter[filters][0][value]', 'ABC');
        objDealController.getAccountRead();
        objDealController.getAccountReadById();
        ApexPages.currentPage().getParameters().put('custid', objAccount.Id);
        objDealController.getAccountReadById();
        objDealController.getBuyerAccount();

        PageReference pageRefAction = objDealController.crudAction();

        
        objDealController.deleteLaserDealForm();
        objDealController.deleteImpactDealForm();
        objDealController.getSelectedForm();
        ApexPages.currentPage().getParameters().put('id', '');
        objDealController.getDeal();
        ApexPages.currentPage().getParameters().put('id', objDeal.Id);
        objDealController.getDeal();
        objDealController.getDealRecord();
        objDealController.getTradeIns();
        ApexPages.currentPage().getParameters().put('id', objTradeIn.Id);
        objDealController.updateTradeIn();
        ApexPages.currentPage().getParameters().put('id', '');
        objDealController.updateDeal();
        ApexPages.currentPage().getParameters().put('id', objDeal.Id);
        objDealController.updateDeal();

        ApexPages.currentPage().getParameters().put('id', '');
        objDealController.createTradeIn();
        ApexPages.currentPage().getParameters().put('id', objDeal.Id);
        ApexPages.currentPage().getParameters().put('dealer__ACV__c', '4000');
        ApexPages.currentPage().getParameters().put('dealer__Trade_Allowance__c', '4000');
        ApexPages.currentPage().getParameters().put('dealer__Recon__c', '1000');
        ApexPages.currentPage().getParameters().put('dealer__Pay_Off_Amount__c', '1000');
        ApexPages.currentPage().getParameters().put('dealer__Profit__c', '0');
        ApexPages.currentPage().getParameters().put('dealer__Net__c', '0');
        ApexPages.currentPage().getParameters().put('Name', 'Test Name');
        ApexPages.currentPage().getParameters().put('dealer__Car_Deal__c', objDeal.Id);
        ApexPages.currentPage().getParameters().put('dealer__Year__c', '2015');
        ApexPages.currentPage().getParameters().put('dealer__Make__c', 'Ford');
        ApexPages.currentPage().getParameters().put('dealer__Model__c', 'Focus');
        ApexPages.currentPage().getParameters().put('dealer__Trim_Level__c', 'SLT');
        ApexPages.currentPage().getParameters().put('dealer__VIN__c', '1HGCM82633A004352');
        ApexPages.currentPage().getParameters().put('dealer__Odometer_at_Trade_In__c', '1500');


        objDealController.createTradeIn();
        ApexPages.currentPage().getParameters().put('id', objTradeIn.Id);
        objDealController.deleteTradeIn();
        ApexPages.currentPage().getParameters().put('id', objDeal.Id);
        //objDealController.getParts();
        objDealController.getPicklistFieldDescribe();
        objDealController.getPicklistValues();

        objDealController.getCategoryReadLookup();

        objDealController.getCategoryReadById('Category');
        objDealController.getCategoryReadById('Sub-category');
        //objDealController.getCategoryReadById('Manufacturer');

        objDealController.getCategoryRead('Category');
        objDealController.getCategoryRead('Sub-category');
        objDealController.getCategoryRead('Manufacturer');

        ApexPages.currentPage().getParameters().put('fieldName', 'dealer__Company_Number__c');
        objDealController.getServiceContractPicklistValues();
        objDealController.getDealStatusValues();
        objDealController.getAvailableContractSoql();
        objDealController.getAvailableContracts();
        objDealController.getAvailableContractCount();
        objDealController.getDiscountTemplates();
        objDealController.getDiscounts();
        ApexPages.currentPage().getParameters().put('dealer__Type__c', 'Coupon');
        ApexPages.currentPage().getParameters().put('dealer__Desc__c', 'Test Description');
        ApexPages.currentPage().getParameters().put('dealer__Amount__c', '155462');
        ApexPages.currentPage().getParameters().put('dealer__Gross__c', 'FE');
        ApexPages.currentPage().getParameters().put('dealer__Taxable__c', 'true');
        ApexPages.currentPage().getParameters().put('id', objDiscount.id);
        Test.stopTest();
/* COMMENTED OUT DURING DTMOB MIGRATION TO AVOID SOQL QUERY LIMIT
        objDealController.updateDiscount();
        objDealController.destroyDiscount();
        
        //ApexPages.currentPage().getParameters().put('dealId',);
        objDealController.getDealMiscTaxes();
        objDealController.getGrossItems();
        objDealController.getMiscTaxCode();
        objDealController.getSelectedContracts();
        //objDealController.deleteContract();
        //ApexPages.currentPage().getParameters().put('models','');
        //objDealController.deleteContract();
        objDealController.insertContract();
        ApexPages.currentPage().getParameters().put('models', '[{"attributes":{"type":"dealer__Service_Contract__c","url":"/services/data/v36.0/sobjects/dealer__Service_Contract__c/a0v610000017aXCAAY"},"dealer__Car_Deal__c":"a0B61000000w9kCEAQ","Name":"160412-869","dealer__Contract_Template__c":false,"dealer__Cost__c":111,"dealer__Customer_Contact__c":"0036100000MhlJUAAZ","dealer__Customer__c":"0016100000Nb6WvAAJ","dealer__Deductable__c":"12","dealer__Description__c":"TEst New Contract","dealer__Taxable__c":false,"dealer__Printable__c":false,"Id":"a0v610000017aXCAAY","dealer__Expiration_Months__c":"34","dealer__Gross__c":333,"dealer__Plan_Code__c":"32","dealer__Sale_Price__c":444,"dealer__Start_Date__c":"2016-04-08","dealer__Type__c":"Extended Service Contract","dealer__Order__c":null}]');
        objDealController.insertContract();
        ApexPages.currentPage().getParameters().put('id', objAccount.Id);
        ApexPages.currentPage().getParameters().put('Phone', objAccount.Id);
        ApexPages.currentPage().getParameters().put('PersonMobilePhone', objAccount.PersonMobilePhone);
        ApexPages.currentPage().getParameters().put('PersonEmail', objAccount.PersonEmail);
        ApexPages.currentPage().getParameters().put('BillingCountry', objAccount.BillingCountry);
        ApexPages.currentPage().getParameters().put('BillingStreet', objAccount.BillingStreet);
        ApexPages.currentPage().getParameters().put('BillingCity', objAccount.BillingCity);
        ApexPages.currentPage().getParameters().put('BillingState', objAccount.BillingState);
        ApexPages.currentPage().getParameters().put('BillingPostalCode', objAccount.BillingPostalCode);
        ApexPages.currentPage().getParameters().put('BillingStreet', objAccount.BillingStreet);
        ApexPages.currentPage().getParameters().put('LastName', objAccount.LastName);
        ApexPages.currentPage().getParameters().put('dealer__Drivers_License_Number__pc', objAccount.dealer__Drivers_License_Number__pc);
        ApexPages.currentPage().getParameters().put('dealer__Drivers_License_Expiration_Date__pc', String.valueOf(objAccount.dealer__Drivers_License_Expiration_Date__pc));
        
        // Co Buyer Data
        ApexPages.currentPage().getParameters().put('dealer__Co_Buyer__c', objCoBuyer.Id);
        ApexPages.currentPage().getParameters().put('dealer__Co_Buyer_First_Name__c', 'Johny'); 
        ApexPages.currentPage().getParameters().put('dealer__Co_Buyer_Last_Name__c', 'Blast'); 
        ApexPages.currentPage().getParameters().put('dealer__Co_Buyer_Home_Phone__c', '5309990099'); 
        ApexPages.currentPage().getParameters().put('dealer__Co_Buyer_Email__c', 'johny@example.com'); 
        ApexPages.currentPage().getParameters().put('dealer__Co_Buyer_Address__c', '123 Win tu Way'); 
        ApexPages.currentPage().getParameters().put('dealer__Co_Buyer_City__c', 'Redding'); 
        ApexPages.currentPage().getParameters().put('dealer__Co_Buyer_State__c', 'CA'); 
        ApexPages.currentPage().getParameters().put('dealer__Co_Buyer_Postal_Code__c', '96001'); 
        ApexPages.currentPage().getParameters().put('dealer__Co_Buyer_Drivers_License_Number__c', 'A1234567'); 
        ApexPages.currentPage().getParameters().put('dealer__Co_Buyer_Drivers_License_Exp_Date__c', '2024-01-01'); 
        ApexPages.currentPage().getParameters().put('IsPersonAccount','true' );
        objDealController.updateBuyerAccount();

        ApexPages.currentPage().getParameters().put('Id','' );
        ApexPages.currentPage().getParameters().put('IsPersonAccount','false' );
        ApexPages.currentPage().getParameters().put('PersonMobiltPhone','123' );
        ApexPages.currentPage().getParameters().put('PersonEmail','t@gm.com' );
        ApexPages.currentPage().getParameters().put('Name','Redding Motors' );
        objDealController.createSalesUp();

        objDealController.updateAccounts();
        objDealController.updateCoBuyerAccount();
        objDealController.updateContract();
        objDealController.deleteContract(); //Commented below in test class
        objDealController.getFinanceCompany();
        ApexPages.currentPage().getParameters().put('filter[filters][0][value]', ' ');
        objDealController.getFinanceCompany();
        ApexPages.currentPage().getParameters().put('id', objDeal.Id);
        objDealController.getLaserForm();
        objDealController.getImpactForm();
        objDealController.getSelectedImpactForm();
        objDealController.getSelectedLaserForm();
        //objDealController.printBundleOfForms();
        objDealController.doHttpRequest(body, isSave); // Need to insert fake body of response when running test
        objDealController.getPdfBody(formsList);
        objDealController.getSerVehicleReadLookup();
        objDealController.getSerVehicleRead();
        ApexPages.currentPage().getParameters().put('filter[filters][0][value]', 'ABC');
        objDealController.getSerVehicleRead();
        objDealController.getSerVehicleReadById();
        ApexPages.currentPage().getParameters().put('custid', '');
        objDealController.getSerVehicleReadById();
        objDealController.getcompiledFDF();
        //objDealController.getSubmitApproval();
        //}

        // Taxes will go here:
        objDealController.getTaxTemplates();
        //objDealController.getDealTaxes();

        // Sales up tests
        //objDealController.getRecentSalesUps();
        ApexPages.currentPage().getParameters().put('models', '[{"attributes":{"type":"dealer__Service_Contract__c","url":"/services/data/v36.0/sobjects/dealer__Service_Contract__c/a0v610000017aXCAAY"},"Name":"160412-869","dealer__Contract_Template__c":false,"dealer__Cost__c":111,"dealer__Deductable__c":"12","dealer__Description__c":"TEst New Contract","dealer__Taxable__c":false,"dealer__Printable__c":false,"Id":"a0v610000017aXCAAY","dealer__Expiration_Months__c":"34","dealer__Gross__c":333,"dealer__Plan_Code__c":"32","dealer__Sale_Price__c":444,"dealer__Start_Date__c":"2016-04-08","dealer__Type__c":"Extended Service Contract","dealer__Order__c":null}]');
        objDealController.updateContract();

        // Testing Taxes

        ApexPages.currentPage().getParameters().put('action', 'create_dealtax');
        ApexPages.currentPage().getParameters().put('dealId', objDeal.Id);
        ApexPages.currentPage().getParameters().put('Id',null);
        ApexPages.currentPage().getParameters().put('Name', 'Testing');
        ApexPages.currentPage().getParameters().put('dealer__Flat_Tax__c', '500');
        ApexPages.currentPage().getParameters().put('dealer__Tax_Percentage__c', '9.9');
        ApexPages.currentPage().getParameters().put('dealer__Type__c', 'Other');

        
        dealer__Deal_Tax__c newtax = new dealer__Deal_Tax__c(
            dealer__Deal__c = objDeal.Id,
            Name = 'Testing',
            dealer__Flat_Tax__c = 500,
            //dealer__Tax_Percentage__c = 9.9,
            dealer__Type__c = 'Other'
        );
        insert newtax;

        objDealController.upsertTaxLine();

        List<dealer__Deal_Tax__c> taxLines = [SELECT Id FROM dealer__Deal_Tax__c LIMIT 1];

        ApexPages.currentPage().getParameters().put('Id',newtax.Id );

        objDealController.upsertTaxLine();

        //objDealController.getDealTaxes();
        objDealController.destroyTaxLine();
        
        dealer__Tax_Zones__c newZone = new dealer__Tax_Zones__c(
            dealer__City__c = 'Redding',
            dealer__County__c = 'Shasta',
            dealer__Postal_Code__c = '96002',
            dealer__Rate__c = 8.25,
            dealer__State__c = 'CA'
        );
        insert newZone;
        
        objDealController.getTaxZones(newZone.Id);

        ApexPages.currentPage().getParameters().put('taxable_zip','96002' );
        ApexPages.currentPage().getParameters().put('filter[filters][0][value]', 'Redding');

        objDealController.getTaxZoneSearch();
        objDealController.getTaxZones();
        objDealController.renewTaxLines();
        objDealController.deleteDeal();
        objDealController.getDefaultStatusValue();

        //objDealController.getreadCashier();

        Test.stopTest();
        // Test BOS
        ApexPages.StandardController sc = new ApexPages.StandardController(objDeal);
        ApexPages.currentPage().getParameters().put('id', objDeal.id);
        DealForm_EXT mob = new DealForm_EXT(new ApexPages.StandardController(objDeal));
        mob.getInvoiceLogo();
        
        List<dealer__After_Market__c> selectedKits = mob.selectedKits;
        List<dealer__Trade_In__c> tradeInList = mob.tradeInList;
        List<dealer__Service_Contract__c> soldOnProposal = mob.soldOnProposal ;
        List<dealer__Discount_Rebate__c> discs = mob.getDiscounts() ;
        mob.getPayor1();
        mob.getPayor2();
        mob.getPayor3();
        mob.getLeadSourcePicklist();
        mob.getLeadTypePicklist();
        mob.getTaxableFees();
        mob.getNonTaxableFees();*/
        // Decimal totalTradeGross = mob.getTotalTradeGross();
    }

    static testmethod void testGetters() {
        dealer__Deal__c objDeal = new dealer__Deal__c();
        DealTRSController objDealController = new DealTRSController();
        DealTRSController objDealStandardController = new DealTRSController(new ApexPages.StandardController(objDeal));
        objDealController.getconversionMFGPicklistValues();
        objDealController.getTaxZones(); 
        objDealController.getcashierOptions();
        objDealController.getPricingStrategy();
    }

    static testmethod void testDeliveryROCreate() {
        dealer.TestClassUtil testUtil = new dealer.TestClassUtil();
        testUtil.insertDMSSettings();
        
        dealer__Dealer_Location__c loc = dealer.TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
        // Create subdata
        testUtil.insertCarDeal();
        dealer__Deal__c deal = [SELECT Id, dealer__Store_Location__c from dealer__Deal__c LIMIT 1];
        deal.dealer__Store_Location__c = loc.Id;
        deal.dealer__Delivery_Date__c = Date.today();
        deal.dealer__Deal_Date__c = Date.today();
        deal.Conversion_Price__c = 100;
        deal.Conversion_Discount__c = 100;
        String supId = testUtil.insertSalesup();
        deal.dealer__Sales_Lead__c = supId;
        update deal;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(deal);
        ApexPages.currentPage().getParameters().put('id', deal.id);
        DealForm_EXT mob = new DealForm_EXT(new ApexPages.StandardController(deal));
        
        mob.getTotalTradeGross();
        mob.getTotalAllowance();
        deal.Vehicle__c = null;
        mob.getShowTradeAllowance();
        
        System.debug(deal.Id);

        // test Static method
        id jobId = DealTRSController.createDeliveryRepairOrder(deal.Id);
        DealTRSController.checkRoQueue(deal.Id,jobId);
        DealTRSController.setasPrimaryDeal(deal.Id);
         
    }

    static testmethod void testCloneDeal() {
        
        dealer.TestClassUtil testUtil = new dealer.TestClassUtil();
        testUtil.insertDMSSettings();
        
        dealer__Dealer_Location__c loc = dealer.TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
        // Create subdata
        testUtil.insertCarDeal();
        dealer__Deal__c deal = [SELECT Id, dealer__Store_Location__c from dealer__Deal__c LIMIT 1];
        deal.dealer__Store_Location__c = loc.Id;
        deal.dealer__Delivery_Date__c = Date.today();
        deal.dealer__Deal_Date__c = Date.today();
        String supId = testUtil.insertSalesup();
        deal.dealer__Sales_Lead__c = supId;
        update deal;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(deal);
        ApexPages.currentPage().getParameters().put('id', deal.id);

        DealTRSController dts = new DealTRSController();
        
        dts.cloneDeal(); 
    }

    static testmethod void testCloseDeal() {

        // Setup the test data
        dealer.TestClassUtil tcu = new dealer.TestClassUtil();
        tcu.insertDMSSettings();
        dealer__Dealer_Location__c loc = dealer.TestClassUtil.insertDealerLocation('RD1', 'Redding Motorcar Company');

        // Insert Account
        Account a = new Account(FirstName='Jarrett', LastName='Kuljis');
        Account b = new Account(FirstName='Morgan', LastName='Kuljis');
        List<Account> accounts = new List<Account>{ a, b };
        insert accounts;

        Contact c = [SELECT Id, AccountId FROM Contact WHERE AccountId=:a.Id Limit 1];

        // Create a vehicle inventory record
        dealer__Vehicle_Inventory__c VI = new dealer__Vehicle_Inventory__c();
            VI.Name = 'Test Vehicle Inventory';
            VI.dealer__Model__c = 'Civic';
            VI.dealer__Stock_Number__c = dealer.TestClassUtil.generateRandomString(8);
            VI.dealer__VIN__c = '5TDYK3DCXBS075856';
            VI.dealer__Company_Number__c = 'RD1';
            VI.dealer__Store_Location__c = loc.Id;
            VI.dealer__Year__c = '2014';
            VI.dealer__Make__c = 'Honda';
            VI.In_Stock__c = true;
        insert VI;

        // Create a Sales Up
        dealer__Sales_Up__c SU = new dealer__Sales_Up__c();     
            SU.Name = 'Test SalesUP';
            SU.dealer__Buyer_Contact__c = c.Id;
            SU.dealer__Customer_Account__c=a.Id;
            SU.dealer__Desired_Stock_Num__c = VI.Id;
            SU.dealer__Make__c = 'Honda';
        insert SU;      

        // Create a Deal
        dealer__Deal__c Deal = new dealer__Deal__c();
            Deal.dealer__Buyer__c = a.Id;
            Deal.dealer__Co_Buyer__c = b.Id;
            Deal.dealer__Buyer_Contact__c = c.Id;
            Deal.dealer__Deal_ID__c = '12345';
            Deal.dealer__Licence__c = '100';
            Deal.dealer__Vehicle__c = VI.Id;
            Deal.Name = '12342';
            Deal.dealer__Sales_Lead__c=SU.Id;
            Deal.dealer__Service_Vehicle__c=[SELECT Id FROM dealer__Service_Vehicle__c].Id; 
            Deal.dealer__Deal_Date__c=Date.today();
            Deal.dealer__Delivery_Date__c=Date.today();
        insert Deal;

        // Create a Trade Record
        dealer__Service_Vehicle__c svTrade = new dealer__Service_Vehicle__c();
            svTrade.dealer__Year__c='2009';
            svTrade.dealer__Make__c='Peugeot';
            svTrade.dealer__Carline__c='208 GTI';
            svTrade.dealer__VIN__c='5FNRL5H90BB042364';
        insert svTrade;

        dealer__Trade_In__c trade = new dealer__Trade_In__c();
            trade.dealer__Car_Deal__c=Deal.Id;
            trade.dealer__Appraisal_Date__c=Date.today();
            trade.dealer__Year__c='2009';
            trade.dealer__Make__c='Peugeot';
            trade.dealer__Model__c='208 GTI';
            trade.dealer__VIN__c='5FNRL5H90BB042364';
            trade.dealer__Trade_Allowance__c=900;
            trade.dealer__Odometer_at_Trade_In__c=129089;
            trade.dealer__Service_Vehicle__c=svTrade.Id;
        insert trade;     

        // Process the close out
        List<dealer__Deal__c> deals = [SELECT Id, dealer__Sales_Lead__c, dealer__Deal_Date__c, dealer__Delivery_Date__c, 
                                            dealer__Vehicle__c, dealer__Service_Vehicle__c, 
                                            dealer__Mileage__c, dealer__Buyer__c, dealer__Buyer_Contact__c 
                                FROM dealer__Deal__c LIMIT 1];
        DealTRSController.closeDeal(deals[0].Id);           
    }

    static testMethod void validateDealTRSController2() {
        dealer.TestClassUtil testutil = new dealer.TestClassUtil();
        testutil.insertDMSSettings();

        List < SObject > sObjectList = new List < SObject > ();
        List < User > userList = new List < User > ();
        List < dealer__Form__c > formsList = new List < dealer__Form__c > ();
        Profile objProfile = [SELECT Id From Profile WHERE Name = 'Standard User'];

        User objUser = new User(Alias = 'newUser',
            Division = 'CR9',
            Email = 'newuser1234@testorg.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Testing',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US', // changed for to avoid: INVALID_OR_NULL_FOR_RESTRICTED_PICKLIST, Locale: bad value for restricted picklist field: America/Los_Angeles
            UserName = 'newuser12348@testorg.com',
            ProfileId = objProfile.Id,
            TimeZoneSidKey = 'America/Los_Angeles');
        insert objUser;
        //userList.add(objUser);
        userList = [select id, Name from User where id =: objUser.id];

        Document document = new Document();
        document.Body = Blob.valueOf('Some Text');
        document.ContentType = 'image/png';
        document.DeveloperName = 'InvoiceLogo';
        document.IsPublic = true;
        document.Name = 'InvoiceLogo';
        document.FolderId = objUser.id;
        insert document;

        //System.runAs(new user(ID = UserInfo.getUserID())){

        Account objAccount = new Account();
        objAccount.FirstName = 'Test Account';
        objAccount.MiddleName = 'Test Account';
        objAccount.LastName = 'Test Account';
        objAccount.Phone = '13256446';
        objAccount.PersonMobilePhone = '65666871';
        objAccount.PersonMobilePhone = 'test@demo.com';
        objAccount.BillingCountry = 'CA';
        objAccount.BillingStreet = 'street';
        objAccount.BillingCity = 'city';
        objAccount.BillingState = 'State';
        objAccount.BillingPostalCode = '151656';
        objAccount.dealer__Active__c = 'Yes';
        objAccount.dealer__Vendor__c = true;
        objAccount.dealer__Tax_ID__c = '21132sdf';
        insert objAccount;

        Contact objContact = new Contact(LastName = 'TestContact');
        insert objContact;

        dealer__Appraisal_Vehicle__c objAppraisalVehicle = new dealer__Appraisal_Vehicle__c(dealer__Make__c = '2016');
        insert objAppraisalVehicle;
        sObjectList.add(objAppraisalVehicle);
        
        dealer__Appraisal_Vehicle__c objAppraisalVehicle1 = new dealer__Appraisal_Vehicle__c(dealer__Make__c = '2015');
        insert objAppraisalVehicle1;
        sObjectList.add(objAppraisalVehicle1);

        dealer__Finance_Company__c objFinanceCompany = new dealer__Finance_Company__c(Name = 'Test Finance');
        insert objFinanceCompany;

        dealer__Dealer_Location__c objLocation = new dealer__Dealer_Location__c(Name = 'Test Location', dealer__City__c = 'City', dealer__Company_Number__c = '561', dealer__Postal_Code__c = 'Code', dealer__State__c = 'ST');
        insert objLocation;

        dealer__Deal__c objDeal = new dealer__Deal__c(Name = 'Test', dealer__Deal_ID__c = 'a0B61000001w9kC', dealer__Buyer__c = objAccount.Id, dealer__Status__c = 'Pending', dealer__Buyer_Address__c = 'Address', dealer__Buyer_City__c = 'City',
            /*dealer__Vehicle__c = objVehicleInventory.Id,*/
            dealer__Buyer_County__c = 'Country', dealer__Buyer_Email__c = 'test@demo.com', dealer__Buyer_Postal_Code__c = '96002', dealer__Buyer_State__c = 'State',
            dealer__Buyer_Mobile_Phone__c = '1656566', dealer__Buyer_Home_Phone__c = '55666454', dealer__Co_Buyer__c = objAccount.Id, dealer__Co_Buyer_Address__c = 'Address',
            dealer__Conversion_Price__c = 1656516, dealer__Co_Buyer_City__c = 'City', dealer__Co_Buyer_County__c = 'Country', dealer__Co_Buyer_Email__c = 'test@demo.com', dealer__Co_Buyer_Home_Phone__c = '651656',
            dealer__Co_Buyer_Mobile_Phone__c = '16516565', dealer__Co_Buyer_State__c = 'State', dealer__Co_Buyer_Postal_Code__c = '96002', dealer__Delivery_Date__c = System.Today(), dealer__Business_Department__c = 'Business',
            dealer__Deal_Date__c = system.today(), dealer__Deal_Close_Date__c = system.today(), dealer__Broker__c = objAccount.Id, dealer__Broker_Address__c = 'Address', dealer__Broker_City__c = 'City',
            dealer__Broker_County__c = 'Country', dealer__Broker_Postal_Code__c = 'Code', dealer__Broker_State__c = 'State', dealer__Business_Title__c = 'Title', dealer__Business_Address__c = 'Address',
            dealer__Business_Phone__c = '16656545', dealer__Business_Contracting_Name__c = 'Business', dealer__Business_City__c = 'City', dealer__Business_State__c = 'State', dealer__Business_Postal_Code__c = 'Code',
            dealer__Business_County__c = 'Country', dealer__Business_Email__c = 'test@demo.com', dealer__Desk_Manager__c = UserInfo.getUserId(),
            /*dealer__DeliveryRepairOrder__c = objServiceRepair.Id,*/
            dealer__Finance_Institution_Account__c = objFinanceCompany.Id, dealer__Term__c = 10, dealer__Days_to_First__c = 124, dealer__Payments_Per_Year__c = 6565,
            dealer__Rate__c = 80, dealer__Amt_Financed__c = 51156, dealer__Monthly_Pymt__c = 44554, dealer__F_I_Manager__c = USerInfo.getUserId(), dealer__Store_Location__c = objLocation.Id, dealer__Auto_Insurance_Phone__c = '65165165',
            dealer__Co_Buyer_Work_Phone__c = '545455', dealer__Salesperson_1__c = UserInfo.getUserId(), dealer__Salesperson_2__c = UserInfo.getUserId(), dealer__Service_Manager__c = UserInfo.getUserId(),
            dealer__Delivery_City__c = 'City', dealer__Delivery_Phone__c = '516566', dealer__Delivery_State__c = 'State', dealer__Delivery_Postal_Code__c = 96002, dealer__Delivery_Mobile__c = '455566', dealer__Delivery_County__c = 'Country',
            dealer__Delivery_Notes__c = 'Notes', dealer__Delivery_Email__c = 'test@demo.com', dealer__Delivery_Street__c = 'Street', dealer__Vehicle_Conversion_Gross__c = 6266566, dealer__Vehicle_Gross__c = 5516566,
            dealer__Deferred_1_Payee__c = objAccount.Id,
            dealer__Deferred_2_Payee__c = objAccount.Id, dealer__Deferred_3_Payee__c = objAccount.Id, dealer__Deferred_Date_1__c = System.Today(), dealer__Deferred_Date_2__c = System.Today(), dealer__Deferred_Date_3__c = System.Today(),
            dealer__Deferred_Down_1__c = 51665, dealer__Deferred_Down_2__c = 65655, dealer__Deferred_Down_3__c = 54555, dealer__Deferred_Note_1__c = 'Note 2', dealer__Deferred_Note_2__c = 'Note 2', dealer__Deferred_Note_3__c = 'Note 3',
            dealer__GVWR__c = 0, dealer__Doc_Fee__c = 445, dealer__License_Fee__c = 55668, dealer__Registration_Title_Fee__c = 45416, dealer__Electronic_Filing_Fee__c = 55999, dealer__Tire_Fee__c = 55598,
            dealer__Smog_Cert__c = 54544);
        insert objDeal;
        //temporary while we fix dealer__formapi
        List<String> frmIdStr = new List<String>();
        String frmBase64 = 'fHwyLDEwLERMRSMrMiwzMCx7IWRlYWwuZGVhbGVyX19EZWFsX0lEX19jfSsyLDUwLFJPUysyLDcwLHshZGVhbC5kZWFsZXJfX1N0b2NrX051bWJlcl9fY30rfHx8fDYsMix7IWRlYWwuZGVhbGVyX19CdXllcl9GaXJzdF9OYW1lX19jfSs2LDMwLHshZGVhbC5kZWFsZXJfX0NvX0J1eWVyX0ZpcnN0X05hbWVfX2N9KzYsNTYseyEkT3JnYW5pemF0aW9uLk5hbWV9K3w3LDIseyFkZWFsLmRlYWxlcl9fQnV5ZXJfQWRkcmVzc19fY30rNywzMCx7IWRlYWwuZGVhbGVyX19Db19CdXllcl9BZGRyZXNzX19jfSs3LDU2LHshJE9yZ2FuaXphdGlvbi5TdHJlZXR9K3w4LDIseyFkZWFsLmRlYWxlcl9fQnV5ZXJfQ2l0eV9fY30geyFkZWFsLmRlYWxlcl9fQnV5ZXJfU3RhdGVfX2N9IHshZGVhbC5kZWFsZXJfX0J1eWVyX0NvdW50eV9fY30geyFkZWFsLmRlYWxlcl9fQnV5ZXJfUG9zdGFsX0NvZGVfX2N9KzgsMzAseyFkZWFsLmRlYWxlcl9fQ29fQnV5ZXJfQ2l0eV9fY30geyFkZWFsLmRlYWxlcl9fQ29fQnV5ZXJfU3RhdGVfX2N9IHshZGVhbC5kZWFsZXJfX0NvX0J1eWVyX0NvdW50eV9fY30geyFkZWFsLmRlYWxlcl9fQ29fQnV5ZXJfUG9zdGFsX0NvZGVfX2N9KzgsNTYseyEkT3JnYW5pemF0aW9uLkNpdHl9IHshJE9yZ2FuaXphdGlvbi5TdGF0ZX0geyEkT3JnYW5pemF0aW9uLlBvc3RhbENvZGV9K3x8fHx8fDE0LDEzLHshZGVhbC5kZWFsZXJfX01ha2VfX2N9K3wxNSwyLHshZGVhbC5kZWFsZXJfX05VT19fY30rMTUsOCx7IWRlYWwuZGVhbGVyX19ZZWFyX19jfSsxNSwxMyx7IWRlYWwuZGVhbGVyX19Nb2RlbF9fY30rMTUsMjQseyFST1VORChkZWFsLmRlYWxlcl9fTWlsZWFnZV9fYywwKX0rMTUsMzYseyFkZWFsLmRlYWxlcl9fVklOX19jfSt8fHx8fHx8fHwyNCw0OCx7IVJPVU5EKGRlYWwuZGVhbGVyX19Eb3duX1B5bXRfX2MsMCl9K3wyNSw1LHshZGVhbC5kZWFsZXJfX1JhdGVfX2N9KzI1LDEzLHshZGVhbC5kZWFsZXJfX0FtdF9GaW5hbmNlZF9fY30rMjUsMjUseyFkZWFsLmRlYWxlcl9fQW10X0ZpbmFuY2VkX19jfSsyNSwzNSx7IWRlYWwuZGVhbGVyX19BbXRfRmluYW5jZWRfX2N9KzI1LDQ4LHshZGVhbC5kZWFsZXJfX0FtdF9GaW5hbmNlZF9fYytkZWFsLmRlYWxlcl9fRG93bl9QeW10X19jfSsyNSw1OCxOL0ErMjUsNzEsTi9BKzI1LDc3LE4vQSt8MjYsNTgsTi9BKzI2LDcxLE4vQSsyNiw3NyxOL0ErfDI3LDY3LE4vQSsyNyw3MSxOL0ErMjcsNzcsTi9BK3wyOCw2NyxOL0ErMjgsNzEsTi9BKzI4LDc3LE4vQSt8MjksNjcsTi9BKzI5LDcxLE4vQSsyOSw3NyxOL0ErfDMwLDY3LE4vQSszMCw3MSxOL0ErMzAsNzcsTi9BK3wzMSw3NyxOL0ErfHx8fHwzNiw1LHshZGVhbC5kZWFsZXJfX1Rlcm1fX2MtMX0rMzYsMjgseyFkZWFsLmRlYWxlcl9fTW9udGhseV9QeW10X19jfSszNiw0NSx7IWRlYWwuZGVhbGVyX19GaXJzdF9QYXltZW50X0RhdGVfX2N9K3x8fHx8fHx8fHx8fHx8fHx8fHw=';
        dealer__Form__c frm = new dealer__Form__c(Name='TestForm', dealer__Impact_Code__c=frmBase64, dealer__Print_Type__c='Impact');
        insert frm;
        frmIdStr.add(frm.Id);
        frm = new dealer__Form__c(Name='TestForm', dealer__FDF_Code__c='', dealer__DocumentContentId__c='a1234', dealer__Print_Type__c='FDF');
        insert frm;
        frmIdStr.add(frm.Id);
       
        DealTRSController.printFormBundle(objDeal.Id, frmIdStr);
        DealTRSController objDealController = new DealTRSController();

        //End Temporary
         // Testing Taxes

        ApexPages.currentPage().getParameters().put('action', 'create_dealtax');
        ApexPages.currentPage().getParameters().put('dealId', objDeal.Id);
        ApexPages.currentPage().getParameters().put('Id',null);
        ApexPages.currentPage().getParameters().put('Name', 'Testing');
        ApexPages.currentPage().getParameters().put('dealer__Flat_Tax__c', '500');
        ApexPages.currentPage().getParameters().put('dealer__Tax_Percentage__c', '9.9');
        ApexPages.currentPage().getParameters().put('dealer__Type__c', 'Other');

        
        dealer__Deal_Tax__c newtax = new dealer__Deal_Tax__c(
            dealer__Deal__c = objDeal.Id,
            Name = 'Testing',
            dealer__Flat_Tax__c = 500,
            //dealer__Tax_Percentage__c = 9.9,
            dealer__Type__c = 'Other'
        );
        insert newtax;

        objDealController.upsertTaxLine();

        List<dealer__Deal_Tax__c> taxLines = [SELECT Id FROM dealer__Deal_Tax__c LIMIT 1];

        ApexPages.currentPage().getParameters().put('Id',newtax.Id );

        objDealController.upsertTaxLine();

        objDealController.getDealTaxes();
        objDealController.destroyTaxLine();
        
        objDealController.getTaxZones(); // no zones set yet.

        dealer__Tax_Zones__c newZone = new dealer__Tax_Zones__c(
            dealer__City__c = 'Redding',
            dealer__County__c = 'Shasta',
            dealer__Postal_Code__c = '96002',
            dealer__Rate__c = 8.25,
            dealer__State__c = 'CA'
        );
        insert newZone;

        ApexPages.currentPage().getParameters().put('taxable_zip','96002' );

        objDealController.getTaxZones();
    }
}