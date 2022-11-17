# RentalScheduleControl

`APIVERSION: 45`

`STATUS: ACTIVE`

Controller for RentalSchedule.vfp


**Group** Rental

## Constructors
### `RentalScheduleControl(ApexPages.Standardcontroller sc)`
---
## Properties

### `vi` → `dealer__Vehicle_Inventory__c`


---
## Methods
### `static getVehiclesJSON(String locId, String region)`

`REMOTEACTION`
### `static getCustomersJSON(String customerFilter)`

`REMOTEACTION`
### `static getCustomersAccountJSON(String customerFilter)`

`REMOTEACTION`
### `static getRatesJSON()`

`REMOTEACTION`
### `static deleteRentalEvent(String rentalId)`

`REMOTEACTION`
### `static getRentalEventsJSON(String locId)`

`REMOTEACTION`
### `static getUserLocation()`

`REMOTEACTION`
### `static getLocationsJSON(String region)`

`REMOTEACTION`
### `static getRegionsJSON()`

`REMOTEACTION`
### `static saveEvent(List<dealer__Rental_Schedule_Event__c> eventData)`

`REMOTEACTION`
### `static getRentalColors()`
### `static getFieldSets()`
### `static getRequiredFields()`
### `static toProperCase(String value)`
---
## Classes
### ContactAccountWrapper
#### Constructors
##### `ContactAccountWrapper(sObject ca, String objectType)`
---
#### Properties

##### `contactAccount` → `sObject`


##### `type` → `String`


---

---
