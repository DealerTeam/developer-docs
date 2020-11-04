/**
* Date            |Developer            |Work#
* Notes
* --
* 2017.01.23      |Gaurav               |W-000903
* Created to test ServiceAppointmentLineControl trigger on Service Appointment Line
**/

@isTest
public class ServiceAppointmentLineControlTest{
    @isTest
    public static void validateServiceAppointmentTrigger(){
        TestClassUtil util = new TestClassUtil();
        if(dealer__DMS_Settings__c.getValues('ActiveSettings') == null){
            util.insertDMSSettings();
        }    

        Profile prof = [select id from profile where name='system Administrator'];
        
        User usr = new User(alias = 'usr', email='us.name@vmail.com',
                  emailencodingkey='UTF-8', lastname='lstname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='testuser128@testorgx.com',
                  Division='DT1');
        insert usr;
        System.runAs(usr) {   
            Account accRec = new Account();
            accRec.FirstName = 'Test';
            accRec.LastName = 'Test';
            accRec.Type = 'Customer - Direct';
            insert accRec;
    
            dealer__Service_Vehicle__c SV = new dealer__Service_Vehicle__c();
            SV.dealer__Year__c = '2014';
            SV.dealer__Veh_Owner__c = accRec.Id;
            SV.dealer__VIN__c = 'MAH58585858';
            SV.dealer__Stock_Number__c = '1234';
            SV.dealer__Make__c = 'Test';
            SV.dealer__Licence__c = 'Test';
            SV.dealer__Last_Service__c = System.today();
            SV.dealer__Carline__c = '2014';
            SV.dealer__Last_6__c = 'B54998';
            insert SV;
    
            dealer__Service_Appointment__c DSAP = new dealer__Service_Appointment__c();
            DSAP.Name = 'Test Appointment';
            DSAP.dealer__Date_Time__c = System.now();
            DSAP.dealer__External_Id__c = '12345';
            DSAP.dealer__Vehicle__c = SV.Id;
            DSAP.dealer__Mileage__c = 100;
            DSAP.dealer__Company_Number__c = '12345';
            DSAP.dealer__SA__c = [Select Id from User where isActive = true limit 1].Id;
            insert DSAP;
            
            dealer__Service_Appointment__c DSAP1 = new dealer__Service_Appointment__c();
            DSAP1.Name = 'Test Appointment 1';
            DSAP1.dealer__Date_Time__c = System.now();
            DSAP1.dealer__External_Id__c = '123456';
            DSAP1.dealer__Vehicle__c = SV.Id;
            DSAP1.dealer__Mileage__c = 100;
            DSAP1.dealer__Company_Number__c = '123';
            insert DSAP1;            
            
            dealer__StandardOpCode__c newSC = new dealer__StandardOpCode__c(Name='123', dealer__Active__c=true, dealer__Book_Time__c=0.5, dealer__Concern__c='test op code', dealer__Op_Code_Description__c='Test op code vialble for all repairs', dealer__Op_Code__c = '12345:123', dealer__Company_Number__c = '12345');
            insert newSC; 

            dealer__Service_Appointment_Line__c line = new dealer__Service_Appointment_Line__c();
            line.dealer__Standard_Op_Code__c = newSC.Id;
            line.dealer__Service_Appointment__c = DSAP.Id;
            line.dealer__Line_Key__c = '12345';
            line.dealer__Pay_Type__c = 'C';
            line.dealer__Qoute__c = 2.5;   
            line.dealer__Op_Code_Name__c = '123';
            line.dealer__Complaint__c = 'Test';         
            insert line;
            
            line.dealer__CustomerConcern__c = 'Somethings Broke.';
            line.dealer__Op_Code_Name__c = '12345';         
            update line;
    
            dealer__Service_Appointment_Line__c line2 = new dealer__Service_Appointment_Line__c();
            line2.dealer__Service_Appointment__c = DSAP.Id;
            line2.dealer__Line_Key__c = '12345';
            line2.dealer__Appointment_Key__c = String.valueOf(DSAP1.Id);
            insert line2;        

        }
    }
}