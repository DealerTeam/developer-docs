---
layout: default
---
# MergePartMasterController

Controller for MergePartMaster.page to retrieve Part Master information and to merge duplicate Part Master records.


**Class** MergePartMasterController


**Test** PartPhysicalInventoryServiceLayer.testMergePartMaster


**Group** Parts

## Constructors
### `public MergePartMasterController(ApexPages controller)`
#### Parameters

|Param|Description|
|---|---|
|`controller`||


**Method** MergePartMasterController

---
## Properties

### `private ListPM` → `List<dealer__Parts_Master__c>`


### `public MasterRec` → `string`


---
## Methods
### `public List<dealer__Parts_Master__c> getPartMaster()`
#### Returns

|Type|Description|
|---|---|
|`List<dealer__Parts_Master__c>`|List<dealer__Parts_Master__c>|


**Method** getPartMaster

### `public map<id,List<dealer__Parts_Inventory__c>> getPartLocOnhand()`
#### Returns

|Type|Description|
|---|---|
|`map<id,List<dealer__Parts_Inventory__c>>`|map<id,List<dealer__Parts_Inventory__c>>|


**Method** getPartLocOnhand

### `public pageReference mergeRecord()`
#### Returns

|Type|Description|
|---|---|
|`pageReference`|pageReference|


**Method** mergeRecord

### `public pageReference goBack()`
#### Returns

|Type|Description|
|---|---|
|`pageReference`|pageReference|


**Method** goBack

---
