@isTest
public class AppraisalControllerTest {
    
    @testSetup static void testDataInit() {
        
        dealer.installScriptOrgAPI.createVdcSetting();

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
        location.dealer__Postal_Code__c='1234';

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
            insert VI;
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
        
        Account a = new Account(FirstName = 'Bob', LastName = 'Smith');
        insert a;
       
        dealer__Sales_Up__c sup = new dealer__Sales_Up__c(
			dealer__Color_Preference_Int__c = 'purple',
			dealer__Customer_Account__c = a.Id,
			dealer__Phone__c = null,
			dealer__Salesperson_1__c = UserInfo.getUserId(),
			dealer__Store_Location__c = location.Id,
			OwnerID = UserInfo.getUserId(),
            dealer__Buyer_Contact__c=a.PersonContactId
		);

		insert sup;        
        
        // Create a Form for Usage
        dealer__Form__c frm = new dealer__Form__c(dealer__Active__c=true, dealer__Document_Object__c='Appraisals', dealer__Form_ID__c='909', Name='TestForm', dealer__Print_Type__c='FDF');
        insert frm;

    }
    
	// Test the insantiated getter methods
	static testmethod void testGetters()
    {   
        
        dealer__Appraisal__c testAppraisal = new dealer__Appraisal__c();
        AppraisalController controller = new AppraisalController(new ApexPages.StandardController(testAppraisal));
        
        // Boolean - Is VDC Active
		Boolean vinDecoderActive = controller.vinDecoderActive;
        
        // Appraisal Config Metadata Getter
		AppraisalConfiguration__mdt appraisalSettings = controller.appraisalSettings;
        
        
    }
    
    //Test saving a new appraisal with vehicle
    static testMethod void newAppraisalTest() {
        dealer__Appraisal__c testAppraisal = new dealer__Appraisal__c();
        AppraisalController controller = new AppraisalController(new ApexPages.StandardController(testAppraisal));
        controller.serviceVehicle.dealer__VIN__c = '2GCEC19V3Y1242654';
        controller.appraisal.dealer__Appraised_Value__c = 1200;
        controller.save();
        controller.createInventoryRecord();
        controller.saveTradeRecord();
        controller.returnToDeal();
        
        controller.populateRepairTypePicklist();

        List<dealer__Appraisal__c> appraisals = [SELECT Id, dealer__Appraised_Value__c, dealer__Service_Vehicle__c, dealer__Service_Vehicle__r.dealer__VIN__c FROM dealer__Appraisal__c];
        System.assertEquals(appraisals.size(), 1);

        dealer__Appraisal__c appraisal = appraisals[0];
        System.assertEquals(appraisal.dealer__Appraised_Value__c, 1200);
        System.assertEquals(appraisal.dealer__Service_Vehicle__r.dealer__VIN__c, '2GCEC19V3Y1242654');
        
        // Test Delete Routine
        controller.deleteRecord();
        
        // Test Form PageReference
        controller.forms();
        
        // Test VIN Decode Data
        AppraisalController.getData('2C4RDGBG2FR581207');

    }

    //Test grabbing an existing vehicle 
    static testMethod void updateAppraisalTest() {
            
        dealer__Service_Vehicle__c serviceVehicle = new dealer__Service_Vehicle__c();
        serviceVehicle.dealer__VIN__c = 'testVIN0123456789';                  
        insert serviceVehicle;           

        dealer__Appraisal__c appraisal = new dealer__Appraisal__c();
        appraisal.dealer__Appraised_Value__c = 1200;
        appraisal.dealer__Service_Vehicle__c = serviceVehicle.Id;
        insert appraisal;

        Test.setCurrentPageReference(new PageReference('Page.AppraisalPage'));
        System.currentPageReference().getParameters().put('id', appraisal.Id);

        dealer__Appraisal__c testAppraisal = new dealer__Appraisal__c();
        AppraisalController controller = new AppraisalController(new ApexPages.StandardController(appraisal));
    
        dealer.AppraisalController.saveVehicleDamage(appraisal.Id+'~NONSENSE');
        controller.save();
        controller.serviceVehicle.dealer__VIN__c ='testVin01234567891';
        controller.save();
        controller.saveTradeRecord();
        controller.reconDescription='Test Recon Desc.';
        controller.reconEstimate=99;
        controller.saveLine();
        
        controller.getEstimateLines();
        controller.getReconTotalLine();
        List<dealer__Service_Vehicle__c> ss = controller.getServiceVehicleByVIN('testVin01234567891');

        dealer__Service_Estimate_Line__c reid = [SELECT Id, Name FROM dealer__Service_Estimate_Line__c ORDER BY CreatedDate DESC LIMIT 1];

        controller.reconEstimate=98;
        controller.reconDescription='Update description line';
        controller.editId=reid.Id;
        controller.editLine();

        controller.reid = reid.Id;
        controller.deleteLine();        

        controller.retrieveBankName();
        controller.returnToSalesUp();
        
    }
    
