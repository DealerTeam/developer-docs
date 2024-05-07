---
layout: default
---
# MergeSalesup



**Class** MergeSalesup


**Group** Sales

## Constructors
### `public MergeSalesup()`

**Method** MergeSalesup

---
## Fields

### `public sObjectTypeOld` → `String`


### `public soslFields` → `String`


---
## Properties

### `public sObjectType` → `String`


### `public searchText` → `String`


### `public foundRecordList` → `List<SObject>`


### `public foundSalesUpList` → `List<dealer__Sales_Up__c>`


### `public sobjectsSlctOpt` → `List<SelectOption>`


### `public merginObjects` → `List<SObject>`


### `public selectedObjFields` → `Map<ID,Map<String,MergeRecordsUtil.InputHiddenValue>>`


### `public describe` → `MergeRecordsUtil`


### `public selectMergeObjectId` → `String`


### `public selectMergeObjectPosition` → `Integer`


### `public masterObjectId` → `String`


---
## Methods
### `public Integer getMaxRecordsCount()`
#### Returns

|Type|Description|
|---|---|
|`Integer`|Integer|


**Method** getMaxRecordsCount

### `public void initMergeAccounts()`
### `public void initMergeSalesUps()`
#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** initMergeSalesUps

### `public void initDescribe()`

inits the describe information

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** initDescribe

### `public void searchRecords()`
#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** searchRecords

### `public void selectMergeObject()`

Moves an object from the search list to the merging list

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** selectMergeObject

### `public PageReference mergeSups()`

Merge records into one

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** mergeSups

### `public PageReference mergeAccounts()`

merges two accounts

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference - A reference to the master object's page|


**Method** mergeAccounts

---
