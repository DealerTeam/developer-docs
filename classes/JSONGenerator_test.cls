@isTest
private class JSONGenerator_test {
    @TestSetup
    static void makeData(){
        Tax_Region__c region = new Tax_Region__c(
            dealer__JurisdictionType__c='State',
            dealer__Rate_Type__c='General',
            dealer__Rate__c=5.0,
            dealer__RegionCode__c='CA'
        );
        insert region;
                    // Tax_Region__c region = new Tax_Region__c() [SELECT Id, dealer__MinTaxableFormula__c, dealer__MinTaxFormula__c, dealer__MaxTaxableFormula__c, dealer__MaxTaxFormula__c FROM Tax_Region__c WHERE Id =: regionId];

    }

    @isTest
    static void testJSONGeneratorController(){
        try{
            // Test error handling when no region is found
            Tax_Region__c region = JSONGeneratorController.getRegion('test');
        } catch(AuraHandledException e){
            system.debug(e);
            System.Assert(e.getMessage().contains('Tax Region not found'));
        }

        Tax_Region__c region = [SELECT Id FROM Tax_Region__c LIMIT 1];
        region = JSONGeneratorController.getRegion(region.Id);
        region.MinTaxableFormula__c = 'test';

        JSONGeneratorController.saveRegion(region);
    }
}
