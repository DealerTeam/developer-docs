# PartLocationMigrate

`APIVERSION: 45`

`STATUS: ACTIVE`

**Implemented types**

[Database.batchable&lt;SObject&gt;](Database.batchable&lt;SObject&gt;)
, 
[database.allowscallouts](database.allowscallouts)
, 
[Database.Stateful](Database.Stateful)

## Constructors
### `PartLocationMigrate(dealer__PartPhysicalInventory__c objPPI)`
---
## Fields

### `ListRecForEmailId` → `List<id>`


### `objPartPhysicalInv` → `dealer__PartPhysicalInventory__c`


---
## Methods
### `start(Database.batchableContext bc)`
### `execute(Database.BatchableContext bc, List<dealer__Parts_Inventory__c> sObjs)`
### `finish(Database.BatchableContext bc)`
---
