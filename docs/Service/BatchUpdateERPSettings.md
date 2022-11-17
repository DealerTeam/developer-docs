# BatchUpdateERPSettings

`APIVERSION: 55`

`STATUS: ACTIVE`



**Implemented types**

[Database.Batchable&lt;sObject&gt;](Database.Batchable&lt;sObject&gt;)


**Class** BatchUpdateERPSettings


**DescriptionBatch** Class to update User records with correct custom setting location info


**Group** Service

## Methods
### `start(Database.BatchableContext BC)`

Collect the batches of records to be passed to execute

#### Parameters

|Param|Description|
|---|---|
|`BC`||

### `execute(Database.BatchableContext BC, List<User> userList)`

Process each batch of records

#### Parameters

|Param|Description|
|---|---|
|`BC`||
|`userList`||

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
