---
layout: default
---
# PartLocationMigrate

**Implemented types**

[Database.batchable&lt;SObject&gt;](Database.batchable&lt;SObject&gt;)
, 
[database.allowscallouts](database.allowscallouts)
, 
[Database.Stateful](Database.Stateful)

## Constructors
### `global PartLocationMigrate(dealer__PartPhysicalInventory__c objPPI)`
---
## Fields

### `global ListRecForEmailId` → `List<id>`


### `global objPartPhysicalInv` → `dealer__PartPhysicalInventory__c`


### `private BIN_REFERENCE_DEPTH` → `Integer`


---
## Methods
### `global Database start(Database bc)`
### `global void execute(Database bc, List<dealer__Parts_Inventory__c> sObjs)`
### `global void finish(Database bc)`
### `private Set<Id> getChildBins(Id binId)`

Returns all bin Ids nested within a bin provided the parent Id

#### Parameters

|Param|Description|
|---|---|
|`binId`|binId description|

#### Returns

|Type|Description|
|---|---|
|`Set<Id>`|return description|


**Method** getChildBins

---
