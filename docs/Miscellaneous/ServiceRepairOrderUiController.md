---
layout: default
---
# ServiceRepairOrderUiController
## Methods
### `public static ServiceRepairOrder getSRO(Id recordId)`

`AURAENABLED`

wired method for supplying SRO Data to related components

#### Parameters

|Param|Description|
|---|---|
|`recordId`||

#### Returns

|Type|Description|
|---|---|
|`ServiceRepairOrder`|wired Service_Repair_Order__c record|


**Method** getSRO

### `public static List<utility.fieldSetWrapper> getFieldSetMembers()`

`AURAENABLED`

returns fields in newrecordfieldset for rendering on sroNew modal

#### Returns

|Type|Description|
|---|---|
|`List<utility.fieldSetWrapper>`|List<utility.fieldSetWrapper> - single wrapped fieldSet from object fieldsetmap|


**Method** getFieldSetMembers

### `public static Account getAccount(Id acctId)`

`AURAENABLED`

returns account from Id provided

#### Parameters

|Param|Description|
|---|---|
|`acctId`|acctId description|

#### Returns

|Type|Description|
|---|---|
|`Account`|return description|


**Method** getAccount

### `public static List<LookupSearchResult> locationAccountFromVehicleInventory(Id vehicleId)`

`AURAENABLED`

locationAccountFromVehicleInventory returns the Location Account from a selected Vehicle Inventory's Store location.

#### Parameters

|Param|Description|
|---|---|
|`vehicleId`|vehicleId description|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return List<LookupSearch>|

### `public static List<LookupSearchResult> getVehicle(String vin, String objectName)`

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


**Method** getVehicle

### `public static utility getUserRecord()`

`AURAENABLED`

returns wrapped utility object containing current running users info

#### Returns

|Type|Description|
|---|---|
|`utility`|utility.UserInformation - wrapper object containing user info|


**Method** getUserRecord

### `public static List<Contact> getBusinessContacts(Id accountId)`

`AURAENABLED`

returns business contacts related to Id provided

#### Parameters

|Param|Description|
|---|---|
|`acctId`|- account to fetch contacts for|

#### Returns

|Type|Description|
|---|---|
|`List<Contact>`|List<Contact> - related business contacts|


**Method** getBusinessContacts

### `public static void invoiceSRO(Id sroId)`

`AURAENABLED`

calls invoiceRepairOrder method to update SRO status

#### Parameters

|Param|Description|
|---|---|
|`sroId`|sro to invoice|


**Method** invoiceSRO

### `public static void postSRO(Id sroId)`

`AURAENABLED`

calls postRepairOrder method to update SRO status

#### Parameters

|Param|Description|
|---|---|
|`sroId`|sro to post|


**Method** postSRO

### `public static Service_Vehicle__c getVehicleRecord(Id svId)`

`AURAENABLED`

get all service vehicle fields from provided id

#### Parameters

|Param|Description|
|---|---|
|`svId`|Id of service vehicle to query|


**Method** getVehicleRecord

---
