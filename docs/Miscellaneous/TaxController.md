---
layout: default
---
# TaxController
## Methods
### `public static List<TaxTransactionItem__c> getTaxItems(Id recordId)`

`AURAENABLED`
### `public static List<FieldSetWrapper> getFieldset()`

`AURAENABLED`
### `public static List<LookupSearchResult> getAvailableTaxZones(String searchFilter, Id recordId, String objectApiName)`

`AURAENABLED`

Controller method to fetch tax zones for any supported object

#### Parameters

|Param|Description|
|---|---|
|`searchFilter`|searchFilter description|
|`recordId`|recordId description|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|return description|


**Method** getAvailableTaxZones

### `public static List<LookupSearchResult> selectedTaxZone(String recordId, String objectApiName)`

`AURAENABLED`

Retrieves selected Tax Zone on a supported record

#### Parameters

|Param|Description|
|---|---|
|`recordId`|String|
|`objectApiName`|String|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|


**Method** selectedTaxZone

### `public static Boolean updateTaxItem(TaxTransactionItem__c taxItem)`

`AURAENABLED`
### `public static Boolean updateTaxZone(Id recordId, String contextObject, Id zoneId)`

`AURAENABLED`
### `public static List<TaxTransactionItem__c> getTaxes(String recordId)`

`AURAENABLED`

Retrives Tax Transaction Items on a Deal record

#### Parameters

|Param|Description|
|---|---|
|`recordId`|String|

#### Returns

|Type|Description|
|---|---|
|`List<TaxTransactionItem__c>`|List<TaxTransactionItem__c>|

### `public static Boolean getLockedStatus(String recordId, String objectApiName)`

`AURAENABLED`

checks for a list of statuses which prevent updates in the tax manager and returns true if the status prevents an update

#### Parameters

|Param|Description|
|---|---|
|`sObjectType`|sObjectType description|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|


**Method** getLockedStatus

---
