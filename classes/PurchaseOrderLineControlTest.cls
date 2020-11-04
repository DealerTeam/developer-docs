@isTest
private class PurchaseOrderLineControlTest {
    
     @TestSetup static void testData() {

        TestClassUtil tu = new TestClassUtil();
        tu.insertDMSSettings();  

        Parts_Service_Pricing_Strategy__c ps = new Parts_Service_Pricing_Strategy__c();
        ps.Method__c = 'Jobber';
        ps.Active__c = true;
        ps.Description__c = 'test';
        ps.Default__c = true;
        ps.dealer__Parts_Variable_Amount__c = 10;
        ps.dealer__Formula_Operand__c = '+';
        insert ps;      
       
    }
    
    
    @isTest static void testInsertPOL() {
        
        Account accRec = new Account();
        accRec.Name = 'Test Account';
        accRec.Type = 'Customer - Direct';
        accRec.dealer__Vendor__c = true;
        insert accRec;
        
        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation(TestClassUtil.generateRandomString(3), TestClassUtil.generateRandomString(8));
        
        dealer__Purchase_Order__c po = new dealer__Purchase_Order__c();
        po.dealer__Vendor__c = accRec.Id;
        po.dealer__Vendor_Email__c = 'test@gmail.com';
        insert po;

        // Create a Parts Master Entry
        dealer__Parts_Master__c pm = new dealer__Parts_Master__c();
        pm.Name = 'FL1A__TEST_PART';
        pm.dealer__Cost__c = 5;
        pm.dealer__Retail_Price__c = 99.99;
        pm.Manufacturer__c = 'FD';
        insert pm;      
		
        //Part
        dealer__Parts_Inventory__c inventory = new dealer__Parts_Inventory__c();
        inventory.dealer__Part_No__c = '9963777777';
        inventory.dealer__Cost__c = 5;
        inventory.dealer__List__c = 10;
        inventory.dealer__MFG__c = 'MFG';
        inventory.dealer__Parts_Master__c = pm.Id;
        inventory.dealer__Location__c= loc.Id;      
        insert inventory;
        
        TestClassUtil testutil = new TestClassUtil();
        String roId             =   testutil.insertServiceRepairOrder();
        
        dealer__Service_Job__c jl = new dealer__Service_Job__c();
        jl.dealer__Service_Repair_Order__c = roId;
        insert jl;
        
        dealer__Parts_Invoice__c pi = new dealer__Parts_Invoice__c(
                                                                    Name='INV1234',
                                                                    dealer__Customer__c=accRec.Id,
                                                                    dealer__Invoice_Number__c='1234',
                                                                    dealer__Location__c=loc.id
                                                                   );
                                                                   
        insert pi;

        // Invoice Line Add
        dealer__Parts_Invoice_Line__c pl = new dealer__Parts_Invoice_Line__c(
                dealer__Quantity_Sold__c = 1, 
                dealer__Part__c = inventory.Id,
                dealer__Part_Number__c = inventory.dealer__Part_No__c,
                dealer__Parts_Invoice__c = pi.Id,
            	dealer__Job_Line__c=jl.id,
            	dealer__Cost__c = 5
            );
        insert pl;

        
        dealer__Purchase_Order_Line__c poline = new dealer__Purchase_Order_Line__c();
        poline.dealer__Purchase_Order__c = po.id;
        poline.dealer__Part__c = inventory.id;
        poline.dealer__Part_Quantity__c = 1;
        poline.dealer__Service_Job_Line__c=jl.id;
        poline.dealer__Amount__c = 5;
        
        Test.startTest();
        	insert poline;
        Test.stopTest();
        
        dealer__Service_Job__c sj = [Select Id, dealer__Parts_Cost__c, dealer__Parts_Total__c, dealer__Service_Repair_Order__c 
                                     from dealer__Service_Job__c];
        
        system.assertEquals(poline.dealer__Amount__c * poline.dealer__Part_Quantity__c, sj.dealer__Parts_Cost__c);
                      
    }    
    
    @isTest static void testDeletePOL() {
        
        Account accRec = new Account();
        accRec.Name = 'Test Account';
        accRec.Type = 'Customer - Direct';
        accRec.dealer__Vendor__c = true;
        insert accRec;
        
        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation(TestClassUtil.generateRandomString(3), TestClassUtil.generateRandomString(8));
        
        dealer__Purchase_Order__c po = new dealer__Purchase_Order__c();
        po.dealer__Vendor__c = accRec.Id;
        po.dealer__Vendor_Email__c = 'test@gmail.com';
        insert po;

        // Create a Parts Master Entry
        dealer__Parts_Master__c pm = new dealer__Parts_Master__c();
        pm.Name = 'FL1A__TEST_PART';
        pm.dealer__Cost__c = 5;
        pm.dealer__Retail_Price__c = 99.99;
        pm.Manufacturer__c = 'FD';
        insert pm;      
		
        //Part
        dealer__Parts_Inventory__c inventory = new dealer__Parts_Inventory__c();
        inventory.dealer__Part_No__c = '9963777777';
        inventory.dealer__Cost__c = 5;
        inventory.dealer__List__c = 10;
        inventory.dealer__MFG__c = 'MFG';
        inventory.dealer__Parts_Master__c = pm.Id;
        inventory.dealer__Location__c= loc.Id;    
        inventory.dealer__On_Order__c = 1;
        insert inventory;
        
        TestClassUtil testutil = new TestClassUtil();
        String roId             =   testutil.insertServiceRepairOrder();
        
        dealer__Service_Job__c jl = new dealer__Service_Job__c();
        jl.dealer__Service_Repair_Order__c = roId;
        insert jl;
        
        dealer__Parts_Invoice__c pi = new dealer__Parts_Invoice__c(
                                                                    Name='INV1234',
                                                                    dealer__Customer__c=accRec.Id,
                                                                    dealer__Invoice_Number__c='1234',
                                                                    dealer__Location__c=loc.id
                                                                   );
                                                                   
        insert pi;

        // Invoice Line Add
        dealer__Parts_Invoice_Line__c pl = new dealer__Parts_Invoice_Line__c(
                dealer__Quantity_Sold__c = 1, 
                dealer__Part__c = inventory.Id,
                dealer__Part_Number__c = inventory.dealer__Part_No__c,
                dealer__Parts_Invoice__c = pi.Id,
            	dealer__Job_Line__c=jl.id,
            	dealer__Cost__c = 5
            );
        insert pl;

        
        dealer__Purchase_Order_Line__c poline = new dealer__Purchase_Order_Line__c();
        poline.dealer__Purchase_Order__c = po.id;
        poline.dealer__Part__c = inventory.id;
        poline.dealer__Part_Quantity__c = 1;
        poline.dealer__Service_Job_Line__c=jl.id;
        poline.dealer__Amount__c = 5;
        
        insert poline;
        
        Test.startTest();
        	delete poline;
        Test.stopTest();
        
        dealer__Service_Job__c sjob = [Select Id, dealer__Sublet_Cost__c 
                                     from dealer__Service_Job__c];
        
        system.assertEquals(0 , sjob.dealer__Sublet_Cost__c);

    }
    
