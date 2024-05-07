---
layout: default
---
# ServiceRepairOrderController
## Methods
### `public static ServiceRepairOrder getSRO(Id sroId)`

`AURAENABLED`

returns SRO object with all related records

#### Parameters

|Param|Description|
|---|---|
|`sroId`|sroId description|

#### Returns

|Type|Description|
|---|---|
|`ServiceRepairOrder`|return description|


**Method** getSRO

### `public static List<Service_Job__c> createLineFromCode(Id codeId, Id sroId, Service_Job__c job)`

`AURAENABLED`

creates a new service job with any applicable related records like Invoice Lines or Tech Times

#### Parameters

|Param|Description|
|---|---|
|`codeId`|codeId description|
|`sroId`|sroId description|
|`job`|job description|

#### Returns

|Type|Description|
|---|---|
|`List<Service_Job__c>`|return description|


**Method** createLineFromCode

### `public static List<Service_Job__c> saveJobLine(Service_Job__c job)`

`AURAENABLED`

Save a job line and force recalculation of header and job lines

#### Parameters

|Param|Description|
|---|---|
|`job`|Service Job to save, Service_Repair_Order__c must be populated on the line|

#### Returns

|Type|Description|
|---|---|
|`List<Service_Job__c>`|return description|

### `public static Boolean deleteJobLine(Id jobId)`

`AURAENABLED`

deletes a service job line

#### Parameters

|Param|Description|
|---|---|
|`jobId`|jobId description|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|


**Method** deleteJobLine

### `public static Boolean deleteTechTime(Id timeId)`

`AURAENABLED`

deletes a tech time and recalculates the service job

#### Parameters

|Param|Description|
|---|---|
|`timeId`|timeId description|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|


**Method** deleteTechTime

### `public static Boolean deletePartLine(Id lineId)`

`AURAENABLED`

deletes a parts invoice line and recalculates the service job

#### Parameters

|Param|Description|
|---|---|
|`lineId`|lineId description|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|


**Method** deletePartLine

### `public static SObject getRecord(Id recordId)`

`AURAENABLED`

queries and returns a record with security enforced

#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|

#### Returns

|Type|Description|
|---|---|
|`SObject`|return description|


**Method** getRecord

### `public static Boolean saveTechTime(Technician_Job_Time__c tt, String timeType, Boolean calculateTime)`

`AURAENABLED`

Creates or updates a tech time and recalculates the service job

#### Parameters

|Param|Description|
|---|---|
|`tt`|tt description|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|


**Method** saveTechTime

### `public static Service_Job__c saveJobDiscount(Service_Job__c job)`

`AURAENABLED`

calls ServiceRepairOrderAPI to update job and sro discounts

#### Parameters

|Param|Description|
|---|---|
|`job`|- service job to update|

#### Returns

|Type|Description|
|---|---|
|`Service_Job__c`|return - updated service job or validation exception|


**Method** saveJobDiscount

### `public static Boolean savePartLines(List<Parts_invoice_Line__c> lines, Map<Id,List<Parts_Ledger__c>> ledgersByPart, Boolean skipRelateLedgers)`

`AURAENABLED`

Insert or updates a parts invoice line related to a service job and recalculates job

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|


**Method** savePartLines

### `public static Map<Id,List<Parts_Ledger__c>> getLedgersToReserve(Map<Id,Integer> partMap)`

`AURAENABLED`
### `public static string getPartsPORT(String recordType)`

`AURAENABLED`

returns the record type Id of the provided PO recordtype developer name

#### Returns

|Type|Description|
|---|---|
|`string`|return description|


**Method** getPartsPORT

### `public static List<LookupSearchResult> searchPurchaseOrders(String searchTerm, String sroId)`

`AURAENABLED`

Search for POs matching a search term and sro Id

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|searchTerm description|
|`sroId`|sroId description|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return description|


**Method** searchPurchaseOrders

### `public static List<LookupSearchResult> getSelection(Id recordId)`

`AURAENABLED`

returns lookupSearchResult for an Id and object name

#### Parameters

|Param|Description|
|---|---|
|`recordId`|Id of record to get lookupsearchresult to display in lookup component|
|`objectName`|api name of the object for matching correct lookupsearch class|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult> a single result in the list for populating lookup component|


**Method** getSelection

