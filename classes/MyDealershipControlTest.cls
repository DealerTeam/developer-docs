@isTest
private class MyDealershipControlTest {
    
    
    private static dealer__Dealer_Location__c createLocation(){
        
        dealer__Dealer_Location__c objLocation = new dealer__Dealer_Location__c();
        objLocation.Name = 'Test Location';
        objLocation.dealer__City__c = 'Test City';
        objLocation.dealer__Company_Number__c = '101';
        objLocation.dealer__Postal_Code__c = '411028';
        objLocation.dealer__State__c = 'CA';
        objLocation.dealer__Tax_Local_Rate__c = 5.0;
        objLocation.dealer__Tax_Local_Rental_Addition__c = 2.0;
        insert objLocation;
        return objLocation;
    }
    
    private static User createUser(){

		Profile prof = [select id from profile where name='Standard User'];
		
        String uniqueUserName = 'standarduser' + DateTime.now().getTime() + '@mytestorgx.com';
        
		User usr = new User(alias = 'usr', email='us.fname@abcmailtst.com',
                emailencodingkey='UTF-8', lastname='lstname',
                timezonesidkey='America/Los_Angeles',
                languagelocalekey='en_US',
                localesidkey='en_US', profileid = prof.Id,
                username=uniqueUserName,
                In_BDC__c = false,
                Division='101');
    
        insert usr;
        return usr;
    }
    
 /*   private static Dealer_Location_User__c createUserLocation(){
        
        Dealer_Location_User__c userLoc = new Dealer_Location_User__c();
        userLoc.User__c = createUser().Id;
        userLoc.Dealer_Location__c = createLocation().Id;
        
        insert userLoc;
        
        return userLoc;
    }*/
    
    
    
    @isTest static void testGetMyDealerships(){
        
        
        //Create User
        User u = createUser();
        
        //Create Location
        dealer__Dealer_Location__c loc = createLocation();
        
        //User Location
        Dealer_Location_User__c userLoc = new Dealer_Location_User__c();
        userLoc.User__c = u.Id;
        userLoc.Dealer_Location__c = loc.Id;
        
        insert userLoc;
        
        List<dealer__Dealer_Location__c> dealershipList;
        system.runAs(u){
             dealershipList = MyDealershipControl.getMyDealerships();
        }
        
        system.assertEquals(1, dealershipList.size());
    }
    
    @isTest static void testChooseDealership(){
        
        //Create User
        User u = createUser();
        
        //Create Location
        dealer__Dealer_Location__c loc = createLocation();

		User retUser;          
        system.runAs(u){
             retUser = MyDealershipControl.chooseDealership(loc.Id);
        }
        
        system.assertEquals(loc.dealer__Company_Number__c, retUser.Division);
    }
    
    @isTest static void testGetUserInfo(){
        
        //Create User
        User u = createUser();

		User retUser;          
        system.runAs(u){
             retUser = MyDealershipControl.getUserInfo();
        }
        
        system.assertEquals(u.Division, retUser.Division);
    }
    
    @isTest static void testBDC(){
        Profile prof = [select id from profile where name='System Administrator'];
        		
        String uniqueUserName = 'admin' + DateTime.now().getTime() + '@mytestorgx.com';
        
		User usr = new User(alias = 'usr', email='us.fname@abcmailtst.com',
                emailencodingkey='UTF-8', lastname='lstname',
                timezonesidkey='America/Los_Angeles',
                languagelocalekey='en_US',
                localesidkey='en_US', profileid = prof.Id,
                username=uniqueUserName,
                In_BDC__c = false,
                Division='101');
    
        insert usr;

        Boolean write;
        Boolean read;
        system.runAs(usr){
            write = MyDealershipControl.getBDCWrite();
            read = MyDealershipControl.getBDCRead();
            MyDealershipControl.updateBDC(true);
        }
        
        usr = [SELECT Id, In_BDC__c FROM User WHERE Id =: usr.Id LIMIT 1];
        system.assertEquals(true, usr.In_BDC__c, 'updateBDC did not update the user record as expected.');
        system.assertEquals(false, write, 'getBDCWrite should return false if In_BDC__c is updateable.');
        system.assertEquals(true, read, 'getBDCRead should return true if In_BDC__c is accessible.');
    }

}