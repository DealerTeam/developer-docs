# BatchUpdateVehicleInternalCharges

`APIVERSION: 45`

`STATUS: ACTIVE`



**Implemented types**

[Database.Batchable&lt;sObject&gt;](Database.Batchable&lt;sObject&gt;)


**Class** BatchUpdateVehicleInternalCharges


**DescriptionBatch** Class to populate Vehicle Inventory internal charges fields from related SROs upon package installation


**Group** Service

## Methods
### `start(Database.BatchableContext BC)`

Collect the batches of records to be passed to execute

#### Parameters

|Param|Description|
|---|---|
|`BC`||

### `execute(Database.BatchableContext BC, List<dealer__Vehicle_Inventory__c> vehicleList)`

Process each batch of records

#### Parameters

|Param|Description|
|---|---|
|`BC`||
|`vehicleList`||

#### Return

**Type**

void

**Description**

void

### `finish(Database.BatchableContext BC)`
#### Parameters

|Param|Description|
|---|---|
|`BC`||

#### Return

**Type**

void

**Description**

void

---
