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

#### Return

**Type**

void

**Description**

void

### `finish(Database.BatchableContext BC)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | C |

#### Return

**Type**

void

**Description**

void

### `start(Database.BatchableContext BC)` → `Database.QueryLocator`

forming batch requires query

#### Parameters
|Param|Description|
|-----|-----------|
|`` | C |

---
