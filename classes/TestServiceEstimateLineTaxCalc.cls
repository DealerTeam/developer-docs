@isTest
private class TestServiceEstimateLineTaxCalc {
    @isTest
    private static void testInsertTrigger() {
        //
        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
        loc.dealer__Tax_Parts__c = true;
        loc.dealer__Tax_Service__c = false;
        loc.dealer__Tax_Local_Rate__c = 10;
        update loc;
        Profile prof = [select id from profile where name='system Administrator'];
        User u = new User(alias = 'usr', email='us.name@vmail.com',
                  emailencodingkey='UTF-8', lastname='lstname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='testuser128@testorgx.com',
                  Division='DT1');
        system.runAs(u){
 
        Account a = new Account();
        a.Name = 'Test Account';
        a.dealer__Tax_Exempt__c = false;
        insert a;    
        // Create a Master Record
        dealer__Service_Estimate__c se = new dealer__Service_Estimate__c(
                                                     dealer__Estimate_Notes__c='Test Service Estimate',
                                                     dealer__Customer__c = a.Id                   
                                                  );
        insert se;

        //Create child record and save some data                                          
        dealer__Service_Estimate_Line__c sl = new dealer__Service_Estimate_Line__c(
                                                        dealer__Description__c= 'TestDescription',
                                                        dealer__Service_Estimate__c=se.Id,
                                                        dealer__Labor__c=decimal.valueOf('100'),
                                                        dealer__Parts__c=decimal.valueOf('100')
                                                       );
        System.debug(sl);                                               
        insert sl;
        
        dealer__Service_Estimate_Line__c tsl = [Select Id, dealer__Tax__c, dealer__Parts__c from dealer__Service_Estimate_Line__c where Id = :sl.Id Limit 1];
        
        System.assertEquals(tsl.dealer__Tax__c, (tsl.dealer__Parts__c * (loc.dealer__Tax_Local_Rate__c / 100)));       
        
        loc.dealer__Tax_Service__c = true;
        update loc;
        a.dealer__Tax_Exempt__c = true;
        update a;
        update se;

        sl.dealer__Parts__c = decimal.valueOf('150');
        sl.dealer__Labor__c = decimal.valueOf('150');
        update sl;
        tsl = [Select Id, dealer__Tax__c, dealer__Parts__c from dealer__Service_Estimate_Line__c where Id = :sl.Id Limit 1];

        System.assertEquals(0, tsl.dealer__Tax__c);
        
        a.dealer__Tax_Exempt__c = false;
        update a;
        update se;
        tsl = [Select Id, dealer__Tax__c, dealer__Parts__c, dealer__Labor__c from dealer__Service_Estimate_Line__c where Id = :sl.Id Limit 1];

        System.assertEquals(30, tsl.dealer__Tax__c);

        }
    }    
    
    @isTest
    private  static void testSERA() {
        if(dealer__TaxSettings__c.getValues('ActiveSettings') == null){
            dealer__TaxSettings__c taxSettings = new dealer__TaxSettings__c();
            taxSettings.Name = 'ActiveSettings';
            taxSettings.dealer__State_Tax_Rate__c = 7.75;
            taxSettings.dealer__State_Code__c = 'VV';
            insert taxSettings;
        }
        RecordType rselected = [Select Id, Name, DeveloperName from RecordType where DeveloperName = 'X4_Square' limit 1];
        dealer__Service_Estimate__c se = new dealer__Service_Estimate__c(
                                                                dealer__Cosmetic_Notes__c='Repair / Repaint Bumper', 
                                                                RecordTypeId=rselected.Id
                                            );
        insert se;
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(se);
        ServiceEstimateRemoteActions sera = new ServiceEstimateRemoteActions(sc); 
        
        ServiceEstimateRemoteActions.saveCosmeticRepairLine(se.Id, 1, 'Test Damage', 125, 'DentPro', 'Dent Repair', 235, 110);
        
        dealer__Service_Estimate_Line__c[] sel = [Select Id, Name, dealer__Repair_Type__c, dealer__Vendor__c 
                                                    from dealer__Service_Estimate_Line__c
                                                    where dealer__Service_Estimate__c = :se.Id ];
                                                
        System.assertEquals(1, sel.size()); 
        System.assertEquals('DentPro', sel[0].dealer__Vendor__c);                                   
    }
}