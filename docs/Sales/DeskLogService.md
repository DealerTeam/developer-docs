# DeskLogService

`APIVERSION: 45`

`STATUS: ACTIVE`

DeskLog Service Layer Encapsulation


**Group** Sales

## Methods
### `static search(searchContext s)`
#### Parameters

|Param|Description|
|---|---|
|`s`|SearchContext of variables|

#### Return

**Type**

List&lt;DeskLogEntry&gt;

**Description**

List&lt;DeskLogEntry&gt;


**Method** search


**Notes** performs the search and return of desk log entries

---
## Classes
### DeskLogEntry

wrapper class defining a desk log entry

#### Properties

##### `appointments` → `List&lt;Sales_Appointment__c&gt;`


##### `appraisals` → `List&lt;Appraisal__c&gt;`


##### `deals` → `List&lt;Deal__c&gt;`


##### `desiredVehicles` → `List&lt;Desired_Vehicle__c&gt;`


##### `employees` → `List&lt;SalesUpService.SalesUpEmployee&gt;`


##### `primaryAppointment` → `Sales_Appointment__c`


##### `primaryDeal` → `Deal__c`


##### `primaryTrade` → `Vehicle_Inventory__c`


##### `primaryVehicle` → `Vehicle_Inventory__c`


##### `salesup` → `Sales_Up__c`


##### `trades` → `List&lt;Trade_In__c&gt;`


---

### searchContext

wrapper for passing the search context to the search method

#### Properties

##### `dealType` → `List&lt;String&gt;`


##### `deskManager` → `List&lt;String&gt;`


##### `financeManager` → `List&lt;String&gt;`


##### `fromDate` → `Date`


##### `leadType` → `List&lt;String&gt;`


##### `location` → `List&lt;String&gt;`


##### `rawSearch` → `String`


##### `salesperson1` → `List&lt;String&gt;`


##### `salesperson2` → `List&lt;String&gt;`


##### `toDate` → `Date`


---

---
