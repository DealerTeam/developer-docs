@isTest
private class TestPurchaseOrder_EXT{

    @testSetup static void testData() {

        TestClassUtil testutil = new TestClassUtil();
        testutil.insertDMSSettings();        

        Account accRec = new Account();
        accRec.Name = TestClassUtil.generateRandomString(6) + ' Corp';
        accRec.Type = 'Customer - Direct';
        accRec.dealer__Vendor__c = true;
        insert accRec;        
    }
    
    static testmethod void testPurchaseOrderEXT() {
        
        Account accRec = [SELECT Id FROM Account WHERE Vendor__c = true LIMIT 1];

        dealer__Purchase_Order__c po = new dealer__Purchase_Order__c();
        po.dealer__Vendor__c = accRec.Id;
        po.dealer__Vendor_Email__c = 'test@gmail.com';
        insert po;

        // Create a Parts Master Entry
        dealer__Parts_Master__c pm = new dealer__Parts_Master__c();
        pm.Name = 'FL1A__TEST_PART';
        pm.dealer__Retail_Price__c = 99.99;
        pm.Manufacturer__c = 'FD';
        insert pm;      

        dealer__Parts_Inventory__c inventory = new dealer__Parts_Inventory__c();
        inventory.dealer__Part_No__c = '9963777777';
        inventory.dealer__Cost__c = 70;
        inventory.dealer__List__c = 70;
        inventory.dealer__MFG__c = 'MFG';
        inventory.dealer__Parts_Master__c = pm.Id;
        inventory.dealer__Location__c=dealer.TestClassUtil.createLocation();         
        insert inventory;
        //dealer__Purchase_Order__c po = [Select Id, Name, dealer__Vendor_Email__c from dealer__Purchase_Order__c limit 1]; 
        
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(po);
        PurchaseOrder_EXT poc = new PurchaseOrder_EXT(sc);
        
        TestClassUtil testutil = new TestClassUtil();
        String roId             =   testutil.insertServiceRepairOrder();
        
        dealer__Service_Job__c jl = new dealer__Service_Job__c();
        jl.dealer__Service_Repair_Order__c = roId;
        insert jl;
        
        system.currentPageReference().getParameters().put('job', jl.id);
        
        dealer__Purchase_Order_Line__c poline = new dealer__Purchase_Order_Line__c();
        poline.dealer__Purchase_Order__c = po.id;
        poline.dealer__Part__c = inventory.id;
        poline.dealer__Part_Quantity__c = 9;
        poline.dealer__Amount__c = 45;
        poline.dealer__Service_Job_Line__c=jl.id;
        insert poline;
        
        
        //dealer__Purchase_Order_Line__c poline = [select Id, Name, dealer__Part__c from dealer__Purchase_Order_Line__c limit 1];
        
        poc.LINEAMT=Decimal.valueOf(10);
        poc.LINEQTY=Decimal.valueOf(1);
        // poc.LINEPO=poline;
        poc.LINEDESC='Purchase of fuel filter';
        
        poc.body='Testing body of email message';
        poc.email='jarrett@dealerteam.com';
        
        dealer__Purchase_Order_Line__c polineGet = poc.getLINEPO();
        
        poc.AttachPDF();
        poc.newPartLine();
        poc.emailPO();
        
        poc.sendPdf();

        // Test Sublet
        
        poc.SUBLET_LINEDESC      =   'Test Desc';
        poc.SUBLET_AMOUNT        =   '99';
        poc.SUBLET_NOTES         =   'TestNotes';
        poc.SUBLET_JOBLINE.dealer__Service_Job_Line__c = jl.Id;
        poc.getSUBLET_JOBLINE();
        poc.addSublet();

        // Test Misc
        poc.MISC_DESC            =   'Test Misc Desc';
        poc.MISC_AMT             =   '100';

        //  Return to Repair Order
        poc.returnToRepairOrder();

    }

