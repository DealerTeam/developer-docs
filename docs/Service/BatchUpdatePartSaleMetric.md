# BatchUpdatePartSaleMetric

`APIVERSION: 45`

`STATUS: ACTIVE`

Handles Batch processing of parts inventory


**Implemented types**

[Database.Batchable&lt;sObject&gt;](Database.Batchable&lt;sObject&gt;)


**Class** BatchUpdatePartSaleMetric


**Test** PartAnalyticsSystemLayer


**Group** Service

## Constructors
### `BatchUpdatePartSaleMetric()`
---
## Methods
### `start(Database.BatchableContext BC)`

forming batch requires query

#### Parameters

|Param|Description|
|---|---|
|`BC`||

### `execute(Database.BatchableContext BC, List<sObject> scope)`

Process the records

#### Parameters

|Param|Description|
|---|---|
|`BC`||
|`scope`||

#### Return

**Type**

void

**Description**

void

### `finish(Database.BatchableContext BC)`
#### Parameters

|Param|Description|
|---|---|
|`BC`||

#### Return

**Type**

void

**Description**

void

---
