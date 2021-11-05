# BatchUpdateEquippedField class

@description

---
## Constructors
### `BatchUpdateEquippedField(String q, String e, String f, String v)`
#### Parameters

| Param | Description |
| ----- | ----------- |
|`` | e |
|`` | f |
|`` | v |

---
## Properties

### `Entity` → `String`

@description

### `ListRecForEmailId` → `List<id>`

@description

### `NewField` → `String`

@description

### `OldField` → `String`

@description

### `Query` → `String`

@description

---
## Methods
### `execute(Database.BatchableContext BC, List<sObject> scope)` → `void`
#### Parameters

| Param | Description |
| ----- | ----------- |
|`` | C |
|`` | e |

#### Return

**Type**

void

**Description**

void

### `finish(Database.BatchableContext BC)` → `void`
#### Parameters

| Param | Description |
| ----- | ----------- |
|`` | C |

#### Return

**Type**

void

**Description**

void

### `start(Database.BatchableContext BC)` → `Database.QueryLocator`
#### Parameters

| Param | Description |
| ----- | ----------- |
|`` | C |

#### Return

**Type**

Database.QueryLocator

**Description**

Database.QueryLocator

---
