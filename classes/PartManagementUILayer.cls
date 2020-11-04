@isTest
private class PartManagementUILayer {

    @testSetup 
    static void SetupData() {
        TestClassUtil tu = new TestClassUtil();
        tu.insertDMSSettings();

        // Create the location
        dealer__Dealer_Location__c loc = TestClassUtil.insertDealerLocation('DT1', 'DealerTeam Motors');
        dealer__Dealer_Location__c loc2 = TestClassUtil.insertDealerLocation('DT2', 'DealerTeam Dua');
        dealer__FixedOperationsSettings__c ops = dealer__FixedOperationsSettings__c.getOrgDefaults();

        ops.dealer__Kit_Create_Part_Master__c = true;
        ops.dealer__PurchaseOrderPartsReceiptAddress__c = 'jarrett@example.com';
        upsert ops;

        Parts_Service_Pricing_Strategy__c ps = new Parts_Service_Pricing_Strategy__c();
        ps.Method__c = 'Jobber';
        ps.Active__c = true;
        ps.Description__c = 'test';
        ps.Default__c = true;
        ps.dealer__Parts_Variable_Amount__c = 10;
        ps.dealer__Formula_Operand__c = '+';
        insert ps;
    
        // Create the user
        Profile prof = [select id from profile where name='system Administrator'];
        User usr = new User(alias = 'usr', email='us.name@vmail.com',
                  emailencodingkey='UTF-8', lastname='lstname',
                  timezonesidkey='America/Los_Angeles',
                  languagelocalekey='en_US',
                  localesidkey='en_US', profileid = prof.Id,
                  username='testuser128@testorgx.com',
                  Division='DT1');
        insert usr;  

        tu.insertAccount();
        tu.insertContact();

        // Create a Parts Master Entry
        dealer__Parts_Master__c pm = new dealer__Parts_Master__c();
        pm.Name = 'FL1A__TEST_PART';
        pm.dealer__Retail_Price__c = 99.99;
        pm.dealer__Cost__c=50;
        pm.Manufacturer__c = 'FD';
        insert pm;

        // Create a Test Part in the Out Inventory
        dealer__Parts_Inventory__c part = new dealer__Parts_Inventory__c();
        part.dealer__Description__c = 'Oil Filter';
        part.dealer__Cost__c = 10;
        part.dealer__Source__c = 'Stocking';
        part.dealer__On_Hand__c = 1;
        part.dealer__Part_No__c = 'FL1A__TEST_PART';
        part.dealer__List__c = 22;
        part.dealer__Parts_Master__c = pm.Id;
        part.dealer__Location__c=loc2.Id;

        insert part;
    }

    @isTest
    static void testPartsReturnAPI() {
    
        User u = [Select Id, Division from User where Username = 'testuser128@testorgx.com'
            limit 1
        ];
        System.runAs(u) {
    
            TestClassUtil tu = new TestClassUtil();
    
            dealer__Parts_Invoice__c pi = new dealer__Parts_Invoice__c();
            pi.dealer__Customer__c = [Select Id from Account limit 1].Id;
            pi.dealer__Customer_Contact__c = [Select Id from Contact limit 1].Id;
            pi.Name = 'Test Invoice';
            pi.dealer__Comapny_Number__c = 'Location 1';
            pi.dealer__Deposit__c = 100;
            pi.dealer__Invoice_Number__c = 'inv1234';
    
            //create
            pi = PartsReturnController.saveReturn(pi);
    
            //void
            PartsReturnController.voidReturn(pi.Id);

            //undo void
            pi.Status__c = 'Open';
            pi.RecordTypeId = [SELECT Id FROM RecordType WHERE SObjectType = 'dealer__Parts_Invoice__c' AND DeveloperName = 'Vendor_Return'].Id;
            PartsReturnController.saveReturn(pi);

            test.startTest();
            Dealer_Location__c loc = [Select Id, Name from Dealer_Location__c where Company_Number__c = 'DT1'];
            Parts_Master__c pm = TestClassUtil.insertPartsMaster();
            Parts_Inventory__c part = TestClassUtil.insertPartInventory(pm.Id, loc.Id);
            Purchase_Order__c po = TestClassUtil.insertPartsPO(part.Id);
            Purchase_Order_Line__c poLine = [Select Id from Purchase_Order_Line__c where Purchase_Order__c =:po.Id  limit 1];

            Parts_Invoice_Line__c returnLine = new Parts_Invoice_Line__c(
                Quantity_Sold__c=1, 
                Part__c=part.Id,
                Parts_Invoice__c=[Select Id from Parts_Invoice__c limit 1].Id,
                Part_Number__c=[Select Id, Name from Parts_Inventory__c where Id =:part.Id limit 1].Name,
                Purchase_Order_Line__c=poLine.Id
            );
            insert returnLine;

            //manually create ledgers (for tests)
            Parts_Ledger__c ledger = new Parts_Ledger__c(
                Part__c = part.Id,
                Parts_Sale_Line__c = returnLine.Id,
                Quantity__c = 1,
                Purchase_order__c = po.Id,
                Item_Value__c = 10
            );
            insert ledger;

            PartsReturnController.saveReturnLine(pi.Id, returnLine);
            test.stopTest();
        }
    }
}