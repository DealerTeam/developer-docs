---
layout: default
---
# PartsPhysicalInventoryBatchable

**Implemented types**

[Database.batchable&lt;SObject&gt;](Database.batchable&lt;SObject&gt;)
, 
[database.allowscallouts](database.allowscallouts)
, 
[Database.Stateful](Database.Stateful)

## Constructors
### `public PartsPhysicalInventoryBatchable(PartPhysicalInventory__c physical)`

PartsPhysicalInventoryBatchable constructor

---
## Fields

### `public ppi` → `PartPhysicalInventory__c`


PartPhysicalInventory__c to be worked in this batch

### `public physicalStatus` → `String`


### `public varianceValue` → `Decimal`


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

### `public void execute(Database bc, List<PartsPhysicalDetail__c> sObjs)`

Execute interface for Batch

#### Parameters

|Param|Description|
|---|---|
|`bc`|Database.BatchableContext|
|`sObjs`|List of Records - PartsPhysicalWorkFile|

### `public void finish(Database bc)`
---
