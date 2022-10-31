# DMSBatchCleanRecords

`APIVERSION: 47`

`STATUS: ACTIVE`

Cleans records of invalid external Ids


**Class** DMSBatchCleanRecords


**Test** TestDMSImports

## Constructors
### `DMSBatchCleanRecords(String Type, String objJSON)`

constructor


**Method** DMSBatchCleanRecords description

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
