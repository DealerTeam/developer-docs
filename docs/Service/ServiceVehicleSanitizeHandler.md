---
layout: default
---
# ServiceVehicleSanitizeHandler

Trigger level class for handling servicevehicle records


**Group** Service

## Methods
### `public void setSystemValues(List<Service_Vehicle__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setSystemValues description

### `public void populateRelatedData(List<Service_Vehicle__c> triggerNew, Map<ID,Service_Vehicle__c> triggerOldMap)`
#### Parameters

|Param|Description|
|---|---|
|`newSV`|Trigger.new context variable|
|`oldVehicleMap`|oldVehicleMap description|


**Method** populateRelatedData

### `public void preventDelete(List<Service_Vehicle__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|list of Service vehicles|


**Method** preventDelete

### `public void updateVehicleConversion(Map<Id,Service_Vehicle__c> triggerNew, Map<Id,Service_Vehicle__c> oldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`oldMap`|oldMap description|


**Method** UpdateVehicleConversion

### `public void UpdateApprisals(List<Service_Vehicle__c> triggerNew)`

Performs an update to the service vehicle related fields associated with the appraisal if vales have changed.

#### Parameters

|Param|Description|
|---|---|
|`Trigger`|.new context list of Service Vehicles|


**Method** AfterUpdateApprisals description

### `public void updateVehicleInventoryDecodeData(Map<Id,Service_Vehicle__c> triggerNew, Map<Id,Service_Vehicle__c> oldMap)`

Update related vehicle inventory when critical fields are updated

#### Parameters

|Param|Description|
|---|---|
|`vehicleId`|vehicleId description|

#### Returns

|Type|Description|
|---|---|
|`void`|void|

### `public void ERPInsert(Id vehicleId)`
### `public void ERPUpdate(Id vehicleId)`
---
