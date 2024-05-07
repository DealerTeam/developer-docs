---
layout: default
---
# PartsPhysical_EXT
## Constructors
### `public PartsPhysical_EXT(ApexPages c)`
---
## Properties

### `public ppi` → `dealer__PartPhysicalInventory__c`


### `public physicalType` → `String`


### `public dollarValue` → `Decimal`


### `public binLocations` → `String`


### `public loc` → `dealer__Dealer_Location__c`


### `public batchId` → `Id`


### `public jobs` → `List<AsyncApexJob>`


### `public isBatchRunning` → `boolean`


### `public progress` → `string`


### `public detail_records` → `List<dealer__PartsPhysicalDetail__c>`


### `public showBin` → `Boolean`


### `public showDollar` → `Boolean`


---
## Methods
### `public PageReference newPhysicalInventory()`
### `private void physicalInventory(dealer__PartPhysicalInventory__c objPPI)`
### `public Pagereference getBatchStatus()`
### `public PageReference redirectPage()`
### `public void updateType()`

Sets booleans to control field visibility based on Type


**Method** updateType

---