    @isTest static void testUpdatePOL() {
        
        Account accRec = new Account();
        accRec.Name = 'Test Account';
        accRec.Type = 'Customer - Direct';
        accRec.dealer__Vendor__c = true;
        insert accRec;
        
        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation(TestClassUtil.generateRandomString(3), TestClassUtil.generateRandomString(8));
        
        dealer__Purchase_Order__c po = new dealer__Purchase_Order__c();
        po.dealer__Vendor__c = accRec.Id;
        po.dealer__Vendor_Email__c = 'test@gmail.com';
        insert po;

        // Create a Parts Master Entry
        dealer__Parts_Master__c pm = new dealer__Parts_Master__c();
        pm.Name = 'FL1A__TEST_PART';
        pm.dealer__Cost__c = 5;
        pm.dealer__Retail_Price__c = 99.99;
        pm.Manufacturer__c = 'FD';
        insert pm;      
		
        //Part
        dealer__Parts_Inventory__c inventory = new dealer__Parts_Inventory__c();
        inventory.dealer__Part_No__c = '9963777777';
        inventory.dealer__Cost__c = 5;
        inventory.dealer__List__c = 10;
        inventory.dealer__MFG__c = 'MFG';
        inventory.dealer__Parts_Master__c = pm.Id;
        inventory.dealer__Location__c= loc.Id;    
        inventory.dealer__On_Order__c = 1;
        insert inventory;
        
        TestClassUtil testutil = new TestClassUtil();
        String roId             =   testutil.insertServiceRepairOrder();
        
        dealer__Service_Job__c jl = new dealer__Service_Job__c();
        jl.dealer__Service_Repair_Order__c = roId;
        insert jl;
        
        dealer__Parts_Invoice__c pi = new dealer__Parts_Invoice__c(
                                                                    Name='INV1234',
                                                                    dealer__Customer__c=accRec.Id,
                                                                    dealer__Invoice_Number__c='1234',
                                                                    dealer__Location__c=loc.id
                                                                   );
                                                                   
        insert pi;

        // Invoice Line Add
        dealer__Parts_Invoice_Line__c pl = new dealer__Parts_Invoice_Line__c(
                dealer__Quantity_Sold__c = 1, 
                dealer__Part__c = inventory.Id,
                dealer__Part_Number__c = inventory.dealer__Part_No__c,
                dealer__Parts_Invoice__c = pi.Id,
            	dealer__Job_Line__c=jl.id,
            	dealer__Cost__c = 5
            );
        insert pl;

        
        dealer__Purchase_Order_Line__c poline = new dealer__Purchase_Order_Line__c();
        poline.dealer__Purchase_Order__c = po.id;
        poline.dealer__Part__c = inventory.id;
        poline.dealer__Part_Quantity__c = 1;
        poline.dealer__Service_Job_Line__c=jl.id;
        poline.dealer__Amount__c = 5;
        
        insert poline;
        
        dealer__Dealer_Location__c location = TestClassUtil.insertDealerLocation(TestClassUtil.generateRandomString(4), TestClassUtil.generateRandomString(8));

        //Part Master
        dealer__Parts_Master__c pmaster = new dealer__Parts_Master__c();
        pmaster.Name = 'FL1B__TEST_PART';
        pmaster.dealer__Cost__c = 5;
        pmaster.dealer__Retail_Price__c = 15;
        pmaster.Manufacturer__c = 'FD';
        insert pmaster;      
        
        //Part
        dealer__Parts_Inventory__c part = new dealer__Parts_Inventory__c();
        part.Description__c = '123';
        part.dealer__Part_No__c = '123';
        part.dealer__Cost__c = 15;
        part.dealer__List__c = 20;
        part.dealer__MFG__c = 'MFG';
        part.dealer__Parts_Master__c = pmaster.Id;
        part.dealer__Location__c= location.Id;    
        part.dealer__On_Order__c = 1;
        insert part;
        
        poline.dealer__Part__c = part.Id;
        
        Test.startTest();
        	update poline;
        Test.stopTest();

		dealer__Purchase_Order_Line__c  objLine = [Select Description__c from dealer__Purchase_Order_Line__c
                                                  Where Id =: poline.Id];     
 
        
        system.assertEquals('FD:FL1B__TEST_PART 123' , objLine.Description__c);

    }

}