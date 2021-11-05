# BatchCarfaxHistoryReport class

Performs batch execution to refresh the vehicle history report of Service Vehicles.

---
## Constructors
### `BatchCarfaxHistoryReport()`

empty constructor
---
## Methods
### `execute(Database.BatchableContext BC, List<sObject> scope)` → `void`

Process the records

#### Parameters

| Param | Description |
| ----- | ----------- |
|`BC` |  Batchable Context |
|`scope` |  List&lt;Sobject&gt; Scope |

#### Return

**Type**

void

**Description**

void

### `finish(Database.BatchableContext BC)` → `void`

Finish interface, this runs at the end of the batchable run.

#### Parameters

| Param | Description |
| ----- | ----------- |
|`BC` |  Batchable Context |

#### Return

**Type**

void

**Description**

void

### `start(Database.BatchableContext BC)` → `Database.QueryLocator`

forming batch requires query

#### Parameters

| Param | Description |
| ----- | ----------- |
|`BC` |  Batchable Context |

---
