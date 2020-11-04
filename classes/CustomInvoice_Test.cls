@isTest 
public class CustomInvoice_Test{
    
    static testMethod void testMetodOne(){
 
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

            TestClassUtil tu = new TestClassUtil();
            tu.insertStdOpcode();
            //tu.insertServiceJob();
            
            dealer__FixedOperationsSettings__c fixedOpsSettings = new dealer__FixedOperationsSettings__c(Repair_Order_Index__c= 1);
            insert fixedOpsSettings;
             
            //Inserting record into location object.
            //dealer__Dealer_Location__c loc = new dealer__Dealer_Location__c();
            //loc.Name = 'Crown Motors';
            //loc.dealer__Company_Number__c = TestClassUtil.generateRandomString(3);
            //loc.dealer__City__c = 'Redding';
            //loc.dealer__State__c= 'CA';
            //loc.dealer__Postal_Code__c='96001';
            //insert loc; 
            
            dealer__Service_Repair_Order__c spo = new dealer__Service_Repair_Order__c();        
            spo.dealer__Customer__c = tu.insertAccount();
            spo.dealer__Deposit__c = 100;
            spo.dealer__Customer_Contact__c = tu.insertContact();
            spo.Name = 'Test Service Repair Order';
            spo.dealer__Customer_Charges__c = 50;
            spo.dealer__Company_Number__c = 'DT1';
            spo.dealer__Tax__c = 30;
            spo.dealer__Shop_Supplies__c = 20;
            spo.dealer__RO_Number__c = 'RO137';
            spo.dealer__Mileage_In__c = 10;
            spo.dealer__Mileage_Out__c = 5;    
            try{
                insert spo;
            }catch(Exception e){
            
            }
            
            dealer__Service_Vehicle__c sv = new dealer__Service_Vehicle__c();
            sv.dealer__Year__c = '2014';
            sv.dealer__Veh_Owner_Contact__c = tu.insertContact();
            sv.dealer__VIN__c = 'B54998';
            sv.dealer__Stock_Number__c = '1234';
            sv.dealer__Make__c = 'Test';
            sv.dealer__Licence__c = 'Test';
            sv.dealer__Last_Service__c = System.today();
            sv.dealer__Carline__c = '2014';
            sv.dealer__Last_6__c = 'B54998';        
            insert sv;

            //Inserting record into Deal Object.
            dealer__Deal__c deal = new dealer__Deal__c();
            deal.dealer__Store_Location__c = loc.Id;
            deal.dealer__Broker__c = tu.insertAccount();
            deal.dealer__Buyer_Contact__c = tu.insertContact();
            deal.dealer__Buyer__c = tu.insertAccount();
            deal.dealer__Co_Buyer_Contact__c = tu.insertContact();
            deal.dealer__Co_Buyer__c = tu.insertAccount();
            deal.dealer__Deal_ID__c = '1623';
            deal.dealer__Licence__c = 'Ty 1831';
            deal.dealer__Vehicle__c = tu.insertVehicleInventory();
            deal.dealer__Service_Vehicle__c = sv.Id;
            // Create Service Vehicle


            //dealer__Service_Vehicle__c sVehicle = [Select Id from dealer__Service_Vehicle__c where dealer__Sales_Inventory__c =:deal.dealer__Vehicle__c limit 1];

            //System.assertNotEquals(sVehicle, null);
            
            deal.Name = '12342';        
            insert deal;
                    
            dealer__After_Market__c am = new dealer__After_Market__c();
            am.Name = 'Test Name';
            am.dealer__Car_Deal__c = deal.id;
            am.dealer__Company_Number__c = '123';
            am.dealer__Description__c = 'Test Desc';
            insert am;
            
         
            
            /*
            dealer__Service_Job__c  sj = new dealer__Service_Job__c ();
            sj.dealer__Service_Repair_Order__c = tu.insertServiceRepairOrder();
            sj.dealer__Stat__c = 'Open';
            sj.dealer__Standard_Operation_Code__c = tu.insertStdOpcode();
            sj.dealer__Parts_Cost__c = 100;
            sj.dealer__Op_Code__c = 'Test opcode';
            sj.dealer__Line_Number__c = 100;
            sj.dealer__Labor_Type__c = 'C';
            sj.dealer__Labor_Rate__c = 'Test Rate';
            sj.dealer__Labor_Charges__c = 100;
            sj.dealer__Job_Start__c = System.Now();
            sj.dealer__Job_Finish__c = System.Now ()+ 10; 
            sj.dealer__Estimate__c = 100;
            sj.dealer__Correction__c = 'Test long text correction';
            sj.dealer__CustomerConcern__c = 'Test long text customer concern';
            sj.dealer__Cause__c = 'Test cause';
            sj.dealer__Book_Time__c = 3;
            sj.dealer__Actual_Time__c = 123;
            sj.Name = 'Test Name';
            sj.dealer__Parts_Total__c = 100;        
            insert sj;
            */
            
            List<dealer__Inspection_Report__c> irList = new List<dealer__Inspection_Report__c>();
            dealer__Inspection_Report__c ir = new dealer__Inspection_Report__c();
            //ir.Name = 'Test Name';
            ir.dealer__Service_Vehicle__c = sv.Id;
            insert ir;
            irList.add(ir);
            

            Test.startTest();

            CustomInvoice ci = new CustomInvoice();
            ci.createROFromDeal(deal);
            CustomInvoice.createServEst(irList, deal);
            ci.createLines(spo,deal);

            Test.stopTest();

        }
        
    }
}