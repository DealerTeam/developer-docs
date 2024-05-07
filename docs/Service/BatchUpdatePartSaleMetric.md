---
layout: default
---
# BatchUpdatePartSaleMetric

Handles Batch processing of parts inventory


**Implemented types**

[Database.Batchable&lt;sObject&gt;](Database.Batchable&lt;sObject&gt;)


**Class** BatchUpdatePartSaleMetric


**Test** PartAnalyticsSystemLayer


**Group** Service

## Constructors
### `global BatchUpdatePartSaleMetric()`
---
## Fields

### `private query` → `String`


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
