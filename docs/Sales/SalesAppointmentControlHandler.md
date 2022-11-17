# SalesAppointmentControlHandler

`APIVERSION: 45`

`STATUS: ACTIVE`

Handler for SalesAppointmentControl trigger


**Group** Sales

## Methods
### `handleBeforeDelete(List<dealer__Sales_Appointment__c> oldSalesApptList)`

Deletes related Event records on before delete context

#### Parameters

|Param|Description|
|---|---|
|`dealer__Sales_Appointment__c`|old list|

### `handleBeforeInsert(List<dealer__Sales_Appointment__c> salesApptList)`

Populate Original_Date and Original_Time fields

#### Parameters

|Param|Description|
|---|---|
|`dealer__Sales_Appointment__c`|list|

### `handleBeforeDateTime(List<dealer__Sales_Appointment__c> salesApptList)`

Populate Date and Time fields with DateTime value on before context

#### Parameters

|Param|Description|
|---|---|
|`dealer__Sales_Appointment__c`|list|

### `handleBeforeUpdate(List<Sales_Appointment__c> salesApptList, Map<Id,Sales_Appointment__c> salesApptOld)`

checks if appointment datetime needs adjusted to the assigned users local time

#### Parameters

|Param|Description|
|---|---|
|`dealer__Sales_Appointment__c`|list|

### `handleAfterInsert(List<dealer__Sales_Appointment__c> salesApptList)`

Creates related event on after Insert context

#### Parameters

|Param|Description|
|---|---|
|`dealer__Sales_Appointment__c`|list|

### `handleAfterUpdate(List<dealer__Sales_Appointment__c> salesApptList)`

on after Update context

#### Parameters

|Param|Description|
|---|---|
|`dealer__Sales_Appointment__c`|list|

---
