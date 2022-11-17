# VehicleInventoryUtility

`APIVERSION: 45`

`STATUS: ACTIVE`
## Methods
### `static beforeInsert(List<dealer__Vehicle_Inventory__c> newVehicle)`
### `static afterInsert(List<dealer__Vehicle_Inventory__c> newVehicle)`
### `static afterInsertStockBookUpdate(List<dealer__Vehicle_Inventory__c> newVehicle)`
### `static beforeUpdate(List<dealer__Vehicle_Inventory__c> newVehicle, Map<ID,dealer__Vehicle_Inventory__c> oldVehicleMap)`
### `static afterUpdate(List<dealer__Vehicle_Inventory__c> newVehicle, Map<ID,dealer__Vehicle_Inventory__c> newVehicleMap, Map<ID,dealer__Vehicle_Inventory__c> oldVehicleMap)`
### `static createStatusCode(List<dealer__Vehicle_Inventory__c> newVehicle, Boolean isUpdate, Map<ID,dealer__Vehicle_Inventory__c> oldVehicleMap)`
### `static createServiceVehicle(List<dealer__Vehicle_Inventory__c> newVehicle, Map<ID,dealer__Vehicle_Inventory__c> oldVehicleMap, Boolean isUpdate)`
### `static populateConversionData(List<dealer__Vehicle_Inventory__c> triggerNew)`
---
