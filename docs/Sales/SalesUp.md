---
layout: default
---
# SalesUp



**Group** Sales

## Methods
### `global dealer__Sales_Up__c create(SalesUpWrapper salesUp)`

Creates a sales up and related records

#### Parameters

|Param|Description|
|---|---|
|`salesUp`|wrapper containing all related objects needed for creation|

#### Returns

|Type|Description|
|---|---|
|`dealer__Sales_Up__c`|return description|


**Method** create

---
## Classes
### SalesUpWrapper

Wrapper class to hold sales up and all related objects needed by SalesUpAPI

#### Constructors
##### `global SalesUpWrapper(Account buyerAccount, Contact buyerContact, List&lt;Task&gt; tasks, List&lt;Desired_Vehicle__c&gt; desiredVehicles, List&lt;Traffic_Log__c&gt; trafficLogs, Sales_Up__c salesUp, Boolean bypassDupes)`
---
#### Fields

##### `global BypassDuplicateMatching` → `Boolean`


Determines whether or not duplicate matching rules will apply for related accounts and contacts

##### `global Tasks` → `List&lt;Task&gt;`


List of tasks to be created and related to the sales up

##### `global DesiredVehicles` → `List&lt;Desired_Vehicle__c&gt;`


List of Desired Vehicles to be created and related to the sales up

##### `global TrafficLogs` → `List&lt;Traffic_Log__c&gt;`


List of traffic logs to be created and related to the sales up

##### `global BuyerAccount` → `Account`


List of tasks to be created and related to the sales up

##### `global BuyerContact` → `Contact`


when buyer contact is populated and contact is of type person account buyer account will also be populated

##### `global SalesUp` → `Sales_Up__c`


Sales up record to be created

---

---
