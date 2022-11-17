# ServiceRepairOrderAPI

`APIVERSION: 45`

`STATUS: ACTIVE`

Service Layer Encapsulation of interaction with the Repair Order Object.


**Group** Service

## Fields

### `PREVENT_TAX_UPDATE_STATUS` → `List<String>`


### `totalDisc` → `Boolean`


### `totalLabor` → `Boolean`


### `totalMisc` → `Boolean`


### `totalParts` → `Boolean`


---
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

### `static cashTransactions(String sroId)`
### `static getJobLinesByRO(Id sroId)`
### `static deleteJobLines(Set<Id> jobIds)`

Accepts a list of job line Ids and deletes them using standard dml

#### Parameters

|Param|Description|
|---|---|
|`jobIds`|jobIds description|

#### Return

**Type**

Boolean

**Description**

return description


**Method** deleteJobLines

### `static createLineFromCode(StandardOpCode__c opCode, Id sroId, Service_Job__c j)`

Gets data from op code and creates a new service job and sublines with save job method

#### Parameters

|Param|Description|
|---|---|
|`StandardOpCode__c`|opCode code containing data used to create new line|
|`Id`|sroId Id of the parent Service Repair Order|

#### Return

**Type**

List&lt;Service_Job__c&gt;

**Description**

String


**Method** createLineFromCode

### `static setTechTimeName(Technician_Job_Time__c tt, String timeType)`

populates the tech time name based on type

#### Parameters

|Param|Description|
|---|---|
|`tt`|tt description|
|`timeType`|timeType description|

#### Return

**Type**

Technician_Job_Time__c

**Description**

return description


**Method** setTechTimeName

### `static saveTechTime(Technician_Job_Time__c tt)`
### `static deleteTechTime(Id techTimeId)`
### `static savePartLines(List<Parts_Invoice_Line__c> lines)`

Creates or updates a Parts Invoice Line related to a Service Job and recalculates Service Job

#### Parameters

|Param|Description|
|---|---|
|`line`|line description|

#### Return

**Type**

List&lt;Parts_Invoice_Line__c&gt;

**Description**

return description


**Method** savePartLines

### `static deletePartLine(Id lineId)`
### `static createJobLinesFromDeal(Deal__c dealObject)`
### `static calculateAndSave(ServiceRepairOrder roWrapper)`
#### Parameters

|Param|Description|
|---|---|
|`roWrapper`|roWrapper description|

#### Return

**Type**

ServiceRepairOrder

**Description**

return description


**Method** calculateAndSave

### `static lineTotalParts(ServiceRepairOrder sroWrapper)`
### `static lineTotalLabor(ServiceRepairOrder sroWrapper)`

Aggregates tech time pricing to calculate Service Job labor totals

#### Parameters

|Param|Description|
|---|---|
|`sroWrapper`|sroWrapper description|

#### Return

**Type**

ServiceRepairOrder

**Description**

return description


**Method** lineTotalLabor

### `static saveMisc(Service_Misc_Charge__c charge, Id roId)`
### `static saveDiscount(Service_Job__c job)`

method called from UI components for saving service job discounts

#### Parameters

|Param|Description|
|---|---|
|`job`|- job to discoun|

#### Return

**Type**

Service_Job__c

**Description**

return - discounted job or LWC ingestable exception


**Method** saveDiscount

### `static deleteMisc(Id chargeId, Id serviceJobId)`
### `static invoiceRepairOrder(Id sroId)`

Method for checking if SRO meets proper invoice conditions before updating status

#### Parameters

|Param|Description|
|---|---|
|`sroId`|Id of SRO to set to invoiced status|


**Method** invoiceRepairOrder

### `static postRepairOrder(Service_Repair_Order__c sro)`

Method for checking if SRO meets proper posting conditions before updating status

#### Parameters

|Param|Description|
|---|---|
|`sro`|SRO to set to posted status|


**Method** postRepairOrder

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

### `static findRecent()`

`AURAENABLED`
### `static findRoByName(String searchContext)`

`AURAENABLED`
### `static findById(Id roId)`

`AURAENABLED`
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

##### `repairOrder` → `Service_Repair_Order__c`

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

**Inheritance**

ServiceRepairOrderAPIException


---
