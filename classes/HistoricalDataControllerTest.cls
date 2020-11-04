@isTest
public class HistoricalDataControllerTest {
    @isTest static void testHistoricalDataController(){
        TestClassUtil util = new TestClassUtil();
        dealer__DMS_Settings__c dms = dealer__DMS_Settings__c.getValues('ActiveSettings');
        if(dms == null){
            util.insertDMSSettings();   
        }

        HistoricalDataController.objectLabels();
        
        deal__c d = new deal__c(name='123', deal_Id__c='test', Vin__c='4S4BRBGC7B3371132');
        insert d;

        Trade_In__c ti = new Trade_In__c(Car_deal__c = d.Id, Vin__C ='4S4BRBGC7B3371132');
        insert ti;

        Service_Repair_Order__c sro = new Service_repair_Order__c(dealer__Mileage_In__c=0, Vin__c='4S4BRBGC7B3371132', name='test');
        insert sro;

        Vehicle_Inventory__c vi = new Vehicle_Inventory__c(name='test', Vin__c = '4S4BRBGC7B3371132', Year__c='2001', Make__c='test',Model__c='test',Stock_number__c='test');
        insert vi;

        Appraisal__c ap = new Appraisal__c(Service_Vehicle__c = [SELECT Id FROM Service_VEhicle__c LIMIT 1].Id);
        insert ap;

        Appraisal__c ap2 = new Appraisal__c(Service_Vehicle__c = [SELECT Id FROM Service_VEhicle__c LIMIT 1].Id);
        insert ap2;

		id[] fixedResults = new id[]{d.Id, ti.Id,sro.Id,vi.Id};
        test.setFixedSearchResults(fixedResults);

        HistoricalDataController.HistoricalVinData data1 = ( HistoricalDataController.HistoricalVinData)JSON.deserialize(HistoricalDataController.historicalVinData(ap.Id), HistoricalDataController.HistoricalVinData.class);
    }
}