    static testmethod void testDeletePurchaseOrderEXT() {
        
        Account accRec = [SELECT Id FROM Account WHERE Vendor__c = true LIMIT 1];

        dealer__Purchase_Order__c po = new dealer__Purchase_Order__c();
        po.dealer__Vendor__c = accRec.Id;
        po.dealer__Vendor_Email__c = 'test@gmail.com';
        insert po;

        // Create a Parts Master Entry
        dealer__Parts_Master__c pm = new dealer__Parts_Master__c();
        pm.Name = 'FL1A__TEST_PART';
        pm.dealer__Retail_Price__c = 99.99;
        pm.Manufacturer__c = 'FD';
        insert pm;      

        dealer__Parts_Inventory__c inventory = new dealer__Parts_Inventory__c();
        inventory.dealer__Part_No__c = '9963777777';
        inventory.dealer__Cost__c = 70;
        inventory.dealer__List__c = 70;
        inventory.dealer__MFG__c = 'MFG';
        inventory.dealer__Parts_Master__c = pm.Id;
        inventory.dealer__Location__c=dealer.TestClassUtil.createLocation();         
        insert inventory;
        //dealer__Purchase_Order__c po = [Select Id, Name, dealer__Vendor_Email__c from dealer__Purchase_Order__c limit 1]; 
        
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(po);
        PurchaseOrder_EXT poc = new PurchaseOrder_EXT(sc);
        
        TestClassUtil testutil = new TestClassUtil();
        String roId             =   testutil.insertServiceRepairOrder();
        
        Test.startTest();

            dealer__Service_Job__c jl = new dealer__Service_Job__c();
            jl.dealer__Service_Repair_Order__c = roId;
            insert jl;
            
            system.currentPageReference().getParameters().put('job', jl.id);
            
            dealer__Purchase_Order_Line__c poline = new dealer__Purchase_Order_Line__c();
            poline.dealer__Purchase_Order__c = po.id;
            poline.dealer__Part__c = inventory.id;
            poline.dealer__Part_Quantity__c = 9;
            poline.dealer__Amount__c = 45;
            poline.dealer__Service_Job_Line__c=jl.id;
            insert poline;

            delete poline;
        
        Test.stopTest();
    }


    static testmethod void testPurchaseOrderEXT1() {
        
        Account accRec = [SELECT Id FROM Account WHERE Vendor__c = true LIMIT 1];

        dealer__Purchase_Order__c po = new dealer__Purchase_Order__c();
        po.dealer__Vendor__c = accRec.Id;
        po.dealer__Vendor_Email__c = 'test@gmail.com';
        insert po;

        // Create a Parts Master Entry
        dealer__Parts_Master__c pm = new dealer__Parts_Master__c();
        pm.Name = 'FL1A__TEST_PART';
        pm.dealer__Retail_Price__c = 99.99;
        pm.Manufacturer__c = 'FD';
        insert pm;      

        dealer__Parts_Inventory__c inventory = new dealer__Parts_Inventory__c();
        inventory.dealer__Part_No__c = '9963777777';
        inventory.dealer__Cost__c = 70;
        inventory.dealer__List__c = 70;
        inventory.dealer__MFG__c = 'MFG';
        inventory.dealer__Parts_Master__c = pm.Id;
        inventory.dealer__Location__c=dealer.TestClassUtil.createLocation();         
        insert inventory;
        //dealer__Purchase_Order__c po = [Select Id, Name, dealer__Vendor_Email__c from dealer__Purchase_Order__c limit 1]; 
        
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(po);
        PurchaseOrder_EXT poc = new PurchaseOrder_EXT(sc);
        
        TestClassUtil testutil = new TestClassUtil();
        String roId             =   testutil.insertServiceRepairOrder();
        
        dealer__Service_Job__c jl = new dealer__Service_Job__c();
        jl.dealer__Service_Repair_Order__c = roId;
        insert jl;
        
        system.currentPageReference().getParameters().put('job', jl.id);
        
        dealer__Purchase_Order_Line__c poline = new dealer__Purchase_Order_Line__c();
        poline.dealer__Purchase_Order__c = po.id;
        poline.dealer__Part_Quantity__c = 9;
        poline.dealer__Amount__c = 45;
        poline.dealer__Part__c = inventory.id;
        poline.dealer__Service_Job_Line__c=jl.id;
        insert poline;
    }

