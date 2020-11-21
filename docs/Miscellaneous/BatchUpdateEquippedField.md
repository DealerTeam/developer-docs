---
layout: default
---
# BatchUpdateEquippedField class

@description

---
## Constructors
### `BatchUpdateEquippedField(String q, String e, String f, String v)`
#### Parameters
|Param|Description|
|-----|-----------|
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
#### Parameters
|Param|Description|
|-----|-----------|
|`` | C |

---
