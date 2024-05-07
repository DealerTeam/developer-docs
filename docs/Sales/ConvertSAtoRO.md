---
layout: default
---
# ConvertSAtoRO



**Class** ConvertSAtoRO


**Group** Sales

## Constructors
### `public ConvertSAtoRO(ApexPages controller)`
#### Parameters

|Param|Description|
|---|---|
|`controller`||


**Method** ConvertSAtoRO

---
## Fields

### `public serviceAppointmentId` → `String`


### `public repairOrderRecord` → `Service_Repair_Order__c`


### `public estimateTotal` → `Decimal`


---
## Properties

### `public RepairOrderID` → `String`


---
## Methods
### `public void autoRun()`

This method create the Service Repair Order record from the Service Appointment, and then deletes the Service Appointment Record

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** autoRun

### `public void insertChildRecords()`

Inserts the Service Job Records from  Service Appointment Line records

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** insertChildRecords

### `public void createTask()`

It created task for the newly created Service Repair Order

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** createTask description

---
## Classes
### SROException

**Inheritance**

SROException


---
