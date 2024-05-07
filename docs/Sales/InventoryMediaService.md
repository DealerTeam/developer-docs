---
layout: default
---
# InventoryMediaService

`RESTRESOURCE`



**Group** Sales

## Methods
### `global static void storeMedia(List<Image> images)`

`HTTPPOST`
### `global static List<Image> getImages()`

`HTTPGET`

getMedia - Returns the associated images with a specific vehicle inventory record

### `private static void sendResponse(UploadResults response)`
### `private void ErrorResponse(String errorMessage)`
---
## Classes
### Image
#### Properties

##### `public imageMeta` → `Inventory_Images__c`


##### `public imageData` → `String`


##### `public imageUrl` → `String`


---

### UploadResults
#### Constructors
##### `public UploadResults(List&lt;Image&gt; images, InventoryMediaAPI uploadResults)`
---
#### Properties

##### `public images` → `List&lt;Image&gt;`


##### `public uploadResults` → `InventoryMediaAPI`


---

---
