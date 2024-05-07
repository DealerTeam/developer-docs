---
layout: default
---
# AppraisalNewController



**Group** Sales

## Methods
### `public static dealer__Dealer_Location__c getUserLocation(Id userId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`userId`|userId the user used to get a location|

#### Returns

|Type|Description|
|---|---|
|`dealer__Dealer_Location__c`|return location record related to the given user|


**Method** getUserLocation wired method that returns the location for the given user

### `public static string createServiceVehicle(dealer__Service_Vehicle__c sv)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`sv`|dealer__Service_Vehicle__c service vehicle to create|

#### Returns

|Type|Description|
|---|---|
|`string`|return Id of the created service vehicle|


**Method** createServiceVehicle Checks if a service vehicle exists for a given vin & creates a record if one does not exist

### `public static Service_Vehicle__c getRelatedVehicle(Id supId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`supId`|supId Id of sales up to find related service vehicles|

#### Returns

|Type|Description|
|---|---|
|`Service_Vehicle__c`|return List of service vehicles related to sales up|


**Method** getRelatedVehicle Get all service vehicles related to a sales up

### `public static List<Trade_In__c> getExistingTrades(String VIN)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`String`|VIN The VIN to find related trades|

#### Returns

|Type|Description|
|---|---|
|`List<Trade_In__c>`|return List of Trade Ins related to the deal|


**Method** getExistingTrades Get all trade ins related to a VIN

### `public static Service_Vehicle__c handleDecode(String VIN)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`VIN`|VIN The VIN to decode|

#### Returns

|Type|Description|
|---|---|
|`Service_Vehicle__c`|return Service_Vehicle__c vehicle with year, make and model populated from VIN Decoder|


**Method** handleDecode Returns year, make and model for a given VIN

### `public static string getObjectName(String objId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`objId`|objId record id to retrieve the object type|

#### Returns

|Type|Description|
|---|---|
|`string`|return String the object api name of the provided id|


**Method** getObjectName Calls utility class to return the object type for a given record id

### `public static Boolean updateTrades(List<Trade_In__c> trades, String app)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`trades`|trades list of trades to update|
|`app`|app id of the appraisal to relate to the trades|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return true if the trades were update otherwise false|


**Method** updateTrades Updates the trades with a new appraisal id

### `public static Service_Estimate__c getServiceEstimateLines(String appId)`

`AURAENABLED`
### `public static Service_Estimate__c refreshEstimateLines(String appId)`

`AURAENABLED`
### `public static void saveNewEstimateLine(Service_Estimate_Line__c line)`

`AURAENABLED`
### `public static List<StandardOpCode__c> getReconCodes()`

`AURAENABLED`
### `public static Appraisal__c getAppraisal(String appId)`

`AURAENABLED`
### `public static Service_Estimate__c createEstimate(String appId)`

`AURAENABLED`
### `public static List<LookupSearchResult> searchFinanceCompanies(String searchTerm)`

`AURAENABLED`

Searches existing finance company records for a matching name based off of searchTerm

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|User inputted string for selecting a finance company based off of record name|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|returns a list of LookupSearchResult records|


**Method** searchFinanceCompanies

### `public static List<LookupSearchResult> recentFinanceCompanies()`

`AURAENABLED`

returns a list of recently viewed finance companies to allow prefilling lookup selections on UI/UX components

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return description|


**Method** recentFinanceCompanies

### `public static List<FieldSetWrapper> getFieldSetMembers(String objRef, String setName)`

`AURAENABLED`

Method for retrieving field set members based off of object name and fieldset name

#### Parameters

|Param|Description|
|---|---|
|`objRef`|API name of object being referenced|
|`setName`|API name of fieldset being referenced on the object|

#### Returns

|Type|Description|
|---|---|
|`List<FieldSetWrapper>`|returns a wrapper class containing fieldnames and required status|


**Method** getFieldSetMembers

### `public static SObject queryAllAccessible(Id recordId)`

`AURAENABLED`

Allows UI/UX components to call utility.queryAllAccessible

#### Parameters

|Param|Description|
|---|---|
|`recordId`|Id of record being returned|

#### Returns

|Type|Description|
|---|---|
|`SObject`|returns a sobject containing all record data available|

---
## Classes
### AppraisalNewControllerException

**Inheritance**

AppraisalNewControllerException


---
