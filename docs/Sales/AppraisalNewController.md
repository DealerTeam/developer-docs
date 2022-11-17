# AppraisalNewController

`APIVERSION: 47`

`STATUS: ACTIVE`



**Group** Sales

## Methods
### `static getUserLocation(Id userId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`userId`|userId the user used to get a location|

#### Return

**Type**

dealer__Dealer_Location__c

**Description**

return location record related to the given user


**Method** getUserLocation wired method that returns the location for the given user

### `static createServiceVehicle(dealer__Service_Vehicle__c sv)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`sv`|dealer__Service_Vehicle__c service vehicle to create|

#### Return

**Type**

string

**Description**

return Id of the created service vehicle


**Method** createServiceVehicle Checks if a service vehicle exists for a given vin & creates a record if one does not exist

### `static getRelatedVehicle(Id supId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`supId`|supId Id of sales up to find related service vehicles|

#### Return

**Type**

Service_Vehicle__c

**Description**

return List of service vehicles related to sales up


**Method** getRelatedVehicle Get all service vehicles related to a sales up

### `static getExistingTrades(String VIN)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`String`|VIN The VIN to find related trades|

#### Return

**Type**

List&lt;Trade_In__c&gt;

**Description**

return List of Trade Ins related to the deal


**Method** getExistingTrades Get all trade ins related to a VIN

### `static handleDecode(String VIN)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`VIN`|VIN The VIN to decode|

#### Return

**Type**

Service_Vehicle__c

**Description**

return Service_Vehicle__c vehicle with year, make and model populated from VIN Decoder


**Method** handleDecode Returns year, make and model for a given VIN

### `static getObjectName(String objId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`objId`|objId record id to retrieve the object type|

#### Return

**Type**

string

**Description**

return String the object api name of the provided id


**Method** getObjectName Calls utility class to return the object type for a given record id

### `static updateTrades(List<Trade_In__c> trades, String app)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`trades`|trades list of trades to update|
|`app`|app id of the appraisal to relate to the trades|

#### Return

**Type**

Boolean

**Description**

return true if the trades were update otherwise false


**Method** updateTrades Updates the trades with a new appraisal id

### `static getServiceEstimateLines(String appId)`

`AURAENABLED`
### `static refreshEstimateLines(String appId)`

`AURAENABLED`
### `static saveNewEstimateLine(Service_Estimate_Line__c line)`

`AURAENABLED`
### `static getReconCodes()`

`AURAENABLED`
### `static getAppraisal(String appId)`

`AURAENABLED`
### `static createEstimate(String appId)`

`AURAENABLED`
### `static searchFinanceCompanies(String searchTerm)`

`AURAENABLED`

Searches existing finance company records for a matching name based off of searchTerm

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|User inputted string for selecting a finance company based off of record name|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

returns a list of LookupSearchResult records


**Method** searchFinanceCompanies

### `static recentFinanceCompanies()`

`AURAENABLED`

returns a list of recently viewed finance companies to allow prefilling lookup selections on UI/UX components

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

return description


**Method** recentFinanceCompanies

### `static getFieldSetMembers(String objRef, String setName)`

`AURAENABLED`

Method for retrieving field set members based off of object name and fieldset name

#### Parameters

|Param|Description|
|---|---|
|`objRef`|API name of object being referenced|
|`setName`|API name of fieldset being referenced on the object|

#### Return

**Type**

List&lt;SalesUpController.fieldSetWrapper&gt;

**Description**

returns a wrapper class containing fieldnames and required status


**Method** getFieldSetMembers

### `static queryAllAccessible(Id recordId)`

`AURAENABLED`

Allows UI/UX components to call utility.queryAllAccessible

#### Parameters

|Param|Description|
|---|---|
|`recordId`|Id of record being returned|

#### Return

**Type**

SObject

**Description**

returns a sobject containing all record data available

---
## Classes
### AppraisalNewControllerException

**Inheritance**

AppraisalNewControllerException


---
