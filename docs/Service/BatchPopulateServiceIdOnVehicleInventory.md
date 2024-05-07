---
layout: default
---
# BatchPopulateServiceIdOnVehicleInventory



**Implemented types**

[Database.Batchable&lt;sObject&gt;](Database.Batchable&lt;sObject&gt;)


**Class** BatchPopulateServiceIdOnVehicleInventory


**Group** Service

## Constructors
### `global BatchPopulateServiceIdOnVehicleInventory()`

**Method** BatchPopulateServiceIdOnVehicleInventory

---
## Fields

### `private query` → `String`


### `global ListRecForEmailId` → `List<id>`


---
## Methods
### `global Database start(Database BC)`
#### Parameters

|Param|Description|
|---|---|
|`BC`||

### `global void execute(Database BC, List<dealer__Vehicle_Inventory__c> scope)`
#### Parameters

|Param|Description|
|---|---|
|`BC`||
|`scope`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|

### `global void finish(Database BC)`
#### Parameters

|Param|Description|
|---|---|
|`BC`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|

---
