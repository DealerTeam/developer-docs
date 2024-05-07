---
layout: default
---
# BatchUpdateVehicleInternalCharges



**Implemented types**

[Database.Batchable&lt;sObject&gt;](Database.Batchable&lt;sObject&gt;)


**Class** BatchUpdateVehicleInternalCharges


**DescriptionBatch** Class to populate Vehicle Inventory internal charges fields from related SROs upon package installation


**Group** Service

## Methods
### `global Database start(Database BC)`

Collect the batches of records to be passed to execute

#### Parameters

|Param|Description|
|---|---|
|`BC`||

### `global void execute(Database BC, List<dealer__Vehicle_Inventory__c> vehicleList)`

Process each batch of records

#### Parameters

|Param|Description|
|---|---|
|`BC`||
|`vehicleList`||

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
