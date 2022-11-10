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
##### Other

* `BuyerAccount` → `Account` (*Inherited*)   - List of tasks to be created and related to the sales up
* `BuyerContact` → `Contact` (*Inherited*)   - when buyer contact is populated and contact is of type person account buyer account will also be populated
* `BypassDuplicateMatching` → `Boolean` (*Inherited*)   - Determines whether or not duplicate matching rules will apply for related accounts and contacts
* `SalesUp` → `Sales_Up__c` (*Inherited*)   - Sales up record to be created
* `TrafficLogs` → `List&lt;Traffic_Log__c&gt;` (*Inherited*)   - List of traffic logs to be created and related to the sales up
---
##### Related Objects

* `DesiredVehicles` → `List&lt;Desired_Vehicle__c&gt;` (*Inherited*)  
* `Tasks` → `List&lt;Task&gt;` (*Inherited*)  
---

---
