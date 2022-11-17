# InventoryMediaService

`RESTRESOURCE`

`APIVERSION: 47`

`STATUS: ACTIVE`



**Group** Sales

## Methods
### `static storeMedia(List<Image> images)`

`HTTPPOST`
### `static getImages()`

`HTTPGET`

getMedia - Returns the associated images with a specific vehicle inventory record

---
## Classes
### Image
#### Properties

##### `imageData` → `String`


##### `imageMeta` → `Inventory_Images__c`


##### `imageUrl` → `String`


---

### UploadResults
#### Constructors
##### `UploadResults(List&lt;Image&gt; images, InventoryMediaAPI.ResponseWrapper uploadResults)`
---
#### Properties

##### `images` → `List&lt;Image&gt;`


##### `uploadResults` → `InventoryMediaAPI.ResponseWrapper`


---

---
