# BinLocationControlHandler

`APIVERSION: 54`

`STATUS: ACTIVE`
## Fields

### `BIN_REFERENCE_DEPTH` → `Integer`


### `binsByParent` → `Map<Id,List<BinLocation__c>>`


### `binsToUpdate` → `List<BinLocation__c>`


### `childPathsUpdated` → `Boolean`


---
## Methods
### `static getInstance()`

getInstance handles returning the running instance of BinLocationControlHandler, will create if one doesn't exist. Only way to create an instance of BinLocationControlHandler

#### Return

**Type**

BinLocationControlHandler

**Description**

return description

### `setBinPath(List<BinLocation__c> triggerNew)`

Set the bin path of created and updated records

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setBinPath

### `setChildBinPath(List<BinLocation__c> triggerNew, Map<Id,BinLocation__c> triggerOldMap)`

updates path and all related child paths

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setChildBinPath

### `validateDepth(List<BinLocation__c> triggerNew)`

Runs after bin path has been set to ensure the nesting is not beyond the allowed value

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** validateDepth

---
