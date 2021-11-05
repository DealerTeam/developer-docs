# BatchCompletePhysical class

Database Batchable interface used with the processing of Parts Physical Inventory workload.

---
## Constructors
### `BatchCompletePhysical(String q)`

The constructor sets the query string for this operation.
#### Parameters

| Param | Description |
| ----- | ----------- |
|`q` |  String Query to execute |

---
## Properties

### `query` → `String`

Query string to perform work on.

---
## Methods
### `execute(Database.BatchableContext BC, List<sObject> scope)` → `void`

Iterates sObjects returned

#### Parameters

| Param | Description |
| ----- | ----------- |
|`BC` |  Database.BatchableContext |
|`scope` |  List&lt;sObject&gt; |

#### Return

**Type**

void

**Description**

void

### `finish(Database.BatchableContext BC)` → `void`

Finish interface for the Batchable context

#### Parameters

| Param | Description |
| ----- | ----------- |
|`BC` |  Database.BatchableContext |

#### Return

**Type**

void

**Description**

void

### `start(Database.BatchableContext BC)` → `Database.QueryLocator`

Starts execution of the batchable interface

#### Parameters

| Param | Description |
| ----- | ----------- |
|`BC` |  BatchableContext |

---
