# CreditApplicationController

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Sales

## Methods
### `static saveRecord(Credit_Application__c record)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`record`||

#### Return

**Type**

Credit_Application__c

**Description**

Credit_Application__c


**Method** saveRecord

### `static getApplicationType(String recordId)`

`AURAENABLED`
### `static GetApplication(string appId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`appId`||

#### Return

**Type**

Credit_Application__c

**Description**

Credit_Application__c


**Method** GetApplication

### `static getRelatedApps(String dealId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`appId`|appId description|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

return description


**Method** getRelatedApps retrieves applications related to the sales up of a deal

### `static getSalesUp(String supId)`

`AURAENABLED`
### `static createAppFromSalesUp(String supId)`

`AURAENABLED`
### `static getPreviousSubmissions(String appId)`

`AURAENABLED`
### `static primaryDeal(String appId)`

`AURAENABLED`
### `static getRelatedDeals(String appId)`

`AURAENABLED`
### `static getServiceProviders(String appId)`

`AURAENABLED`
### `static getServiceProvidersDeal(String dealId)`

`AURAENABLED`
### `static submitApplication(String integration, String recordId, String dealId, String providerId)`

`AURAENABLED`
---
## Classes
### creditException

**Inheritance**

creditException


---
