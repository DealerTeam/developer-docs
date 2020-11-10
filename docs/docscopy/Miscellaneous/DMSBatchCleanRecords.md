---
layout: default
---
# DMSBatchCleanRecords class

Cleans records of invalid external Ids

---
## Constructors
### `DMSBatchCleanRecords(String Type, String objJSON)`

constructor
---
## Properties

### `DMSObjJSON` → `String`

### `ObjectAPIName` → `String`

---
## Methods
### `execute(Database.BatchableContext BC, List<sObject> scope)` → `void`

Process the records

#### Parameters
|Param|Description|
|-----|-----------|
|`` | C |
|`` | e |

### `finish(Database.BatchableContext BC)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | C |

### `start(Database.BatchableContext BC)` → `Database.QueryLocator`

forming batch requires query

#### Parameters
|Param|Description|
|-----|-----------|
|`` | C |

---