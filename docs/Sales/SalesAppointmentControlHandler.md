---
layout: default
---
# SalesAppointmentControlHandler

Handler for SalesAppointmentControl trigger


**Group** Sales

## Methods
### `public void handleBeforeDelete(List<dealer__Sales_Appointment__c> oldSalesApptList)`

Deletes related Event records on before delete context

#### Parameters

|Param|Description|
|---|---|
|`dealer__Sales_Appointment__c`|old list|

### `public void handleBeforeInsert(List<dealer__Sales_Appointment__c> salesApptList)`

Populate Original_Date and Original_Time fields

#### Parameters

|Param|Description|
|---|---|
|`dealer__Sales_Appointment__c`|list|

### `public void handleBeforeDateTime(List<dealer__Sales_Appointment__c> salesApptList)`

Populate Date and Time fields with DateTime value on before context

#### Parameters

|Param|Description|
|---|---|
|`dealer__Sales_Appointment__c`|list|

### `public void handleBeforeUpdate(List<Sales_Appointment__c> salesApptList, Map<Id,Sales_Appointment__c> salesApptOld)`

checks if appointment datetime needs adjusted to the assigned users local time

#### Parameters

|Param|Description|
|---|---|
|`dealer__Sales_Appointment__c`|list|

### `private void adjustTimezone(List<Sales_Appointment__c> salesApptList)`

- adjusts the datetime of a sales appointment to the local time of the assigned user

#### Parameters

|Param|Description|
|---|---|
|`salesApptList`|sales appt records to update|


**Method** adjustTimezone

### `public void handleAfterInsert(List<dealer__Sales_Appointment__c> salesApptList)`

Creates related event on after Insert context

#### Parameters

|Param|Description|
|---|---|
|`dealer__Sales_Appointment__c`|list|

### `public void handleAfterUpdate(List<dealer__Sales_Appointment__c> salesApptList)`

on after Update context

#### Parameters

|Param|Description|
|---|---|
|`dealer__Sales_Appointment__c`|list|

### `private void handleAfterInsertUpdate(List<dealer__Sales_Appointment__c> salesApptList)`

Updates SalesUp latest appointment date/time

#### Parameters

|Param|Description|
|---|---|
|`dealer__Sales_Appointment__c`|list|

---
