@isTest
private with sharing class TestTaxTransactionItemControl {
    @TestSetup
    static void makeData(){
        TestClassUtil tcu = new TestClassUtil();
		tcu.insertDMSSettings();

        Parts_Service_Pricing_Strategy__c ps = new Parts_Service_Pricing_Strategy__c();
        ps.Method__c = 'Jobber';
        ps.Active__c = true;
        ps.Description__c = 'test';
        ps.Default__c = true;
        ps.dealer__Parts_Variable_Amount__c = 10;
        ps.dealer__Formula_Operand__c = '+';
        insert ps;  

        Dealer_Location__c     loc = TestClassUtil.insertDealerLocation('RD1', 'Redding Motorcar Company');
        Deal__c                 deal = new Deal__c(Deal_ID__c='9999');
        Parts_Invoice__c        pi = new Parts_Invoice__c(Location__c = loc.Id);
        Rental_Agreements__c    ra = new Rental_Agreements__c();
        Service_Repair_Order__c sro = new Service_Repair_Order__c(Mileage_In__c=100);

        insert deal;
        insert pi;
        insert ra;
        insert sro;
    }
    @isTest
    public static void TestTaxTransactionItemControl() {
        
        Deal__c deal = [select id from Deal__c limit 1];
        Parts_Invoice__c pi = [SELECT Id FROM Parts_Invoice__c LIMIT 1];
        Rental_Agreements__c ra = [SELECT Id FROM Rental_Agreements__c LIMIT 1];
        Service_Repair_Order__c sro = [SELECT Id FROM Service_Repair_Order__c LIMIT 1];
        
        TaxTransactionItem__c dealTTI = new TaxTransactionItem__c(DealTax__c=deal.Id, JurisdictionType__c='City',RateType__c='Part');
        insert dealTTI;
        TaxTransactionItem__c piTTI = new TaxTransactionItem__c(PartsInvoiceTax__c=pi.Id);
        insert piTTI;
        TaxTransactionItem__c rentalTTI = new TaxTransactionItem__c(RentalTax__c=ra.Id);
        insert rentalTTI;
        TaxTransactionItem__c sroTTI = new TaxTransactionItem__c(ServiceROTax__c=sro.Id);
        insert sroTTI;
    }
}