# InventoryMediaAPI

`APIVERSION: 47`

`STATUS: ACTIVE`



**Group** Sales

## Constructors
### `InventoryMediaAPI()`
---
## Methods
### `static uploadInventoryMedia(String imageBody)`
### `static createInventoryMedia(Vehicle_Inventory__c vehicle, List<File> uploadResults)`
### `static getInventoryMedia(String stockNumber)`
### `static processExternalMediaUpload()`

`FUTURE`

processExternalMediaUpload makes call to middleware endpoint to retrieve external csv with image urls to upload. Can be called from schedulable.

---
## Classes
### File
#### Fields

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

### ResponseWrapper
#### Fields

##### `Errors` → `List&lt;String&gt;`


##### `Results` → `List&lt;File&gt;`


---

### UploadWrapper
#### Constructors
##### `UploadWrapper(String orgId, Boolean isSandbox, String imageBody)`
---

### calloutWrapper

---
