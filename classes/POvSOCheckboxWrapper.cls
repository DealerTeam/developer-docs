/**
 * POvSOCheckboxWrapper
 * @test PartManagementServiceLayer.testPOVSO
 */
public with sharing class POvSOCheckboxWrapper {
    
    public boolean checked {get;set;}
    public dealer__Parts_Order__c oline {get;set;}
    public Id orderId {get;set;}

    public POvSOCheckBoxWrapper() {
        oline   = new dealer__Parts_Order__c();
        checked = false;
        orderId = null;
    }
    
    public POvSOCheckBoxWrapper(dealer__Parts_Order__c poline) {

        oline   =   poline;
        checked =   true;
        orderId =   null;
    }

    public POvSOCheckBoxWrapper(dealer__Parts_Order__c poline, Id oid) {

        oline   =   poline;
        checked =   true;
        orderId =   oid;
    }
}