/* ****************************************************************
    * Author: Techila Global Services Pvt Ltd.
    * Modified Date: 18-July-2016
    * Description: To test trigger for rolling up amount field of Cashering 
                   to its Parent Rental Agreement's Total Payment field.  
    
    ****************************************************************** */
@isTest
public  class CashierControl_TC {

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


        insert(new dealer__Payment_Methods__c(
                        dealer__Method__c='Cash',
                        dealer__Type__c='Cash',
                        Name='ActiveCash'   
                    )
        );

        Parts_Service_Pricing_Strategy__c ps = new Parts_Service_Pricing_Strategy__c();
            ps.Method__c = 'Jobber';
            ps.Active__c = true;
            ps.Description__c = 'test';
            ps.Default__c = true;
            ps.dealer__Parts_Variable_Amount__c = 10;
            ps.dealer__Formula_Operand__c = '+';
            insert ps;
    }    

    public static  testmethod void MyunitTest(){

        // Instantiate Cashier
        PageReference pr = Page.CashierPayments;
        pr.getParameters().put('id', getCasherId());
        pr.getParameters().put('department', 'service');
        Test.setCurrentPage(pr);

        // Instantiate Cashier
        Cashier cashier = new Cashier();

        // Test Methods
        cashier.getPaymentMethods();
        String paymethods = cashier.paymethods;
        String authcode   = cashier.authCode;
        String closedate  = cashier.closedate;
        Boolean deposit   = cashier.deposit;
        Boolean posted    = cashier.posted;

        // Test Service Related Methods
        cashier.loadServiceInvoice();

        // call cancel ref
        cashier.cancel();
        cashier.voidRepairOrder();
    }

    public static  testmethod void test1()
    {
        // Instantiate Cashier
        PageReference pr = Page.CashierPayments;
        pr.getParameters().put('id', getCasherId());
        pr.getParameters().put('department', 'service');
        Test.setCurrentPage(pr);

        // Instantiate Cashier
        Cashier cashier = new Cashier();

        // Test Methods
        cashier.getPaymentMethods();
        String paymethods = cashier.paymethods;
        String authcode   = cashier.authCode;
        String closedate  = cashier.closedate;
        Boolean deposit   = cashier.deposit;
        Boolean posted    = cashier.posted;

        cashier.paymethods ='cash';
        cashier.totaldue = 100;
        cashier.applyamount = 50;


        cashier.applyPayment(); 
    }      

    @isTest static void cashierPageControllerTest()
    {
        Dealer_Location__c location = [SELECT Id FROM Dealer_Location__c LIMIT 1];
        Account account = [SELECT Id FROM Account LIMIT 1];

        Cashering__c cashiering = (Cashering__c)TestFactory.createSObject(new Cashering__c(Location__c=location.Id, Customer__c=account.Id));
        insert cashiering;

        ApexPages.StandardController sc = new ApexPages.StandardController(cashiering);
        cashierPageController ext = new cashierPageController(sc);

        // Test Getters
        System.assert(ext.cashierRecord!=null, 'cashierRecord getter failed');
        System.assert(ext.logoUrl!=null, 'logoUrl getter failed');
        System.assert(ext.location!=null, 'location getter failed');
        System.assert(ext.customer!=null, 'customer getter failed');
    }
    
    //Method for creating Rental Agreement and its child Cashering for validating RollUp trigger Written on Cashering
    public static  testmethod void MyunitTestOne(){
        List<dealer__Cashering__c> objCasheringList = new List<dealer__Cashering__c>();
        dealer__Rental_Rates__c objRentalRates = new dealer__Rental_Rates__c(dealer__Active__c = true, dealer__Daily_Rate__c = 1000.0);
        insert objRentalRates;  
        dealer__Rental_Accessories__c objRentalAccessories = new dealer__Rental_Accessories__c(dealer__Daily_Rate__c = 5.0);
        insert objRentalAccessories;
        dealer__DMS_Settings__c objDMSCustomSetting = new dealer__DMS_Settings__c();
        objDMSCustomSetting.Name = 'Test Custom Setting One';
        objDMSCustomSetting.dealer__Default_Tax_Rate__c = 6.0;
        objDMSCustomSetting.dealer__Parts_Current_Invoice_Number__c = 50155;
        objDMSCustomSetting.dealer__Parts_Current_Quote_Number__c = 20034;
        objDMSCustomSetting.dealer__Service_Appointment_Sequence_Number__c = 2612;
        objDMSCustomSetting.dealer__Service_CP_Labor_Rate__c = 20.0;
        objDMSCustomSetting.dealer__Service_Current_Invoice_Number__c = 30145;
        objDMSCustomSetting.dealer__Service_Internal_Labor_Rate__c = 50.0;
        objDMSCustomSetting.dealer__Service_Warranty_Labor_Rate__c = 70.0;
        insert objDMSCustomSetting;
        dealer__Rental_Agreements__c objRentalAgreement = new dealer__Rental_Agreements__c();
        objRentalAgreement.dealer__Date_Out__c = System.today();
        objRentalAgreement.dealer__Date_DUE_In__c = System.today()+7;
        objRentalAgreement.dealer__Return_Date__c = System.today()+8;
        objRentalAgreement.dealer__Excess_Miles_Fee__c = 1.25;
        objRentalAgreement.dealer__Fuel_Charge_per_Gallon__c = 25.50;
        objRentalAgreement.dealer__Insurer__c = 'Test Insurer';
        objRentalAgreement.dealer__Mileage_Out__c = 17.50;
        objRentalAgreement.dealer__Policy_Expiration_Date__c = System.today()+30;
        objRentalAgreement.dealer__Policy_No__c = '451518547845';
        objRentalAgreement.dealer__Re_Fuel_Fee__c = 150.00;
        objRentalAgreement.dealer__Time_DUE_IN__c = '12:00';
        objRentalAgreement.dealer__Time_OUT__c = '06:00';
        objRentalAgreement.dealer__Days_Free__c = 2;
        objRentalAgreement.dealer__Vehicle_Licence_Fee__c = 10.50;        
        objRentalAgreement.dealer__Rental_Rates_code__c = objRentalRates.Id;
        objRentalAgreement.dealer__Rental_Accessories__c = objRentalAccessories.Id;
        objRentalAgreement.dealer__Adjustment_Charges__c = 20.0;
        objRentalAgreement.dealer__Discount__c = -25.0;
        objRentalAgreement.dealer__Delivery_Fee__c = 55.0;
        objRentalAgreement.dealer__Tax_Exempt__c = false;
        insert objRentalAgreement;
        for(Integer i=1; i<200; i++){
            dealer__Cashering__c objCasheir = new dealer__Cashering__c(dealer__Amount__c = 100.0, 
                                                                       dealer__Close_Date__c = System.today(),
                                                                       dealer__Payment_Method__c = 'Cash', 
                                                                       dealer__Rental_Agreement__c = objRentalAgreement.Id);
            objCasheringList.add(objCasheir);
        }
        if(objCasheringList.size()>0){
            insert objCasheringList;
        }
        objRentalAgreement = [SELECT dealer__Total_Payments__c FROM dealer__Rental_Agreements__c WHERE ID =: objRentalAgreement.Id];
        System.assertEquals(19900.0, objRentalAgreement.dealer__Total_Payments__c);
    } 

    static Id getCasherId()
    {
        dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');

        Account acc = new Account();
        acc.LastName ='Test';
        acc.AccountSource ='Dealer';
        acc.BillingState = 'CA';
        //acc_list.add(acc);
        insert acc;

        Contact  con = new Contact();
        con.Phone = '8888888';
        con.LastName = 'Test';
       // con_list.add(con);
        insert con;
        
        dealer__Service_Vehicle__c  dsv = new dealer__Service_Vehicle__c();
        dsv.dealer__VIN__c ='Test';
        dsv.Name='Test';
        dsv.dealer__Body_Style__c = 'Test';
        dsv.dealer__Company_Number__c='12123';
        dsv.dealer__Veh_Owner_Contact__c = con.id;
        dsv.dealer__Carline__c ='Test';
        dsv.dealer__Make__c  ='Test';
        dsv.dealer__Year__c  ='2013';
       // dsv_list.add(dsv);
        //insert dsv;
        
    
        dealer__Service_Repair_Order__c  dsr = new dealer__Service_Repair_Order__c();
        dsr.dealer__Customer__c =acc.id;
        dsr.dealer__Mileage_In__c =12;
        dsr.dealer__RO_Number__c ='1221984521';
        
        insert dsr;
         
        dealer__Cashering__c ds = new dealer__Cashering__c();
        ds.Amount__c =12;
        ds.Service_Repair_Order__c=dsr.id;
        ds.Payment_Method__c='Credit Card';
        ds.Location__c = [SELECT Id from Dealer_Location__c LIMIT 1].Id;
        ds.Customer__c = acc.Id;

        insert ds;
        ds.dealer__Amount__c =11;
        update ds;
        delete ds;

        return dsr.Id;
    } 
    
    public static testmethod void testPostInvoiceService(){
        // Instantiate Cashier
        PageReference pr = Page.CashierPayments;
        String invoiceId = getCasherId();
        pr.getParameters().put('id', invoiceId);
        pr.getParameters().put('department', 'service');
        Test.setCurrentPage(pr);

        // Instantiate Cashier
        Cashier cashier = new Cashier();

        // Test Methods
        cashier.getPaymentMethods();
        String paymethods = cashier.paymethods;
        String authcode   = cashier.authCode;
        String closedate  = cashier.closedate;
        Boolean posted    = cashier.posted;

        cashier.paymethods ='cash';
        cashier.totaldue = 100;
        cashier.applyamount = 0;
        cashier.deposit = true;

		Test.startTest();
        cashier.postInvoice();
        Test.stopTest();
        
        Service_Repair_Order__c si = [Select Id, Status__c from Service_Repair_Order__c where Id = :invoiceId limit 1];

        System.assertEquals('Posted',  si.Status__c);
          
    } 
    
    public static testmethod void testPostInvoiceParts(){
        // Instantiate Cashier
        PageReference pr = Page.CashierPayments;
        Dealer_Location__c loc = [select id from dealer_Location__c LIMIT 1];
        Parts_Invoice__c pi = new Parts_Invoice__c(Invoice_Date_Time__c = System.now(), 
                                                   Location__c = loc.Id,
                                                   Post_Date_Time__c = System.today(),
                                                  dealer__Invoice_Number__c = '1234');
        insert pi;
        
           
        dealer__Cashering__c ds = new dealer__Cashering__c();
        ds.dealer__Amount__c =12;
        ds.dealer__Payment_Method__c='Cash';
        insert ds; 
        
        pr.getParameters().put('id', pi.Id);
        pr.getParameters().put('department', 'parts');
        Test.setCurrentPage(pr);

        // Instantiate Cashier
        Cashier cashier = new Cashier();

        // Test Methods
        cashier.getPaymentMethods();
        String paymethods = cashier.paymethods;
        String authcode   = cashier.authCode;
        String closedate  = cashier.closedate;
        Boolean posted    = cashier.posted;

        cashier.paymethods ='cash';
        cashier.totaldue = 100;
        cashier.applyamount = 0;
        cashier.deposit = true;

		Test.startTest();
        cashier.postInvoice();
        Test.stopTest();
        
		Parts_Invoice__c si = [Select Id, Status__c from Parts_Invoice__c where Id =:pi.Id limit 1];
                        
        System.assertEquals('Posted',  si.Status__c);
          
    } 
    
     public static  testmethod void testReopenRO(){
        // Instantiate Cashier
        PageReference pr = Page.CashierPayments;
        String invoiceId = getCasherId();
        Service_Repair_Order__c si = [Select Id, Status__c from Service_Repair_Order__c where Id = :invoiceId limit 1];
        si.Status__c = 'Open';
         
        pr.getParameters().put('id', invoiceId);
        pr.getParameters().put('department', 'service');
        Test.setCurrentPage(pr);

        // Instantiate Cashier
        Cashier cashier = new Cashier();
		Test.startTest();
        cashier.reOpenRO();
        Test.stopTest();
        
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        boolean b = false;
        for(Apexpages.Message msg:msgs){
            if (msg.getDetail().contains('Repair Order is not posted, please check Repair Order Status before attempting to Re-Open')){
                b = true;
            } 
        }
 		system.assert(b);
          
    } 

    public static  testmethod void testEmailService(){

		Test.startTest();
        Cashier.emailServiceAddress();
        Test.stopTest();
        
    } 
    
}