---
layout: default
---
# ServiceAppointment_EXT



**Group** Service

## Constructors
### `public ServiceAppointment_EXT(ApexPages sc)`
---
## Fields

### `private sa` → `dealer__Service_Appointment__c`


### `public urlParameters` → `Map<String,String>`


### `private util` → `Utility`


### `public advisorList` → `List<User>`


### `public locationList` → `List<cLocation>`


---
## Properties

### `public advisor` → `Id`


### `public sv` → `dealer__Service_Vehicle__c`


### `public sl` → `List<dealer__Service_Appointment_Line__c>`


### `public e` → `Event`


### `public timeString` → `String`


### `public opCodeId` → `String`


### `public opCodeName` → `String`


### `public lineConcern` → `String`


### `public opCodeDescription` → `String`


### `public payType` → `String`


### `public estimate` → `String`


### `public booktime` → `Decimal`


### `public apptDay` → `String`


### `public apptMonth` → `String`


### `public apptYear` → `String`


### `public renderDecodeButt` → `Boolean`


### `public myDealershipId` → `Id`


---
## Methods
### `public void getJobLines()`
### `public String getServiceHistoryJSON()`
### `public PageReference create()`
### `public PageReference addJobLine()`
### `public List<User> advisorList()`
### `public List<User> getAdvisorList()`
### `public String getAdvisorResourceJSON()`
### `public static List<cLocation> buildLocUserList()`
### `public static List<cLocation> buildLocUserList(string SearchAsk)`
### `public static List<cLocation> buildLocUserList(Id locId)`
### `public static String getLocationsJSON()`
### `public static String getLocationSearch(String searchAsk)`
### `public List<cLocation> getLocationList()`
### `public String getAppointmentColors()`
### `public Decimal getAppointmentDuration()`
### `public String getSelectedAdvisors()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getSelectedAdvisors


**Notes** returns a valid json string containing a list of advisors.

### `public String getCalendarEventsJSON()`
### `public String getDefaultLocation()`
### `public String getLastLocationId()`

**Method** getLastLocationId


**Notes** Used by the scheduler page to provide the last location used within the scheduler.

### `public static void setSchedulerView(String viewName)`

`REMOTEACTION`

Save current Service Scheduler view to the Users custom setting

#### Parameters

|Param|Description|
|---|---|
|`viewName`|viewName description|

### `public static List<Service_Appointment__c> getCalendarEvents()`

`REMOTEACTION`

**Method** getCalendarEvents


**Notes** RemoteAction returning events related to service appointments

### `public static List<cContact> contactUpdateInsert(String contactJSON)`

`REMOTEACTION`
### `public static List<cContact> createServiceVehicleIgnore(String contactJSON)`

`REMOTEACTION`
### `public static cVehicle createServiceVehicle(String vehicleJSON)`

`REMOTEACTION`
### `public static Map<String,Object> decodedVin(String vin)`

`REMOTEACTION`
### `public static List<dealer__Service_Job__c> getJobListHistory(String vehicleId)`

`REMOTEACTION`
### `public static boolean updateAdvisorSelectionRemote(String advIds)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`String`|[json string of advisor id's]|

#### Returns

|Type|Description|
|---|---|
|`boolean`|Boolean|


**Method** updateAdvisorSelectionRemote


**Notes** updated to use a lightweight object to store the values, custom setting textarea (255) was insufficient.

### `public static boolean updateDefaultLocation(String locId)`

`REMOTEACTION`
### `public static boolean deleteSAline(String lineId)`

`REMOTEACTION`
### `public static Service_Repair_Order__c convertAppointment(String serviceAppointmentId)`

`REMOTEACTION`
---
## Classes
### customException

**Inheritance**

customException


### cContact
#### Constructors
##### `public cContact(Account c)`
##### `public cContact(sObject c)`
---
#### Properties

##### `public custId` → `String`


##### `public Name` → `String`


##### `public custEmail` → `String`


##### `public custPhone` → `String`


##### `public custMobilePhone` → `String`


##### `public custHomePhone` → `String`


---

### cVehicle
#### Constructors
##### `public cVehicle(dealer__Service_Vehicle__c v)`
---
#### Properties

##### `public con` → `dealer__Service_Vehicle__c`


##### `public custid` → `String`


##### `public id` → `String`


##### `public name` → `String`


##### `public licence` → `String`


##### `public vin` → `String`


##### `public modelCode` → `String`


##### `public year` → `String`


##### `public make` → `String`


##### `public model` → `String`


##### `public trim` → `String`


---

### cLocation
#### Constructors
##### `public cLocation(dealer__Dealer_Location__c l, List&lt;cMember&gt; ml)`
---
#### Properties

##### `public Id` → `String`


##### `public Name` → `String`


##### `public aptLength` → `Decimal`


##### `public OpenHour` → `String`


##### `public CloseHour` → `String`


##### `public companyNumber` → `String`


##### `public Members` → `List&lt;cMember&gt;`


---

### cMember
#### Constructors
##### `public cMember(String l_id, String l_name)`
---
#### Properties

##### `public id` → `String`


##### `public name` → `String`


---

---
