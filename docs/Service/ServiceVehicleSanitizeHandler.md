# ServiceVehicleSanitizeHandler

`APIVERSION: 45`

`STATUS: ACTIVE`

Trigger level class for handling servicevehicle records


**Group** Service

## Methods
### `setSystemValues(List<Service_Vehicle__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setSystemValues description

### `populateRelatedData(List<Service_Vehicle__c> triggerNew, Map<ID,Service_Vehicle__c> triggerOldMap)`
#### Parameters

|Param|Description|
|---|---|
|`newSV`|Trigger.new context variable|
|`oldVehicleMap`|oldVehicleMap description|


**Method** populateRelatedData

### `preventDelete(List<Service_Vehicle__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|list of Service vehicles|


**Method** preventDelete

### `UpdateVehicleConversion(Map<Id,Service_Vehicle__c> triggerNew, Map<Id,Service_Vehicle__c> oldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`oldMap`|oldMap description|


**Method** UpdateVehicleConversion

### `UpdateApprisals(List<Service_Vehicle__c> triggerNew)`

Performs an update to the service vehicle related fields associated with the appraisal if vales have changed.

#### Parameters

|Param|Description|
|---|---|
|`Trigger`|.new context list of Service Vehicles|


**Method** AfterUpdateApprisals description

### `ERPInsert(Id vehicleId)`
### `ERPUpdate(Id vehicleId)`
---
