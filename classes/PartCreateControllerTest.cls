@isTest
private class PartCreateControllerTest {
    
    @testSetup static void setup() {
        
        dealer__Dealer_Location__c objLocation = new dealer__Dealer_Location__c();
            objLocation.Name = 'Test Location';
            objLocation.dealer__City__c = 'Test City';
            objLocation.dealer__Company_Number__c = '101';
            objLocation.dealer__Postal_Code__c = '411028';
            objLocation.dealer__State__c = 'CA';
            objLocation.dealer__Tax_Local_Rate__c = 5.0;
            objLocation.dealer__Tax_Local_Rental_Addition__c = 2.0;
            insert objLocation;
        
        Profile prof = [select id from profile where name='Standard User'];
        
        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@mytestorgx.com';
        
        User usr = new User(alias = 'usr', email='us.fname@abcmailtst.com',
                  emailencodingkey='UTF-8', lastname='lstname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username=uniqueUserName,
                  Division='101');
        
        insert usr;
    }
    
    @isTest static void testCompany(){
        
        User u = [Select Id, Division From User where Email = 'us.fname@abcmailtst.com' Limit 1];
        dealer__Dealer_Location__c loc = [Select Id, dealer__Company_Number__c 
                                          From dealer__Dealer_Location__c Where dealer__Company_Number__c =: u.Division];
        
        Id locId;
        system.runAs(u){
        	locId = PartCreateController.Company(); 
        }
        
        system.assertEquals(loc.Id, locId);
    }
    
    @isTest static void testCompanyNull(){
        
        User u = [Select Id, Division From User where Email = 'us.fname@abcmailtst.com' Limit 1];
        u.Division = '200';
        update u;
        Boolean exCatched = false;
        
        system.runAs(u){
            Test.startTest();
            try{
        		PartCreateController.Company(); 
            }catch(AuraHandledException ex){
                exCatched = true;
            }
            Test.stopTest();
        }
        
        system.assert(exCatched, 'Custom exception catched');
    }
}