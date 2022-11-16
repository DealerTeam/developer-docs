# PartInventorySet_EXT

`APIVERSION: 48`

`STATUS: ACTIVE`



**Group** Parts

## Constructors
### `PartInventorySet_EXT(ApexPages.StandardSetController standardSetController)`
---
## Fields

### `ssc` → `ApexPages.StandardSetController`


---
## Properties

### `nameLabel` → `String`


### `onHandLabel` → `String`


### `partAPI` → `PartInventoryAPI`


### `parts` → `List<dealer__Parts_Inventory__c>`


### `partsSize` → `decimal`


### `reasonForChange` → `String`


---
## Methods
### `setPartAPI()`
### `updateParts()`
### `cancel()`
### `validateReasonForChange()`
### `adjustOnHand()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** adjustOnHand


**Notes** Used to adjust the onhand quantity of part in physical inventory.  This is specifically for Manual Adjustments.


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `queryParts()`
---
