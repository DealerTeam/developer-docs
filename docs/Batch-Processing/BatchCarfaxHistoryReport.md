---
layout: default
---
# BatchCarfaxHistoryReport

Performs batch execution to refresh the vehicle history report of Service Vehicles.


**Implemented types**

[Database.Batchable&lt;sObject&gt;](Database.Batchable&lt;sObject&gt;)
, 
[Database.AllowsCallouts](Database.AllowsCallouts)


**Group** Batch Processing

## Constructors
### `global BatchCarfaxHistoryReport()`

empty constructor

---
## Fields

### `private query` → `String`


### `private days` → `Integer`


---
## Methods
### `global Database start(Database BC)`

forming batch requires query

#### Parameters

|Param|Description|
|---|---|
|`BC`|Batchable Context|

### `global void execute(Database BC, List<sObject> scope)`

Process the records

#### Parameters

|Param|Description|
|---|---|
|`BC`|Batchable Context|
|`scope`|List<Sobject> Scope|

#### Returns

|Type|Description|
|---|---|
|`void`|void|

### `global void finish(Database BC)`

Finish interface, this runs at the end of the batchable run.

#### Parameters

|Param|Description|
|---|---|
|`BC`|Batchable Context|

#### Returns

|Type|Description|
|---|---|
|`void`|void|

---
