---
layout: default
---
# DeskLogService

DeskLog Service Layer Encapsulation


**Group** Sales

## Methods
### `public static List<DeskLogEntry> search(searchContext s)`
#### Parameters

|Param|Description|
|---|---|
|`s`|SearchContext of variables|

#### Returns

|Type|Description|
|---|---|
|`List<DeskLogEntry>`|List<DeskLogEntry>|


**Method** search


**Notes** performs the search and return of desk log entries

---
## Classes
### DeskLogEntry

wrapper class defining a desk log entry

#### Properties

##### `public salesup` → `Sales_Up__c`


##### `public primaryDeal` → `Deal__c`


##### `public primaryAppointment` → `Sales_Appointment__c`


##### `public primaryVehicle` → `Vehicle_Inventory__c`


##### `public primaryTrade` → `Vehicle_Inventory__c`


##### `public deals` → `List&lt;Deal__c&gt;`


##### `public appointments` → `List&lt;Sales_Appointment__c&gt;`


##### `public desiredVehicles` → `List&lt;Desired_Vehicle__c&gt;`


##### `public trades` → `List&lt;Trade_In__c&gt;`


##### `public employees` → `List&lt;SalesUpService.SalesUpEmployee&gt;`


##### `public appraisals` → `List&lt;Appraisal__c&gt;`


---

### searchContext

wrapper for passing the search context to the search method

#### Properties

##### `public fromDate` → `Date`


##### `public toDate` → `Date`


##### `public rawSearch` → `String`


##### `public leadType` → `List&lt;String&gt;`


##### `public dealType` → `List&lt;String&gt;`


##### `public location` → `List&lt;String&gt;`


##### `public salesperson1` → `List&lt;String&gt;`


##### `public salesperson2` → `List&lt;String&gt;`


##### `public deskManager` → `List&lt;String&gt;`


##### `public financeManager` → `List&lt;String&gt;`


---

---