    static testmethod void testUpdatePurchaseOrderEXT() {
        
        Account accRec = [SELECT Id FROM Account WHERE Vendor__c = true LIMIT 1];

        dealer__Purchase_Order__c po = new dealer__Purchase_Order__c();
        po.dealer__Vendor__c = accRec.Id;
        po.dealer__Vendor_Email__c = 'test@gmail.com';
        po.dealer__Accepted_DateTime__c = system.now();
        insert po;

        // Create a Parts Master Entry
        dealer__Parts_Master__c pm = new dealer__Parts_Master__c();
        pm.Name = 'FL1A__TEST_PART';
        pm.dealer__Retail_Price__c = 99.99;
        pm.Manufacturer__c = 'FD';
        insert pm;      

        dealer__Parts_Inventory__c inventory = new dealer__Parts_Inventory__c();
        inventory.dealer__Part_No__c = '9963777777';
        inventory.dealer__Cost__c = 70;
        inventory.dealer__List__c = 70;
        inventory.dealer__MFG__c = 'MFG';
        inventory.dealer__Parts_Master__c = pm.Id;
        inventory.dealer__Location__c=dealer.TestClassUtil.createLocation();         
        insert inventory;
        //dealer__Purchase_Order__c po = [Select Id, Name, dealer__Vendor_Email__c from dealer__Purchase_Order__c limit 1]; 
        
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(po);
        PurchaseOrder_EXT poc = new PurchaseOrder_EXT(sc);
        
        TestClassUtil testutil = new TestClassUtil();
        String roId             =   testutil.insertServiceRepairOrder();
        
        dealer__Service_Job__c jl = new dealer__Service_Job__c();
        jl.dealer__Service_Repair_Order__c = roId;
        insert jl;
        
        system.currentPageReference().getParameters().put('job', jl.id);
        
        dealer__Purchase_Order_Line__c poline = new dealer__Purchase_Order_Line__c();
        poline.dealer__Purchase_Order__c = po.id;
        poline.dealer__Part__c = inventory.id;
        poline.dealer__Part_Quantity__c = 9;
        poline.dealer__Amount__c = 45;
        poline.dealer__Service_Job_Line__c=jl.id;
        insert poline;

        update poline;
    }

    static testmethod void testSubletPO() {
        TestClassUtil testutil = new TestClassUtil();
        String roId             =   testutil.insertServiceRepairOrder();
        dealer__Service_Job__c jl = new dealer__Service_Job__c();
        jl.dealer__Service_Repair_Order__c = roId;
        insert jl; 

        Account accRec = [SELECT Id FROM Account WHERE Vendor__c = true LIMIT 1];

        Test.setCurrentPage(new PageReference('Page.dealer__PurchaseOrder'));
        system.currentPageReference().getParameters().put('ro', roId);

        dealer__Purchase_Order__c po = new dealer__Purchase_Order__c();
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(po);
        PurchaseOrder_EXT poc = new PurchaseOrder_EXT(sc);        

        po.dealer__Vendor__c = accRec.Id;
        poc.recordTypeName='Sublet';
        poc.save();

        String purl = poc.postingURL;
        String rname = poc.recordTypeName;
        String ca = poc.CHARGE_AMOUNT;
        String spoid = poc.select_part_order_id;

        // poc.getPartsLines(); method removed 
        poc.getorderLines();

        //poc.postingURL = 'dealer__PurchaseOrderPost'
        poc.closePurchaseOrder();
        poc.recordTypeName = 'Parts_Purchase';
        poc.acceptPO();
        poc.postPO();
        poc.receiveParts();

    }
    
