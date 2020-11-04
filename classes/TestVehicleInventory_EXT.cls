@isTest
private class TestVehicleInventory_EXT {
    static testmethod void testVEI_EXT() {
 
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
                  
        System.runAs(usr){  

        dealer__Vehicle_Inventory__c inv = new dealer__Vehicle_Inventory__c(
                                        Name='test',
                                        dealer__VIN__c='3GNEK12Z15G244588',
                                        dealer__Make__c='Chevrolet',
                                        dealer__Model__c='1500',
                                        dealer__Stock_Number__c='VT100',
                                        dealer__Year__c='2012'
                                    );
        insert inv;
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(inv);
        VehicleInventory_EXT vi = new VehicleInventory_EXT(sc);
        
        System.assertEquals(false, vi.getHasActivityHistories());
        System.assertEquals(false, vi.getHasServiceEstimates());
        System.assertEquals(false, vi.getHasStatusCodeHistory()); 

        }                           
    }
}