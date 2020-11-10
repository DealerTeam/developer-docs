---
layout: default
---
# InventoryMediaService class
---
## Methods
### `getImages()` → `List<Image>`

 getMedia - Returns the associated images with a specific vehicle inventory record

### `storeMedia(List<Image> images)` → `void`
---
## Inner Classes

### InventoryMediaService.Image class
---
#### Properties

##### `imageData` → `String`

##### `imageMeta` → `Inventory_Images__c`

##### `imageUrl` → `String`

---
### InventoryMediaService.UploadResults class
---
#### Constructors
##### `UploadResults(List<Image> images, InventoryMediaAPI.ResponseWrapper uploadResults )`
---
#### Properties

##### `images` → `List<Image>`

##### `uploadResults` → `InventoryMediaAPI.ResponseWrapper`

---
