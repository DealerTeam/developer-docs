---
layout: default
---
# ConvertSAtoRO class

@description

---
## Constructors
### `ConvertSAtoRO(ApexPages.StandardController controller)`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | r |

---
## Properties

### `RepairOrderID` → `String`

 @descption

### `estimateTotal` → `Decimal`

 @descption

### `repairOrderRecord` → `Service_Repair_Order__c`

 @descption

### `serviceAppointmentId` → `String`

 @descption

---
## Methods
### `autoRun()` → `void`

This method create the Service Repair Order record from the Service Appointment, and then deletes the Service Appointment Record

### `createTask()` → `void`

It created task for the newly created Service Repair Order

### `insertChildRecords()` → `void`

Inserts the Service Job Records from  Service Appointment Line records

---
## Inner Classes

### ConvertSAtoRO.SROException class

@description

---
