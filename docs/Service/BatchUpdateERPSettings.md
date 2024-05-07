---
layout: default
---
# BatchUpdateERPSettings



**Implemented types**

[Database.Batchable&lt;sObject&gt;](Database.Batchable&lt;sObject&gt;)


**Class** BatchUpdateERPSettings


**DescriptionBatch** Class to update User records with correct custom setting location info


**Group** Service

## Methods
### `public Database start(Database BC)`

Collect the batches of records to be passed to execute

#### Parameters

|Param|Description|
|---|---|
|`BC`||

### `public void execute(Database BC, List<User> userList)`

Process each batch of records

#### Parameters

|Param|Description|
|---|---|
|`BC`||
|`userList`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|

### `public void finish(Database BC)`
#### Parameters

|Param|Description|
|---|---|
|`BC`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|

---
