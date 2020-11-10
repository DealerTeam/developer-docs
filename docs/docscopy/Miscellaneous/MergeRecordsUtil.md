---
layout: default
---
# MergeRecordsUtil class

@description

---
## Properties

### `MERGED_RECORDS_COUNT` → `Integer`

This guides the number of merged records

---
## Methods
### `copyDataIntoMasterRecord(SelectMasterResult recordSet, Map<ID,Map<String,InputHiddenValue>> selectedObjFields)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | t |
|`` | s |

### `initDescribes(String sObjectType)` → `DescribeResult`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

### `mergeRecords(List<SObject> merginObjects, String masterId)` → `SelectMasterResult`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | s |
|`` | d |

---
## Inner Classes

### MergeRecordsUtil.DescribeResult class

Init all the necessary describes

---
#### Constructors
##### `DescribeResult()`
---
#### Properties

##### `allFields` → `MergeRecordsUtil.Field>`

##### `allFieldsKeySet` → `List<String>`

##### `nameField` → `String`

##### `nameFieldLabel` → `String`

##### `sOType` → `Schema.SobjectType`

##### `uniqueFields` → `Map<String,String>`

##### `uniqueFieldsKeySet` → `List<String>`

---
### MergeRecordsUtil.Field class

Utility class to handle field specs

---
#### Constructors
##### `Field(String name, String label, Boolean isWritable)`
---
#### Properties

##### `isWritable` → `Boolean`

##### `label` → `String`

##### `name` → `String`

---
### MergeRecordsUtil.InputHiddenValue class

Utility class to handle the single cell

---
#### Constructors
##### `InputHiddenValue(String name, Boolean isChecked, Boolean isSelectable)`
---
#### Properties

##### `isChecked` → `Boolean`

##### `isSelectable` → `Boolean`

##### `name` → `String`

---
### MergeRecordsUtil.SelectMasterResult class

Utility class to handle the master/loosers selection

---
#### Properties

##### `loserObjs` → `List<SOBject>`

##### `masterObject` → `SObject`

---
