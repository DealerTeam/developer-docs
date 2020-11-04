@isTest (seeAllData=true)
private class TestChartofAccountsEXT {
    static testmethod void testChartofAccountsExtController() {
        
        dealer__Chart_of_Accounts__c coa = new dealer__Chart_of_Accounts__c(
            Name='Test123',
            dealer__Account_Number__c='1234A',
            dealer__Active__c=true,
            dealer__Description__c='Test Account'
        );
        
        insert coa;
        
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(coa);
        ChartOfAccounts_EXT controller = new ChartOfAccounts_EXT(sc);
        
        controller.SaveandNew();
            
    }
    
    static testmethod void testChartofAccountsExtController1() {
    dealer__Chart_of_Accounts__c coa1 = new dealer__Chart_of_Accounts__c();
           /*  Name='Test123',
            dealer__Account_Number__c='1234A',
            dealer__Active__c=true,
            dealer__Description__c='Test Account'
        );
        
        insert coa;*/
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(coa1);
        ChartOfAccounts_EXT controller = new ChartOfAccounts_EXT(sc);
        
        controller.SaveandNew(); 
}
}