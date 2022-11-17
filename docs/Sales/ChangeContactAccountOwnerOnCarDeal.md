# ChangeContactAccountOwnerOnCarDeal

`APIVERSION: 45`

`STATUS: ACTIVE`



**Implemented types**

[Database.Batchable&lt;sObject&gt;](Database.Batchable&lt;sObject&gt;)
, 
[Database.Stateful](Database.Stateful)


**Class** ChangeContactAccountOwnerOnCarDeal


**Group** Sales

## Constructors
### `ChangeContactAccountOwnerOnCarDeal(String query)`
#### Parameters

|Param|Description|
|---|---|
|`query`||


**Method** ChangeContactAccountOwnerOnCarDeal

---
## Fields

### `AccountOwners` → `Map<String,String>`


### `AccsList` → `List<String>`


### `ContactsOwners` → `Map<String,String>`


### `consList` → `List<String>`


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



### `execute(Database.BatchableContext BC, List<sObject> batch)`
#### Return

**Type**

void

**Description**

void

### `updateOwners(Map<String,String> con, Map<String,String> Acc)`
#### Parameters

|Param|Description|
|---|---|
|`con`||
|`Acc`||

#### Return

**Type**

void

**Description**

void


**Method** updateOwners

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
