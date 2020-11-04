public with sharing class MigrateVehicleEquipmentQueue implements Queueable {
    List<Service_Vehicle__c> serviceVehicles;
    public MigrateVehicleEquipmentQueue(List<Service_Vehicle__c> serviceVehicles) {
        this.serviceVehicles = serviceVehicles;
    }
    public void execute(QueueableContext context) {
        VehicleEquipmentAPI.migrateVehicleEquipment(JSON.serialize(serviceVehicles));
   }
}
