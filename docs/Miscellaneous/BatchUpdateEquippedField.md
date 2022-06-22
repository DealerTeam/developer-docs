# BatchUpdateEquippedField

`APIVERSION: 45`

`STATUS: ACTIVE`

**Class** BatchUpdateEquippedField

## Constructors
### `BatchUpdateEquippedField(String q, String e, String f, String v)`
#### Parameters

|Param|Description|
|---|---|
|`e`||
|`f`||
|`v`||


**Method** BatchUpdateEquippedField

---
## Fields

### `Entity` → `String`


### `ListRecForEmailId` → `List<id>`


### `NewField` → `String`


### `OldField` → `String`


### `Query` → `String`


---
## Methods
### `start(Database.BatchableContext BC)`
#### Parameters

|Param|Description|
|---|---|
|`BC`||

#### Return

**Type**

Database.QueryLocator

**Description**

Database.QueryLocator

### `execute(Database.BatchableContext BC, List<sObject> scope)`
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