### `public static List<LookupSearchResult> relatedPurchaseOrders(String sroId)`

`AURAENABLED`

Returns recently viewed PO records

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static List<LookupSearchResult> searchMiscCodes(String searchTerm, String locId)`

`AURAENABLED`

returns MiscChargeCodes related to a location and searchTerm

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|searchTerm description|
|`locId`|locId description|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return description|


**Method** searchMiscCodes

### `public static List<LookupSearchResult> recentMiscCodes(String locId)`

`AURAENABLED`

returns recent misc codes related to location

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|searchTerm description|
|`locId`|locId description|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return description|


**Method** searchMiscCodes

### `public static Boolean saveMisc(Service_Misc_Charge__c charge, Id roId)`

`AURAENABLED`

Save a service misc charge and recalculate totals

#### Parameters

|Param|Description|
|---|---|
|`charge`|charge description|
|`roId`|roId description|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|


**Method** saveMisc

### `public static Boolean deleteMisc(Id chargeId, Id jobId)`

`AURAENABLED`

Delete a service misc charge and recalculate totals

#### Parameters

|Param|Description|
|---|---|
|`chargeId`|chargeId description|
|`jobId`|jobId description|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|


**Method** deleteMisc

### `public static Boolean updateStatus(List<Id> lineIds, String status)`

`AURAENABLED`

performs a bulk update of the status field on job lines

#### Parameters

|Param|Description|
|---|---|
|`lineIds`|lineIds description|
|`status`|status description|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|


**Method** updateStatus

### `public static List<Parts_Invoice_Line__c> getPartLinesByJob(Id jobId)`

`AURAENABLED`

returns part lines related to the single service job line id provided

#### Parameters

|Param|Description|
|---|---|
|`jobId`|jobId description|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Invoice_Line__c>`|return description|


**Method** getPartLinesByJob

### `public static List<Service_Job__c> getJobLines(Id sroId)`

`AURAENABLED`

returns part lines related to the single service job line id provided

#### Parameters

|Param|Description|
|---|---|
|`jobId`|jobId description|

#### Returns

|Type|Description|
|---|---|
|`List<Service_Job__c>`|return description|


**Method** getPartLinesByJob

### `private static Decimal getLaborRate(Technician_Job_Time__c tt)`

returns labor rate from Operation Code related to the parent job line

#### Parameters

|Param|Description|
|---|---|
|`tt`|tt description|

#### Returns

|Type|Description|
|---|---|
|`Decimal`|return description|


**Method** getLaborRate

### `public static Boolean actualTimeEnabled()`

`AURAENABLED`

determines if the actual time clock should show for technicians on the SRO

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean - determines if AllowActualTimes DMS setting is enabled|


**Method** actualTimeEnabled

### `public static List<Dealer_Location_User__c> getSroUser(Id locationId)`

`AURAENABLED`

search dealer location users related to a location for a given string

#### Parameters

|Param|Description|
|---|---|
|`locationId`|sro location to verify users against|

#### Returns

|Type|Description|
|---|---|
|`List<Dealer_Location_User__c>`|List<Dealer_Location_User__c> current running user|


**Method** getSroUser

### `public static List<LookupSearchResult> recentDLUs(String locId)`

`AURAENABLED`

Returns recently viewed DLU records

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static List<LookupSearchResult> searchDLUs(String searchTerm, String locId)`

`AURAENABLED`

search dealer location users related to a location for a given string

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|term to search|
|`locId`|location to find users from|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult> dealer location users to display in lookup component|


**Method** searchDLUs

### `public static List<LookupSearchResult> selectedTech(String userId)`

`AURAENABLED`

returns Technician for populating lookup based on id

#### Parameters

|Param|Description|
|---|---|
|`userId`|- user to populate lookup with|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<lookupSearchResult>|


**Method** selectedTech

### `public static Utility getUserRecord()`

`AURAENABLED`

returns wrapped user object with assigned location

#### Returns

|Type|Description|
|---|---|
|`Utility`|user record and location object|


**Method** getUserRecord

### `public static Decimal getLaborRate(Id lineId)`

`AURAENABLED`

Returns the default labor rate for a Service Job based on Op Code and Location

#### Parameters

|Param|Description|
|---|---|
|`line`|line description|

#### Returns

|Type|Description|
|---|---|
|`Decimal`|return description|


**Method** getLaborRate

---
