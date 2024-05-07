---
layout: default
---
# TaxRegionControlHandler
## Methods
### `public static void setExternalId(List<Tax_Region__c> triggerNew)`
### `public static void setTaxZoneDates(List<Tax_Region__c> triggerNew)`

setTaxZoneDates Before Update

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|

### `public static void expireRegions(List<Tax_Region__c> triggerNew, Map<Id,Tax_Region__c> triggerOldMap)`
---
## Classes
### TaxRegion

Wrapper Container to hold tax junctions part of a region.

#### Constructors
##### `public TaxRegion(Tax_Region__c taxRegion, List&lt;TaxJunction__c&gt; taxJunctions)`
---
#### Fields

##### `public taxRegion` → `Tax_Region__c`


##### `public taxJunctions` → `List&lt;TaxJunction__c&gt;`


---

---
