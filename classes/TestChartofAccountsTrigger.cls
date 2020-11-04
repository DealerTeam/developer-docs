@istest (seeAllData=true)
private class TestChartofAccountsTrigger {
    
    static testmethod void testChartofAccountsTriggerUnitTest() {
        
        dealer__Chart_of_Accounts__c coa = new dealer__Chart_of_Accounts__c(Name='NoNameSet', dealer__Account_Number__c='7777', dealer__Description__c='SVC POLICY', dealer__Active__c=true);
        insert coa; 
    }
}