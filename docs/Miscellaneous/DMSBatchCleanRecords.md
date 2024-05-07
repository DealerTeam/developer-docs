---
layout: default
---
# DMSBatchCleanRecords

Cleans records of invalid external Ids


**Implemented types**

[Database.Batchable&lt;sObject&gt;](Database.Batchable&lt;sObject&gt;)
, 
[Database.AllowsCallouts](Database.AllowsCallouts)


**Class** DMSBatchCleanRecords


**Test** TestDMSImports

## Constructors
### `global DMSBatchCleanRecords(String Type, String objJSON)`

constructor


**Method** DMSBatchCleanRecords description

---
## Fields

### `private query` → `String`


---
## Properties

### `public ObjectAPIName` → `String`


### `public DMSObjJSON` → `String`


---
## Methods
### `global Database start(Database BC)`

forming batch requires query

#### Parameters

|Param|Description|
|---|---|
|`BC`||

### `global void execute(Database BC, List<sObject> scope)`

Process the records

#### Parameters

|Param|Description|
|---|---|
|`BC`||
|`scope`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|

### `global void finish(Database BC)`
#### Parameters

|Param|Description|
|---|---|
|`BC`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|

---
