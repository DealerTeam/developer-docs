---
layout: default
---
# BatchCompletePhysical

Database Batchable interface used with the processing of Parts Physical Inventory workload.


**Implemented types**

[Database.Batchable&lt;sObject&gt;](Database.Batchable&lt;sObject&gt;)


**Group** Batch Processing

## Constructors
### `global BatchCompletePhysical(String q)`

The constructor sets the query string for this operation.

#### Parameters

|Param|Description|
|---|---|
|`q`|String Query to execute|

---
## Fields

### `global query` → `String`


Query string to perform work on.

---
## Methods
### `global Database start(Database BC)`

Starts execution of the batchable interface

#### Parameters

|Param|Description|
|---|---|
|`BC`|BatchableContext|

### `global void execute(Database BC, List<sObject> scope)`

Iterates sObjects returned

#### Parameters

|Param|Description|
|---|---|
|`BC`|Database.BatchableContext|
|`scope`|List<sObject>|

#### Returns

|Type|Description|
|---|---|
|`void`|void|

### `global void finish(Database BC)`

Finish interface for the Batchable context

#### Parameters

|Param|Description|
|---|---|
|`BC`|Database.BatchableContext|

#### Returns

|Type|Description|
|---|---|
|`void`|void|

---
