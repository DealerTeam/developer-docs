---
layout: default
---
# MergeSalesup class

@description

---
## Constructors
### `MergeSalesup()`
---
## Properties

### `Map<ID,Map<String,MergeRecordsUtil.InputHiddenValue>>selectedObjFields` → `public`

@description

### `describe` → `MergeRecordsUtil.DescribeResult`

@description

### `foundRecordList` → `List<SObject>`

@description

### `foundSalesUpList` → `List<dealer__Sales_Up__c>`

@description

### `masterObjectId` → `String`

@description

### `merginObjects` → `List<SObject>`

@description

### `sObjectType` → `String`

@description

### `sObjectTypeOld` → `String`

@description

### `searchText` → `String`

@description

### `selectMergeObjectId` → `String`

@description

### `selectMergeObjectPosition` → `Integer`

@description

### `sobjectsSlctOpt` → `List<SelectOption>`

@description

### `soslFields` → `String`

@description

---
## Methods
### `getMaxRecordsCount()` → `Integer`
### `initDescribe()` → `void`

inits the describe information

### `initMergeAccounts()` → `void`
### `initMergeSalesUps()` → `void`
### `mergeAccounts()` → `PageReference`

merges two accounts

### `mergeSups()` → `PageReference`

Merge records into one

### `searchRecords()` → `void`
### `selectMergeObject()` → `void`

Moves an object from the search list to the merging list

---
