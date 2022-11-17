# ConvertSAtoRO

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** ConvertSAtoRO


**Group** Sales

## Constructors
### `ConvertSAtoRO(ApexPages.StandardController controller)`
#### Parameters

|Param|Description|
|---|---|
|`controller`||


**Method** ConvertSAtoRO

---
## Fields

### `estimateTotal` → `Decimal`


### `repairOrderRecord` → `Service_Repair_Order__c`


### `serviceAppointmentId` → `String`


---
## Properties

### `RepairOrderID` → `String`


---
## Methods
### `autoRun()`

This method create the Service Repair Order record from the Service Appointment, and then deletes the Service Appointment Record

#### Return

**Type**

void

**Description**

void


**Method** autoRun

### `insertChildRecords()`

Inserts the Service Job Records from  Service Appointment Line records

#### Return

**Type**

void

**Description**

void


**Method** insertChildRecords

### `createTask()`

It created task for the newly created Service Repair Order

#### Return

**Type**

void

**Description**

void


**Method** createTask description

---
## Classes
### SROException

**Inheritance**

SROException


---
