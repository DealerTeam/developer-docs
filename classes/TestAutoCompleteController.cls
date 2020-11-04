@istest
private class TestAutoCompleteController {

    static testmethod void testACC() {
        Account a = new Account(Name='Smith Company', Phone='5302321111', Rating='AAA');
        insert a;
        
        Sobject[] findresultsList = autoCompleteController.findSObjects('Account', 'Smith', 'Phone,Rating', 'Phone,Rating');

        // Replacement Method
        Sobject[] searchresultsList = autoCompleteController.searchSObjects('Account', 'Smith', 'Phone,Rating', 'Phone,Rating', '', '');        
        
        System.assertEquals(1, searchresultsList.size()); 
    }
    
}