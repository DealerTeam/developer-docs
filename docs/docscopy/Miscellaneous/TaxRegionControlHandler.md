---
layout: default
---
# TaxRegionControlHandler class
---
## Methods
### `expireRegions(List<Tax_Region__c> triggerNew, Map<Id,Tax_Region__c> triggerOldMap)` → `void`
### `setExternalId(List<Tax_Region__c> triggerNew)` → `void`
### `setTaxZoneDates(List<Tax_Region__c> triggerNew)` → `void`

 setTaxZoneDates Before Update

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |  triggerNew description |

---
## Inner Classes

### TaxRegionControlHandler.TaxRegion class

 Wrapper Container to hold tax junctions part of a region.

---
#### Constructors
##### `TaxRegion(Tax_Region__c taxRegion, List<TaxJunction__c> taxJunctions)`
---
#### Properties

##### `taxJunctions` → `List<TaxJunction__c>`

##### `taxRegion` → `Tax_Region__c`

---