    static testmethod void testPOPrinting(){
        
        Document doc = new Document();
        doc.Name = 'InvoiceLogo';
        doc.DeveloperName = 'InvoiceLogo';
        if([Select Id from Document Where DeveloperName = 'InvoiceLogo'].size() == 0){
            doc.FolderId = userinfo.getUserId();
            insert doc;
        }
        
        RecordType rt = [select Id, Name from RecordType  
                        where SObjectType='dealer__Purchase_Order__c' and name = 'Miscellaneous'limit 1];
                        
        Account accRec = [SELECT Id FROM Account WHERE Vendor__c = true LIMIT 1];
        
        Contact con = new Contact();
        con.Phone = '8888888';
        con.LastName = 'Test';
        insert con;
        
        dealer__Parts_Quote__c pq = new dealer__Parts_Quote__c();
        pq.dealer__Customer_Contact__c = con.id;
        pq.dealer__Counterman__c = UserInfo.getUserId();
        pq.dealer__Price_Level__c = 'high';
        insert pq;
        
        dealer__Parts_Quote_Line__c pl = new dealer__Parts_Quote_Line__c();
        pl.dealer__Core__c = 125.2;
        pl.dealer__List__c = 565;
        pl.dealer__Cost__c = 858;
        pl.dealer__Quantity__c = 55;
        pl.dealer__Parts_Quote__c = pq.id; 
        insert pl;
        dealer__Dealer_Location__c l = new dealer__Dealer_Location__c(
                   Name = 'test loc',
                   dealer__Company_Number__c = '1234',
                   dealer__City__c = 'rjy',
                   dealer__State__c = 'ap',
                   dealer__Postal_Code__c = '12345'
                    );
                    insert l;

        //dealer__Purchase_Order__c po = [Select Id, Name, dealer__Vendor_Email__c from dealer__Purchase_Order__c limit 1]; 
        dealer__Purchase_Order__c po = new dealer__Purchase_Order__c();
        po.RecordTypeId = rt.id;
        po.dealer__Vendor__c = accRec.Id;
        po.dealer__Vendor_Email__c = 'test@gmail.com';
        insert po;
        
        dealer__Parts_Master__c pm = new dealer__Parts_Master__c();
        pm.Name = 'FL1A__TEST_PART';
        pm.dealer__Retail_Price__c = 99.99;
        pm.Manufacturer__c = 'FD';
        insert pm;      

        dealer__Parts_Inventory__c inventory = new dealer__Parts_Inventory__c();
        inventory.dealer__Part_No__c = '9963777777';
        inventory.dealer__Cost__c = 70;
        inventory.dealer__List__c = 70;
        inventory.dealer__MFG__c = 'MFG';
        inventory.dealer__Parts_Master__c = pm.Id;
        inventory.dealer__Location__c=dealer.TestClassUtil.createLocation();         
        insert inventory;
        
        dealer__Purchase_Order_Line__c poline = new dealer__Purchase_Order_Line__c();
        poline.dealer__Purchase_Order__c = po.id;
        poline.dealer__Part__c = inventory.id;
        poline.dealer__Part_Quantity__c = 9;
        poline.dealer__Amount__c = 227;
        insert poline;
        
        PageReference printPage = Page.PurchaseOrderPDF;
        Test.setCurrentPageReference(printPage); 
        System.currentPageReference().getParameters().put('id', po.Id);
        
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(po);        
        
        PurchaseOrder_Printing poprint = new PurchaseOrder_Printing(sc);
        
        String pDateTime = poprint.printDateTime;
        
        poprint.getInvoiceLogo();
        poprint.prepareOrderLinesForPrinting();
        dealer__Dealer_Location__c loc = poprint.dlr;

    }

    static testmethod void testVehiclePurchase() {

        TestClassUtil testutil = new TestClassUtil();
        testutil.insertVINDecoderSetup();
        
        Account accRec = new Account();
        accRec.Name = 'Test Account';
        accRec.Type = 'Customer - Direct';
        accRec.dealer__Vendor__c = true;
        insert accRec;

        dealer__Purchase_Order__c po = new dealer__Purchase_Order__c();
        po.dealer__Vendor__c = accRec.Id;
        po.dealer__Vendor_Email__c = 'test@gmail.com';
        po.dealer__StockNumber__c = '12345';
        po.dealer__VIN__c = '2C4RDGBG2FR581207';
        insert po;    
            
        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(po);
        PurchaseOrder_EXT poc = new PurchaseOrder_EXT(sc);     

        List<SelectOption> ops = poc.getVehicleStatusOptions();
        poc.findExisting();
        poc.decodeVIN();

    }

    static testmethod void testVoid() {

        Account accRec = [SELECT Id FROM Account WHERE Vendor__c = true LIMIT 1];
        
        dealer__Purchase_Order__c po = new dealer__Purchase_Order__c();
        po.dealer__Vendor__c = accRec.Id;
        po.dealer__Vendor_Email__c = 'test@gmail.com';
        insert po;

        ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(po);
        PurchaseOrder_EXT poc = new PurchaseOrder_EXT(sc);        

        poc.voidPO();


    }
}