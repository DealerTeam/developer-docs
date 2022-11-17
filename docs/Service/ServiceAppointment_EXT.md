# ServiceAppointment_EXT

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Service

## Constructors
### `ServiceAppointment_EXT(ApexPages.Standardcontroller sc)`
---
## Fields

### `advisorList` → `List<User>`


### `locationList` → `List<cLocation>`


### `urlParameters` → `Map<String,String>`


---
## Properties

### `advisor` → `Id`


### `apptDay` → `String`


### `apptMonth` → `String`


### `apptYear` → `String`


### `booktime` → `Decimal`


### `e` → `Event`


### `estimate` → `String`


### `lineConcern` → `String`


### `myDealershipId` → `Id`


### `opCodeDescription` → `String`


### `opCodeId` → `String`


### `opCodeName` → `String`


### `payType` → `String`


### `sl` → `List<dealer__Service_Appointment_Line__c>`


### `sv` → `dealer__Service_Vehicle__c`


### `timeString` → `String`


---
## Methods
### `getJobLines()`
### `getServiceHistoryJSON()`
### `create()`
### `addJobLine()`
### `advisorList()`
### `getAdvisorList()`
### `getAdvisorResourceJSON()`
### `static buildLocUserList()`
### `static buildLocUserList(string SearchAsk)`
### `static buildLocUserList(Id locId)`
### `static getLocationsJSON()`
### `static getLocationSearch(String searchAsk)`
### `getLocationList()`
### `getAppointmentColors()`
### `getAppointmentDuration()`
### `getSelectedAdvisors()`
#### Return

**Type**

String

**Description**

String


**Method** getSelectedAdvisors


**Notes** returns a valid json string containing a list of advisors.

### `getCalendarEventsJSON()`
### `getDefaultLocation()`
### `getLastLocationId()`

**Method** getLastLocationId


**Notes** Used by the scheduler page to provide the last location used within the scheduler.

### `static setSchedulerView(String viewName)`

`REMOTEACTION`

Save current Service Scheduler view to the Users custom setting

#### Parameters

|Param|Description|
|---|---|
|`viewName`|viewName description|

### `static getCalendarEvents()`

`REMOTEACTION`

**Method** getCalendarEvents


**Notes** RemoteAction returning events related to service appointments

### `static contactUpdateInsert(String contactJSON)`

`REMOTEACTION`
### `static createServiceVehicleIgnore(String contactJSON)`

`REMOTEACTION`
### `static createServiceVehicle(String vehicleJSON)`

`REMOTEACTION`
### `static decodedVin(String vin)`

`REMOTEACTION`
### `static getJobListHistory(String vehicleId)`

`REMOTEACTION`
### `static updateAdvisorSelectionRemote(String advIds)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`String`|[json string of advisor id's]|

#### Return

**Type**

boolean

**Description**

Boolean


**Method** updateAdvisorSelectionRemote


**Notes** updated to use a lightweight object to store the values, custom setting textarea (255) was insufficient.

### `static updateDefaultLocation(String locId)`

`REMOTEACTION`
### `static deleteSAline(String lineId)`

`REMOTEACTION`
---
## Classes
### cContact
#### Constructors
##### `cContact(Account c)`
##### `cContact(sObject c)`
---
#### Properties

##### `Name` → `String`


##### `custEmail` → `String`


##### `custHomePhone` → `String`


##### `custId` → `String`


##### `custMobilePhone` → `String`


##### `custPhone` → `String`


---

### cLocation
#### Constructors
##### `cLocation(dealer__Dealer_Location__c l, List&lt;cMember&gt; ml)`
---
#### Properties

##### `CloseHour` → `String`


##### `Id` → `String`


##### `Members` → `List&lt;cMember&gt;`


##### `Name` → `String`


##### `OpenHour` → `String`


##### `aptLength` → `Decimal`


##### `companyNumber` → `String`


---

### cMember
#### Constructors
##### `cMember(String l_id, String l_name)`
---
#### Properties

##### `id` → `String`


##### `name` → `String`


---

### cVehicle
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

### customException

**Inheritance**

customException


---
