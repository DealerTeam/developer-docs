# SalesUp

`APIVERSION: 49`

`STATUS: ACTIVE`

**Group** Sales

## Methods
### `create(SalesUpWrapper salesUp)`

Creates a sales up and related records

#### Parameters

|Param|Description|
|---|---|
|`salesUp`|wrapper containing all related objects needed for creation|

#### Return

**Type**

dealer__Sales_Up__c

**Description**

return description


**Method** create

---
## Classes
### SalesUpWrapper

Wrapper class to hold sales up and all related objects needed by SalesUpAPI

#### Constructors
##### `SalesUpWrapper(Account buyerAccount, Contact buyerContact, List&lt;Task&gt; tasks, List&lt;Desired_Vehicle__c&gt; desiredVehicles, List&lt;Traffic_Log__c&gt; trafficLogs, Sales_Up__c salesUp, Boolean bypassDupes)`
---
#### Fields

##### `BuyerAccount` → `Account`


List of tasks to be created and related to the sales up

##### `BuyerContact` → `Contact`


when buyer contact is populated and contact is of type person account buyer account will also be populated

##### `BypassDuplicateMatching` → `Boolean`


Determines whether or not duplicate matching rules will apply for related accounts and contacts

##### `DesiredVehicles` → `List&lt;Desired_Vehicle__c&gt;`


List of Desired Vehicles to be created and related to the sales up

##### `SalesUp` → `Sales_Up__c`


Sales up record to be created

##### `Tasks` → `List&lt;Task&gt;`


List of tasks to be created and related to the sales up

##### `TrafficLogs` → `List&lt;Traffic_Log__c&gt;`


List of traffic logs to be created and related to the sales up

---

---
