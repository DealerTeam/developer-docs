# ServiceEstimate_EXT

`APIVERSION: 45`

`STATUS: ACTIVE`
## Constructors
### `ServiceEstimate_EXT(ApexPages.Standardcontroller sc)`
---
## Fields

### `InventoryVehicleId` → `String`


### `dms` → `list<dealer__DMS_Settings__c>`


### `vid` → `dealer__Vehicle_Inventory__c`


---
## Properties

### `RecordID` → `String`


### `ShowRecord` → `String`


### `body` → `String`


### `email` → `String`


### `se` → `dealer__Service_Estimate__c`


### `subject` → `String`


---
## Methods
### `setInventoryVehicleId(String n)`
### `getInventoryVehicleId()`
### `finalize()`
### `convertToRO()`
### `getEstimateLines()`
### `addService()`
### `addPart()`
### `addSublet()`
### `addCosmetic()`
### `emailButton()`
### `noRefresh()`
### `saveMobile4Square()`
### `Save()`
### `saveEstimate()`
### `getHasEstimateLines()`
### `getHasActivityHistories()`
### `getVehicle()`
### `getROJobLines()`
### `AttachPDF()`
### `sendPdf()`
---
