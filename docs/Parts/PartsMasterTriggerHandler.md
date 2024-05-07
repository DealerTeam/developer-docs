---
layout: default
---
# PartsMasterTriggerHandler



**Class** PartsMasterTriggerHandler - Domain Layer Logic


**Test** PartPhysicalInventoryDomainLayer


**Group** Parts

## Methods
### `public static void PartMasterAndPartsSync(List<Parts_Master__c> PartsMasterList, Map<Id,Parts_Master__c> PartOldMap)`
### `public static void CheckDefaultValues(List<Parts_Master__c> PartsMasterList)`
### `public static void DefaultValues(List<Parts_Master__c> PartsMasterList, Map<Id,Parts_Master__c> PartNewMap)`

Checks for updates to certain fields and updates their values on related Parts Inventory

#### Parameters

|Param|Description|
|---|---|
|`PartsMasterList`|PartsMasterList description|
|`PartNewMap`|PartNewMap description|


**Method** DefaultValues

---
