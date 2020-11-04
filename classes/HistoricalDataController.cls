public with sharing class HistoricalDataController {

    @AuraEnabled(cacheable=true)
    public static Map<String,String> objectLabels(){
        //dynamic strings in the future (list of objects in parameters)
        Map<String,String> labelMap = new Map<String,String>();
        labelMap.put('dealer__Deal__c',SObjectType.Deal__c.getLabelPlural());
        labelMap.put('dealer__Trade_In__c',SObjectType.Trade_In__c.getLabelPlural());
        labelMap.put('dealer__Service_Repair_Order__c',SObjectType.Service_Repair_Order__c.getLabelPlural());
        labelMap.put('dealer__Appraisal__c',SObjectType.Appraisal__c.getLabelPlural());
        labelMap.put('dealer__Vehicle_Inventory__c',SObjectType.Vehicle_Inventory__c.getLabelPlural());
        
        return labelMap; 
    }

    @AuraEnabled(cacheable=true)
    public static string historicalVinData(String recordId){        
        System.assert(recordID != null, 'Appraisal Id required to get historical data for a vin');
        Appraisal__c appraisal = [SELECT Id, Name,Service_Vehicle__c, Service_Vehicle__r.VIN__c FROM Appraisal__c WHERE Id =: recordId];

        if(appraisal.Service_Vehicle__c != null && appraisal.Service_Vehicle__r.Vin__c != null){

            List<Appraisal__c> relatedAppraisals = new List<Appraisal__c>();
            for(Appraisal__c ap : [Select Id, Name, dealer__Service_Vehicle__c, dealer__Service_Vehicle__r.dealer__Vin__c, CreatedById, CreatedBy.Name, createdDate FROM Appraisal__c WHERE Id !=: recordId AND Service_Vehicle__r.Vin__c =: appraisal.Service_Vehicle__r.Vin__c ]){
                relatedAppraisals.add(ap);
            }
            
            List <List<Sobject>> searchlist = [FIND: appraisal.dealer__Service_Vehicle__r.dealer__Vin__c In All Fields Returning
            dealer__Deal__C(Id,Name,dealer__Vehicle__c, dealer__Vehicle__r.dealer__Vin__c, dealer__Vin__c,CreatedById, CreatedBy.Name, createdDate),
            dealer__Trade_In__c(Id,Name,dealer__VIN__c,CreatedById, CreatedBy.Name, createdDate),
            dealer__Service_Repair_Order__c(Id, Name, dealer__VIN__c, dealer__Vehicle__c, dealer__Vehicle__r.dealer__Vin__c,  CreatedById, CreatedBy.Name, createdDate),
            /*dealer__Appraisal__c(Id, Name, dealer__Service_Vehicle__c, dealer__Service_Vehicle__r.dealer__Vin__c, CreatedById, CreatedBy.Name, createdDate),*/
            dealer__Vehicle_Inventory__c(Id, Name,dealer__VIN__c, Service_Vehicle__c, Service_Vehicle__r.dealer__Vin__c, CreatedById, CreatedBy.Name, createdDate)];
            
            List<RowData> dealData = new List<RowData>();
            List<RowData> tradeData = new List<RowData>();
            List<RowData> sroData = new List<RowData>();
            List<RowData> appraisalData = new List<RowData>();
            List<RowData> vehicleData = new List<RowData>();

            for(Deal__c r : ((List < Deal__c > ) searchList[0])){
                dealData.add(new RowData(r.Name, '/'+r.Id, r.CreatedBy.Name, r.createdDate));
            }
            for(Trade_In__c r : ((List < Trade_In__c > ) searchList[1])){
                tradeData.add(new RowData(r.Name, '/'+r.Id, r.CreatedBy.Name, r.createdDate));
            }
            for(Service_Repair_Order__c r : ((List < Service_Repair_Order__c > ) searchList[2])){
                sroData.add(new RowData(r.Name, '/'+r.Id, r.CreatedBy.Name, r.createdDate));
            }
            for(Appraisal__c r : relatedAppraisals){
                appraisalData.add(new RowData(r.Name, '/'+r.Id, r.CreatedBy.Name, r.createdDate));
            }
            for(Vehicle_Inventory__c r : ((List < dealer__Vehicle_Inventory__c > ) searchList[3])){
                vehicleData.add(new RowData(r.Name, '/'+r.Id, r.CreatedBy.Name, r.createdDate));
            }
            return JSON.serializePretty(new HistoricalVinData(dealData,tradeData,sroData,appraisalData, vehicleData));
        }
        return '[]';
    }

    public class HistoricalVinData{
        @AuraEnabled public List<RowData> Deals;
        @AuraEnabled public List<RowData> Trades;
        @AuraEnabled public List<RowData> ServiceRepairOrders;
        @AuraEnabled public List<RowData> Appraisals;
        @AuraEnabled public List<RowData> VehicleInventory;
        public HistoricalVinData(List<RowData> deals,List<RowData> trades,List<RowData> serviceRepairOrders,List<RowData> appraisals,List<RowData> vehicleInventory){
            this.Deals = deals;
            this.Trades = trades;
            this.ServiceRepairOrders = serviceRepairOrders;
            this.Appraisals = appraisals;
            this.VehicleInventory = vehicleInventory;
        }
    }

    public class RowData{
       @AuraEnabled Public String Name;
       @AuraEnabled Public String RecordLink;
       @AuraEnabled Public String CreatedByName;
       @AuraEnabled Public DateTime CreatedDate;
       public RowData(String name, String recordLink, String createdByName, DateTime createdDate){
           this.Name = name;
           this.RecordLink = recordLink;
           this.CreatedByName = createdByName;
           this.CreatedDate = createdDate;
       }
    }

}