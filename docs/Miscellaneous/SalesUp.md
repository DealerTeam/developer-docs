---
layout: default
---
# SalesUp class
---
## Methods
### `create(SalesUpWrapper salesUp)` → `dealer__Sales_Up__c`

Creates a sales up and related records

#### Parameters
|Param|Description|
|-----|-----------|
|`salesUp` |  wrapper containing all related objects needed for creation |

---
## Inner Classes

### SalesUp.SalesUpWrapper class

Wrapper class to hold sales up and all related objects needed by SalesUpAPI

---
#### Constructors
##### `SalesUpWrapper(Account buyerAccount, Contact buyerContact, List<Task> tasks, List<Desired_Vehicle__c> desiredVehicles, List<Traffic_Log__c> trafficLogs, Sales_Up__c salesUp, Boolean bypassDupes)`
---
#### Properties

##### `BuyerAccount` → `Account`

List of tasks to be created and related to the sales up

##### `BuyerContact` → `Contact`

when buyer contact is populated and contact is of type person account buyer account will also be populated

##### `BypassDuplicateMatching` → `Boolean`

 Determines whether or not duplicate matching rules will apply for related accounts and contacts

##### `DesiredVehicles` → `List<Desired_Vehicle__c>`

List of Desired Vehicles to be created and related to the sales up

##### `SalesUp` → `Sales_Up__c`

Sales up record to be created

##### `Tasks` → `List<Task>`

List of tasks to be created and related to the sales up

##### `TrafficLogs` → `List<Traffic_Log__c>`

List of traffic logs to be created and related to the sales up

---
