@isTest
public class Inspection_Report_EXT_TC{

    static testMethod void myUnitTest() {
    
    dealer__Inspection_Report__c ir= new dealer__Inspection_Report__c();
     ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(ir);
     Inspection_Report_EXT ire = new Inspection_Report_EXT(sc);
    
    
    
    }
    }