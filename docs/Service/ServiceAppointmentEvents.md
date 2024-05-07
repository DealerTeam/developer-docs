---
layout: default
---
# ServiceAppointmentEvents



**Group** Service

## Constructors
### `public ServiceAppointmentEvents()`
---
## Fields

### `public urlParameters` → `Map<String,String>`


### `public sa` → `List<dealer__Service_Appointment__c>`


### `public ros` → `List<dealer__Service_Repair_Order__c>`


---
## Properties

### `public uid` → `User`


### `public startDate` → `Date`


### `public endDate` → `Date`


### `public qDate` → `Date`


### `public action` → `String`


### `public customerId` → `String`


### `public selectedLocation` → `String`


### `public validLocations` → `String`


### `public crudResponse` → `String`


---
## Methods
### `public PageReference saveAppointment()`
### `public String createAppointmentLogic()`
### `public String updateAppointmentLogic()`
### `public String deleteAppointment()`
### `public String getcrud()`
### `public String getVehicleRead()`
### `public String getCustomerReadDecision()`
### `public String getSchedulerLocations()`
### `public string getLocationRead()`
### `public String getCustomerRead()`
### `public String getCustomerReadById()`
### `public String getStandardOperationCodes()`
### `public String getPmtTypeOptions()`
### `public List<dealer__Service_Appointment__c> listOfEvents()`
### `public List<Service_Repair_Order__c> listofROs()`

Query repair order within the specified date range for the selected location

#### Returns

|Type|Description|
|---|---|
|`List<Service_Repair_Order__c>`|return description|

### `public String generateEventFeed()`
### `public String getAppointmentJSON()`
---
