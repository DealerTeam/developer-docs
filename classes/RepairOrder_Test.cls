@isTest (seeAllData = true)
private class RepairOrder_Test{

    static testmethod void testRepairOrder(){
        
    test.startTest();  
        dealer__Appraisal__c appraisal = new dealer__Appraisal__c();
        
        dealer__Service_Vehicle__c svcVeh = new dealer__Service_Vehicle__c();
        svcVeh.dealer__Vin__c = '2C4RDGCG4DR687666';
        svcVeh.dealer__Year__c = '2013';
        svcVeh.dealer__Make__c = 'Dodge';
        svcVeh.dealer__Carline__c = 'Grand Caravan';
        svcVeh.dealer__Trim_Level__c = 'SXT';
        svcVeh.dealer__Last_Odometer__c = 123456;
        svcVeh.dealer__Body_Type__c = 'Mini-Van';
        svcVeh.dealer__Licence__c = '123dfd';
        try{
          insert svcVeh;
        }catch(Exception e){
        
        }
    
    
        dealer__Dealer_Location__c dLocation = new dealer__Dealer_Location__c();
        dLocation.dealer__City__c = 'Udupi';
        dLocation.dealer__Company_Number__c = '1234';
        dLocation.dealer__State__c = 'Ka';
        dLocation.dealer__Postal_Code__c = '560050';
        
        Account a = new Account ();
        a.name ='Dheeraj';
        
        dealer__Sales_Up__c salesUp = new dealer__Sales_Up__c();
        salesUp.dealer__LastName__c = 'Test SUP';
        salesUp.dealer__Lead_Status__c = 'Open';
        salesUp.dealer__Lead_Type__c = 'Phone';
        salesUp.dealer__Lead_Date__c = System.today();
        salesUp.dealer__Trade_VIN__c = '2C4RDGCG4DR687666';
        salesUp.dealer__Trade_Year__c = '2056';
        salesUp.dealer__Trade_Make__c = 'MARS';
        salesUp.dealer__Trade_Model__c = 'THING';
        try{
            insert a;
            insert dLocation; 
            insert salesUp;
        }catch(Exception e){
            System.debug('LOCATION ERROR'+e);
        }
        
    
        dealer__Service_Repair_Order__c ro = new dealer__Service_Repair_Order__c();
        ro.dealer__Customer__c = a.Id;
        ro.dealer__Mileage_In__c = 55;
        
        
        dealer__Appraisal_Vehicle__c apprVeh = new dealer__Appraisal_Vehicle__c();
        apprVeh.dealer__Sales_Up__c = salesUp.id;
        apprVeh.dealer__Service_Vehicle__c = svcVeh.id;
        apprVeh.dealer__VIN__c = salesUp.dealer__Trade_VIN__c;
        apprVeh.dealer__Year__c = salesUp.dealer__Trade_Year__c;
        apprVeh.dealer__Make__c = salesUp.dealer__Trade_Make__c;
        apprVeh.dealer__Model__c = salesUp.dealer__Trade_Model__c;
        
        try{    
          insert ro;
          insert apprVeh;
        }catch(Exception e){
            System.debug('RO ERROR'+e);
        }
        
         dealer__Deal__c d = new dealer__Deal__c();
         d.dealer__Auto_Insurance_City__c = 'Blore';
         d.dealer__Buyer__c = a.Id;
         d.dealer__Store_Location__c = dLocation.Id;
         d.dealer__Deal_ID__c = 'Test123';
         try{
             insert d;
         }catch(Exception e){
         System.debug('DEAL ERROR'+e);
    
         }
         
        dealer__After_Market__c am = new dealer__After_Market__c();
        am.Name = 'Test Name';
        am.dealer__Car_Deal__c = d.id;
        am.dealer__Company_Number__c = '123';
        am.dealer__Description__c = 'Test Desc';
        
        try{
            insert am;
        }catch(Exception e){
        
        }
        
        dealer__After_Market__c am1 = new dealer__After_Market__c();
        am1.Name = 'Test1 Name';
        am1.dealer__Car_Deal__c = d.id;
        am1.dealer__Company_Number__c = '123';
        am1.dealer__Description__c = 'Test1 Desc';
        
        try{
            insert am1;
        }catch(Exception e){
        
        }
            
        
        dealer__We_Owe__c weOwe = new dealer__We_Owe__c();
        weOwe.dealer__Car_Deal__c = d.Id;
        weOwe.dealer__Description__c= 'Test';
        try{
        insert weOwe;
        } Catch(Exception e){
        }
       
        dealer__We_Owe_Line__c wLines = new dealer__We_Owe_Line__c();    
        wLines.dealer__Cost__c = 25;
        
        wLines.dealer__Description__c = 'Test Description';
        wLines.dealer__Labor_Hours__c = 5;
        wLines.dealer__Labor_Sale__c =10;
        wLines.dealer__List_Price__c = 100;
        wLines.dealer__Parts_Sale__c = 120;
        wLines.dealer__Sale_Price__c = 180;
        wLines.dealer__Taxable__c = TRUE;
        wLines.dealer__We_Owe__c = weOwe.Id;
        
        try{
            insert wLines;
        } catch(Exception e){
        } 
        
        ApexPages.currentPage().getParameters().put('weOweId',weOwe.id);         
        RepairOrder rOrder = new RepairOrder();
        rOrder.createRepairOrder();
        test.stopTest();
    }
    
    @isTest static void test_method_three() {
        test.startTest();
        
        dealer__Service_Estimate__c se = new dealer__Service_Estimate__c();
        se.dealer__Status__c = 'Open';
        se.dealer__Current_Mileage__c = 10;
        try{
            insert se;
        } catch(Exception e){
        } 
        
        dealer__Service_Estimate_Line__c sel = new dealer__Service_Estimate_Line__c();
        sel.dealer__Service_Estimate__c = se.id;
        try{
            insert sel;
        } catch(Exception e){
        } 
        
        
        se.dealer__Status__c = 'Finalized';
        
        try{
            update se;
        } catch(Exception e){
        } 
        
        
        test.stopTest();
        
    }
}