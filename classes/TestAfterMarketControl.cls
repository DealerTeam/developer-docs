/**
*   Created 11-22-2016 by Abhishek
*   
**
* Date            |Developer            |Work#
* Notes
* -------------------------------------------------
* 11-23-2016      |Gaurav Agrawal       |W-000710
*    
*/

@isTest
private class TestAfterMarketControl {
    
    @isTest static void test_method_one() {
        
        AfterMarketControlHandler objHandler = new AfterMarketControlHandler();
        
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
        
        dealer__We_Owe__c objWeOwe = new dealer__We_Owe__c();
        objWeOwe.dealer__Car_Deal__c = Deal.Id;
        insert objWeOwe;
        
        dealer__Deal_Tax__c objDealTax = new dealer__Deal_Tax__c();
        objDealTax.Name = 'Test Deal Tax';
        objDealTax.dealer__Deal__c = Deal.Id;
        insert objDealTax;
        
        dealer__After_Market__c objAfterMarket = new dealer__After_Market__c();
        objAfterMarket.Name = 'Test AFM';
        objAfterMarket.dealer__Car_Deal__c = Deal.Id;
        insert objAfterMarket;
    }
    
    @isTest static void test_method_two() {
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
        
        dealer__After_Market__c objAfterMarket = new dealer__After_Market__c();
        objAfterMarket.Name = 'Test AFM';
        objAfterMarket.dealer__Car_Deal__c = Deal.Id;
        insert objAfterMarket;
        
        objAfterMarket.dealer__Type__c = 'Part';
        update objAfterMarket;
        
        objAfterMarket.dealer__Type__c = 'Labor';
        update objAfterMarket;
        
        dealer__Misc_Tax_Codes__c objMiscTaxCode = new dealer__Misc_Tax_Codes__c();
        objMiscTaxCode.Name = 'Test Misc Tax Code';
        objMiscTaxCode.dealer__Taxable__c = true;
        objMiscTaxCode.dealer__Percent__c = 22.5;
        insert objMiscTaxCode;
        
        objAfterMarket.dealer__Tax_Rate__c = 22.5;
        objAfterMarket.dealer__Sale_Price__c = 150;
        objAfterMarket.dealer__Misc_Tax_Code__c = objMiscTaxCode.Id;
        update objAfterMarket;
    }     
}