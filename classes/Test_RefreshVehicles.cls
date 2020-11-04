@isTest
private class Test_RefreshVehicles {
	
	@isTest static void testRV() {

        //Set up the Mock Http Response stuff
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());


        dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c(
                                                Name='test',
                                                dealer__VIN__c='3GNEK12Z15G244588',
                                                dealer__Make__c='Chevrolet',
                                                dealer__Model__c='1500',
                                                dealer__Stock_Number__c='VT100',
                                                dealer__Year__c='2012',
                                                dealer__Company_Number__c = 'AD1'
                                            );


        //Create a 'set' of vehicle inventory records to pass to StandardSetController
        List<dealer__Vehicle_Inventory__c> vehicleSet = new List<dealer__Vehicle_Inventory__c>();
        vehicleSet.add(inv);

        //Create the Standard Set Controller
        ApexPages.StandardSetController sc = new ApexPages.StandardSetController(vehicleSet);
        sc.setSelected(vehicleSet);

        RefreshVehicles rv = new RefreshVehicles(sc);

        System.assertEquals(1, rv.ssc.getResultSize());

        PageReference result = rv.SyncVehicles();

        // System.assertNotEquals(null, result);
        
	}

    @isTest static void testRVNoVehicles(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        List<dealer__Vehicle_Inventory__c> vehicleSet = new List<dealer__Vehicle_Inventory__c>();

        //Create the Standard Set Controller
        ApexPages.StandardSetController sc = new ApexPages.StandardSetController(vehicleSet);
        sc.setSelected(vehicleSet);

        RefreshVehicles rv = new RefreshVehicles(sc);

        System.assertEquals(0, rv.ssc.getResultSize());

        PageReference result = rv.SyncVehicles();

        System.assertEquals(null, result);

    }
}