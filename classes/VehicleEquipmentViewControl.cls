/*
Controller for VehicleEquipmentView components in both LEX and Classic
Tested by TestVehicleEquipmentViewControl
*/
public with sharing class VehicleEquipmentViewControl {

    public Integer totalRecords {get; set;}
    public List < Decode_Values__b > vehicleEquipment { get;set; }

    public VehicleEquipmentViewControl() {
        QueryEquipment();
    }

    // Classic Methods
    public void QueryEquipment() {
        Id recordId = ApexPages.currentPage().getParameters().get('id');
        system.debug('reId '+recordId);
        Service_Vehicle__c serviceVehicle = getServiceVehicle(recordId);
        system.assert(serviceVehicle.Id != null,'A valid service vehicle was not found.');
        
        List<Decode_Values__b> decodeData = new List<Decode_Values__b>();
        for(Decode_Values__b dv :VehicleEquipmentAPI.getBigObjectEquipment(serviceVehicle)){
            if(dv.Equipped__c == 1)
            decodeData.add(dv);
        }

        vehicleEquipment = decodeData.size() > 0 ? decodeData : new List<Decode_Values__b>();
        totalRecords = VehicleEquipment.size();
    }

    public static Service_Vehicle__c getServiceVehicle(id vehicleId) {
        String sObjectType = vehicleId.getSObjectType().getDescribe().getName();
        try {
            if (sObjectType == 'dealer__Vehicle_Inventory__c') {
                return [SELECT Id FROM Service_Vehicle__c WHERE Sales_Inventory__c =: vehicleId];
            } else if (sObjectType == 'dealer__Service_Vehicle__c') {
                return [SELECT Id FROM Service_Vehicle__c WHERE Id =: vehicleId];
            } else if(sObjectType != 'dealer__Vehicle_Inventory__c' && sObjectType != 'dealer__Service_Vehicle__c') {
                throw new VehicleEquipmentViewControlException('Invalid Id with type: '+sObjectType+'. Expected either a dealer__Vehicle__Inventory__c or dealer__Service_Vehicle__c Id.');
            }
        } catch (QueryException e) {
            throw new QueryException('Error: Service vehicle not found for '+sObjectType+' with Id: \''+vehicleId+'\'');
        }
        return new Service_Vehicle__c();
    }

    // LEX Methods
    @AuraEnabled
    public static String CreateEquipmentTable(String vehicleId) {
        Service_Vehicle__c serviceVehicle = getServiceVehicle(vehicleId);
        if (serviceVehicle.Id == null) throw new AuraHandledException('A valid service vehicle was not found.');

        DataTableResponse response = new DataTableResponse();
        Schema.SObjectType objDescribe = Schema.getGlobalDescribe().get('dealer__Decode_Values__b');
        Map < string, Schema.SObjectField > objMap = objDescribe.getDescribe().fields.getMap();

        List < DataTableColumn > dataColumns = new List < DataTableColumn > ();
        for (String FieldApiName: objMap.keySet()) {
            if (FieldAPIName == 'dealer__Description__c' ||
                FieldAPIName == 'dealer__EquipmentCategory__c' ||
                FieldAPIName == 'dealer__equipmentname__c' ||
                FieldAPIName == 'dealer__optionid__c' ||
                FieldAPIName == 'dealer__ordercode__c')
                dataColumns.add(new DataTableColumn(
                    objMap.get(FieldApiName).getDescribe().getLabel(),
                    true,//sortable
                    String.valueOf(objMap.get(FieldApiName).getDescribe().getName()),
                    String.valueOf(objMap.get(FieldApiName).getDescribe().getType()).toLowerCase()
                ));
        }

        //Cant filter SOQL by non-indexed fields on Big Objects so we loop results.
        List<Decode_Values__b> decodeData = new List<Decode_Values__b>();
        for(Decode_Values__b dv :VehicleEquipmentAPI.getBigObjectEquipment(serviceVehicle)){
            if(dv.Equipped__c == 1)
            decodeData.add(dv);
        }
        response.columns = dataColumns;
        response.data = decodeData;
        return json.SerializePretty(response);
    }

    public class DataTableResponse {
        public List < DataTableColumn > columns {get;set; }
        public List < Decode_Values__b > data {get;set;}

        public DataTableResponse() {
            columns = new List < DataTableColumn > ();
            data = new List < Decode_Values__b > ();
        }
    }

    public class DataTableColumn {
        public String label { get;set; }
        public Boolean sortable {get;set;}
        public String fieldName {get;set; }
        public String type {get; set; }

        public DataTableColumn(String label, Boolean sortable, String fieldName, String type) {
            this.label = label;
            this.sortable = sortable;
            this.fieldName = fieldName;
            this.type = type;
        }
    }

    public class VehicleEquipmentViewControlException extends Exception{}

}