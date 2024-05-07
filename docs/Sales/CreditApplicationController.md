---
layout: default
---
# CreditApplicationController



**Group** Sales

## Methods
### `public static Credit_Application__c saveRecord(Credit_Application__c record)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`record`||

#### Returns

|Type|Description|
|---|---|
|`Credit_Application__c`|Credit_Application__c|


**Method** saveRecord

### `public static string getApplicationType(String recordId)`

`AURAENABLED`
### `public static Credit_Application__c GetApplication(string appId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`appId`||

#### Returns

|Type|Description|
|---|---|
|`Credit_Application__c`|Credit_Application__c|


**Method** GetApplication

### `public static List<LookupSearchResult> getRelatedApps(String dealId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`appId`|appId description|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return description|


**Method** getRelatedApps retrieves applications related to the sales up of a deal

### `public static Sales_Up__c getSalesUp(String supId)`

`AURAENABLED`
### `public static Credit_Application__c createAppFromSalesUp(String supId)`

`AURAENABLED`
### `public static List<CreditApplicationSubmission__c> getPreviousSubmissions(String appId)`

`AURAENABLED`
### `public static List<LookupSearchResult> primaryDeal(String appId)`

`AURAENABLED`
### `public static List<LookupSearchResult> getRelatedDeals(String appId)`

`AURAENABLED`
### `public static List<LookupSearchResult> getServiceProviders(String appId)`

`AURAENABLED`
### `public static List<LookupSearchResult> getServiceProvidersDeal(String dealId)`

`AURAENABLED`
### `public static CreditApplicationSubmission__c submitApplication(String integration, String recordId, String dealId, String providerId)`

`AURAENABLED`
---
## Classes
### creditException

**Inheritance**

creditException


---
