---
layout: default
---
# RentalScheduleControl

Controller for RentalSchedule.vfp


**Group** Rental

## Constructors
### `public RentalScheduleControl(ApexPages sc)`
---
## Properties

### `public vi` → `dealer__Vehicle_Inventory__c`


---
## Methods
### `public static List<dealer__Vehicle_Inventory__c> getVehiclesJSON(String locId, String region)`

`REMOTEACTION`
### `public static List<Contact> getCustomersJSON(String customerFilter)`

`REMOTEACTION`
### `public static List<ContactAccountWrapper> getCustomersAccountJSON(String customerFilter)`

`REMOTEACTION`
### `public static List<dealer__Rental_Rates__c> getRatesJSON()`

`REMOTEACTION`
### `public static void deleteRentalEvent(String rentalId)`

`REMOTEACTION`
### `public static List<dealer__Rental_Schedule_Event__c> getRentalEventsJSON(String locId)`

`REMOTEACTION`
### `public static String getUserLocation()`

`REMOTEACTION`
### `public static List<dealer__Dealer_Location__c> getLocationsJSON(String region)`

`REMOTEACTION`
### `public static List<dealer__Region__c> getRegionsJSON()`

`REMOTEACTION`
### `public static boolean saveEvent(List<dealer__Rental_Schedule_Event__c> eventData)`

`REMOTEACTION`
### `private static boolean checkEventOverbooked(dealer__Rental_Schedule_Event__c rentalSchedule)`
### `public static String getRentalColors()`
### `public static List<String> getFieldSets()`
### `public static List<String> getRequiredFields()`
### `public static String toProperCase(String value)`
---
## Classes
### ContactAccountWrapper
#### Constructors
##### `public ContactAccountWrapper(sObject ca, String objectType)`
---
#### Properties

##### `public contactAccount` → `sObject`


##### `public type` → `String`


---

---
