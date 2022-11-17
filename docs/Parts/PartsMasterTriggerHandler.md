# PartsMasterTriggerHandler

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** PartsMasterTriggerHandler - Domain Layer Logic


**Test** PartPhysicalInventoryDomainLayer


**Group** Parts

## Methods
### `static PartMasterAndPartsSync(List<Parts_Master__c> PartsMasterList, Map<Id,Parts_Master__c> PartOldMap)`
### `static CheckDefaultValues(List<Parts_Master__c> PartsMasterList)`
### `static DefaultValues(List<Parts_Master__c> PartsMasterList, Map<Id,Parts_Master__c> PartNewMap)`

Checks for updates to certain fields and updates their values on related Parts Inventory

#### Parameters

|Param|Description|
|---|---|
|`PartsMasterList`|PartsMasterList description|
|`PartNewMap`|PartNewMap description|


**Method** DefaultValues

---
