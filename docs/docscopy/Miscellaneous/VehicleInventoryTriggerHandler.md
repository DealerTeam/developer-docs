---
layout: default
---
# VehicleInventoryTriggerHandler class

 Date            |Developer            |Work# Notes -- 2016-11-10    |Sneha Utture    |W-000642 Implement Trigger Framework

---
## Constructors
### `VehicleInventoryTriggerHandler(boolean isExecuting, integer size)`
---
## Properties

### `IsExecuteAnonymousContext` → `boolean`

### `IsFromBachJob` → `boolean`

### `IsTriggerContext` → `boolean`

### `IsVehicleUpdate` → `boolean`

### `IsVisualforcePageContext` → `boolean`

### `IsWebServiceContext` → `boolean`

### `isFromUploadAPI` → `boolean`

---
## Methods
### `OnAfterInsert(List<dealer__Vehicle_Inventory__c> newVehicle)` → `void`
### `OnAfterUpdate( List<dealer__Vehicle_Inventory__c> newVehicle, List<dealer__Vehicle_Inventory__c> oldVehicle, Map<ID, dealer__Vehicle_Inventory__c> newVehicleMap , Map<ID, dealer__Vehicle_Inventory__c> oldVehicleMap )` → `void`
### `OnAfterUpdateAsync(Set<ID> newVehicleIDs)` → `void`
### `OnBeforeInsert(List<dealer__Vehicle_Inventory__c> newVehicle)` → `void`
### `OnBeforeUpdate( List<dealer__Vehicle_Inventory__c> newVehicle, List<dealer__Vehicle_Inventory__c> oldVehicle, Map<ID, dealer__Vehicle_Inventory__c> newVehicleMap , Map<ID, dealer__Vehicle_Inventory__c> oldVehicleMap )` → `void`
---
