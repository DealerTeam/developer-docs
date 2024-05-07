---
layout: default
---
# ERPAPI

ERPAPI Class is the common class for handling ERP Interaction Requests


**Group** DMS

## Methods
### `public static void handleERPProcess(String eventBusTransactionJSON)`

`FUTURE`

Asynchronously Kicks off an ERP Integration event name with a record Id

#### Parameters

|Param|Description|
|---|---|
|`processName`|DeveloperName of the DMSERPProcess__mdt Custom Metadata Record|
|`recordId`|Record Id of the record to be processed.|

#### Returns

|Type|Description|
|---|---|
|`void`|return description|

### `public static List<ERPTransactionLog__c> handleBulkRecords(DMSRecord__e eventBusTransaction, DMSDataEventAPI bulkData)`

Handles Bulk ERP transaction

#### Parameters

|Param|Description|
|---|---|
|`eventBusTransaction`|DMSRecord__e platform event|
|`bulkData`|DMSDataEventAPI.BulkData holds Event Details. See DMSDataEventAPI class for more details.|

#### Returns

|Type|Description|
|---|---|
|`List<ERPTransactionLog__c>`|return description|

### `public static void handleERPProcessSync(ERPProcess erpProcess, DMSDataEventAPI bulkData)`

Handles single ERP Process Synchronously

#### Parameters

|Param|Description|
|---|---|
|`erpProcess`|DeveloperName of the DMSERPProcess__mdt Custom Metadata Record|
|`bulkData`|DMSDataEventAPI.BulkData holds Event Details. See DMSDataEventAPI class for more details.|

#### Returns

|Type|Description|
|---|---|
|`void`|return description|

### `private static ERPInquiry handleERPDefinedEvent(DMSERPEvent__mdt event, DMSDataEventAPI bulkEvents)`

Helper method to handleERPProcess - Handles multiple defined Process.

#### Parameters

|Param|Description|
|---|---|
|`event`|[DMSERPEvent__mdt](DMSERPEvent__mdt) Metadata definition of the Event|
|`bulkEvents`|[DMSDataEventAPI.BulkEvents](DMSDataEventAPI.BulkEvents) wrapped data|

#### Returns

|Type|Description|
|---|---|
|`ERPInquiry`|[ERPInquiry](../Miscellaneous/ERPInquiry.md) Results of the defiend event.|

### `public static Map<String,Object> querySetupData(String table)`

queryData

### `private static ERPInquiry handleERPEvent(DMSERPEvent__mdt event, DMSDataEventAPI bulkEvents)`

Helper method to handleERPProcess - Handles bulk Events

#### Parameters

|Param|Description|
|---|---|
|`event`|event description|
|`recordId`|recordId description|

#### Returns

|Type|Description|
|---|---|
|`ERPInquiry`|return description|

### `public static Map<String,String> eventDataMap(String recordId)`

Builds and maps data for ERP Events. Store Id, CompanyId, requesting user etc. DEPRECATE

### `public static Map<String,Map<String,String>> eventDataMap(Set<String> recordIds)`

Handles single ERP Process Synchronously

#### Parameters

|Param|Description|
|---|---|
|`recordIds`|Set<String> records to process|

#### Returns

|Type|Description|
|---|---|
|`Map<String,Map<String,String>>`|return description|

### `private static void populateDealEventDataMap(Set<String> recordIds, Map<String,Map<String,String>> edMap)`
### `private static void populateAccountEventDataMap(Set<String> recordIds, Map<String,Map<String,String>> edMap)`
### `private static void populateServiceVehicleEventDataMap(Set<String> recordIds, Map<String,Map<String,String>> edMap)`
### `private static void populateVehicleInventoryEventDataMap(Set<String> recordIds, Map<String,Map<String,String>> edMap)`
### `private static void populateSROEventDataMap(Set<String> recordIds, Map<String,Map<String,String>> edMap)`
### `private static void populatePurchaseOrderEventDataMap(Set<String> recordIds, Map<String,Map<String,String>> edMap)`
### `private static void populateEventDataMapDefaultData(Map<String,Map<String,String>> edMap)`
### `public static Map<String,Object> mapSchema(SObjectType sObjType, Map<String,Object> objectData)`

Maps Dealerteam values to Dealerstar-Compatible values based on the sObject's schema. Example: Checkboxes should equate to 'Y', or 'N' in DS.

#### Parameters

|Param|Description|
|---|---|
|`sObjType`||
|`objectData`||


**Group** DMS

---
## Classes
### DefinedRequestBody
#### Constructors
##### `public DefinedRequestBody(Object data, DMSDataEventAPI eventData)`
---
#### Fields

##### `public data` → `Object`


##### `public eventData` → `DMSDataEventAPI`


---

### ERPAPIException

**Inheritance**

ERPAPIException


---
