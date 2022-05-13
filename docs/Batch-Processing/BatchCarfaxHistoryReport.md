# BatchCarfaxHistoryReport

`APIVERSION: 49`

`STATUS: ACTIVE`

Performs batch execution to refresh the vehicle history report of Service Vehicles.


**Group** Batch Processing

## Constructors
### `BatchCarfaxHistoryReport()`

empty constructor

---
## Methods
### `start(Database.BatchableContext BC)`

forming batch requires query

#### Parameters
|Param|Description|
|---|---|
|`BC`|Batchable Context|

### `execute(Database.BatchableContext BC, List<sObject> scope)`

Process the records

#### Parameters
|Param|Description|
|---|---|
|`BC`|Batchable Context|
|`scope`|List<Sobject> Scope|

#### Return

**Type**

void

**Description**

void

### `finish(Database.BatchableContext BC)`

Finish interface, this runs at the end of the batchable run.

#### Parameters
|Param|Description|
|---|---|
|`BC`|Batchable Context|

#### Return

**Type**

void

**Description**

void

---
