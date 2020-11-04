@isTest(seeAllData=true)

private class TestServiceHistory {
    static testmethod void testServiceHistory() {
                

        if(dealer__DMS_Settings__c.getValues('ActiveSettings') == null){
            dealer__DMS_Settings__c dms = new dealer__DMS_Settings__c();
            dms.Name = 'ActiveSettings';
            dms.dealer__Service_Current_Invoice_Number__c = 30093;
            dms.dealer__Service_Job_Line_Number__c = 8;
            //dms.dealer__State_Tax_Rate__c = 7.75;
            dms.dealer__Parts_Current_Invoice_Number__c = 50115;
            dms.dealer__Parts_Current_Quote_Number__c = 20028;
            dms.dealer__Default_Tax_Rate__c = 7.75;
            dms.dealer__Service_Appointment_Sequence_Number__c=2000;
            insert dms;   
        }

        Contact c = new Contact(
                    FirstName='James',
                    LastName='Rowland',
                    Birthdate=date.parse('01/01/1970'),
                    Email='none@blackhole.org',
                    Salutation='Mr.',
                    Phone='5302221234',
                    MailingStreet='555 Cypress Ave',
                    MailingCity='Redding',
                    MailingState='CA',
                    MailingPostalCode='96001'
            );
                    
        insert c;
        
        dealer__Service_Vehicle__c vehicle = new dealer__Service_Vehicle__c( 
                                                                                Name='TestVehicle',
                                                                                dealer__Year__c='2011',
                                                                                dealer__Make__c='Ford',
                                                                                dealer__Carline__c='Escape'
                                                                            );
        insert vehicle;
        
        // ServiceHistory.serviceHistoryJSON(vehicle.Id);       
        
            
        dealer__Service_Repair_Order__c sro = new dealer__Service_Repair_Order__c(  Name='testRO',
                                                                                    dealer__Vehicle__c=vehicle.Id,
                                                                                    dealer__Mileage_In__c=1234,
                                                                                    dealer__Customer_Contact__c=c.Id,
                                                                                    dealer__RO_Number__c='RO#123456'
                                                                                );
                                                                                
        insert sro;
        
        
        dealer__Service_Job__c sjl = new dealer__Service_Job__c(
                                                                Name='Line1',
                                                                dealer__Service_Repair_Order__c=sro.Id,
                                                                dealer__Line_Number__c=1,
                                                                dealer__Op_Code__c='A123'
                                                                );
        insert sjl; 
        
        // Zero History
        ServiceHistory.serviceHistoryJSON(vehicle.Id);
        
        sro.dealer__Invoiced_Date_Time__c=DateTime.now();
        update sro;
        
        // Populated History & test constructor
        ServiceHistory sh = new ServiceHistory();
        ServiceHistory.serviceVehicle = vehicle.Id;
        ServiceHistory.serviceHistoryJSON(vehicle.Id);  
    }
    
    static testmethod void testRewardsTriggers() {
            
            Contact c = new Contact(
                        FirstName='James',
                        LastName='Rowland',
                        Birthdate=date.parse('01/01/1970'),
                        Email='none@blackhole.org',
                        Salutation='Mr.',
                        Phone='5302221234',
                        MailingStreet='555 Cypress Ave',
                        MailingCity='Redding',
                        MailingState='CA',
                        MailingPostalCode='96001'
                );
                        
            insert c;           
            
            dealer__Rewards__c r = new dealer__Rewards__c();
            r.Name = '555999000';
            r.dealer__Primary_Contact__c=c.Id;
            
            insert r;
            
            dealer__Reward_Transaction__c rt = new dealer__Reward_Transaction__c();
            rt.dealer__Rewards_Account__c=r.Id;
            rt.dealer__Customer_Charges_this_visit__c = 100;
            rt.dealer__Rewards_Claimed__c=-1;
            rt.dealer__Rewards_Earned__c=5;
            rt.dealer__Transaction_Document__c='A1234';
            
            insert rt;
            
            rt.dealer__Oil_Changed_this_visit__c=true;
            rt.dealer__Rewards_Earned__c=125;
            rt.dealer__Rewards_Claimed__c=-5;
            
            update rt;
            
            delete rt;
    }
}