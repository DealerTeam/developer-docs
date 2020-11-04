@isTest
public class AppraisalDashboardControllerTest {
  @isTest static void filterTest() {
        dealer__Service_Vehicle__c serviceVehicle = new dealer__Service_Vehicle__c();
        serviceVehicle.dealer__VIN__c = 'testVIN0123456789';
        serviceVehicle.dealer__Year__c = '2016';
        serviceVehicle.dealer__Make__c = 'Ford';
        serviceVehicle.dealer__Carline__c = 'Cool Car';
        insert serviceVehicle;

        dealer__Appraisal__c appraisal = new dealer__Appraisal__c();
        appraisal.dealer__Appraised_Value__c = 12000;
        appraisal.dealer__ConversionModel__c ='Braun XT';
        appraisal.dealer__Service_Vehicle__c = serviceVehicle.Id;
        insert appraisal;

        dealer__Service_Vehicle__c serviceVehicle2 = new dealer__Service_Vehicle__c();
        serviceVehicle2.dealer__VIN__c = 'abcdefghijklmnopq';
        serviceVehicle2.dealer__Year__c = '2000';
        serviceVehicle2.dealer__Make__c = 'GMC';
        insert serviceVehicle2;

        dealer__Appraisal__c appraisal2 = new dealer__Appraisal__c();
        appraisal2.dealer__Appraised_Value__c = 1000;
        appraisal2.dealer__ConversionModel__c ='Braun XT';
        appraisal2.dealer__Service_Vehicle__c = serviceVehicle2.Id;
        insert appraisal2;

        //finds both appraisals when no filters set
        AppraisalDashboardController controller = new AppraisalDashboardController();
        controller.appraisalSearch();
        System.assertEquals(controller.appraisals.size(), 0);

        //set filters 
        controller.year.add('2016');
        controller.make.add('Ford');
        controller.conversion.add('Braun XT');
        controller.model = 'Cool Car';
        controller.vin = 'testVIN0123456789';       
        controller.appraisalMin = 5000;
        controller.appraisalMax = 15000;

        //only first appraisal matches filters
        controller.appraisalSearch();

        //all filter fields from before now cleared
        controller.clearFilters();
        System.assertEquals(controller.year.size(), 0);
        System.assertEquals(controller.make.size(), 0);
        System.assertEquals(controller.vin, '');
        System.assertEquals(controller.model, '');
        System.assertEquals(controller.appraisalMin, null);
        System.assertEquals(controller.appraisalMax, null);
        

    }
}