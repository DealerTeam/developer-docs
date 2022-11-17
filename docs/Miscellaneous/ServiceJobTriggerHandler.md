# ServiceJobTriggerHandler

`APIVERSION: 45`

`STATUS: ACTIVE`
## Fields

### `ListServiceOrder` → `List<Service_Repair_Order__c>`


### `ListUser` → `List<User>`


### `StandardOpCodeList` → `List<StandardOpCode__c>`


---
## Methods
### `handleBeforeInsert(List<Service_Job__c> ListServiceJob)`
### `handleBeforeUpdate(List<Service_Job__c> ListServiceJob, Map<Id,Service_Job__c> MapServiceJob)`
### `handleBeforeDelete(List<Service_Job__c> ListServiceJob)`
### `setTaxExempt(List<Service_Job__c> triggerNew)`

Sets tax exempt status of job lines on create based on parent RO data

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setTaxExempt

### `preventClosedUpdate(List<Service_Job__c> triggerNew, Map<Id,Service_Job__c> triggerOldMap)`

checks dmsConfig and if enabled only allow updates to fields in the config while status is complete and is not changed (prevents issues moving to complete status)

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|


**Method** preventClosedUpdate

### `preventCloseUnfilledLines(Map<Id,Service_Job__c> triggerNewMap, Map<Id,Service_Job__c> triggerOldMap)`

Prevent completing of a job line with any related unfilled invoice lines

#### Parameters

|Param|Description|
|---|---|
|`triggerNewMap`|triggerNewMap description|
|`triggerOldMap`|triggerOldMap description|

---
