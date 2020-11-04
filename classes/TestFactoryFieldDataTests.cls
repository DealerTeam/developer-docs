@isTest
private class TestFactoryFieldDataTests {
    
    @isTest static void AccountDefaultsTest(){
        test.startTest();
        
        Account obj = (Account)TestFactory.createSObject(new Account(), true);
        
        integer count = database.countQuery('select count() from Account');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    
    @isTest static void After_MarketDefaultsTest()
    {
        test.startTest();
        
        After_Market__c obj = (After_Market__c)TestFactory.createSObject(new After_Market__c(), true);
        After_Market__c[] obj2 = (After_Market__c[])TestFactory.createSObjectList(new After_Market__c(), 5,'TestFactoryFieldData.After_MarketDefaults', true);
        
        
        TestFactoryFieldData data = new  TestFactoryFieldData();
        //After_MarketDefaults().getFieldDefaults();		
        
        integer count = database.countQuery('select count() from After_Market__c');
        //System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    
    @isTest static void Appraisal_VehicleDefaultsTest()
    {
        test.startTest();
        
        Appraisal_Vehicle__c obj = (Appraisal_Vehicle__c)TestFactory.createSObject(new Appraisal_Vehicle__c(), true);
        
        integer count = database.countQuery('select count() from Appraisal_Vehicle__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    
    @isTest static void AppraisalDefaultsTest()
    {
        test.startTest();
        
        Appraisal__c obj = (Appraisal__c)TestFactory.createSObject(new Appraisal__c(), true);
        
        integer count = database.countQuery('select count() from Appraisal__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    
    @isTest static void CampaignDefaultsTest()
    {
        test.startTest();
        
        Campaign__c obj = (Campaign__c)TestFactory.createSObject(new Campaign__c(), true);
        Campaign__c[] obj2 = (Campaign__c[])TestFactory.createSObjectList(new Campaign__c(), 5,'TestFactoryFieldData.CampaignDefaults', true);
        
        
        
        
        integer count = database.countQuery('select count() from Campaign__c');
        System.assertEquals(6, count);
        
        test.stopTest();
    }
    
    
    @isTest static void CaseDefaultsTest()
    {
        test.startTest();
        
        Case obj = (Case)TestFactory.createSObject(new Case(), true);
        Case[] obj2 = (Case[])TestFactory.createSObjectList(new Case(), 5,'TestFactoryFieldData.CaseDefaults', true);
        
        
        
        integer count = database.countQuery('select count() from Case');
        System.assertEquals(6, count);
        
        test.stopTest();
    }
    
    @isTest static void CasheringDefaultsTest()
    {
        test.startTest();
        
        Cashering__c obj = (Cashering__c)TestFactory.createSObject(new Cashering__c(), true);
        //Cashering__c[] obj2 = (Cashering__c[])TestFactory.createSObjectList(new Cashering__c(), 5,'TestFactoryFieldData.CasheringDefaults', true);
        integer count = database.countQuery('select count() from Cashering__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Commission_TierDefaultsTest()
    {
        test.startTest();
        
        Commission_Tier__c obj = (Commission_Tier__c)TestFactory.createSObject(new Commission_Tier__c(), true);
        //Commission_Tier__c[] obj2 = (Commission_Tier__c[])TestFactory.createSObjectList(new Commission_Tier__c(), 5,'TestFactoryFieldData.Commission_TierDefaults', true);
        integer count = database.countQuery('select count() from Commission_Tier__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
     
    @isTest static void CommissionDefaultsTest()
    {
        test.startTest();
        
        Commission__c obj = (Commission__c)TestFactory.createSObject(new Commission__c(), true);
        
        integer count = database.countQuery('select count() from Commission__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void ContactDefaultsTest()
    {
        test.startTest();
        
        Contact obj = (Contact)TestFactory.createSObject(new Contact(), true);
        
        integer count = database.countQuery('select count() from Contact');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void testCDMSettings(){
        test.startTest();
        
        //CDM_Settings__c obj = (CDM_Settings__c)TestFactory.createSObject(new CDM_Settings__c(), true);
        //CDM_Settings__c[] obj2 = (CDM_Settings__c[])TestFactory.createSObjectList(new CDM_Settings__c(), 5,'TestFactoryFieldData.CDM_SettingsDefaults', true);
        //integer count = database.countQuery('select count() from CDM_Settings__c');
        //System.assertEquals(6, count);
        
        test.stopTest();
    }    
    
    
    
    
    @isTest static void Credit_ApplicationDefaultsTest()
    {
        test.startTest();
        Dealer_Location__c loc = (Dealer_Location__c)TestFactory.createSObject(new Dealer_Location__c(), true);
        Sales_Up__c sup = (Sales_Up__c)TestFactory.createSObject(new Sales_Up__c(Store_Location__c = loc.Id), true);
        Credit_Application__c obj = (Credit_Application__c)TestFactory.createSObject(new Credit_Application__c(Sales_up__c = sup.Id), true);
        
        integer count = database.countQuery('select count() from Credit_Application__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void CRMSettingsDefaultsTest()
    {
        test.startTest();
        
        CRMSettings__c obj = (CRMSettings__c)TestFactory.createSObject(new CRMSettings__c(), true);
        
        integer count = database.countQuery('select count() from CRMSettings__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Custom_EquipmentDefaultsTest()
    {
        test.startTest();
        
        Custom_Equipment__c obj = (Custom_Equipment__c)TestFactory.createSObject(new Custom_Equipment__c(), true);
        
        integer count = database.countQuery('select count() from Custom_Equipment__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Dealer_TradeDefaultsTest()
    {
        test.startTest();
        
        Dealer_Trade__c obj = (Dealer_Trade__c)TestFactory.createSObject(new Dealer_Trade__c(), true);
        
        integer count = database.countQuery('select count() from Dealer_Trade__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Deal_Status_Map_SettingDefaultsTest()
    {
        test.startTest();
        
        Deal_Status_Map_Setting__c obj = (Deal_Status_Map_Setting__c)TestFactory.createSObject(new Deal_Status_Map_Setting__c(), true);
        
        integer count = database.countQuery('select count() from Deal_Status_Map_Setting__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Deal_TaxDefaultsTest()
    {
        test.startTest();
        
        Deal_Tax__c obj = (Deal_Tax__c)TestFactory.createSObject(new Deal_Tax__c(), true);
        
        integer count = database.countQuery('select count() from Deal_Tax__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Desired_VehicleDefaultsTest()
    {
        test.startTest();
        
        Desired_Vehicle__c obj = (Desired_Vehicle__c)TestFactory.createSObject(new Desired_Vehicle__c(), true);
        
        integer count = database.countQuery('select count() from Desired_Vehicle__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Discount_RebateDefaultsTest()
    {
        test.startTest();
        
        Discount_Rebate__c obj = (Discount_Rebate__c)TestFactory.createSObject(new Discount_Rebate__c(AppliesTo__c='Part'), true);
        
        integer count = database.countQuery('select count() from Discount_Rebate__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void DriverDefaultsTest()
    {
        test.startTest();
        
        Driver__c obj = (Driver__c)TestFactory.createSObject(new Driver__c(), true);
        
        integer count = database.countQuery('select count() from Driver__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void EmployeeDefaultsTest()
    {
        test.startTest();
        
        Employee__c obj = (Employee__c)TestFactory.createSObject(new Employee__c(), true);
        
        integer count = database.countQuery('select count() from Employee__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Equipment_MasterDefaultsTest()
    {
        test.startTest();
        
        Equipment_Master__c obj = (Equipment_Master__c)TestFactory.createSObject(new Equipment_Master__c(TaxRateType__c='Part'), true);
        
        integer count = database.countQuery('select count() from Equipment_Master__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void EquityDefaultsTest()
    {
        test.startTest();
        
        Equity__c obj = (Equity__c)TestFactory.createSObject(new Equity__c(), true);
        
        integer count = database.countQuery('select count() from Equity__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Finance_CompanyDefaultsTest()
    {
        test.startTest();
        
        Finance_Company__c obj = (Finance_Company__c)TestFactory.createSObject(new Finance_Company__c(), true);
        
        integer count = database.countQuery('select count() from Finance_Company__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Fit_GuideDefaultsTest()
    {
        test.startTest();
        
        Fit_Guide__c obj = (Fit_Guide__c)TestFactory.createSObject(new Fit_Guide__c(), true);
        
        integer count = database.countQuery('select count() from Fit_Guide__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void FixedOperationsSettingsDefaultsTest()
    {
        test.startTest();
        
        FixedOperationsSettings__c obj = (FixedOperationsSettings__c)TestFactory.createSObject(new FixedOperationsSettings__c(), true);
        
        integer count = database.countQuery('select count() from FixedOperationsSettings__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void GLDefaultsTest()
    {
        test.startTest();
        
        GL__c obj = (GL__c)TestFactory.createSObject(new GL__c(), true);
        
        integer count = database.countQuery('select count() from GL__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Inspection_ReportDefaultsTest()
    {
        test.startTest();
        
        Inspection_Report__c obj = (Inspection_Report__c)TestFactory.createSObject(new Inspection_Report__c(), true);
        
        integer count = database.countQuery('select count() from Inspection_Report__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Kit_CategoryDefaultsTest()
    {
        test.startTest();
        
        Kit_Category__c obj = (Kit_Category__c)TestFactory.createSObject(new Kit_Category__c(), true);
        
        integer count = database.countQuery('select count() from Kit_Category__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Misc_Tax_CodesDefaultsTest()
    {
        test.startTest();
        
        Misc_Tax_Codes__c obj = (Misc_Tax_Codes__c)TestFactory.createSObject(new Misc_Tax_Codes__c(), true);
        
        integer count = database.countQuery('select count() from Misc_Tax_Codes__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void MobileApplicationSettingsDefaultsTest()
    {
        test.startTest();
        
        MobileApplicationSettings__c obj = (MobileApplicationSettings__c)TestFactory.createSObject(new MobileApplicationSettings__c(), true);
        
        integer count = database.countQuery('select count() from MobileApplicationSettings__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void MobileAppSettingsDefaultsTest()
    {
        test.startTest();
        
        MobileAppSettings__c obj = (MobileAppSettings__c)TestFactory.createSObject(new MobileAppSettings__c(), true);
        
        integer count = database.countQuery('select count() from MobileAppSettings__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void OrganizationDefaultsDefaultsTest()
    {
        test.startTest();
        
        OrganizationDefaults__c obj = (OrganizationDefaults__c)TestFactory.createSObject(new OrganizationDefaults__c(), true);
        
        integer count = database.countQuery('select count() from OrganizationDefaults__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void OrganizationLocationSettingsDefaultsTest()
    {
        test.startTest();
        
        OrganizationLocationSettings__c obj = (OrganizationLocationSettings__c)TestFactory.createSObject(new OrganizationLocationSettings__c(), true);
        
        integer count = database.countQuery('select count() from OrganizationLocationSettings__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Parts_KitDefaultsTest()
    {
        test.startTest();
        
        Parts_Kit__c obj = (Parts_Kit__c)TestFactory.createSObject(new Parts_Kit__c(), true);
        
        integer count = database.countQuery('select count() from Parts_Kit__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Parts_QuoteDefaultsTest()
    {
        test.startTest();
        
        Parts_Quote__c obj = (Parts_Quote__c)TestFactory.createSObject(new Parts_Quote__c(), true);
        
        integer count = database.countQuery('select count() from Parts_Quote__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Parts_Service_Pricing_StrategyDefaultsTest()
    {
        test.startTest();
        
        Parts_Service_Pricing_Strategy__c obj = (Parts_Service_Pricing_Strategy__c)TestFactory.createSObject(new Parts_Service_Pricing_Strategy__c(), true);
        
        integer count = database.countQuery('select count() from Parts_Service_Pricing_Strategy__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void PaymentMethodsDefaultsTest()
    {
        test.startTest();
        
        PaymentMethods__c obj = (PaymentMethods__c)TestFactory.createSObject(new PaymentMethods__c(), true);
        
        integer count = database.countQuery('select count() from PaymentMethods__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Payment_MethodsDefaultsTest()
    {
        test.startTest();
        
        Payment_Methods__c obj = (Payment_Methods__c)TestFactory.createSObject(new Payment_Methods__c(), true);
        
        integer count = database.countQuery('select count() from Payment_Methods__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void RentalSettingsDefaultsTest()
    {
        test.startTest();
        
        RentalSettings__c obj = (RentalSettings__c)TestFactory.createSObject(new RentalSettings__c(), true);
        
        integer count = database.countQuery('select count() from RentalSettings__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Rental_AccessoriesDefaultsTest()
    {
        test.startTest();
        
        Rental_Accessories__c obj = (Rental_Accessories__c)TestFactory.createSObject(new Rental_Accessories__c(), true);
        
        integer count = database.countQuery('select count() from Rental_Accessories__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Rental_RatesDefaultsTest()
    {
        test.startTest();
        
        Rental_Rates__c obj = (Rental_Rates__c)TestFactory.createSObject(new Rental_Rates__c(), true);
        
        integer count = database.countQuery('select count() from Rental_Rates__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void RewardsDefaultsTest()
    {
        test.startTest();
        
        Rewards__c obj = (Rewards__c)TestFactory.createSObject(new Rewards__c(), true);
        
        integer count = database.countQuery('select count() from Rewards__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void RO_Status_SettingsDefaultsTest()
    {
        test.startTest();
        
        RO_Status_Settings__c obj = (RO_Status_Settings__c)TestFactory.createSObject(new RO_Status_Settings__c(), true);
        
        integer count = database.countQuery('select count() from RO_Status_Settings__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void SalesDeskLogSettingsDefaultsTest()
    {
        test.startTest();
        
        SalesDeskLogSettings__c obj = (SalesDeskLogSettings__c)TestFactory.createSObject(new SalesDeskLogSettings__c(), true);
        
        integer count = database.countQuery('select count() from SalesDeskLogSettings__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void SalesDispositionsDefaultsTest()
    {
        test.startTest();
        
        SalesDispositions__c obj = (SalesDispositions__c)TestFactory.createSObject(new SalesDispositions__c(), true);
        
        integer count = database.countQuery('select count() from SalesDispositions__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void SalesUp_Status_SettingsDefaultsTest()
    {
        test.startTest();
        
        SalesUp_Status_Settings__c obj = (SalesUp_Status_Settings__c)TestFactory.createSObject(new SalesUp_Status_Settings__c(), true);
        
        integer count = database.countQuery('select count() from SalesUp_Status_Settings__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Sales_UpDefaultsTest()
    {
        test.startTest();
        
        Sales_Up__c obj = (Sales_Up__c)TestFactory.createSObject(new Sales_Up__c(), true);
        
        integer count = database.countQuery('select count() from Sales_Up__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void SchedulerSelectionDefaultsTest()
    {
        test.startTest();
        
        SchedulerSelection__c obj = (SchedulerSelection__c)TestFactory.createSObject(new SchedulerSelection__c(), true);
        
        integer count = database.countQuery('select count() from SchedulerSelection__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void ServiceLaborRateDefaultDefaultsTest()
    {
        test.startTest();
        
        ServiceLaborRateDefault__c obj = (ServiceLaborRateDefault__c)TestFactory.createSObject(new ServiceLaborRateDefault__c(), true);
        
        integer count = database.countQuery('select count() from ServiceLaborRateDefault__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Service_ContractDefaultsTest()
    {
        test.startTest();
        
        Service_Contract__c obj = (Service_Contract__c)TestFactory.createSObject(new Service_Contract__c(), true);
        
        integer count = database.countQuery('select count() from Service_Contract__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Service_EstimateDefaultsTest()
    {
        test.startTest();
        
        Service_Estimate__c obj = (Service_Estimate__c)TestFactory.createSObject(new Service_Estimate__c(), true);
        
        integer count = database.countQuery('select count() from Service_Estimate__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Service_Loyalty_EventDefaultsTest()
    {
        test.startTest();
        
        Service_Loyalty_Event__c obj = (Service_Loyalty_Event__c)TestFactory.createSObject(new Service_Loyalty_Event__c(), true);
        
        integer count = database.countQuery('select count() from Service_Loyalty_Event__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Service_VehicleDefaultsTest()
    {
        test.startTest();
        
        Service_Vehicle__c obj = (Service_Vehicle__c)TestFactory.createSObject(new Service_Vehicle__c(), true);
        
        integer count = database.countQuery('select count() from Service_Vehicle__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Special_Order_LineDefaultsTest()
    {
        test.startTest();
        
        Special_Order_Line__c obj = (Special_Order_Line__c)TestFactory.createSObject(new Special_Order_Line__c(), true);
        
        integer count = database.countQuery('select count() from Special_Order_Line__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Special_OrderDefaultsTest()
    {
        test.startTest();
        
        Special_Order__c obj = (Special_Order__c)TestFactory.createSObject(new Special_Order__c(), true);
        
        integer count = database.countQuery('select count() from Special_Order__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void StandardOpCodeDefaultsTest()
    {
        test.startTest();
        
        StandardOpCode__c obj = (StandardOpCode__c)TestFactory.createSObject(new StandardOpCode__c(), true);
        
        integer count = database.countQuery('select count() from StandardOpCode__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Stock_OrderDefaultsTest()
    {
        test.startTest();
        
        Stock_Order__c obj = (Stock_Order__c)TestFactory.createSObject(new Stock_Order__c(), true);
        
        integer count = database.countQuery('select count() from Stock_Order__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void SurveyDefaultsTest()
    {
        test.startTest();
        
        Survey__c obj = (Survey__c)TestFactory.createSObject(new Survey__c(), true);
        
        integer count = database.countQuery('select count() from Survey__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void System_LogDefaultsTest()
    {
        test.startTest();
        
        System_Log__c obj = (System_Log__c)TestFactory.createSObject(new System_Log__c(), true);
        
        integer count = database.countQuery('select count() from System_Log__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Tax_ZonesDefaultsTest()
    {
        test.startTest();
        
        Tax_Zones__c obj = (Tax_Zones__c)TestFactory.createSObject(new Tax_Zones__c(), true);
        
        integer count = database.countQuery('select count() from Tax_Zones__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Time_ClockDefaultsTest()
    {
        test.startTest();
        
        Time_Clock__c obj = (Time_Clock__c)TestFactory.createSObject(new Time_Clock__c(), true);
        
        integer count = database.countQuery('select count() from Time_Clock__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Traffic_LogDefaultsTest()
    {
        test.startTest();
        
        Traffic_Log__c obj = (Traffic_Log__c)TestFactory.createSObject(new Traffic_Log__c(), true);
        
        integer count = database.countQuery('select count() from Traffic_Log__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void VehicleModelDefaultsTest()
    {
        test.startTest();
        
        VehicleModel__c obj = (VehicleModel__c)TestFactory.createSObject(new VehicleModel__c(), true);
        
        integer count = database.countQuery('select count() from VehicleModel__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void Vehicle_Inventory_Status_Code_HistoryDefaultsTest()
    {
        test.startTest();
        
        Vehicle_Inventory_Status_Code_History__c obj = (Vehicle_Inventory_Status_Code_History__c)TestFactory.createSObject(new Vehicle_Inventory_Status_Code_History__c(), true);
        
        integer count = database.countQuery('select count() from Vehicle_Inventory_Status_Code_History__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void VINDecoderCSDefaultsTest()
    {
        test.startTest();
        
        VINDecoderCS__c obj = (VINDecoderCS__c)TestFactory.createSObject(new VINDecoderCS__c(), true);
        
        integer count = database.countQuery('select count() from VINDecoderCS__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void We_OweDefaultsTest()
    {
        test.startTest();
        
        We_Owe__c obj = (We_Owe__c)TestFactory.createSObject(new We_Owe__c(), true);
        
        integer count = database.countQuery('select count() from We_Owe__c');
        System.assertEquals(1, count);
        
        test.stopTest();
    }
    
    @isTest static void testCreateSObjectAccount(){
        test.startTest();        
        Account a = (Account)TestFactory.createSObject(new Account(), 'TestFactoryFieldData.AccountDefaults',true);
        Account[] b = (Account[])TestFactory.createSObjectList(new Account(), 5);
        Account[] c = (Account[])TestFactory.createSObjectList(new Account(), 5, true);
        Account[] d = (Account[])TestFactory.createSObjectList(new Account(), 5,'TestFactoryFieldData.AccountDefaults', true); 
        Account[] e = (Account[])TestFactory.createSObjectList(new Account(), 5,'TestFactoryFieldData.AccountDefaults'); 
        Integer count = database.countQuery('select count() from Account');
        test.stopTest();
    }
    
    @isTest static void testCreateSObjectReward_Transaction(){
        Reward_Transaction__c objReward_Transaction = (Reward_Transaction__c)TestFactory.createSObject(new Reward_Transaction__c(),'TestFactoryFieldData.Reward_TransactionDefaults');
        integer count = database.countQuery('select count() from Reward_Transaction__c');
    }
    
    
    @isTest static void testCreateSObjectRO_Status_Settings(){
        RO_Status_Settings__c objRO_Status_Settings = (RO_Status_Settings__c)TestFactory.createSObject(new RO_Status_Settings__c(),'TestFactoryFieldData.RO_Status_SettingsDefaults');
        integer count = database.countQuery('select count() from RO_Status_Settings__c');
    }
    
    
    @isTest static void testCreateSObjectSalesDeskLogSettings(){
        SalesDeskLogSettings__c objSalesDeskLogSettings = (SalesDeskLogSettings__c)TestFactory.createSObject(new SalesDeskLogSettings__c(),'TestFactoryFieldData.SalesDeskLogSettingsDefaults');
        integer count = database.countQuery('select count() from SalesDeskLogSettings__c');
    }
    
    
    @isTest static void testCreateSObjectSalesDispositions(){
        SalesDispositions__c objSalesDispositions = (SalesDispositions__c)TestFactory.createSObject(new SalesDispositions__c(),'TestFactoryFieldData.SalesDispositionsDefaults');
        integer count = database.countQuery('select count() from SalesDispositions__c');
    }
    
    
    @isTest static void testCreateSObjectSalesUp_Status_Settings(){
        SalesUp_Status_Settings__c objSalesUp_Status_Settings = (SalesUp_Status_Settings__c)TestFactory.createSObject(new SalesUp_Status_Settings__c(),'TestFactoryFieldData.SalesUp_Status_SettingsDefaults');
        integer count = database.countQuery('select count() from SalesUp_Status_Settings__c');
    }
    
    
    @isTest static void testCreateSObjectSales_Appointment(){
        Sales_Appointment__c objSales_Appointment = (Sales_Appointment__c)TestFactory.createSObject(new Sales_Appointment__c(),'TestFactoryFieldData.Sales_AppointmentDefaults');
        integer count = database.countQuery('select count() from Sales_Appointment__c');
    }
    
    
    @isTest static void testCreateSObjectSales_Fee(){
        Sales_Fee__c objSales_Fee = (Sales_Fee__c)TestFactory.createSObject(new Sales_Fee__c(),'TestFactoryFieldData.Sales_FeeDefaults');
        integer count = database.countQuery('select count() from Sales_Fee__c');
    }
    
    
    @isTest static void testCreateSObjectSales_Up(){
        Sales_Up__c objSales_Up = (Sales_Up__c)TestFactory.createSObject(new Sales_Up__c(),'TestFactoryFieldData.Sales_UpDefaults');
        integer count = database.countQuery('select count() from Sales_Up__c');
    }
    
    
    @isTest static void testCreateSObjectSchedulerSelection(){
        SchedulerSelection__c objSchedulerSelection = (SchedulerSelection__c)TestFactory.createSObject(new SchedulerSelection__c(),'TestFactoryFieldData.SchedulerSelectionDefaults');
        integer count = database.countQuery('select count() from SchedulerSelection__c');
    }
    
    
    @isTest static void testCreateSObjectService_Appointment_Line(){
        Service_Appointment_Line__c objService_Appointment_Line = (Service_Appointment_Line__c)TestFactory.createSObject(new Service_Appointment_Line__c(),'TestFactoryFieldData.Service_Appointment_LineDefaults');
        integer count = database.countQuery('select count() from Service_Appointment_Line__c');
    }
    
    
    @isTest static void testCreateSObjectService_Appointment(){
        Service_Appointment__c objService_Appointment = (Service_Appointment__c)TestFactory.createSObject(new Service_Appointment__c(),'TestFactoryFieldData.Service_AppointmentDefaults');
        integer count = database.countQuery('select count() from Service_Appointment__c');
    }
    
    
    @isTest static void testCreateSObjectService_Contract(){
        Service_Contract__c objService_Contract = (Service_Contract__c)TestFactory.createSObject(new Service_Contract__c(),'TestFactoryFieldData.Service_ContractDefaults');
        integer count = database.countQuery('select count() from Service_Contract__c');
    }
    
    
    @isTest static void testCreateSObjectService_Estimate_Line(){
        Service_Estimate_Line__c objService_Estimate_Line = (Service_Estimate_Line__c)TestFactory.createSObject(new Service_Estimate_Line__c(),'TestFactoryFieldData.Service_Estimate_LineDefaults');
        integer count = database.countQuery('select count() from Service_Estimate_Line__c');
    }
    
    
    @isTest static void testCreateSObjectService_Estimate(){
        Service_Estimate__c objService_Estimate = (Service_Estimate__c)TestFactory.createSObject(new Service_Estimate__c(),'TestFactoryFieldData.Service_EstimateDefaults');
        integer count = database.countQuery('select count() from Service_Estimate__c');
    }
    
    
    @isTest static void testCreateSObjectService_Job(){
        Service_Job__c objService_Job = (Service_Job__c)TestFactory.createSObject(new Service_Job__c(),'TestFactoryFieldData.Service_JobDefaults');
        integer count = database.countQuery('select count() from Service_Job__c');
    }
    
    
    @isTest static void testCreateSObjectService_Loyalty_Event(){
        Service_Loyalty_Event__c objService_Loyalty_Event = (Service_Loyalty_Event__c)TestFactory.createSObject(new Service_Loyalty_Event__c(),'TestFactoryFieldData.Service_Loyalty_EventDefaults');
        integer count = database.countQuery('select count() from Service_Loyalty_Event__c');
    }
    
    
    @isTest static void testCreateSObjectService_Misc_Charge(){
        Service_Misc_Charge__c objService_Misc_Charge = (Service_Misc_Charge__c)TestFactory.createSObject(new Service_Misc_Charge__c(),'TestFactoryFieldData.Service_Misc_ChargeDefaults');
        integer count = database.countQuery('select count() from Service_Misc_Charge__c');
    }
    
    
    @isTest static void testCreateSObjectService_Repair_Order(){
        Service_Repair_Order__c objService_Repair_Order = (Service_Repair_Order__c)TestFactory.createSObject(new Service_Repair_Order__c(),'TestFactoryFieldData.Service_Repair_OrderDefaults');
        integer count = database.countQuery('select count() from Service_Repair_Order__c');
    }
    
    
    @isTest static void testCreateSObjectService_Vehicle_Equipment(){
        Service_Vehicle_Equipment__c objService_Vehicle_Equipment = (Service_Vehicle_Equipment__c)TestFactory.createSObject(new Service_Vehicle_Equipment__c(),'TestFactoryFieldData.Service_Vehicle_EquipmentDefaults');
        integer count = database.countQuery('select count() from Service_Vehicle_Equipment__c');
    }
    
    
    @isTest static void testCreateSObjectService_Vehicle(){
        Service_Vehicle__c objService_Vehicle = (Service_Vehicle__c)TestFactory.createSObject(new Service_Vehicle__c(),'TestFactoryFieldData.Service_VehicleDefaults');
        integer count = database.countQuery('select count() from Service_Vehicle__c');
    }
    
    
    @isTest static void testCreateSObjectSpecial_Order_Line(){
        Special_Order_Line__c objSpecial_Order_Line = (Special_Order_Line__c)TestFactory.createSObject(new Special_Order_Line__c(),'TestFactoryFieldData.Special_Order_LineDefaults');
        integer count = database.countQuery('select count() from Special_Order_Line__c');
    }
    
    
    @isTest static void testCreateSObjectSpecial_Order(){
        Special_Order__c objSpecial_Order = (Special_Order__c)TestFactory.createSObject(new Special_Order__c(),'TestFactoryFieldData.Special_OrderDefaults');
        integer count = database.countQuery('select count() from Special_Order__c');
    }
    
    
    @isTest static void testCreateSObjectStandardOpCode(){
        StandardOpCode__c objStandardOpCode = (StandardOpCode__c)TestFactory.createSObject(new StandardOpCode__c(),'TestFactoryFieldData.StandardOpCodeDefaults');
        integer count = database.countQuery('select count() from StandardOpCode__c');
    }
    
    
    @isTest static void testCreateSObjectStock_Number_Book(){
        Stock_Number_Book__c objStock_Number_Book = (Stock_Number_Book__c)TestFactory.createSObject(new Stock_Number_Book__c(),'TestFactoryFieldData.Stock_Number_BookDefaults');
        integer count = database.countQuery('select count() from Stock_Number_Book__c');
    }
    
    
    @isTest static void testCreateSObjectStock_Order_Line(){
        Stock_Order_Line__c objStock_Order_Line = (Stock_Order_Line__c)TestFactory.createSObject(new Stock_Order_Line__c(),'TestFactoryFieldData.Stock_Order_LineDefaults');
        integer count = database.countQuery('select count() from Stock_Order_Line__c');
    }
    
    
    @isTest static void testCreateSObjectStock_Order(){
        Stock_Order__c objStock_Order = (Stock_Order__c)TestFactory.createSObject(new Stock_Order__c(),'TestFactoryFieldData.Stock_OrderDefaults');
        integer count = database.countQuery('select count() from Stock_Order__c');
    }
    
    
    @isTest static void testCreateSObjectSurvey_Question(){
        Survey_Question__c objSurvey_Question = (Survey_Question__c)TestFactory.createSObject(new Survey_Question__c(),'TestFactoryFieldData.Survey_QuestionDefaults');
        integer count = database.countQuery('select count() from Survey_Question__c');
    }
    
    
    @isTest static void testCreateSObjectSurvey(){
        Survey__c objSurvey = (Survey__c)TestFactory.createSObject(new Survey__c(),'TestFactoryFieldData.SurveyDefaults');
        integer count = database.countQuery('select count() from Survey__c');
    }
    
    
    @isTest static void testCreateSObjectSystem_Log(){
        System_Log__c objSystem_Log = (System_Log__c)TestFactory.createSObject(new System_Log__c(),'TestFactoryFieldData.System_LogDefaults');
        integer count = database.countQuery('select count() from System_Log__c');
    }
    
    
    @isTest static void testCreateSObjectCRMSettings(){
        CRMSettings__c objCRMSettings = (CRMSettings__c)TestFactory.createSObject(new CRMSettings__c(),'TestFactoryFieldData.CRMSettingsDefaults');
        integer count = database.countQuery('select count() from CRMSettings__c');
    }
    
    
    @isTest static void testCreateSObjectCustom_Equipment(){
        Custom_Equipment__c objCustom_Equipment = (Custom_Equipment__c)TestFactory.createSObject(new Custom_Equipment__c(),'TestFactoryFieldData.Custom_EquipmentDefaults');
        integer count = database.countQuery('select count() from Custom_Equipment__c');
    }
    
    
    @isTest static void testCreateSObjectDealer_Location(){
        Dealer_Location__c objDealer_Location = (Dealer_Location__c)TestFactory.createSObject(new Dealer_Location__c(),'TestFactoryFieldData.Dealer_LocationDefaults');
        integer count = database.countQuery('select count() from Dealer_Location__c');
    }
    
    
    @isTest static void testCreateSObjectDealer_Trade(){
        Dealer_Trade__c objDealer_Trade = (Dealer_Trade__c)TestFactory.createSObject(new Dealer_Trade__c(),'TestFactoryFieldData.Dealer_TradeDefaults');
        integer count = database.countQuery('select count() from Dealer_Trade__c');
    }
    
    
    @isTest static void testCreateSObjectDeal_Payment(){
        Deal_Payment__c objDeal_Payment = (Deal_Payment__c)TestFactory.createSObject(new Deal_Payment__c(),'TestFactoryFieldData.Deal_PaymentDefaults');
        integer count = database.countQuery('select count() from Deal_Payment__c');
    }
    
    
    @isTest static void testCreateSObjectDeal_Status_Map_Setting(){
        Deal_Status_Map_Setting__c objDeal_Status_Map_Setting = (Deal_Status_Map_Setting__c)TestFactory.createSObject(new Deal_Status_Map_Setting__c(),'TestFactoryFieldData.Deal_Status_Map_SettingDefaults');
        integer count = database.countQuery('select count() from Deal_Status_Map_Setting__c');
    }
    
    
    @isTest static void testCreateSObjectDeal_Tax(){
        Deal_Tax__c objDeal_Tax = (Deal_Tax__c)TestFactory.createSObject(new Deal_Tax__c(),'TestFactoryFieldData.Deal_TaxDefaults');
        integer count = database.countQuery('select count() from Deal_Tax__c');
    }
    
    
    @isTest static void testCreateSObjectDeal(){
        Deal__c objDeal = (Deal__c)TestFactory.createSObject(new Deal__c(),'TestFactoryFieldData.DealDefaults');
        integer count = database.countQuery('select count() from Deal__c');
    }
    
    
    @isTest static void testCreateSObjectDesired_Vehicle(){
        Desired_Vehicle__c objDesired_Vehicle = (Desired_Vehicle__c)TestFactory.createSObject(new Desired_Vehicle__c(),'TestFactoryFieldData.Desired_VehicleDefaults');
        integer count = database.countQuery('select count() from Desired_Vehicle__c');
    }
    
    
    @isTest static void testCreateSObjectDiscount_Rebate(){
        Discount_Rebate__c objDiscount_Rebate = (Discount_Rebate__c)TestFactory.createSObject(new Discount_Rebate__c(),'TestFactoryFieldData.Discount_RebateDefaults');
        integer count = database.countQuery('select count() from Discount_Rebate__c');
    }
    
    
    @isTest static void testCreateSObjectDMS_Settings(){
        DMS_Settings__c objDMS_Settings = (DMS_Settings__c)TestFactory.createSObject(new DMS_Settings__c(),'TestFactoryFieldData.DMS_SettingsDefaults');
        integer count = database.countQuery('select count() from DMS_Settings__c');
    }
    
    
    @isTest static void testCreateSObjectDriver(){
        Driver__c objDriver = (Driver__c)TestFactory.createSObject(new Driver__c(),'TestFactoryFieldData.DriverDefaults');
        integer count = database.countQuery('select count() from Driver__c');
    }
    
    
    @isTest static void testCreateSObjectEmployee(){
        Employee__c objEmployee = (Employee__c)TestFactory.createSObject(new Employee__c(),'TestFactoryFieldData.EmployeeDefaults');
        integer count = database.countQuery('select count() from Employee__c');
    }
    
    
    @isTest static void testCreateSObjectEquipment_Master(){
        Equipment_Master__c objEquipment_Master = (Equipment_Master__c)TestFactory.createSObject(new Equipment_Master__c(),'TestFactoryFieldData.Equipment_MasterDefaults');
        integer count = database.countQuery('select count() from Equipment_Master__c');
    }
    
    
    @isTest static void testCreateSObjectEquity(){
        Equity__c objEquity = (Equity__c)TestFactory.createSObject(new Equity__c(),'TestFactoryFieldData.EquityDefaults');
        integer count = database.countQuery('select count() from Equity__c');
    }
    
    
    @isTest static void testCreateSObjectFinance_Company(){
        Finance_Company__c objFinance_Company = (Finance_Company__c)TestFactory.createSObject(new Finance_Company__c(),'TestFactoryFieldData.Finance_CompanyDefaults');
        integer count = database.countQuery('select count() from Finance_Company__c');
    }
    
    
    @isTest static void testCreateSObjectFit_Guide(){
        Fit_Guide__c objFit_Guide = (Fit_Guide__c)TestFactory.createSObject(new Fit_Guide__c(),'TestFactoryFieldData.Fit_GuideDefaults');
        integer count = database.countQuery('select count() from Fit_Guide__c');
    }
    
    
    @isTest static void testCreateSObjectFixedOperationsSettings(){
        FixedOperationsSettings__c objFixedOperationsSettings = (FixedOperationsSettings__c)TestFactory.createSObject(new FixedOperationsSettings__c(),'TestFactoryFieldData.FixedOperationsSettingsDefaults');
        integer count = database.countQuery('select count() from FixedOperationsSettings__c');
    }
    
    
    @isTest static void testCreateSObjectForm(){
        Form__c objForm = (Form__c)TestFactory.createSObject(new Form__c(),'TestFactoryFieldData.FormDefaults');
        integer count = database.countQuery('select count() from Form__c');
    }
    
    
    @isTest static void testCreateSObjectGL_Accounts(){
        GL_Accounts__c objGL_Accounts = (GL_Accounts__c)TestFactory.createSObject(new GL_Accounts__c(),'TestFactoryFieldData.GL_AccountsDefaults');
        integer count = database.countQuery('select count() from GL_Accounts__c');
    }
    
    
    @isTest static void testCreateSObjectGL(){
        GL__c objGL = (GL__c)TestFactory.createSObject(new GL__c(),'TestFactoryFieldData.GLDefaults');
        integer count = database.countQuery('select count() from GL__c');
    }
    
    
    @isTest static void testCreateSObjectInspection_Report_Lines(){
        Inspection_Report_Lines__c objInspection_Report_Lines = (Inspection_Report_Lines__c)TestFactory.createSObject(new Inspection_Report_Lines__c(),'TestFactoryFieldData.Inspection_Report_LinesDefaults');
        integer count = database.countQuery('select count() from Inspection_Report_Lines__c');
    }
    
    
    @isTest static void testCreateSObjectInspection_Report(){
        Inspection_Report__c objInspection_Report = (Inspection_Report__c)TestFactory.createSObject(new Inspection_Report__c(),'TestFactoryFieldData.Inspection_ReportDefaults');
        integer count = database.countQuery('select count() from Inspection_Report__c');
    }
    
    
    @isTest static void testCreateSObjectIntercompanyLeadRouting(){
        IntercompanyLeadRouting__c objIntercompanyLeadRouting = (IntercompanyLeadRouting__c)TestFactory.createSObject(new IntercompanyLeadRouting__c(),'TestFactoryFieldData.IntercompanyLeadRoutingDefaults');
        integer count = database.countQuery('select count() from IntercompanyLeadRouting__c');
    }
    
    
    @isTest static void testCreateSObjectInventoryFeed(){
        InventoryFeed__c objInventoryFeed = (InventoryFeed__c)TestFactory.createSObject(new InventoryFeed__c(),'TestFactoryFieldData.InventoryFeedDefaults');
        integer count = database.countQuery('select count() from InventoryFeed__c');
    }
    
    
    @isTest static void testCreateSObjectInventory_Images(){
        Inventory_Images__c objInventory_Images = (Inventory_Images__c)TestFactory.createSObject(new Inventory_Images__c(),'TestFactoryFieldData.Inventory_ImagesDefaults');
        integer count = database.countQuery('select count() from Inventory_Images__c');
    }
    
    
    @isTest static void testCreateSObjectKit_Category(){
        Kit_Category__c objKit_Category = (Kit_Category__c)TestFactory.createSObject(new Kit_Category__c(),'TestFactoryFieldData.Kit_CategoryDefaults');
        integer count = database.countQuery('select count() from Kit_Category__c');
    }
    
    
    @isTest static void testCreateSObjectMisc_Tax_Codes(){
        Misc_Tax_Codes__c objMisc_Tax_Codes = (Misc_Tax_Codes__c)TestFactory.createSObject(new Misc_Tax_Codes__c(),'TestFactoryFieldData.Misc_Tax_CodesDefaults');
        integer count = database.countQuery('select count() from Misc_Tax_Codes__c');
    }
    
    
    @isTest static void testCreateSObjectMobileApplicationSettings(){
        MobileApplicationSettings__c objMobileApplicationSettings = (MobileApplicationSettings__c)TestFactory.createSObject(new MobileApplicationSettings__c(),'TestFactoryFieldData.MobileApplicationSettingsDefaults');
        integer count = database.countQuery('select count() from MobileApplicationSettings__c');
    }
    
    
    @isTest static void testCreateSObjectMobileAppSettings(){
        MobileAppSettings__c objMobileAppSettings = (MobileAppSettings__c)TestFactory.createSObject(new MobileAppSettings__c(),'TestFactoryFieldData.MobileAppSettingsDefaults');
        integer count = database.countQuery('select count() from MobileAppSettings__c');
    }
    
    
    @isTest static void testCreateSObjectOrganizationDefaults(){
        OrganizationDefaults__c objOrganizationDefaults = (OrganizationDefaults__c)TestFactory.createSObject(new OrganizationDefaults__c(),'TestFactoryFieldData.OrganizationDefaultsDefaults');
        integer count = database.countQuery('select count() from OrganizationDefaults__c');
    }
    
    
    @isTest static void testCreateSObjectOrganizationLocationSettings(){
        OrganizationLocationSettings__c objOrganizationLocationSettings = (OrganizationLocationSettings__c)TestFactory.createSObject(new OrganizationLocationSettings__c(),'TestFactoryFieldData.OrganizationLocationSettingsDefaults');
        integer count = database.countQuery('select count() from OrganizationLocationSettings__c');
    }
    
    
    @isTest static void testCreateSObjectPartsPhysicalDetail(){
        PartsPhysicalDetail__c objPartsPhysicalDetail = (PartsPhysicalDetail__c)TestFactory.createSObject(new PartsPhysicalDetail__c(),'TestFactoryFieldData.PartsPhysicalDetailDefaults');
        integer count = database.countQuery('select count() from PartsPhysicalDetail__c');
    }
    
    
    @isTest static void testCreateSObjectParts_Inventory(){
        Parts_Inventory__c objParts_Inventory = (Parts_Inventory__c)TestFactory.createSObject(new Parts_Inventory__c(),'TestFactoryFieldData.Parts_InventoryDefaults');
        integer count = database.countQuery('select count() from Parts_Inventory__c');
    }
    
    
    @isTest static void testCreateSObjectParts_Invoice(){
        Parts_Invoice__c objParts_Invoice = (Parts_Invoice__c)TestFactory.createSObject(new Parts_Invoice__c(),'TestFactoryFieldData.Parts_InvoiceDefaults');
        integer count = database.countQuery('select count() from Parts_Invoice__c');
    }
    
    
    @isTest static void testCreateSObjectParts_Kit_Item(){
        Parts_Kit_Item__c objParts_Kit_Item = (Parts_Kit_Item__c)TestFactory.createSObject(new Parts_Kit_Item__c(),'TestFactoryFieldData.Parts_Kit_ItemDefaults');
        integer count = database.countQuery('select count() from Parts_Kit_Item__c');
    }
    
    
    @isTest static void testCreateSObjectParts_Kit(){
        Parts_Kit__c objParts_Kit = (Parts_Kit__c)TestFactory.createSObject(new Parts_Kit__c(),'TestFactoryFieldData.Parts_KitDefaults');
        integer count = database.countQuery('select count() from Parts_Kit__c');
    }
    
    
    @isTest static void testCreateSObjectParts_Ledger(){
        Parts_Ledger__c objParts_Ledger = (Parts_Ledger__c)TestFactory.createSObject(new Parts_Ledger__c(),'TestFactoryFieldData.Parts_LedgerDefaults');
        integer count = database.countQuery('select count() from Parts_Ledger__c');
    }
    
    
    @isTest static void testCreateSObjectParts_Master(){
        Parts_Master__c objParts_Master = (Parts_Master__c)TestFactory.createSObject(new Parts_Master__c(),'TestFactoryFieldData.Parts_MasterDefaults');
        integer count = database.countQuery('select count() from Parts_Master__c');
    }
    
    
    @isTest static void testCreateSObjectParts_Order(){
        Parts_Order__c objParts_Order = (Parts_Order__c)TestFactory.createSObject(new Parts_Order__c(),'TestFactoryFieldData.Parts_OrderDefaults');
        integer count = database.countQuery('select count() from Parts_Order__c');
    }
    
    
    @isTest static void testCreateSObjectParts_Quote_Line(){
        Parts_Quote_Line__c objParts_Quote_Line = (Parts_Quote_Line__c)TestFactory.createSObject(new Parts_Quote_Line__c(),'TestFactoryFieldData.Parts_Quote_LineDefaults');
        integer count = database.countQuery('select count() from Parts_Quote_Line__c');
    }
    
    
    @isTest static void testCreateSObjectParts_Quote(){
        Parts_Quote__c objParts_Quote = (Parts_Quote__c)TestFactory.createSObject(new Parts_Quote__c(),'TestFactoryFieldData.Parts_QuoteDefaults');
        integer count = database.countQuery('select count() from Parts_Quote__c');
    }
    
    
    @isTest static void testCreateSObjectParts_Service_Pricing_Strategy(){
        Parts_Service_Pricing_Strategy__c objParts_Service_Pricing_Strategy = (Parts_Service_Pricing_Strategy__c)TestFactory.createSObject(new Parts_Service_Pricing_Strategy__c(),'TestFactoryFieldData.Parts_Service_Pricing_StrategyDefaults');
        integer count = database.countQuery('select count() from Parts_Service_Pricing_Strategy__c');
    }
    
    
    @isTest static void testCreateSObjectPart_Inventory_History(){
        Part_Inventory_History__c objPart_Inventory_History = (Part_Inventory_History__c)TestFactory.createSObject(new Part_Inventory_History__c(),'TestFactoryFieldData.Part_Inventory_HistoryDefaults');
        integer count = database.countQuery('select count() from Part_Inventory_History__c');
    }
    
    
    @isTest static void testCreateSObjectPaymentMethods(){
        PaymentMethods__c objPaymentMethods = (PaymentMethods__c)TestFactory.createSObject(new PaymentMethods__c(),'TestFactoryFieldData.PaymentMethodsDefaults');
        integer count = database.countQuery('select count() from PaymentMethods__c');
    }
    
    
    @isTest static void testCreateSObjectPostingTemplateRule(){
        PostingTemplateRule__c objPostingTemplateRule = (PostingTemplateRule__c)TestFactory.createSObject(new PostingTemplateRule__c(),'TestFactoryFieldData.PostingTemplateRuleDefaults');
        integer count = database.countQuery('select count() from PostingTemplateRule__c');
    }
    
    
    @isTest static void testCreateSObjectPurchase_Order_Line(){
        Purchase_Order_Line__c objPurchase_Order_Line = (Purchase_Order_Line__c)TestFactory.createSObject(new Purchase_Order_Line__c(),'TestFactoryFieldData.Purchase_Order_LineDefaults');
        integer count = database.countQuery('select count() from Purchase_Order_Line__c');
    }
    
    
    @isTest static void testCreateSObjectPurchase_Order(){
        Purchase_Order__c objPurchase_Order = (Purchase_Order__c)TestFactory.createSObject(new Purchase_Order__c(),'TestFactoryFieldData.Purchase_OrderDefaults');
        integer count = database.countQuery('select count() from Purchase_Order__c');
    }
    
    
    @isTest static void testCreateSObjectRentalSettings(){
        RentalSettings__c objRentalSettings = (RentalSettings__c)TestFactory.createSObject(new RentalSettings__c(),'TestFactoryFieldData.RentalSettingsDefaults');
        integer count = database.countQuery('select count() from RentalSettings__c');
    }
    
    
    @isTest static void testCreateSObjectRental_Accessories(){
        Rental_Accessories__c objRental_Accessories = (Rental_Accessories__c)TestFactory.createSObject(new Rental_Accessories__c(),'TestFactoryFieldData.Rental_AccessoriesDefaults');
        integer count = database.countQuery('select count() from Rental_Accessories__c');
    }
    
    
    @isTest static void testCreateSObjectRental_Agreements(){
        Rental_Agreements__c objRental_Agreements = (Rental_Agreements__c)TestFactory.createSObject(new Rental_Agreements__c(),'TestFactoryFieldData.Rental_AgreementsDefaults');
        integer count = database.countQuery('select count() from Rental_Agreements__c');
    }
    
    
    @isTest static void testCreateSObjectRental_Rates(){
        Rental_Rates__c objRental_Rates = (Rental_Rates__c)TestFactory.createSObject(new Rental_Rates__c(),'TestFactoryFieldData.Rental_RatesDefaults');
        integer count = database.countQuery('select count() from Rental_Rates__c');
    }
    
    
    @isTest static void testCreateSObjectRewards(){
        Rewards__c objRewards = (Rewards__c)TestFactory.createSObject(new Rewards__c(),'TestFactoryFieldData.RewardsDefaults');
        integer count = database.countQuery('select count() from Rewards__c');
    }
    
    
    @isTest static void testCreateSObjectReward_Journal(){
        Reward_Journal__c objReward_Journal = (Reward_Journal__c)TestFactory.createSObject(new Reward_Journal__c(),'TestFactoryFieldData.Reward_JournalDefaults');
        integer count = database.countQuery('select count() from Reward_Journal__c');
    }
    
    
    @isTest static void testCreateSObjectVehicle_Inventory(){
        Vehicle_Inventory__c objVehicle_Inventory = (Vehicle_Inventory__c)TestFactory.createSObject(new Vehicle_Inventory__c(),'TestFactoryFieldData.Vehicle_InventoryDefaults');
        integer count = database.countQuery('select count() from Vehicle_Inventory__c');
    }
    
}