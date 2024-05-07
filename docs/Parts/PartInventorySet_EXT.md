---
layout: default
---
# PartInventorySet_EXT



**Group** Parts

## Constructors
### `public PartInventorySet_EXT(ApexPages standardSetController)`
---
## Fields

### `public ssc` → `ApexPages`


---
## Properties

### `public parts` → `List<dealer__Parts_Inventory__c>`


### `public partsSize` → `decimal`


### `public reasonForChange` → `String`


### `public partAPI` → `PartInventoryAPI`


### `public nameLabel` → `String`


### `public onHandLabel` → `String`


---
## Methods
### `public void setPartAPI()`
### `public Pagereference updateParts()`
### `public PageReference cancel()`
### `public boolean validateReasonForChange()`
### `public PageReference adjustOnHand()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** adjustOnHand


**Notes** Used to adjust the onhand quantity of part in physical inventory.  This is specifically for Manual Adjustments.


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `public void queryParts()`
---
