---
layout: default
---
# CreditApplicationController class

@description

---
## Methods
### `GetApplication(string appId)` → `Credit_Application__c`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `createAppFromSalesUp(String supId)` → `Credit_Application__c`
### `getApplicationType(String recordId)` → `string`
### `getPreviousSubmissions(String appId)` → `List<CreditApplicationSubmission__c>`
### `getRelatedApps(String dealId)` → `List<LookupSearchResult>`

 getRelatedApps retrieves applications related to the sales up of a deal

#### Parameters
|Param|Description|
|-----|-----------|
|`appId` |  appId description |

### `getRelatedDeals(String appId)` → `List<LookupSearchResult>`
### `getSalesUp(String supId)` → `Sales_Up__c`
### `getServiceProviders(String appId)` → `List<LookupSearchResult>`
### `getServiceProvidersDeal(String dealId)` → `List<LookupSearchResult>`
### `primaryDeal(String appId)` → `List<LookupSearchResult>`
### `saveRecord(Credit_Application__c record)` → `Credit_Application__c`

 saveRecord

#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `submitApplication(String integration, String recordId, String dealId, String providerId)` → `CreditApplicationSubmission__c`
---
## Inner Classes

### CreditApplicationController.creditException class

@description

---
