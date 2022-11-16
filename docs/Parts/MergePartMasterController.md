# MergePartMasterController

`APIVERSION: 45`

`STATUS: ACTIVE`

Controller for MergePartMaster.page to retrieve Part Master information and to merge duplicate Part Master records.


**Class** MergePartMasterController


**Test** PartPhysicalInventoryServiceLayer.testMergePartMaster


**Group** Parts

## Constructors
### `MergePartMasterController(ApexPages.StandardSetController controller)`
#### Parameters

|Param|Description|
|---|---|
|`controller`||


**Method** MergePartMasterController

---
## Properties

### `MasterRec` → `string`


---
## Methods
### `getPartMaster()`
#### Return

**Type**

List&lt;dealer__Parts_Master__c&gt;

**Description**

List&lt;dealer__Parts_Master__c&gt;


**Method** getPartMaster

### `getPartLocOnhand()`
#### Return

**Type**

map&lt;id,List&lt;dealer__Parts_Inventory__c&gt;&gt;

**Description**

map&lt;id,List&lt;dealer__Parts_Inventory__c&gt;&gt;


**Method** getPartLocOnhand

### `mergeRecord()`
#### Return

**Type**

pageReference

**Description**

pageReference


**Method** mergeRecord

### `goBack()`
#### Return

**Type**

pageReference

**Description**

pageReference


**Method** goBack

---
