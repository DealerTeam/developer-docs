# MergeSalesup

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** MergeSalesup


**Group** Sales

## Constructors
### `MergeSalesup()`

**Method** MergeSalesup

---
## Fields

### `sObjectTypeOld` → `String`


### `soslFields` → `String`


---
## Properties

### `describe` → `MergeRecordsUtil.DescribeResult`


### `foundRecordList` → `List<SObject>`


### `foundSalesUpList` → `List<dealer__Sales_Up__c>`


### `masterObjectId` → `String`


### `merginObjects` → `List<SObject>`


### `sObjectType` → `String`


### `searchText` → `String`


### `selectMergeObjectId` → `String`


### `selectMergeObjectPosition` → `Integer`


### `selectedObjFields` → `Map<ID,Map<String,MergeRecordsUtil.InputHiddenValue>>`


### `sobjectsSlctOpt` → `List<SelectOption>`


---
## Methods
### `getMaxRecordsCount()`
#### Return

**Type**

Integer

**Description**

Integer


**Method** getMaxRecordsCount

### `initMergeAccounts()`
### `initMergeSalesUps()`
#### Return

**Type**

void

**Description**

void


**Method** initMergeSalesUps

### `initDescribe()`

inits the describe information

#### Return

**Type**

void

**Description**

void


**Method** initDescribe

### `searchRecords()`
#### Return

**Type**

void

**Description**

void


**Method** searchRecords

### `selectMergeObject()`

Moves an object from the search list to the merging list

#### Return

**Type**

void

**Description**

void


**Method** selectMergeObject

### `mergeSups()`

Merge records into one

#### Return

**Type**

PageReference

**Description**

PageReference


**Method** mergeSups

### `mergeAccounts()`

merges two accounts

#### Return

**Type**

PageReference

**Description**

PageReference - A reference to the master object's page


**Method** mergeAccounts

---
