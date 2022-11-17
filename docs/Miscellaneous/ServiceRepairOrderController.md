# ServiceRepairOrderController

`APIVERSION: 52`

`STATUS: ACTIVE`
## Methods
### `static getSRO(Id sroId)`

`AURAENABLED`

returns SRO object with all related records

#### Parameters

|Param|Description|
|---|---|
|`sroId`|sroId description|

#### Return

**Type**

ServiceRepairOrder

**Description**

return description


**Method** getSRO

### `static createLineFromCode(Id codeId, Id sroId, Service_Job__c job)`

`AURAENABLED`

creates a new service job with any applicable related records like Invoice Lines or Tech Times

#### Parameters

|Param|Description|
|---|---|
|`codeId`|codeId description|
|`sroId`|sroId description|
|`job`|job description|

#### Return

**Type**

List&lt;Service_Job__c&gt;

**Description**

return description


**Method** createLineFromCode

### `static deleteJobLine(Id jobId)`

`AURAENABLED`

deletes a service job line

#### Parameters

|Param|Description|
|---|---|
|`jobId`|jobId description|

#### Return

**Type**

Boolean

**Description**

return description


**Method** deleteJobLine

### `static deleteTechTime(Id timeId)`

`AURAENABLED`

deletes a tech time and recalculates the service job

#### Parameters

|Param|Description|
|---|---|
|`timeId`|timeId description|

#### Return

**Type**

Boolean

**Description**

return description


**Method** deleteTechTime

### `static deletePartLine(Id lineId)`

`AURAENABLED`

deletes a parts invoice line and recalculates the service job

#### Parameters

|Param|Description|
|---|---|
|`lineId`|lineId description|

#### Return

**Type**

Boolean

**Description**

return description


**Method** deletePartLine

### `static getRecord(Id recordId)`

`AURAENABLED`

queries and returns a record with security enforced

#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|

#### Return

**Type**

SObject

**Description**

return description


**Method** getRecord

### `static saveTechTime(Technician_Job_Time__c tt, String timeType, Boolean calculateTime)`

`AURAENABLED`

Creates or updates a tech time and recalculates the service job

#### Parameters

|Param|Description|
|---|---|
|`tt`|tt description|

#### Return

**Type**

Boolean

**Description**

return description


**Method** saveTechTime

### `static saveJobDiscount(Service_Job__c job)`

`AURAENABLED`

calls ServiceRepairOrderAPI to update job and sro discounts

#### Parameters

|Param|Description|
|---|---|
|`job`|- service job to update|

#### Return

**Type**

Service_Job__c

**Description**

return - updated service job or validation exception


**Method** saveJobDiscount

### `static savePartLines(List<Parts_invoice_Line__c> lines)`

`AURAENABLED`

Insert or updates a parts invoice line related to a service job and recalculates job

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|

#### Return

**Type**

Boolean

**Description**

return description


**Method** savePartLines

### `static getPartsPORT(String recordType)`

`AURAENABLED`

returns the record type Id of the provided PO recordtype developer name

#### Return

**Type**

string

**Description**

return description


**Method** getPartsPORT

### `static searchPurchaseOrders(String searchTerm, String sroId)`

`AURAENABLED`

Search for POs matching a search term and sro Id

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|searchTerm description|
|`sroId`|sroId description|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

return description


**Method** searchPurchaseOrders

### `static getSelection(Id recordId)`

`AURAENABLED`

returns lookupSearchResult for an Id and object name

#### Parameters

|Param|Description|
|---|---|
|`recordId`|Id of record to get lookupsearchresult to display in lookup component|
|`objectName`|api name of the object for matching correct lookupsearch class|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt; a single result in the list for populating lookup component


**Method** getSelection

### `static relatedPurchaseOrders(String sroId)`

`AURAENABLED`

Returns recently viewed PO records

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt;

### `static searchMiscCodes(String searchTerm, String locId)`

`AURAENABLED`

returns MiscChargeCodes related to a location and searchTerm

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|searchTerm description|
|`locId`|locId description|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

return description


**Method** searchMiscCodes

### `static recentMiscCodes(String locId)`

`AURAENABLED`

returns recent misc codes related to location

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|searchTerm description|
|`locId`|locId description|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

return description


**Method** searchMiscCodes

### `static saveMisc(Service_Misc_Charge__c charge, Id roId)`

`AURAENABLED`

Save a service misc charge and recalculate totals

#### Parameters

|Param|Description|
|---|---|
|`charge`|charge description|
|`roId`|roId description|

#### Return

**Type**

Boolean

**Description**

return description


**Method** saveMisc

### `static deleteMisc(Id chargeId, Id jobId)`

`AURAENABLED`

Delete a service misc charge and recalculate totals

#### Parameters

|Param|Description|
|---|---|
|`chargeId`|chargeId description|
|`jobId`|jobId description|

#### Return

**Type**

Boolean

**Description**

return description


**Method** deleteMisc

### `static updateStatus(List<Id> lineIds, String status)`

`AURAENABLED`

performs a bulk update of the status field on job lines

#### Parameters

|Param|Description|
|---|---|
|`lineIds`|lineIds description|
|`status`|status description|

#### Return

**Type**

Boolean

**Description**

return description


**Method** updateStatus

### `static getPartLinesByJob(Id jobId)`

`AURAENABLED`

returns part lines related to the single service job line id provided

#### Parameters

|Param|Description|
|---|---|
|`jobId`|jobId description|

#### Return

**Type**

List&lt;Parts_Invoice_Line__c&gt;

**Description**

return description


**Method** getPartLinesByJob

### `static actualTimeEnabled()`

`AURAENABLED`

determines if the actual time clock should show for technicians on the SRO

#### Return

**Type**

Boolean

**Description**

Boolean - determines if AllowActualTimes DMS setting is enabled


**Method** actualTimeEnabled

### `static getSroUser(Id locationId)`

`AURAENABLED`

search dealer location users related to a location for a given string

#### Parameters

|Param|Description|
|---|---|
|`locationId`|sro location to verify users against|

#### Return

**Type**

List&lt;Dealer_Location_User__c&gt;

**Description**

List&lt;Dealer_Location_User__c&gt; current running user


**Method** getSroUser

### `static recentDLUs(String locId)`

`AURAENABLED`

Returns recently viewed DLU records

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt;

### `static searchDLUs(String searchTerm, String locId)`

`AURAENABLED`

search dealer location users related to a location for a given string

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|term to search|
|`locId`|location to find users from|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt; dealer location users to display in lookup component


**Method** searchDLUs

### `static selectedTech(String userId)`

`AURAENABLED`

returns Technician for populating lookup based on id

#### Parameters

|Param|Description|
|---|---|
|`userId`|- user to populate lookup with|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;lookupSearchResult&gt;


**Method** selectedTech

### `static getUserRecord()`

`AURAENABLED`

returns wrapped user object with assigned location

#### Return

**Type**

Utility.UserInformation

**Description**

user record and location object


**Method** getUserRecord

### `static getLaborRate(Id lineId)`

`AURAENABLED`

Returns the default labor rate for a Service Job based on Op Code and Location

#### Parameters

|Param|Description|
|---|---|
|`line`|line description|

#### Return

**Type**

Decimal

**Description**

return description


**Method** getLaborRate

---
