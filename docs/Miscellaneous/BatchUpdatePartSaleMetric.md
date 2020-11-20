---
layout: default
---
# BatchUpdatePartSaleMetric class

Handles Batch processing of parts inventory

---
## Constructors
### `BatchUpdatePartSaleMetric()`
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
