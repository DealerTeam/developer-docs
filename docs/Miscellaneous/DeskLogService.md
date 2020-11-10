---
layout: default
---
# DeskLogService class

 DeskLog Service Layer Encapsulation

---
## Methods
### `search(searchContext s)` → `List<DeskLogEntry>`

 search

#### Parameters
|Param|Description|
|-----|-----------|
|`s` |  SearchContext of variables |

---
## Inner Classes

### DeskLogService.DeskLogEntry class

 DeskLogEntry @notes wrapper class defining a desk log entry

---
#### Properties

##### `appointments` → `List<Sales_Appointment__c>`

##### `appraisals` → `List<Appraisal__c>`

##### `deals` → `List<Deal__c>`

##### `desiredVehicles` → `List<Desired_Vehicle__c>`

##### `employees` → `List<SalesUpService.SalesUpEmployee>`

##### `primaryAppointment` → `Sales_Appointment__c`

##### `primaryDeal` → `Deal__c`

##### `primaryTrade` → `Vehicle_Inventory__c`

##### `primaryVehicle` → `Vehicle_Inventory__c`

##### `salesup` → `Sales_Up__c`

##### `trades` → `List<Trade_In__c>`

---
### DeskLogService.searchContext class

 searchContext @notes wrapper for passing the search context to the search method

---
#### Properties

##### `dealType` → `List<String>`

##### `deskManager` → `List<String>`

##### `financeManager` → `List<String>`

##### `fromDate` → `Date`

##### `leadType` → `List<String>`

##### `location` → `List<String>`

##### `rawSearch` → `String`

##### `salesperson1` → `List<String>`

##### `salesperson2` → `List<String>`

##### `toDate` → `Date`

---
