@isTest
public class TaxAPI_Test {
    public static Deal__c SetupDealData() 
	{
		TestClassUtil tcu = new TestClassUtil();
		tcu.insertDMSSettings();
		Dealer_Location__c loc = TestClassUtil.insertDealerLocation('RD1', 'Redding Motorcar Company');
		loc.Deal_Fees__c ='[    {       "feeName":"Fee1",       "feeDescription":"asdflasdf",       "feeDefaultAmount":5,       "feeDefaultOnDeals":true,       "feeTaxable":true     },     {       "feeName":"Fee2",       "feeDescription":"asdflasdf",       "feeDefaultAmount":5,       "feeDefaultOnDeals":true,       "feeTaxable":true,       "bullshit":false     } ]';
		loc.Tax_Delivery_Address__c = true;
        upsert loc;
        
		// Insert Account
		Account a = new Account(FirstName='Jarrett', LastName='Kuljis', Tax_Id__c='{"TAXID":"test","TAXZONE","TEST"}');
		Account b = new Account(FirstName='Morgan', LastName='Kuljis');
		List<Account> accounts = new List<Account>{ a, b };
        insert accounts;
        
        //Create Tax Zones and Regions
        Tax_Zones__c zone = (Tax_Zones__c)TestFactory.createSObject(new Tax_Zones__c(),true);

		Tax_Region__c region = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'Vehicle', Rate__c = -5, JurisdictionType__c = 'State', RegionCode__c = 'Test'), true);
		TaxJunction__c junc = new TaxJunction__c(TaxRegion__c = region.Id, TaxZone__c = zone.Id);
		insert junc;

		Tax_Region__c vehRegion = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'Vehicle', Rate__c = 5, JurisdictionType__c = 'State', RegionCode__c = 'VehTest'), true);
		TaxJunction__c vJunc = new TaxJunction__c(TaxRegion__c = vehRegion.Id, TaxZone__c = zone.Id);
        insert vJunc;
        
        Tax_Region__c convRegion = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'Conversion', Rate__c = 5, JurisdictionType__c = 'State', RegionCode__c = 'VehTest'), true);
		TaxJunction__c conJunc = new TaxJunction__c(TaxRegion__c = convRegion.Id, TaxZone__c = zone.Id);
		insert conJunc;

		Tax_Region__c genRegion = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'General', Rate__c = 5, JurisdictionType__c = 'State', RegionCode__c = 'VehTest'), true);
		TaxJunction__c gJunc = new TaxJunction__c(TaxRegion__c = genRegion.Id, TaxZone__c = zone.Id);
        insert gJunc;
        
        Tax_Region__c laborRegion = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'Labor', Rate__c = 5, JurisdictionType__c = 'State', RegionCode__c = 'VehTest'), true);
		TaxJunction__c lJunc = new TaxJunction__c(TaxRegion__c = laborRegion.Id, TaxZone__c = zone.Id);
        insert lJunc;
        
        Tax_Region__c partRegion = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'Part', Rate__c = 5, JurisdictionType__c = 'State', RegionCode__c = 'VehTest'), true);
		TaxJunction__c pJunc = new TaxJunction__c(TaxRegion__c = partRegion.Id, TaxZone__c = zone.Id);
        insert pJunc;
        
        Tax_Region__c conRegion = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'Contract', Rate__c = 5, JurisdictionType__c = 'State', RegionCode__c = 'VehTest'), true);
		TaxJunction__c cJunc = new TaxJunction__c(TaxRegion__c = conRegion.Id, TaxZone__c = zone.Id);
        insert cJunc;

        Tax_Region__c feeRegion = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'Fee', Rate__c = 5, JurisdictionType__c = 'State', RegionCode__c = 'VehTest'), true);
		TaxJunction__c fJunc = new TaxJunction__c(TaxRegion__c = feeRegion.Id, TaxZone__c = zone.Id);
		insert fJunc;
        
		Contact c = [SELECT Id, AccountId FROM Contact WHERE AccountId=:a.Id Limit 1];

		// Create a vehicle inventory record
		Vehicle_Inventory__c VI = new Vehicle_Inventory__c();
			VI.Name = 'Test Vehicle Inventory';
			VI.Model__c = 'Civic';
			VI.Stock_Number__c = dealer.TestClassUtil.generateRandomString(8);
			VI.VIN__c = '5TDYK3DCXBS075856';
			VI.Company_Number__c = 'RD1';
			VI.Store_Location__c = loc.Id;
			VI.Year__c = '2014';
			VI.Make__c = 'Honda';
			VI.In_Stock__c = true;
		insert VI;

		// Create a Sales Up
        Sales_Up__c SU = new Sales_Up__c();     
			SU.Name = 'Test SalesUP';
			SU.Buyer_Contact__c = c.Id;
			SU.Customer_Account__c=a.Id;
			SU.Desired_Stock_Num__c = VI.Id;
			SU.Make__c = 'Honda';
		insert SU;		

		// Create a Deal
        Deal__c Deal = new Deal__c();
			Deal.Buyer__c = a.Id;
			Deal.Co_Buyer__c = b.Id;
			Deal.Buyer_Contact__c = c.Id;
			Deal.Store_Location__c = loc.Id;
			Deal.Deal_ID__c = '12345';
			Deal.Licence__c = '100';
			Deal.Vehicle__c = VI.Id;
			Deal.Name = '12342';
			Deal.Sales_Lead__c=SU.Id;
			Deal.Service_Vehicle__c=[SELECT Id FROM Service_Vehicle__c].Id;	
			Deal.Deal_Date__c=Date.today();
            Deal.TaxableFeeTotal__c = 100;
            Deal.Delivery_Date__c=Date.today();
            deal.Tax_Zone__c = zone.Id;
        insert Deal;

		// Create a Trade Record
		Service_Vehicle__c svTrade = new Service_Vehicle__c();
			svTrade.Year__c='2009';
			svTrade.Make__c='Peugeot';
			svTrade.Carline__c='208 GTI';
			svTrade.VIN__c='5FNRL5H90BB042364';
		insert svTrade;

		Trade_In__c trade = new Trade_In__c();
			trade.Car_Deal__c=Deal.Id;
			trade.Appraisal_Date__c=Date.today();
			trade.Year__c='2009';
			trade.Make__c='Peugeot';
			trade.Model__c='208 GTI';
			trade.VIN__c='5FNRL5H90BB042364';
			trade.Trade_Allowance__c=900;
			trade.Odometer_at_Trade_In__c=129089;
			trade.Service_Vehicle__c=svTrade.Id;
		insert trade;

		Appraisal__c app = new Appraisal__c();
		app.Service_Vehicle__c = svTrade.Id;
		app.Appraisal_Date__c = System.today();
        insert app;

        return deal;
    }

    @isTest
	static void testApplyTaxZone()
	{
        Deal__c deal = (Deal__c)Utility.queryAllFields('dealer__Deal__c', SetupDealData().Id);
       
        Test.startTest();
        deal.TaxableVehicleTotal__c = 500;
        deal.Total_Taxable_Equipment__c = 1000;
        deal.TaxableFeeTotal__c = 200;
        deal.TaxableConversionTotal__c = 5000;
        deal.TaxableContractTotal__c = 2500;
        deal.TaxablePartTotal__c = 100;
        deal.TaxableLaborTotal__c = 100;
        update deal;

        TaxAPI.CalculateTaxes(deal);

        Test.stopTest();

    }

    @isTest 
    static void testAfterMarket(){
        Deal__c deal = (Deal__c)Utility.queryAllFields('dealer__Deal__c', SetupDealData().Id);
       
        Test.startTest();
        deal.TaxableVehicleTotal__c = 500;
        deal.Total_Taxable_Equipment__c = 1000;
        deal.TaxableFeeTotal__c = 200;
        deal.TaxableConversionTotal__c = 5000;
        deal.TaxableContractTotal__c = 2500;
        deal.TaxablePartTotal__c = 100;
        deal.TaxableLaborTotal__c = 100;
        update deal;

        List<After_Market__c> am = new List<After_Market__c>{
            new After_Market__c(Car_Deal__c = deal.Id, Type__c = 'Part' , Taxable__c = true, Tax_Rate__c=5, Sale_Price__c = 10, Labor_Sale__c = 10, Quantity__c = 1, Labor_Hours__c = 1),
            new After_Market__c(Car_Deal__c = deal.Id, Type__c = 'Labor' , Taxable__c = true, Tax_Rate__c=5, Sale_Price__c = 10, Labor_Sale__c = 10, Quantity__c = 1, Labor_Hours__c = 1),
            new After_Market__c(Car_Deal__c = deal.Id, Type__c = 'Sublet' , Taxable__c = true, Tax_Rate__c=5, Sale_Price__c = 10, Labor_Sale__c = 10, Quantity__c = 1, Labor_Hours__c = 1),
            new After_Market__c(Car_Deal__c = deal.Id, Type__c = 'Misc' , Taxable__c = true, Tax_Rate__c=5, Sale_Price__c = 10, Labor_Sale__c = 10, Quantity__c = 1, Labor_Hours__c = 1)
        };
        
        insert am;

        TaxAPI taxCalc = new TaxAPI();
        List<TaxAPI.afterMarketTaxRegions> taxItems = taxCalc.calculateAfterMarketItemsTax(am, new Tax_Zones__c(Id=[SELECT id FROM Tax_Zones__c LIMIT 1].Id));
        taxCalc.applyAfterMarketTaxes(taxItems);
        TaxAPI.CalculateTaxes(deal);

        Test.stopTest();
    }

    @isTest
	static void testManualTax()
	{
        Deal__c deal = (Deal__c)Utility.queryAllFields('dealer__Deal__c', SetupDealData().Id);
       
        deal.TaxableVehicleTotal__c = 500;
        deal.Total_Taxable_Equipment__c = 1000;
        deal.TaxableFeeTotal__c = 200;
        deal.TaxableConversionTotal__c = 5000;
        deal.TaxableContractTotal__c = 2500;
        deal.TaxablePartTotal__c = 100;
        deal.TaxableLaborTotal__c = 100;
        deal.Tax_Zone__c = null;

        update deal;

        //Clear out setup Regions
        delete [SELECT Id FROM Tax_Region__c];
        delete [SELECT Id FROM TaxJunction__c];
        List<TaxTransactionItem__c> ttis = new List<TaxTransactionItem__c>{
            new TaxTransactionItem__c(Rate__c = 5, ManualOverride__c = true, RateType__c ='General', JurisdictionType__c ='State',DealTax__c = deal.Id, SObjectId__c = deal.Id),
            new TaxTransactionItem__c(Rate__c = 5, ManualOverride__c = true, RateType__c ='Vehicle', JurisdictionType__c ='State',DealTax__c = deal.Id, SObjectId__c = deal.Id),
            new TaxTransactionItem__c(Rate__c = 5, ManualOverride__c = true, RateType__c ='Conversion', JurisdictionType__c ='State',DealTax__c = deal.Id, SObjectId__c = deal.Id),
            new TaxTransactionItem__c(Rate__c = 5, ManualOverride__c = true, RateType__c ='Part', JurisdictionType__c ='State',DealTax__c = deal.Id, SObjectId__c = deal.Id),
            new TaxTransactionItem__c(Rate__c = 5, ManualOverride__c = true, RateType__c ='Labor', JurisdictionType__c ='State',DealTax__c = deal.Id, SObjectId__c = deal.Id),
            new TaxTransactionItem__c(Rate__c = 5, ManualOverride__c = true, RateType__c ='Fee', JurisdictionType__c ='State',DealTax__c = deal.Id, SObjectId__c = deal.Id),
            new TaxTransactionItem__c(Rate__c = 5, ManualOverride__c = true, RateType__c ='Contract', JurisdictionType__c ='State',DealTax__c = deal.Id, SObjectId__c = deal.Id)
        };
        insert ttis;

        TaxAPI.CalculateTaxes(deal);

    }

    @isTest
    static void testExpiredTaxRegion(){
        Deal__c deal = SetupDealData();

        Dealer_Location__c loc = [SELECT Id FROM Dealer_Location__c LIMIT 1];
        loc.TaxationDateDeal__c = 'dealer__Delivery_Date__c';
        update loc;

        //Clear out setup Regions
        delete [SELECT Id FROM Tax_Region__c];
        delete [SELECT Id FROM TaxJunction__c];

        // 1: Test that a TTI will not be created if taxation date is later than Expiration Date
        Tax_Zones__c zone = [SELECT Id FROM Tax_Zones__c LIMIT 1];
		Tax_Region__c region = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'General', ExpirationDate__c = Date.Today().addDays(-1), Rate__c = -5, JurisdictionType__c = 'State', RegionCode__c = 'Test'), true);
		TaxJunction__c junc = new TaxJunction__c(TaxRegion__c = region.Id, TaxZone__c = zone.Id);
        insert junc;

        deal = (Deal__c)Utility.queryAllFields('dealer__Deal__c', deal.Id);

        TaxAPI.calculateTaxes(deal);

        TaxTransactionItem__c [] ttis = [SELECT Id FROM TaxTransactionItem__c];
        System.assertEquals(0, ttis.size());
		TaxAPI.removeTaxTransactionItems(deal);
    }

    @isTest
    static void testValidDateTaxRegion(){
        Deal__c deal = SetupDealData();

        Dealer_Location__c loc = [SELECT Id FROM Dealer_Location__c LIMIT 1];
        loc.TaxationDateDeal__c = 'dealer__Delivery_Date__c';
        update loc;

        //Clear out setup Regions
        delete [SELECT Id FROM Tax_Region__c];
        delete [SELECT Id FROM TaxJunction__c];

        // 1: Test that a TTI will be created if taxation date is on or before Expiration Date
        Tax_Zones__c zone = [SELECT Id FROM Tax_Zones__c LIMIT 1];
		Tax_Region__c region = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'General', ExpirationDate__c = Date.Today(), Rate__c = 5, JurisdictionType__c = 'State', RegionCode__c = 'Test'), true);
		TaxJunction__c junc = new TaxJunction__c(TaxRegion__c = region.Id, TaxZone__c = zone.Id);
        insert junc;

        deal = (Deal__c)Utility.queryAllFields('dealer__Deal__c', deal.Id);
        TaxAPI.calculateTaxes(deal);

        TaxTransactionItem__c [] ttis = [SELECT Id FROM TaxTransactionItem__c];
        System.assertEquals(1, ttis.size());
    }

    @isTest
    static void testExpireRegion(){
        Deal__c deal = (Deal__c)Utility.queryAllFields('dealer__Deal__c', SetupDealData().Id);
        Dealer_Location__c loc = [SELECT Id FROM Dealer_Location__c LIMIT 1];
        Tax_Region__c region = [SELECT Id FROM Tax_Region__c WHERE Rate_Type__c = 'General'];
        
        test.startTest();
        region.ExpirationDate__c = date.today();
        region.ExpirationRate__c = 15;
        update region;
        test.stopTest();

        Tax_Region__c newRegion = [SELECT Id, Rate__c, EffectiveDate__c, ExpirationRate__c FROM Tax_Region__c WHERE ParentRegion__c =: region.Id];
        system.assert(newRegion != null, 'Expiring a tax Region did not create a new region');
        system.assert(newRegion.EffectiveDate__c == Date.today().addDays(1), 'Expiring a tax region did not create new region with a valid effective date (Expiration Date + 1)');
        system.assert(newRegion.Rate__c == region.ExpirationRate__c, 'Expiring a tax region did not create new region with a valid rate');

        TaxJunction__c junc = [SELECT Id, TaxRegion__c, TaxZone__c FROM TaxJunction__c where TaxRegion__c =: newRegion.Id];
        system.assert(junc != null, 'Expiring a tax region did not generate a tax junction');
    }

    /** The Following set of classes - defaultTax_1 - 6 will test the 
     * following auto taxation criteria by using the TaxAPI.getAvailableTaxZonesDeal method.
     * by calling DealAPI.create.
     * 
     * a = Buyer State
     * b = Buyer County
     * c = Buyer City
     * d = Buyer Postal Code
     * 
     * 1 - a & b & c & d Match Tax Zone Record
     * 2 - a & b & c Match Tax Zone Record
     * 3 - a & b OR a & c Match Tax Zone Record
     * 4 - b & c & d Match Tax Zone Record
     * 5 - d Match Tax Zone Record
     * 6 - a Matches Tax Zone Record
     */

    @isTest 
    /** Buyer State & Buyer County & Buyer City & Buyer Zip Match Tax Zone Record */
    static void defaultTax_1(){
        TestClassUtil tcu = new TestClassUtil();

        DealAPI.deal dealWrapper = new DealAPI.deal();

        tcu.insertDMSSettings();
        
        //Based on location setting, we should tax vehicle
		Dealer_Location__c loc = TestClassUtil.insertDealerLocation('RD1', 'Redding Motorcar Company');
		loc.Deal_Fees__c ='[    {       "feeName":"Fee1",       "feeDescription":"asdflasdf",       "feeDefaultAmount":5,       "feeDefaultOnDeals":true,       "feeTaxable":true     },     {       "feeName":"Fee2",       "feeDescription":"asdflasdf",       "feeDefaultAmount":5,       "feeDefaultOnDeals":true,       "feeTaxable":true,       "bullshit":false     } ]';
        loc.Tax_Delivery_Address__c = true;
        loc.VehicleTaxDefault__c = true;
        loc.TaxConversion__c = true;
        upsert loc;
        
		//Account
		Account a = new Account(FirstName='Jarrett', LastName='Kuljis', Tax_Id__c='{"TAXID":"test","TAXZONE","TEST"}', BillingState='CA', County__c='Shasta', BillingCity='Redding', BillingPostalCode='96002');
        
        //Should Create an account.
        dealWrapper.buyer = a;

        //Create Tax Zones and Regions
        Tax_Zones__c matchingZone = (Tax_Zones__c)TestFactory.createSObject(new Tax_Zones__c(City__c = 'Redding', State__c='CA', Postal_Code__c = '96002', County__c='Shasta'),true);

		Tax_Region__c region = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'Vehicle', Rate__c = 5, JurisdictionType__c = 'State', RegionCode__c = 'Test'), true);
		TaxJunction__c junc = new TaxJunction__c(TaxRegion__c = region.Id, TaxZone__c = matchingZone.Id);
        insert junc;
        
        Tax_Zones__c nonMatchingZone = (Tax_Zones__c)TestFactory.createSObject(new Tax_Zones__c(City__c = 'Anderson', State__c='CA', Postal_Code__c = '96003', County__c='Colusa'),true);

		Tax_Region__c region2 = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'Vehicle', Rate__c = 5, JurisdictionType__c = 'City', RegionCode__c = 'CT'), true);
		TaxJunction__c junc2 = new TaxJunction__c(TaxRegion__c = region.Id, TaxZone__c = nonMatchingZone.Id);
		insert junc2;
        
		// Create a vehicle inventory record
		Vehicle_Inventory__c VI = new Vehicle_Inventory__c();
			VI.Name = 'Test Vehicle Inventory';
			VI.Model__c = 'Civic';
			VI.Stock_Number__c = dealer.TestClassUtil.generateRandomString(8);
			VI.VIN__c = '5TDYK3DCXBS075856';
			VI.Company_Number__c = 'RD1';
			VI.Store_Location__c = loc.Id;
			VI.Year__c = '2014';
			VI.Make__c = 'Honda';
			VI.In_Stock__c = true;
		insert VI;

		// Create a Deal
        Deal__c deal = new Deal__c();
        deal.Name = '12342';
        deal.Store_Location__c = loc.Id;
        deal.Vehicle__c = VI.Id;
        deal.Vehicle_Price__c = 1000;

        dealWrapper.dealHeader = deal;

        deal = DealAPI.create(dealWrapper);
        system.assert(deal.Tax_Zone__c == matchingZone.Id,'The proper zone was not added to this deal on create. In TaxOverride.FilterResults the zones_1 variable should have contained this tax zone only.');
    }

    @isTest 
    /** Buyer State & Buyer County & Buyer City Match Tax Zone Record */
    static void defaultTax_2(){
        TestClassUtil tcu = new TestClassUtil();

        DealAPI.deal dealWrapper = new DealAPI.deal();

        tcu.insertDMSSettings();
        
        //Based on location setting, we should tax vehicle
		Dealer_Location__c loc = TestClassUtil.insertDealerLocation('RD1', 'Redding Motorcar Company');
		loc.Deal_Fees__c ='[    {       "feeName":"Fee1",       "feeDescription":"asdflasdf",       "feeDefaultAmount":5,       "feeDefaultOnDeals":true,       "feeTaxable":true     },     {       "feeName":"Fee2",       "feeDescription":"asdflasdf",       "feeDefaultAmount":5,       "feeDefaultOnDeals":true,       "feeTaxable":true,       "bullshit":false     } ]';
        loc.Tax_Delivery_Address__c = true;
        loc.VehicleTaxDefault__c = true;
        loc.TaxConversion__c = true;
        upsert loc;
        
		//Account
		Account a = new Account(FirstName='Jarrett', LastName='Kuljis', Tax_Id__c='{"TAXID":"test","TAXZONE","TEST"}', BillingState='CA', County__c='Shasta', BillingCity='Redding');
        
        //Should Create an account.
        dealWrapper.buyer = a;

        //Create Tax Zones and Regions
        Tax_Zones__c matchingZone = (Tax_Zones__c)TestFactory.createSObject(new Tax_Zones__c(City__c = 'Redding', State__c='CA', Postal_Code__c = '96002', County__c='Shasta'),true);

		Tax_Region__c region = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'Vehicle', Rate__c = 5, JurisdictionType__c = 'State', RegionCode__c = 'Test'), true);
		TaxJunction__c junc = new TaxJunction__c(TaxRegion__c = region.Id, TaxZone__c = matchingZone.Id);
        insert junc;
        
        Tax_Zones__c nonMatchingZone = (Tax_Zones__c)TestFactory.createSObject(new Tax_Zones__c(City__c = 'Anderson', State__c='CA', Postal_Code__c = '96003', County__c='Colusa'),true);

		Tax_Region__c region2 = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'Vehicle', Rate__c = 5, JurisdictionType__c = 'City', RegionCode__c = 'CT'), true);
		TaxJunction__c junc2 = new TaxJunction__c(TaxRegion__c = region.Id, TaxZone__c = nonMatchingZone.Id);
		insert junc2;
        
		// Create a vehicle inventory record
		Vehicle_Inventory__c VI = new Vehicle_Inventory__c();
			VI.Name = 'Test Vehicle Inventory';
			VI.Model__c = 'Civic';
			VI.Stock_Number__c = dealer.TestClassUtil.generateRandomString(8);
			VI.VIN__c = '5TDYK3DCXBS075856';
			VI.Company_Number__c = 'RD1';
			VI.Store_Location__c = loc.Id;
			VI.Year__c = '2014';
			VI.Make__c = 'Honda';
			VI.In_Stock__c = true;
		insert VI;

		// Create a Deal
        Deal__c deal = new Deal__c();
        deal.Name = '12342';
        deal.Store_Location__c = loc.Id;
        deal.Vehicle__c = VI.Id;
        deal.Vehicle_Price__c = 1000;

        dealWrapper.dealHeader = deal;

        deal = DealAPI.create(dealWrapper);
        system.assert(deal.Tax_Zone__c == matchingZone.Id,'The proper zone was not added to this deal on create. In TaxOverride.FilterResults the zones_2 variable should have contained this tax zone only.');
    }

    @isTest 
    /** (Buyer State & Buyer County) OR (Buyer State & Buyer City) matches Taxes Zone Record */
    static void defaultTax_3(){
        TestClassUtil tcu = new TestClassUtil();

        DealAPI.deal dealWrapper = new DealAPI.deal();

        tcu.insertDMSSettings();
        
        //Based on location setting, we should tax vehicle
		Dealer_Location__c loc = TestClassUtil.insertDealerLocation('RD1', 'Redding Motorcar Company');
		loc.Deal_Fees__c ='[    {       "feeName":"Fee1",       "feeDescription":"asdflasdf",       "feeDefaultAmount":5,       "feeDefaultOnDeals":true,       "feeTaxable":true     },     {       "feeName":"Fee2",       "feeDescription":"asdflasdf",       "feeDefaultAmount":5,       "feeDefaultOnDeals":true,       "feeTaxable":true,       "bullshit":false     } ]';
        loc.Tax_Delivery_Address__c = true;
        loc.VehicleTaxDefault__c = true;
        loc.TaxConversion__c = true;
        upsert loc;
        
		//Account
		Account a = new Account(FirstName='Jarrett', LastName='Kuljis', Tax_Id__c='{"TAXID":"test","TAXZONE","TEST"}', BillingState='CA', County__c='Shasta', BillingCity='SouthRedding', BillingPostalCode='96007');
        
        //Should Create an account.
        dealWrapper.buyer = a;

        //Create Tax Zones and Regions
        Tax_Zones__c matchingZone = (Tax_Zones__c)TestFactory.createSObject(new Tax_Zones__c(City__c = 'Redding', State__c='CA', Postal_Code__c = '96002', County__c='Shasta'),true);

		Tax_Region__c region = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'Vehicle', Rate__c = 5, JurisdictionType__c = 'State', RegionCode__c = 'Test'), true);
		TaxJunction__c junc = new TaxJunction__c(TaxRegion__c = region.Id, TaxZone__c = matchingZone.Id);
        insert junc;
        
        Tax_Zones__c nonMatchingZone = (Tax_Zones__c)TestFactory.createSObject(new Tax_Zones__c(City__c = 'Anderson', State__c='CA', Postal_Code__c = '96003', County__c='Colusa'),true);

		Tax_Region__c region2 = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'Vehicle', Rate__c = 5, JurisdictionType__c = 'City', RegionCode__c = 'CT'), true);
		TaxJunction__c junc2 = new TaxJunction__c(TaxRegion__c = region.Id, TaxZone__c = nonMatchingZone.Id);
		insert junc2;
        
		// Create a vehicle inventory record
		Vehicle_Inventory__c VI = new Vehicle_Inventory__c();
			VI.Name = 'Test Vehicle Inventory';
			VI.Model__c = 'Civic';
			VI.Stock_Number__c = dealer.TestClassUtil.generateRandomString(8);
			VI.VIN__c = '5TDYK3DCXBS075856';
			VI.Company_Number__c = 'RD1';
			VI.Store_Location__c = loc.Id;
			VI.Year__c = '2014';
			VI.Make__c = 'Honda';
			VI.In_Stock__c = true;
		insert VI;

		// Create a Deal
        Deal__c deal = new Deal__c();
        deal.Name = '12342';
        deal.Store_Location__c = loc.Id;
        deal.Vehicle__c = VI.Id;
        deal.Vehicle_Price__c = 1000;

        dealWrapper.dealHeader = deal;

        deal = DealAPI.create(dealWrapper);
        system.assert(deal.Tax_Zone__c == matchingZone.Id,'The proper zone was not added to this deal on create. In TaxOverride.FilterResults the zones_3 variable should have contained this tax zone only.');
    }

    @isTest 
    /** Buyer County & Buyer City & Buyer Postal Code Matches Tax Zone Record */
    static void defaultTax_4(){
        TestClassUtil tcu = new TestClassUtil();

        DealAPI.deal dealWrapper = new DealAPI.deal();

        tcu.insertDMSSettings();
        
        //Based on location setting, we should tax vehicle
		Dealer_Location__c loc = TestClassUtil.insertDealerLocation('RD1', 'Redding Motorcar Company');
		loc.Deal_Fees__c ='[    {       "feeName":"Fee1",       "feeDescription":"asdflasdf",       "feeDefaultAmount":5,       "feeDefaultOnDeals":true,       "feeTaxable":true     },     {       "feeName":"Fee2",       "feeDescription":"asdflasdf",       "feeDefaultAmount":5,       "feeDefaultOnDeals":true,       "feeTaxable":true,       "bullshit":false     } ]';
        loc.Tax_Delivery_Address__c = true;
        loc.VehicleTaxDefault__c = true;
        loc.TaxConversion__c = true;
        upsert loc;
        
		//Account
		Account a = new Account(FirstName='Jarrett', LastName='Kuljis', Tax_Id__c='{"TAXID":"test","TAXZONE","TEST"}', BillingState='AZ', County__c='Shasta', BillingCity='Redding', BillingPostalCode='96002');
        
        //Should Create an account.
        dealWrapper.buyer = a;

        //Create Tax Zones and Regions
        Tax_Zones__c matchingZone = (Tax_Zones__c)TestFactory.createSObject(new Tax_Zones__c(City__c = 'Redding', State__c='CA', Postal_Code__c = '96002', County__c='Shasta'),true);

		Tax_Region__c region = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'Vehicle', Rate__c = 5, JurisdictionType__c = 'State', RegionCode__c = 'Test'), true);
		TaxJunction__c junc = new TaxJunction__c(TaxRegion__c = region.Id, TaxZone__c = matchingZone.Id);
        insert junc;
        
        Tax_Zones__c nonMatchingZone = (Tax_Zones__c)TestFactory.createSObject(new Tax_Zones__c(City__c = 'Anderson', State__c='CA', Postal_Code__c = '96003', County__c='Colusa'),true);

		Tax_Region__c region2 = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'Vehicle', Rate__c = 5, JurisdictionType__c = 'City', RegionCode__c = 'CT'), true);
		TaxJunction__c junc2 = new TaxJunction__c(TaxRegion__c = region.Id, TaxZone__c = nonMatchingZone.Id);
		insert junc2;
        
		// Create a vehicle inventory record
		Vehicle_Inventory__c VI = new Vehicle_Inventory__c();
			VI.Name = 'Test Vehicle Inventory';
			VI.Model__c = 'Civic';
			VI.Stock_Number__c = dealer.TestClassUtil.generateRandomString(8);
			VI.VIN__c = '5TDYK3DCXBS075856';
			VI.Company_Number__c = 'RD1';
			VI.Store_Location__c = loc.Id;
			VI.Year__c = '2014';
			VI.Make__c = 'Honda';
			VI.In_Stock__c = true;
		insert VI;

		// Create a Deal
        Deal__c deal = new Deal__c();
        deal.Name = '12342';
        deal.Store_Location__c = loc.Id;
        deal.Vehicle__c = VI.Id;
        deal.Vehicle_Price__c = 1000;

        dealWrapper.dealHeader = deal;

        deal = DealAPI.create(dealWrapper);
        system.assert(deal.Tax_Zone__c == matchingZone.Id,'The proper zone was not added to this deal on create. In TaxOverride.FilterResults the zones_4 variable should have contained this tax zone only.');
    }

    @isTest 
    /** Buyer Postal Code Matches Tax Zone Record */
    static void defaultTax_5(){
        TestClassUtil tcu = new TestClassUtil();

        DealAPI.deal dealWrapper = new DealAPI.deal();

        tcu.insertDMSSettings();
        
        //Based on location setting, we should tax vehicle
		Dealer_Location__c loc = TestClassUtil.insertDealerLocation('RD1', 'Redding Motorcar Company');
		loc.Deal_Fees__c ='[    {       "feeName":"Fee1",       "feeDescription":"asdflasdf",       "feeDefaultAmount":5,       "feeDefaultOnDeals":true,       "feeTaxable":true     },     {       "feeName":"Fee2",       "feeDescription":"asdflasdf",       "feeDefaultAmount":5,       "feeDefaultOnDeals":true,       "feeTaxable":true,       "bullshit":false     } ]';
        loc.Tax_Delivery_Address__c = true;
        loc.VehicleTaxDefault__c = true;
        loc.TaxConversion__c = true;
        upsert loc;
        
		//Account
		Account a = new Account(FirstName='Jarrett', LastName='Kuljis', Tax_Id__c='{"TAXID":"test","TAXZONE","TEST"}', BillingState='CW', County__c='Shasta_1Wrong', BillingCity='Redding_wrong', BillingPostalCode='96002');
        
        //Should Create an account.
        dealWrapper.buyer = a;

        //Create Tax Zones and Regions
        Tax_Zones__c matchingZone = (Tax_Zones__c)TestFactory.createSObject(new Tax_Zones__c(City__c = 'Redding', State__c='CA', Postal_Code__c = '96002', County__c='Shasta'),true);

		Tax_Region__c region = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'Vehicle', Rate__c = 5, JurisdictionType__c = 'State', RegionCode__c = 'Test'), true);
		TaxJunction__c junc = new TaxJunction__c(TaxRegion__c = region.Id, TaxZone__c = matchingZone.Id);
        insert junc;
        
        Tax_Zones__c nonMatchingZone = (Tax_Zones__c)TestFactory.createSObject(new Tax_Zones__c(City__c = 'Anderson', State__c='CA', Postal_Code__c = '96003', County__c='Colusa'),true);

		Tax_Region__c region2 = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'Vehicle', Rate__c = 5, JurisdictionType__c = 'City', RegionCode__c = 'CT'), true);
		TaxJunction__c junc2 = new TaxJunction__c(TaxRegion__c = region.Id, TaxZone__c = nonMatchingZone.Id);
		insert junc2;
        
		// Create a vehicle inventory record
		Vehicle_Inventory__c VI = new Vehicle_Inventory__c();
			VI.Name = 'Test Vehicle Inventory';
			VI.Model__c = 'Civic';
			VI.Stock_Number__c = dealer.TestClassUtil.generateRandomString(8);
			VI.VIN__c = '5TDYK3DCXBS075856';
			VI.Company_Number__c = 'RD1';
			VI.Store_Location__c = loc.Id;
			VI.Year__c = '2014';
			VI.Make__c = 'Honda';
			VI.In_Stock__c = true;
		insert VI;

		// Create a Deal
        Deal__c deal = new Deal__c();
        deal.Name = '12342';
        deal.Store_Location__c = loc.Id;
        deal.Vehicle__c = VI.Id;
        deal.Vehicle_Price__c = 1000;

        dealWrapper.dealHeader = deal;

        deal = DealAPI.create(dealWrapper);
        system.assert(deal.Tax_Zone__c == matchingZone.Id,'The proper zone was not added to this deal on create. In TaxOverride.FilterResults the zones_5 variable should have contained this tax zone only.');
    }

    @isTest 
    /** Buyer BillingState Matches Tax Zone Record */
    static void defaultTax_NoMatches(){
        TestClassUtil tcu = new TestClassUtil();

        DealAPI.deal dealWrapper = new DealAPI.deal();

        tcu.insertDMSSettings();
        
        //Based on location setting, we should tax vehicle
		Dealer_Location__c loc = TestClassUtil.insertDealerLocation('RD1', 'Redding Motorcar Company');
		loc.Deal_Fees__c ='[    {       "feeName":"Fee1",       "feeDescription":"asdflasdf",       "feeDefaultAmount":5,       "feeDefaultOnDeals":true,       "feeTaxable":true     },     {       "feeName":"Fee2",       "feeDescription":"asdflasdf",       "feeDefaultAmount":5,       "feeDefaultOnDeals":true,       "feeTaxable":true,       "bullshit":false     } ]';
        loc.Tax_Delivery_Address__c = true;
        loc.VehicleTaxDefault__c = true;
        loc.TaxConversion__c = true;
        upsert loc;
        
		//Account
		Account a = new Account(FirstName='Jarrett', LastName='Kuljis', Tax_Id__c='{"TAXID":"test","TAXZONE","TEST"}', BillingState='CA', County__c='ShastaW', BillingCity='ReddingW', BillingPostalCode='96007');
        
        //Should Create an account.
        dealWrapper.buyer = a;

        //Create Tax Zones and Regions
        Tax_Zones__c matchingZone = (Tax_Zones__c)TestFactory.createSObject(new Tax_Zones__c(City__c = 'Redding', State__c='CA', Postal_Code__c = '96002', County__c='Shasta'),true);

		Tax_Region__c region = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'Vehicle', Rate__c = 5, JurisdictionType__c = 'State', RegionCode__c = 'Test'), true);
		TaxJunction__c junc = new TaxJunction__c(TaxRegion__c = region.Id, TaxZone__c = matchingZone.Id);
        insert junc;
        
        Tax_Zones__c nonMatchingZone = (Tax_Zones__c)TestFactory.createSObject(new Tax_Zones__c(City__c = 'Anderson', State__c='CW', Postal_Code__c = '96003', County__c='Colusa'),true);

		Tax_Region__c region2 = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'Vehicle', Rate__c = 5, JurisdictionType__c = 'City', RegionCode__c = 'CT'), true);
		TaxJunction__c junc2 = new TaxJunction__c(TaxRegion__c = region.Id, TaxZone__c = nonMatchingZone.Id);
		insert junc2;
        
		// Create a vehicle inventory record
		Vehicle_Inventory__c VI = new Vehicle_Inventory__c();
			VI.Name = 'Test Vehicle Inventory';
			VI.Model__c = 'Civic';
			VI.Stock_Number__c = dealer.TestClassUtil.generateRandomString(8);
			VI.VIN__c = '5TDYK3DCXBS075856';
			VI.Company_Number__c = 'RD1';
			VI.Store_Location__c = loc.Id;
			VI.Year__c = '2014';
			VI.Make__c = 'Honda';
			VI.In_Stock__c = true;
		insert VI;

		// Create a Deal
        Deal__c deal = new Deal__c();
        deal.Name = '12342';
        deal.Store_Location__c = loc.Id;
        deal.Vehicle__c = VI.Id;
        deal.Vehicle_Price__c = 1000;

        dealWrapper.dealHeader = deal;

        deal = DealAPI.create(dealWrapper);
        system.assert(deal.Tax_Zone__c == matchingZone.Id,'The proper zone was not added to this deal on create. In TaxOverride.FilterResults the zones_6 variable should have contained this tax zone only.');
    }

    @isTest 
    /** Buyer BillingState Matches Tax Zone Record */
    static void defaultTax_6(){
        TestClassUtil tcu = new TestClassUtil();

        DealAPI.deal dealWrapper = new DealAPI.deal();

        tcu.insertDMSSettings();
        
        //Based on location setting, we should tax vehicle
		Dealer_Location__c loc = TestClassUtil.insertDealerLocation('RD1', 'Redding Motorcar Company');
		loc.Deal_Fees__c ='[    {       "feeName":"Fee1",       "feeDescription":"asdflasdf",       "feeDefaultAmount":5,       "feeDefaultOnDeals":true,       "feeTaxable":true     },     {       "feeName":"Fee2",       "feeDescription":"asdflasdf",       "feeDefaultAmount":5,       "feeDefaultOnDeals":true,       "feeTaxable":true,       "bullshit":false     } ]';
        loc.Tax_Delivery_Address__c = true;
        loc.VehicleTaxDefault__c = true;
        loc.TaxConversion__c = true;
        upsert loc;
        
		//Account
		Account a = new Account(FirstName='Jarrett', LastName='Kuljis', Tax_Id__c='{"TAXID":"test","TAXZONE","TEST"}', BillingState='CX', County__c='ShastaW', BillingCity='ReddingW', BillingPostalCode='96007');
        
        //Should Create an account.
        dealWrapper.buyer = a;

        //Create Tax Zones and Regions
        Tax_Zones__c matchingZone = (Tax_Zones__c)TestFactory.createSObject(new Tax_Zones__c(City__c = 'Redding', State__c='CA', Postal_Code__c = '96002', County__c='Shasta'),true);

		Tax_Region__c region = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'Vehicle', Rate__c = 5, JurisdictionType__c = 'State', RegionCode__c = 'Test'), true);
		TaxJunction__c junc = new TaxJunction__c(TaxRegion__c = region.Id, TaxZone__c = matchingZone.Id);
        insert junc;
        
        Tax_Zones__c nonMatchingZone = (Tax_Zones__c)TestFactory.createSObject(new Tax_Zones__c(City__c = 'Anderson', State__c='CW', Postal_Code__c = '96003', County__c='Colusa'),true);

		Tax_Region__c region2 = (Tax_Region__c)TestFactory.createSObject(new Tax_Region__c(Rate_Type__c = 'Vehicle', Rate__c = 5, JurisdictionType__c = 'City', RegionCode__c = 'CT'), true);
		TaxJunction__c junc2 = new TaxJunction__c(TaxRegion__c = region.Id, TaxZone__c = nonMatchingZone.Id);
		insert junc2;
        
		// Create a vehicle inventory record
		Vehicle_Inventory__c VI = new Vehicle_Inventory__c();
			VI.Name = 'Test Vehicle Inventory';
			VI.Model__c = 'Civic';
			VI.Stock_Number__c = dealer.TestClassUtil.generateRandomString(8);
			VI.VIN__c = '5TDYK3DCXBS075856';
			VI.Company_Number__c = 'RD1';
			VI.Store_Location__c = loc.Id;
			VI.Year__c = '2014';
			VI.Make__c = 'Honda';
			VI.In_Stock__c = true;
		insert VI;

		// Create a Deal
        Deal__c deal = new Deal__c();
        deal.Name = '12342';
        deal.Store_Location__c = loc.Id;
        deal.Vehicle__c = VI.Id;
        deal.Vehicle_Price__c = 1000;

        dealWrapper.dealHeader = deal;

        deal = DealAPI.create(dealWrapper);
        system.assert(deal.Tax_Zone__c == null,'No tax zone should have appied to deal. No Filter criteria met. In TaxOverride.FilterResults there should have been two tax zones returned.');
    }
    
    
}
