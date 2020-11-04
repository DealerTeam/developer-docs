@isTest
public class LocationControlTest {
    
    public static dealer__Dealer_Location__c loc;
    
    static void init(){
        
        loc = new dealer__Dealer_Location__c(Name = 'Test Location', dealer__Company_Number__c = 'DT1',
                                                                         dealer__Street__c	= 'Street', dealer__City__c = 'New York',
                                                                         dealer__State__c	= 'NY', dealer__Postal_Code__c = '11216',
                                                                         dealer__Tax_Misc__c = 'All', dealer__Logo_Name__c = 'locLogo');
    }
    
    @isTest static void testHandleAccounts() {  
        
        init();
        
        Test.startTest();
        insert loc;
        Test.stopTest();
        
        //Verify Account creation upon insert
        Account a = [Select Id, Name From Account];
        system.assertEquals(a.Name, loc.Name);
    }
    
      @isTest static void testHandleLogo() {  
        
        init();
        
        Test.startTest();
        insert loc;
        Test.stopTest();        
    
        //Verify logo name
        system.assertEquals(loc.Logo_Name__c, 'locLogo');  
    }
    
}