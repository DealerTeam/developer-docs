# PartLocationMigrate

`APIVERSION: 45`

`STATUS: ACTIVE`

**Test** PartPhysicalInventoryDomainLayer.testPartsMasterTriggerHandler Date            |Developer            |Work# Notes --


**Group** Parts 2017.13.01      |Gaurav               |W-000892 Created batch class for bulk insertion of Part Physical Detail records

## Constructors
### `PartLocationMigrate(dealer__PartPhysicalInventory__c objPPI)`
#### Parameters
|Param|Description|
|---|---|

---
## Fields

### `ListRecForEmailId` → `List<id>`


### `objPartPhysicalInv` → `dealer__PartPhysicalInventory__c`


---
## Methods
### `start(Database.batchableContext bc)`
#### Parameters
|Param|Description|
|---|---|

### `execute(Database.BatchableContext bc, List<dealer__Parts_Inventory__c> sObjs)`
#### Parameters
|Param|Description|
|---|---|

### `finish(Database.BatchableContext bc)`
#### Parameters
|Param|Description|
|---|---|

---
