# VehicleInventoryTriggerHandler

`APIVERSION: 45`

`STATUS: ACTIVE`
## Constructors
### `VehicleInventoryTriggerHandler(boolean isExecuting, integer size)`
---
## Fields

### `IsFromBachJob` → `boolean`


### `IsVehicleUpdate` → `boolean`


### `isFromUploadAPI` → `boolean`


---
## Properties

### `IsExecuteAnonymousContext` → `boolean`


### `IsTriggerContext` → `boolean`


### `IsVisualforcePageContext` → `boolean`


### `IsWebServiceContext` → `boolean`


---
## Methods
### `OnBeforeInsert(List<dealer__Vehicle_Inventory__c> newVehicle)`
### `OnAfterInsert(List<dealer__Vehicle_Inventory__c> newVehicle)`
### `OnAfterUpdate(List<dealer__Vehicle_Inventory__c> newVehicle, List<dealer__Vehicle_Inventory__c> oldVehicle, Map<ID,dealer__Vehicle_Inventory__c> newVehicleMap, Map<ID,dealer__Vehicle_Inventory__c> oldVehicleMap)`
### `OnBeforeUpdate(List<dealer__Vehicle_Inventory__c> newVehicle, List<dealer__Vehicle_Inventory__c> oldVehicle, Map<ID,dealer__Vehicle_Inventory__c> newVehicleMap, Map<ID,dealer__Vehicle_Inventory__c> oldVehicleMap)`
### `ERPInsert(Id vehicleId)`
### `ERPUpdate(Id vehicleId)`
---