    //#T-00947 Begin
    //Appraisal insert trigger to default source field to 'Trade-in'
    static testMethod void insertAppraisalTest() {
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

        
        Contact objContact = new Contact(FirstName = 'TestFirst', Phone = '315616566', MobilePhone = '16565656', Email = 'test@demo.com', MailingStreet = 'testStreet', MailingCity = 'testCity', MailingPostalCode = 'ds1f56565', MailingState = 'testState',LastName = 'TestContact');
        insert objContact;
        
        dealer__Finance_Company__c objFinanceCompany = new dealer__Finance_Company__c(Name = 'Test Finance');
        insert objFinanceCompany;
        
        dealer__Dealer_Location__c objLocation = [Select Id from dealer__Dealer_Location__c WHERE name ='Test Location' LIMIT 1];
        
        dealer__Deal__c objDeal = new dealer__Deal__c(Name = 'Test', dealer__Deal_ID__c = '1500', dealer__Buyer__c = objAccount.Id, dealer__Status__c = 'Pending', dealer__Buyer_Address__c = 'Address', dealer__Buyer_City__c = 'City',
            /*dealer__Vehicle__c = objVehicleInventory.Id,*/
            dealer__Buyer_County__c = 'Country', dealer__Buyer_Email__c = 'test@demo.com', dealer__Buyer_Postal_Code__c = 'Postal Code', dealer__Buyer_State__c = 'State',
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
        
        // Insert Trade-in
		dealer__Trade_In__c trade1 = new dealer__Trade_In__c();
        trade1.dealer__Trade_Allowance__c=9000;
        trade1.dealer__Pay_Off_Amount__c=9000;
        trade1.dealer__Stock_Number__c='A123456';
        trade1.dealer__Car_Deal__c=objDeal.Id;
        trade1.dealer__VIN__c='123456789';
        trade1.Name='Trade1';
        trade1.dealer__Year__c='2009';
        trade1.dealer__Make__c='Honda';
        trade1.dealer__Model__c='Civic';
        trade1.dealer__Trim_Level__c='EX-L';
       	trade1.dealer__Odometer_at_Trade_In__c=90013;
        insert trade1;
        
        //Insert Appraisal with deal
        dealer__Appraisal__c appraisal = new dealer__Appraisal__c();
        appraisal.dealer__Appraised_Value__c = 1200;        
        appraisal.dealer__Deal__c=objDeal.id;
        appraisal.dealer__Trade_In__c=trade1.Id;
        insert appraisal;
        
        ApexPages.currentPage().getParameters().put('did', objDeal.Id);
        AppraisalController controller = new AppraisalController(new ApexPages.StandardController(appraisal));
        controller.saveTradeRecord();
		controller.returnToDeal();
        
        ApexPages.currentPage().getParameters().put('tradeid', [SELECT Id From dealer__Trade_In__c LIMIT 1].Id);
        
        controller.serviceVehicle.dealer__VIN__c = 'testVIN0123456789';
        controller.serviceVehicle.dealer__Last_Odometer__c = 10; 
        controller.save();
        dealer__Sales_Up__c sup = [SELECT ID from dealer__Sales_Up__c limit 1];
        ApexPages.currentPage().getParameters().put('sid', sup.Id);
        AppraisalController controller2 = new AppraisalController(new ApexPages.StandardController(appraisal));
        
		ApexPages.currentPage().getParameters().put('tradeid', trade1.Id);
        AppraisalController controller3 = new AppraisalController(new ApexPages.StandardController(appraisal));   
    }
    //#T-00947 End
    //
    
    static testmethod void appraisalFormController() {
        
        dealer__Appraisal__c testAppraisal = new dealer__Appraisal__c();
        AppraisalController controller = new AppraisalController(new ApexPages.StandardController(testAppraisal));
        controller.serviceVehicle.dealer__VIN__c = 'testVIN0123456789';
        controller.appraisal.dealer__Appraised_Value__c = 1200;
        controller.save();
        controller.createInventoryRecord();
        controller.saveTradeRecord();
        controller.returnToDeal();        
        
        dealer__Appraisal__c appraisal = [Select Id from dealer__Appraisal__c Limit 1];
        ApexPages.StandardController sc = new ApexPages.StandardController(appraisal);
        AppraisalFormsController ac = new AppraisalFormsController(sc);
        
        List<dealer__Form__c> frm = ac.formList;
        
        // Test PageReferences
        ac.returnToAppraisal();
        ac.form_id = [SELECT ID from dealer__Form__c limit 1].Id;
        ac.selectImpactForm();
        
        // Test Static Methods
        String fdf = '{"Form" : "'+ac.form_id+'", "Deal":""}';      
        AppraisalFormsController.compileFDF(fdf);

        AppraisalFormsController.getcompiledFDF(ac.form_id+'~'+testAppraisal.Id);
    }

    @isTest
    static void testVINDecode() {

        if (dealer__VINDecoderCS__c.getValues('ActiveSettings') == null) {
            dealer__VINDecoderCS__c VINDecod = new dealer__VINDecoderCS__c();
            VINDecod.Name = 'ActiveSettings';
            VINDecod.dealer__DecoderAPI_URL__c = 'https://api.dataonesoftware.com/webservices/vindecoder/decode';
            VINDecod.dealer__DecoderClientID__c = '6310';
            VINDecod.dealer__DecoderKey__c = 'asdfasdfasdfasdfasdfasdf';
            VINDecod.dealer__DecoderName__c = 'Data One Software';
            insert VINDecod;
        }

        User u = [Select Id from User where Username = 'testuser128@testorgx.com'];
        System.runAs(u) {
            TestClassUtil newUtil = new TestClassUtil();
            dealer__Service_Vehicle__c sv = new dealer__Service_Vehicle__c();
            sv.dealer__Year__c = '2014';
            sv.dealer__Veh_Owner_Contact__c = newUtil.insertContact();
            sv.dealer__VIN__c = '2FAFP71W4YX101840';
            sv.dealer__Stock_Number__c = '1234';
            sv.dealer__Make__c = 'Test';
            sv.dealer__Customer_Key__c = '1234';
            sv.dealer__Licence__c = 'Test';
            sv.dealer__Last_Service__c = System.today();
            sv.dealer__Carline__c = '2014';
            sv.dealer__Last_6__c = 'B54998';

            insert sv;

            dealer__sales_Up__c salesup = [Select Id from dealer__sales_Up__c limit 1];

            pageReference pr = page.VINDecodeServiceVehicleStyleSelect;
            pr.getParameters().put('id', sv.id);
            pr.getParameters().put('owner', userInfo.getUserId());
            pr.getParameters().put('suid', salesUp.id);
            test.setCurrentPage(pr);
            dealer__Appraisal__c app = new dealer__Appraisal__c();
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(app);
            AppraisalController ac = new AppraisalController(sc);
            ac.doDecode(sv.dealer__VIN__c);

            String engine = ac.selectedEngine;
            String trans = ac.selectedTransmission;

            ac.setSelectedStyleId('100378355');
            ac.doDecodePage();
            ac.editPage();

            ac.vinNotPresent();
            ac.doDecodePage();
            ac.getDecode();
            ac.getModelKeyList();
            ac.getSelectedStyleId();
            ac.setSelectedStyleId('123');

            ac.getDecode();
            ac.getModelKeyList();
            String styleIDreturned = ac.getSelectedStyleId();
            System.assertEquals(ac.SelectedStyleId, styleIDreturned);
            ac.vd.StyleDat(ac.SelectedStyleId);
            ac.setSelectedStyleId('100378355');
            ac.vd.StyleDat('100378355');

            ac.getEngineSelect();
            ac.getTransmissionSelect();
            ac.Save();
            ac.serviceVehicle.Id = null;
            ac.Save();
            ac.getInstalledEquipment();
            ac.getOptEquip();
            ac.getIsDecode();
            ac.editPage();

        }
    }
}