@isTest
private class TestSROUpdateAccountTrigger {

    static testMethod void myUnitTest() {

        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');

    	dealer__DMS_Settings__c dms = new dealer__DMS_Settings__c();
    	if(dealer__DMS_Settings__c.getValues('ActiveSettings') == null){
        	dms.Name = 'ActiveSettings';
        	dms.dealer__Service_Current_Invoice_Number__c = 30093;
        	dms.dealer__Service_Job_Line_Number__c = 8;
        	//dms.dealer__State_Tax_Rate__c = 7.75;
        	dms.dealer__Parts_Current_Invoice_Number__c = 50115;
        	dms.dealer__Parts_Current_Quote_Number__c = 20028;
        	dms.dealer__Default_Tax_Rate__c = 7.75;
        	dms.dealer__Service_RO_Tax_if_Parts_Sold__c = true;
        	dms.dealer__Labor_Taxable__c = true;
        	insert dms;
    	}

        Parts_Service_Pricing_Strategy__c ps = new Parts_Service_Pricing_Strategy__c();
        ps.Method__c = 'Jobber';
        ps.Active__c = true;
        ps.Description__c = 'test';
        ps.Default__c = true;
        ps.dealer__Parts_Variable_Amount__c = 10;
        ps.dealer__Formula_Operand__c = '+';
        insert ps;  
        
    	dealer__CRMSettings__c crm = new dealer__CRMSettings__c();
    	if(dealer__CRMSettings__c.getInstance() == null){
    		system.debug('in to the loop');
    		crm.dealer__Rewards_Program_Enabled__c = true;    		
    	}
    	else{
    		dealer__CRMSettings__c crm1 = dealer__CRMSettings__c.getInstance();
    		if(crm1 != null){
                crm.dealer__Rewards_Program_Enabled__c = true;
    			system.debug('the values are'+crm1);
    		}
    	}
        crm.dealer__Rewards_OilChange_OpCodes__c='QLOF-0/20,QWRKS,QWRKSD,Q1000,01LOFGAS,QLOF';
        crm.dealer__Rewards_FreeService_OpCodes__c='Q 5TH FREE';
        upsert crm;
    	
        // TO DO: implement unit test
        Account accRec = new Account();
        accRec.Name = 'Test Account';
        accRec.Type = 'Customer - Direct';
        insert accRec;
        
        Contact conRec = new Contact();
        conRec.AccountId = accRec.Id;
        conRec.LastName = 'TestContact';
        conRec.FirstName = 'testFirstName';
        conRec.Email = 'nicki.allen@me.com';
        conRec.HomePhone = '8099306664';
        conRec.MobilePhone = '8099306664';
        insert conRec;
        
        dealer__Parts_Invoice__c pi = new dealer__Parts_Invoice__c();
        pi.dealer__Customer__c = accRec.Id;
        pi.dealer__Customer_Contact__c = conRec.Id;
        pi.Name = 'Test Invoice';
        pi.Location__c = loc.Id;
        pi.dealer__Comapny_Number__c = 'Location 1';
        pi.dealer__Deposit__c = 100;
        pi.dealer__Invoice_Number__c = 'inv1234';
        insert pi;
        
        dealer__Service_Vehicle__c SV = new dealer__Service_Vehicle__c();
        SV.dealer__Year__c = '2014';
        SV.dealer__Veh_Owner_Contact__c = conRec.Id;
        SV.dealer__VIN__c = 'B54998';
        SV.dealer__Stock_Number__c = '1234';
        SV.dealer__Make__c = 'Test';
        SV.dealer__Licence__c = 'Test';
        SV.dealer__Last_Service__c = System.today();
        SV.dealer__Carline__c = '2014';
        SV.dealer__Last_6__c = 'B54998';
        insert SV;
        
        
        dealer__Service_Repair_Order__c srOrder = new dealer__Service_Repair_Order__c();
        srOrder.dealer__Customer__c = accRec.Id;
        srOrder.dealer__Customer_Number__c  = 'Test';
        //srOrder.dealer__Customer_Contact__c = conRec.Id;
        srOrder.dealer__Service_Advisor__c = [Select Id from User where isActive = true limit 1].Id;
        srOrder.dealer__Parts_Invoice__c = pi.Id;
        //srOrder.dealer__Vehicle__c = SV.Id;
        srOrder.dealer__VIN__c = 'TESTVIN';
        srOrder.dealer__Mileage_In__c = 12;
        srOrder.dealer__RO_Number__c = 'RONUMBER2727';
        insert srOrder;
        
        
        dealer__Service_Job__c serJob = new dealer__Service_Job__c();
        serJob.dealer__Service_Repair_Order__c = srOrder.Id;
        serJob.dealer__Sublet_Total__c = 10;
        serJob.dealer__Job_Line_Id__c = srOrder.Id;
        serJob.dealer__Labor_Type__c = 'C';
        insert serJob;
        dealer__Service_Job__c serJob1 = new dealer__Service_Job__c();
        serJob1.dealer__Service_Repair_Order__c = srOrder.Id;
        serJob1.dealer__Sublet_Total__c = 10;
        serJob1.dealer__Job_Line_Id__c = srOrder.Id+'1';
        serJob1.dealer__Labor_Type__c = 'W';
        insert serJob1;
        dealer__Service_Job__c serJob2 = new dealer__Service_Job__c();
        serJob2.dealer__Service_Repair_Order__c = srOrder.Id;
        serJob2.dealer__Sublet_Total__c = 10;
        serJob2.dealer__Job_Line_Id__c = srOrder.Id+'2';
        serJob2.dealer__Labor_Type__c = 'I';
        insert serJob2;
        
        srOrder.dealer__Customer_Contact__c = conRec.Id;
        update srOrder;

    }
}