---
layout: default
---
# BinLocationControlHandler
## Constructors
### `private BinLocationControlHandler()`

Private constructor is to prevent instantiating without getInstance method


**Method** BinLocationControlHandler

---
## Fields

### `private instance` → `BinLocationControlHandler`


### `public BIN_REFERENCE_DEPTH` → `Integer`


### `public childPathsUpdated` → `Boolean`


### `public binsByParent` → `Map<Id,List<BinLocation__c>>`


### `public binsToUpdate` → `List<BinLocation__c>`


---
## Methods
### `public static BinLocationControlHandler getInstance()`

getInstance handles returning the running instance of BinLocationControlHandler, will create if one doesn't exist. Only way to create an instance of BinLocationControlHandler

#### Returns

|Type|Description|
|---|---|
|`BinLocationControlHandler`|return description|

### `public void setBinPath(List<BinLocation__c> triggerNew)`

Set the bin path of created and updated records

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setBinPath

### `public void setChildBinPath(List<BinLocation__c> triggerNew, Map<Id,BinLocation__c> triggerOldMap)`

updates path and all related child paths

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setChildBinPath

### `public void validateDepth(List<BinLocation__c> triggerNew)`

Runs after bin path has been set to ensure the nesting is not beyond the allowed value

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** validateDepth

### `private List<BinLocation__c> getChildBins(Set<Id> parentIds)`

returns child bins from a list of bin Ids, ignoring those which have already been processed in the transaction

#### Parameters

|Param|Description|
|---|---|
|`parentIds`|parentIds description|

#### Returns

|Type|Description|
|---|---|
|`List<BinLocation__c>`|return description|


**Method** getChildBins

### `private void populatePath(BinLocation__c bin, String parentPath)`
---
