@isTest
private class StockOrderDomainLayer {
    @TestSetup
    static void testSetup(){
      dealer__Stock_Order__c so = (dealer__Stock_Order__c)TestFactory.createSObject(new dealer__Stock_Order__c(), true);
      dealer__Stock_Order_Line__c sol = (dealer__Stock_Order_Line__c)TestFactory.createSObject(new dealer__Stock_Order_Line__c(dealer__Stock_Order__c = so.Id, dealer__Part_Number__c = 'Test'), true);
      dealer__Parts_Master__c pm = (dealer__Parts_Master__c)TestFactory.createSObject(new dealer__Parts_Master__c(Name = 'Test Part'), true);
    }

    @isTest
    static void testBeforeUpdate(){
        dealer__Parts_Master__c pm = [SELECT Id, Name FROM dealer__Parts_Master__c];
        dealer__Stock_Order_Line__c sol = [SELECT Id, Part_Number__c, PartMaster__c FROM dealer__Stock_Order_Line__c];

        sol.PartMaster__c = pm.Id;
        update sol;
        sol = [SELECT Id, Part_Number__c, PartMaster__c FROM dealer__Stock_Order_Line__c];
        system.assertEquals(pm.Name, sol.Part_Number__c, 'Trigger did not update Part Number from Parts Master.');
    }

    @isTest
    static void testBeforeInsert(){
        dealer__Parts_Master__c pm = [SELECT Id, Name FROM dealer__Parts_Master__c];
        dealer__Stock_Order__c so = [SELECT Id FROM dealer__Stock_Order__c];
        dealer__Stock_Order_Line__c sol = (dealer__Stock_Order_Line__c)TestFactory.createSObject(new dealer__Stock_Order_Line__c(dealer__Stock_Order__c = so.Id, dealer__Part_Number__c = 'Insert Part', dealer__PartMaster__c = pm.Id), true);

        sol = [SELECT Id, Part_Number__c, PartMaster__c FROM dealer__Stock_Order_Line__c WHERE Id =: sol.Id];
        system.assertEquals(pm.Name, sol.Part_Number__c, 'Trigger did not update Part Number from Parts Master.');
    }
}