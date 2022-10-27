# BatchCompletePhysical

`APIVERSION: 45`

`STATUS: ACTIVE`

Database Batchable interface used with the processing of Parts Physical Inventory workload.

**Group** Batch Processing

## Constructors

### `BatchCompletePhysical(String q)`

The constructor sets the query string for this operation.

#### Parameters

| Param | Description             |
| ----- | ----------------------- |
| `q`   | String Query to execute |

***

## Fields

### `query` → `String`

Query string to perform work on.

***

## Methods

### `start(Database.BatchableContext BC)`

Starts execution of the batchable interface

#### Parameters

| Param | Description      |
| ----- | ---------------- |
| `BC`  | BatchableContext |

### `execute(Database.BatchableContext BC, List<sObject> scope)`

Iterates sObjects returned

#### Parameters

| Param   | Description               |
| ------- | ------------------------- |
| `BC`    | Database.BatchableContext |
| `scope` | List                      |

#### Return

**Type**

void

**Description**

void

### `finish(Database.BatchableContext BC)`

Finish interface for the Batchable context

#### Parameters

| Param | Description               |
| ----- | ------------------------- |
| `BC`  | Database.BatchableContext |

#### Return

**Type**

void

**Description**

void

***
