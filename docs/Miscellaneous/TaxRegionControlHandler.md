# TaxRegionControlHandler

`APIVERSION: 49`

`STATUS: ACTIVE`
## Methods
### `static setExternalId(List<Tax_Region__c> triggerNew)`
### `static setTaxZoneDates(List<Tax_Region__c> triggerNew)`

setTaxZoneDates Before Update

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|

### `static expireRegions(List<Tax_Region__c> triggerNew, Map<Id,Tax_Region__c> triggerOldMap)`
---
## Classes
### TaxRegion

Wrapper Container to hold tax junctions part of a region.

#### Constructors
##### `TaxRegion(Tax_Region__c taxRegion, List&lt;TaxJunction__c&gt; taxJunctions)`
---
#### Fields

##### `taxJunctions` → `List&lt;TaxJunction__c&gt;`


##### `taxRegion` → `Tax_Region__c`


---

---
