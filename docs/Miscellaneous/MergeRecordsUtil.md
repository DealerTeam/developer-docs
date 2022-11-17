# MergeRecordsUtil

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** MergeRecordsUtil

## Fields

### `MERGED_RECORDS_COUNT` → `Integer`


This guides the number of merged records

---
## Methods
### `static mergeRecords(List<SObject> merginObjects, String masterId)`
#### Parameters

|Param|Description|
|---|---|
|`merginObjects`||
|`masterId`||

#### Return

**Type**

SelectMasterResult

**Description**

SelectMasterResult


**Method** mergeRecords

### `static copyDataIntoMasterRecord(SelectMasterResult recordSet, Map<ID,Map<String,InputHiddenValue>> selectedObjFields)`
#### Parameters

|Param|Description|
|---|---|
|`recordSet`||
|`selectedObjFields`||

#### Return

**Type**

void

**Description**

void


**Method** copyDataIntoMasterRecord

### `static initDescribes(String sObjectType)`
#### Parameters

|Param|Description|
|---|---|
|`sObjectType`||

#### Return

**Type**

DescribeResult

**Description**

DescribeResult


**Method** initDescribes

---
## Classes
### DescribeResult

Init all the necessary describes

#### Constructors
##### `DescribeResult()`
---
#### Fields

##### `sOType` → `Schema.SobjectType`


---
#### Properties

##### `allFields` → `Map&lt;String,MergeRecordsUtil.Field&gt;`


##### `allFieldsKeySet` → `List&lt;String&gt;`


##### `nameField` → `String`


##### `nameFieldLabel` → `String`


##### `uniqueFields` → `Map&lt;String,String&gt;`


##### `uniqueFieldsKeySet` → `List&lt;String&gt;`


---

### Field

Utility class to handle field specs

#### Constructors
##### `Field(String name, String label, Boolean isWritable)`
---
#### Properties

##### `isWritable` → `Boolean`


##### `label` → `String`


##### `name` → `String`


---

### InputHiddenValue

Utility class to handle the single cell

#### Constructors
##### `InputHiddenValue(String name, Boolean isChecked, Boolean isSelectable)`
---
#### Properties

##### `isChecked` → `Boolean`


##### `isSelectable` → `Boolean`


##### `name` → `String`


---

### SelectMasterResult

Utility class to handle the master/loosers selection

#### Fields

##### `loserObjs` → `List&lt;SOBject&gt;`


##### `masterObject` → `SObject`


---

---
