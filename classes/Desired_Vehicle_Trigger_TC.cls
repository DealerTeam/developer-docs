@isTest
private class Desired_Vehicle_Trigger_TC {

    static testMethod void desiredVehicleTriggerTest() {
        Sales_Up__c SU=new Sales_Up__c(dealer__FirstName__c='test',dealer__LastName__c='test',dealer__Make__c='test',dealer__Model__c='test',
                  dealer__Year_High__c='test',dealer__Trade_Trim_Level__c='test');
        insert SU;
        Desired_Vehicle__c DV=new Desired_Vehicle__c(dealer__Make__c='test',dealer__Model__c='test',
                  dealer__Year__c='test',dealer__Trim_Level__c='test',Sales_Up__c=SU.ID);
        insert DV;

        DV.dealer__Make__c = null;
        DV.dealer__Model__c= null;
        DV.dealer__Year__c = null;
        update DV;

        SU.DesiredVehicle__c = dv.Id;
        update SU;

        DV.Trim_Level__c = 'LX';
        DV.Year__c = '2019';
        DV.Make__c = 'Honda';
        DV.Model__c = 'Civic';
        DV.Exterior_Color__c = 'Green';
        DV.Interior_Color__c = 'White';
        DV.VIN__c = '123456abcd98764';
        update DV;

        SU = [SELECT Id, VIN__c FROM dealer__Sales_Up__c WHERE DesiredVehicle__C =: dv.Id];
        System.assertEquals(DV.VIN__c, SU.VIN__c, 'updateRelatedSalesUp did not update the VIN on Sales Up from the related Desired Vehicle.');
    }
}