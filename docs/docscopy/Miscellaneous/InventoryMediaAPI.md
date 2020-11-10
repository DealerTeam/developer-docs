---
layout: default
---
# InventoryMediaAPI class
---
## Constructors
### `InventoryMediaAPI()`
---
## Methods
### `createInventoryMedia(Vehicle_Inventory__c vehicle, List<File> uploadResults)` → `List<Inventory_Images__c>`
### `getInventoryMedia(String stockNumber)` → `List<InventoryMediaService.Image>`
### `processExternalMediaUpload()` → `void`

 processExternalMediaUpload makes call to middleware endpoint to retrieve external csv with image urls to upload. Can be called from schedulable.

### `uploadInventoryMedia(String imageBody)` → `string`
---
## Inner Classes

### InventoryMediaAPI.File class
---
#### Properties

##### `Bucket` → `String`

##### `ETag` → `String`

##### `Key` → `String`

##### `Location` → `String`

##### `MainHeight` → `Decimal`

##### `MainWidth` → `Decimal`

##### `Mime` → `String`

##### `ThumbHeight` → `Decimal`

##### `ThumbLocation` → `String`

##### `ThumbWidth` → `Decimal`

##### `VersionId` → `String`

##### `imageMeta` → `Inventory_Images__c`

---
### InventoryMediaAPI.ResponseWrapper class
---
#### Properties

##### `Errors` → `List<String>`

##### `Results` → `List<File>`

---
### InventoryMediaAPI.UploadWrapper class
---
#### Constructors
##### `UploadWrapper(String orgId, Boolean isSandbox, String imageBody)`
---
### InventoryMediaAPI.calloutWrapper class
---
