
# ServiceRepairOrderAPI

`APIVERSION: 45`

`STATUS: ACTIVE`

Service Layer Test Description.


**Group** Service

## Methods
### `static createRepairOrderFromDeal(Deal__c dealObject)`

This method serves to create repair orders from deals.  These repair orders are often referred to as delivery repair orders.

#### Parameters

|Param|Description|
|---|---|
|`dealObject`|sObject Deal|

#### Return

**Type**

Service_Repair_Order__c

**Description**

Returns the Service Repair Order sobject created.

### `static createRepairOrderFromEstimate(Service_Estimate__c estimateObject)`

Tbhis method converts a Service Estimate to a Service Repair Order

#### Parameters

|Param|Description|
|---|---|
|`estimateObject`|The estimateObject parameter is a complete or at minimum stored Service Estimate including Record ID|

#### Return

**Type**

Service_Repair_Order__c

**Description**

Returns a Service Repair Order

### `static createJobLinesFromDeal(Deal__c dealObject)`
### `static invoke(List<InvocableParams> params)`

`INVOCABLEMETHOD`

Method used to call supported methods via invocable apex

#### Parameters

|Param|Description|
|---|---|
|`params`|params description|

#### Return

**Type**

List&lt;InvocableResponse&gt;

**Description**

return description


**Method** invoke

---
## Classes
### InvocableParams

Wrapper to hold all invocable variable inputs needed for invoke method

#### Fields

##### `jobLines` → `List&lt;Service_Job__c&gt;`

`INVOCABLEVARIABLE` 

##### `methodName` → `String`

`INVOCABLEVARIABLE` 

##### `partLines` → `List&lt;Parts_Invoice_Line__c&gt;`

`INVOCABLEVARIABLE` 

---

### InvocableResponse

Wrapper to hold data returned by invocable

#### Fields

##### `jobLines` → `List&lt;Service_Job__c&gt;`

`INVOCABLEVARIABLE` 

##### `message` → `String`

`INVOCABLEVARIABLE` 

##### `partLines` → `List&lt;Parts_Invoice_Line__c&gt;`

`INVOCABLEVARIABLE` 

##### `status` → `String`

`INVOCABLEVARIABLE` 

---

### ServiceRepairOrderAPIException

---
