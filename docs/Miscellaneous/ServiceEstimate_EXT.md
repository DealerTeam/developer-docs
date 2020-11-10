---
layout: default
---
# ServiceEstimate_EXT class

 2016.08.29       |Sneha                |Case#1978 Comment RO Number assignment code as its added in trigger

---
## Constructors
### `ServiceEstimate_EXT(ApexPages.Standardcontroller sc)`
---
## Properties

### `InventoryVehicleId` → `String`

### `RecordID` → `String`

### `ShowRecord` → `String`

### `body` → `String`

### `dms` → `list<dealer__DMS_Settings__c>`

### `email` → `String`

### `se` → `dealer__Service_Estimate__c`

### `subject` → `String`

### `vid` → `dealer__Vehicle_Inventory__c`

---
## Methods
### `AttachPDF()` → `Messaging.EmailFileAttachment`
### `Save()` → `PageReference`
### `addCosmetic()` → `PageReference`
### `addPart()` → `PageReference`
### `addService()` → `PageReference`
### `addSublet()` → `PageReference`
### `convertToRO()` → `pageReference`

It converts Service Estimate to Service Repair Order and Service Estimate Lines to Service Job lines @ added by Mahesh S

### `emailButton()` → `PageReference`
### `finalize()` → `pageReference`
### `getEstimateLines()` → `dealer__Service_Estimate_Line__c[]`
### `getHasActivityHistories()` → `boolean`
### `getHasEstimateLines()` → `boolean`
### `getInventoryVehicleId()` → `String`
### `getROJobLines()` → `List<dealer__Service_Job__c>`
### `getVehicle()` → `dealer__Vehicle_Inventory__c`
### `noRefresh()` → `PageReference`
### `saveEstimate()` → `PageReference`
### `saveMobile4Square()` → `PageReference`
### `sendPdf()` → `PageReference`
### `setInventoryVehicleId(String n)` → `void`
---
