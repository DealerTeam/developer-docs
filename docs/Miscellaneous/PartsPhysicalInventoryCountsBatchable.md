---
layout: default
---
# PartsPhysicalInventoryCountsBatchable

**Implemented types**

[Database.batchable&lt;SObject&gt;](Database.batchable&lt;SObject&gt;)
, 
[database.allowscallouts](database.allowscallouts)
, 
[Database.Stateful](Database.Stateful)

## Constructors
### `public PartsPhysicalInventoryCountsBatchable(PartPhysicalInventory__c physical, Map<Id,Integer> countMap)`

PartsPhysicalInventoryCountsBatchable constructor

---
## Fields

### `public ppi` → `PartPhysicalInventory__c`


### `public countMap` → `Map<Id,Integer>`


### `public openRows` → `Integer`


---
## Methods
### `public Database start(Database bc)`

Start interface for Batch Job

#### Parameters

|Param|Description|
|---|---|
|`bc`|Batchable context|

#### Returns

|Type|Description|
|---|---|
|`Database`|Database.QueryLocator|

### `public void execute(Database bc, List<PartsPhysicalDetail__c> records)`

Execute interface for Batch

#### Parameters

|Param|Description|
|---|---|
|`bc`|Database.BatchableContext|
|`sObjs`|List of Records - PartsPhysicalWorkFile|

### `public void finish(Database bc)`
---
