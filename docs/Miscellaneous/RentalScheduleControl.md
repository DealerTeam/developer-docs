---
layout: default
---
# RentalScheduleControl class
---
## Constructors
### `RentalScheduleControl(ApexPages.Standardcontroller sc)`
---
## Properties

### `vi` → `dealer__Vehicle_Inventory__c`

---
## Methods
### `deleteRentalEvent(String rentalId)` → `void`
### `getCustomersAccountJSON(String customerFilter)` → `List<ContactAccountWrapper>`
### `getCustomersJSON(String customerFilter)` → `List<Contact>`
### `getFieldSets()` → `List<String>`
### `getLocationsJSON(String region)` → `List<dealer__Dealer_Location__c>`
### `getRatesJSON()` → `List<dealer__Rental_Rates__c>`
### `getRegionsJSON()` → `List<dealer__Region__c>`
### `getRentalColors()` → `String`
### `getRentalEventsJSON(String locId)` → `List<dealer__Rental_Schedule_Event__c>`
### `getRequiredFields()` → `List<String>`
### `getUserLocation()` → `String`
### `getVehiclesJSON(String locId, String region)` → `List<dealer__Vehicle_Inventory__c>`
### `saveEvent(List<dealer__Rental_Schedule_Event__c> eventData)` → `boolean`
### `toProperCase(String value)` → `String`
---
## Inner Classes

### RentalScheduleControl.ContactAccountWrapper class

 		Inner class to handle contact / account 		dropdown data

---
#### Constructors
##### `ContactAccountWrapper(sObject ca, String objectType)`
---
#### Properties

##### `contactAccount` → `sObject`

##### `type` → `String`

---
