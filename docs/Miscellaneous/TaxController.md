# TaxController

`APIVERSION: 52`

`STATUS: ACTIVE`
## Methods
### `static getTaxItems(Id recordId)`

`AURAENABLED`
### `static getFieldset()`

`AURAENABLED`
### `static getAvailableTaxZones(String searchFilter, Id recordId, String objectApiName)`

`AURAENABLED`

Controller method to fetch tax zones for any supported object

#### Parameters

|Param|Description|
|---|---|
|`searchFilter`|searchFilter description|
|`recordId`|recordId description|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

return description


**Method** getAvailableTaxZones

### `static selectedTaxZone(String recordId, String objectApiName)`

`AURAENABLED`

Retrieves selected Tax Zone on a supported record

#### Parameters

|Param|Description|
|---|---|
|`recordId`|String|
|`objectApiName`|String|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt;


**Method** selectedTaxZone

### `static updateTaxItem(TaxTransactionItem__c taxItem)`

`AURAENABLED`
### `static updateTaxZone(Id recordId, String contextObject, Id zoneId)`

`AURAENABLED`
### `static getTaxes(String recordId)`

`AURAENABLED`

Retrives Tax Transaction Items on a Deal record

#### Parameters

|Param|Description|
|---|---|
|`recordId`|String|

#### Return

**Type**

List&lt;TaxTransactionItem__c&gt;

**Description**

List&lt;TaxTransactionItem__c&gt;

### `static getLockedStatus(String recordId, String objectApiName)`

`AURAENABLED`

checks for a list of statuses which prevent updates in the tax manager and returns true if the status prevents an update

#### Parameters

|Param|Description|
|---|---|
|`sObjectType`|sObjectType description|

#### Return

**Type**

Boolean

**Description**

return description


**Method** getLockedStatus

---
