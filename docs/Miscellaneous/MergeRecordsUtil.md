---
layout: default
---
# MergeRecordsUtil



**Class** MergeRecordsUtil

## Fields

### `public MERGED_RECORDS_COUNT` → `Integer`


This guides the number of merged records

---
## Methods
### `public static SelectMasterResult mergeRecords(List<SObject> merginObjects, String masterId)`
#### Parameters

|Param|Description|
|---|---|
|`merginObjects`||
|`masterId`||

#### Returns

|Type|Description|
|---|---|
|`SelectMasterResult`|SelectMasterResult|


**Method** mergeRecords

### `public static void copyDataIntoMasterRecord(SelectMasterResult recordSet, Map<ID,Map<String,InputHiddenValue>> selectedObjFields)`
#### Parameters

|Param|Description|
|---|---|
|`recordSet`||
|`selectedObjFields`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** copyDataIntoMasterRecord

### `public static DescribeResult initDescribes(String sObjectType)`
#### Parameters

|Param|Description|
|---|---|
|`sObjectType`||

#### Returns

|Type|Description|
|---|---|
|`DescribeResult`|DescribeResult|


**Method** initDescribes

---
## Classes
### SelectMasterResult

Utility class to handle the master/loosers selection

#### Fields

##### `public loserObjs` → `List&lt;SOBject&gt;`


##### `public masterObject` → `SObject`


---

### InputHiddenValue

Utility class to handle the single cell

#### Constructors
##### `public InputHiddenValue(String name, Boolean isChecked, Boolean isSelectable)`
---
#### Properties

##### `public isChecked` → `Boolean`


##### `public isSelectable` → `Boolean`


##### `public name` → `String`


---

### Field

Utility class to handle field specs

#### Constructors
##### `public Field(String name, String label, Boolean isWritable)`
---
#### Properties

##### `public name` → `String`


##### `public label` → `String`


##### `public isWritable` → `Boolean`


---

### DescribeResult

Init all the necessary describes

#### Constructors
##### `public DescribeResult()`
---
#### Fields

##### `public sOType` → `Schema`


---
#### Properties

##### `public nameField` → `String`


##### `public nameFieldLabel` → `String`


##### `public allFields` → `Map&lt;String,MergeRecordsUtil.Field&gt;`


##### `public allFieldsKeySet` → `List&lt;String&gt;`


##### `public uniqueFields` → `Map&lt;String,String&gt;`


##### `public uniqueFieldsKeySet` → `List&lt;String&gt;`


---

---
