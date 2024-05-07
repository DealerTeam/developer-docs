---
layout: default
---
# ServiceAppointmentControlHandler



**Group** Service

## Constructors
### `public ServiceAppointmentControlHandler()`
---
## Fields

### `public dms` → `DMS_Settings__c`


---
## Methods
### `public void addEventsonInsert(List<dealer__Service_Appointment__c> triggerNew)`
### `public void addEventsonUpdate(List<Service_Appointment__c> triggerNew)`
### `public Event setEventDetails(Event relatedEvent, Service_Appointment__c appt)`

Set event fields based on Service Appointment and return event

#### Parameters

|Param|Description|
|---|---|
|`relatedEvent`|relatedEvent description|
|`appt`|appt description|

#### Returns

|Type|Description|
|---|---|
|`Event`|return description|

### `public void BeforeHandlerforMapping(List<dealer__Service_Appointment__c> triggerNew)`
### `public void deleteEvents(List<Service_Appointment__c> triggerNew)`
### `private void setName(Service_Appointment__c appt)`

Sets the appointment name based on the dms setting and location related to the appt

#### Parameters

|Param|Description|
|---|---|
|`appt`|appt description|

#### Returns

|Type|Description|
|---|---|
|`void`|return description|

---
