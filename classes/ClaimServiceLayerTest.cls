@isTest
public class ClaimServiceLayerTest {
    
    @TestSetup
    static void testSetup(){
    
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

            Account a = new Account(Name = 'ABC Solutions');
            insert a;
            
            
            Document doc = new Document();
            doc.Name='InvoiceLogo';
            doc.DeveloperName = 'InvoiceLogo';
            doc.FolderId=usr.Id;
            insert doc ;


            dealer__Dealer_Location__c location = new dealer__Dealer_Location__c();
            location.name = 'Test Location';
            location.dealer__Company_Number__c=usr.Division;
            location.dealer__City__c='ABSD';
            location.dealer__State__c='NY';
            location.dealer__Postal_Code__c='1234';
            location.dealer__Default_Rate__c = 9.9;
            location.dealer__Warranty_Labor_Rate__c = 85.00;
            location.dealer__Location_Account__c = a.Id;
            location.dealer__Logo_Name__c = 'nologo';
            upsert location;

            StandardOpCode__c sop = new StandardOpCode__c();
            sop.name = 'Test Code';
            sop.Company_Number__c = usr.Division;
            sop.Active__c = true;
            sop.Book_Time__c = 1.5;
            insert sop;

            if(dealer__DMS_Settings__c.getValues('ActiveSettings') == null){
                dealer__DMS_Settings__c dms = new dealer__DMS_Settings__c();
                dms.Name = 'ActiveSettings';
                dms.dealer__Service_Current_Invoice_Number__c = 30093;
                dms.dealer__Service_Job_Line_Number__c = 8;
                dms.dealer__Parts_Current_Invoice_Number__c = 50115;
                dms.dealer__Parts_Current_Quote_Number__c = 20028;
                dms.dealer__Default_Tax_Rate__c = 7.75;
                dms.dealer__Service_Appointment_Sequence_Number__c=2000;
                insert dms;   
            }

            Service_Vehicle__c sv = new Service_Vehicle__c();
            sv.Year__c='2019';
            sv.Make__c='Peugeot';
            sv.Carline__c='308 GTi';
            sv.VIN__c='5FNRL5H90BB042844';
            insert sv;

            dealer__Claim__c claim = new dealer__Claim__c(dealer__Customer__c = a.Id,
                                                          dealer__StoreLocation__c = location.Id,
                                                          dealer__ServiceAdvisor__c = usr.Id, 
                                                          dealer__ServiceVehicle__c = sv.Id);
            insert claim;
        }
    }
    
@isTest
    public static void testClaimPrintController(){
        dealer__Claim__c claim = [SELECT Id, Name FROM dealer__Claim__c LIMIT 1];
        
            ApexPages.currentPage().getParameters().put('Id', claim.Id);
            ClaimPrintController controller = new ClaimPrintController(new ApexPages.StandardController(claim));
        

    }

    

}