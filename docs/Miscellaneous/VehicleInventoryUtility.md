---
layout: default
---
# VehicleInventoryUtility class

 Date            |Developer            |Work# Notes -- 2016-11-10    |Sneha Utture    |W-000642 Implement Trigger Framework /** Date          |Developer            |Work# 2018-06-14    |Oscar Quintela       |W-001685

---
## Methods
### `afterInsert( List<dealer__Vehicle_Inventory__c> newVehicle )` → `boolean`
### `afterInsertStockBookUpdate( List<dealer__Vehicle_Inventory__c> newVehicle )` → `void`
### `afterUpdate( List<dealer__Vehicle_Inventory__c> newVehicle,Map<ID, dealer__Vehicle_Inventory__c> newVehicleMap,Map<ID, dealer__Vehicle_Inventory__c> oldVehicleMap )` → `boolean`
### `beforeInsert( List<dealer__Vehicle_Inventory__c> newVehicle)` → `void`
### `beforeUpdate( List<dealer__Vehicle_Inventory__c> newVehicle,Map<ID, dealer__Vehicle_Inventory__c> oldVehicleMap )` → `void`
### `createServiceVehicle(List<dealer__Vehicle_Inventory__c> newVehicle, Map<ID, dealer__Vehicle_Inventory__c> oldVehicleMap,Boolean isUpdate)` → `boolean`
### `createStatusCode(List<dealer__Vehicle_Inventory__c> newVehicle,Boolean isUpdate,Map<ID, dealer__Vehicle_Inventory__c> oldVehicleMap)` → `void`
### `populateConversionData(List<dealer__Vehicle_Inventory__c> triggerNew)` → `void`
---
