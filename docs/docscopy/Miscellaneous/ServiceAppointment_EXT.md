---
layout: default
---
# ServiceAppointment_EXT class
---
## Constructors
### `ServiceAppointment_EXT(ApexPages.Standardcontroller sc)`
---
## Properties

### `advisor` → `Id`

### `advisorList` → `List<User>`

### `apptDay` → `String`

### `apptMonth` → `String`

### `apptYear` → `String`

### `booktime` → `Decimal`

### `e` → `Ev`

### `estimate` → `String`

### `lineConcern` → `String`

### `locationList` → `List<cLocation>`

### `myDealershipId` → `Id`

### `opCodeDescription` → `String`

### `opCodeId` → `String`

### `opCodeName` → `String`

### `payType` → `String`

### `renderDecodeButt` → `Boolean`

### `sl` → `List<dealer__Service_Appointment_Line__c>`

### `sv` → `dealer__Service_Vehicle__c`

### `timeString` → `String`

### `urlParameters` → `String>`

---
## Methods
### `addJobLine()` → `PageReference`
### `advisorList()` → `List<User>`
### `buildLocUserList()` → `List<cLocation>`
### `buildLocUserList(string SearchAsk)` → `List<cLocation>`
### `buildLocUserList(Id locId)` → `List<cLocation>`
### `contactUpdateInsert(String contactJSON)` → `List<cContact>`
### `create()` → `PageReference`
### `createServiceVehicle(String vehicleJSON)` → `cVehicle`
### `createServiceVehicleIgnore(String contactJSON)` → `List<cContact>`
### `decodedVin(String vin)` → `Map<String,Object>`
### `deleteSAline(String lineId)` → `boolean`
### `getAdvisorList()` → `List<User>`
### `getAdvisorResourceJSON()` → `String`
### `getAppointmentColors()` → `String`
### `getAppointmentDuration()` → `Decimal`
### `getCalendarEvents()` → `List<Service_Appointment__c>`

 getCalendarEvents @notes RemoteAction returning events related to service appointments

### `getCalendarEventsJSON()` → `String`
### `getDefaultLocation()` → `String`
### `getJobLines()` → `void`
### `getJobListHistory(String vehicleId)` → `List<dealer__Service_Job__c>`
### `getLastLocationId()` → `String`

 getLastLocationId @notes Used by the scheduler page to provide the last location used within the scheduler.

### `getLocationList()` → `List<cLocation>`
### `getLocationSearch(String searchAsk)` → `String`
### `getLocationsJSON()` → `String`
### `getSelectedAdvisors()` → `String`

 getSelectedAdvisors

### `getServiceHistoryJSON()` → `String`
### `updateAdvisorSelectionRemote(String advIds)` → `boolean`

 updateAdvisorSelectionRemote

#### Parameters
|Param|Description|
|-----|-----------|
|`String` |  [json string of advisor id's] |

### `updateDefaultLocation(String locId)` → `boolean`
---
## Inner Classes

### ServiceAppointment_EXT.cContact class
---
#### Constructors
##### `cContact( Account c )`
##### `cContact( sObject c )`
---
#### Properties

##### `Name` → `String`

##### `custEmail` → `String`

##### `custHomePhone` → `String`

##### `custId` → `String`

##### `custMobilePhone` → `String`

##### `custPhone` → `String`

---
### ServiceAppointment_EXT.cLocation class
---
#### Constructors
##### `cLocation(dealer__Dealer_Location__c l, List<cMember> ml)`
---
#### Properties

##### `CloseHour` → `String`

##### `Id` → `String`

##### `Members` → `List<cMember>`

##### `Name` → `String`

##### `OpenHour` → `String`

##### `aptLength` → `Decimal`

##### `companyNumber` → `String`

---
### ServiceAppointment_EXT.cMember class
---
#### Constructors
##### `cMember(String l_id , String l_name)`
---
#### Properties

##### `id` → `String`

##### `name` → `String`

---
### ServiceAppointment_EXT.cVehicle class
---
#### Constructors
##### `cVehicle(dealer__Service_Vehicle__c v)`
---
#### Properties

##### `con` → `dealer__Service_Vehicle__c`

##### `custid` → `String`

##### `id` → `String`

##### `licence` → `String`

##### `make` → `String`

##### `model` → `String`

##### `modelCode` → `String`

##### `name` → `String`

##### `trim` → `String`

##### `vin` → `String`

##### `year` → `String`

---
### ServiceAppointment_EXT.customException class
---
