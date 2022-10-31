# PartLocationMigrate class

 @test PartPhysicalInventoryDomainLayer.testPartsMasterTriggerHandler Date            |Developer            |Work# Notes --

---
## Constructors
### `PartLocationMigrate(dealer__PartPhysicalInventory__c objPPI)`
---
## Properties

### `ListRecForEmailId` → `List<id>`

### `objPartPhysicalInv` → `dealer__PartPhysicalInventory__c`

---
## Methods
### `execute(Database.BatchableContext bc, List<dealer__Parts_Inventory__c> sObjs)` → `void`
### `finish(Database.BatchableContext bc)` → `void`
### `start(Database.batchableContext bc)` → `Database.QueryLocator`
---
