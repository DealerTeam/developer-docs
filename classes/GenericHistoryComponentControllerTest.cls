@isTest(seeAllData=true) 
private class GenericHistoryComponentControllerTest{
    static testMethod void validateGenericHistoryController() {
        TestclassUtil tcu = new TestclassUtil();
        Id invId = tcu.insertVehicleInventory();
        update new dealer__Vehicle_Inventory__c(
            Id=invId,
            In_Stock__c=true
        );
		
        /*
        Test.startTest();
        
        
                                     
        AggregateResult[] aggResList = [select ParentId, Count(ID) from Vehicle_Inventory__History Group By ParentId Having Count(ID) >= 1 Limit 1];         
        
        GenericHistoryComponentController con = new GenericHistoryComponentController();
        con.myObject = [select id from Vehicle_Inventory__c where id=: (ID)aggResList[0].get('ParentId')];
        con.recordLimit = 5;
        con.getObjectHistory();
        
        system.assert(con.getObjectHistory().size()>0);
        Test.stopTest();
		*/
    }      
}