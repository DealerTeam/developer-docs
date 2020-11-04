@isTest
private class DesiredVehicle_EXT_TC{

    static testMethod void desiredVehicleTest() {
     Sales_Up__c SU=new Sales_Up__c(dealer__FirstName__c='test',dealer__LastName__c='test',dealer__Make__c='test',dealer__Model__c='test',
                  dealer__Year_High__c='test',dealer__Trade_Trim_Level__c='test');
        insert SU;
        Desired_Vehicle__c DV=new Desired_Vehicle__c(dealer__Make__c='test',dealer__Model__c='test',
                  dealer__Year__c='test',dealer__Trim_Level__c='test',Sales_Up__c=SU.ID);
        insert DV;

   ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(dv);
         
  DesiredVehicle_EXT dve = new DesiredVehicle_EXT(sc);
  
    
    }
    }