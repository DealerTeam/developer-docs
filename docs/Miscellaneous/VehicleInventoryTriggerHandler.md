---
layout: default
---
# VehicleInventoryTriggerHandler
## Constructors
### `public VehicleInventoryTriggerHandler(boolean isExecuting, integer size)`
---
## Fields

### `private m_isExecuting` → `boolean`


### `private BatchSize` → `integer`


### `public IsFromBachJob` → `boolean`


### `public isFromUploadAPI` → `boolean`


### `public IsVehicleUpdate` → `boolean`


---
## Properties

### `public IsTriggerContext` → `boolean`


### `public IsVisualforcePageContext` → `boolean`


### `public IsWebServiceContext` → `boolean`


### `public IsExecuteAnonymousContext` → `boolean`


---
## Methods
### `public void OnBeforeInsert(List<dealer__Vehicle_Inventory__c> newVehicle)`
### `public void OnAfterInsert(List<dealer__Vehicle_Inventory__c> newVehicle)`
### `public void OnAfterUpdate(List<dealer__Vehicle_Inventory__c> newVehicle, List<dealer__Vehicle_Inventory__c> oldVehicle, Map<ID,dealer__Vehicle_Inventory__c> newVehicleMap, Map<ID,dealer__Vehicle_Inventory__c> oldVehicleMap)`
### `public void OnBeforeUpdate(List<dealer__Vehicle_Inventory__c> newVehicle, List<dealer__Vehicle_Inventory__c> oldVehicle, Map<ID,dealer__Vehicle_Inventory__c> newVehicleMap, Map<ID,dealer__Vehicle_Inventory__c> oldVehicleMap)`
### `public void ERPInsert(List<Vehicle_Inventory__c> triggerNew)`
### `public void ERPUpdate(List<Vehicle_Inventory__c> triggerNew)`
---
