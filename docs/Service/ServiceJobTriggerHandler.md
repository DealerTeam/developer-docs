---
layout: default
---
# ServiceJobTriggerHandler

Domain layer logic to force the job lien interaction with header and related objects.


**Group** Service

## Fields

### `public ListUser` → `List<User>`


### `public StandardOpCodeList` → `List<StandardOpCode__c>`


### `public ListServiceOrder` → `List<Service_Repair_Order__c>`


---
## Methods
### `public void handleBeforeInsert(List<Service_Job__c> ListServiceJob)`
### `public void handleBeforeUpdate(List<Service_Job__c> ListServiceJob, Map<Id,Service_Job__c> MapServiceJob)`
### `public void handleBeforeDelete(List<Service_Job__c> ListServiceJob)`
### `public static void setInternalSaleAccount(List<Service_Job__c> jobs)`

setInternalSaleAccount sets the Sale Account for Internal Job lines when a Vehicle Inventory is present on the RO

#### Parameters

|Param|Description|
|---|---|
|`Set`|<Id> jobIds|


**Notes** This method depends on the Chart of Acounts being loaded into the local sObject prior to jobline update

### `public void setTaxExempt(List<Service_Job__c> triggerNew)`

Sets tax exempt status of job lines on create based on parent RO data

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setTaxExempt

### `public void preventClosedUpdate(List<Service_Job__c> triggerNew, Map<Id,Service_Job__c> triggerOldMap)`

checks dmsConfig and if enabled only allow updates to fields in the config while status is complete and is not changed (prevents issues moving to complete status)

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|


**Method** preventClosedUpdate

### `public void preventCloseUnfilledLines(Map<Id,Service_Job__c> triggerNewMap, Map<Id,Service_Job__c> triggerOldMap)`

Prevent completing of a job line with any related unfilled invoice lines

#### Parameters

|Param|Description|
|---|---|
|`triggerNewMap`|triggerNewMap description|
|`triggerOldMap`|triggerOldMap description|

---
