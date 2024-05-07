---
layout: default
---
# InventoryMediaAPI



**Group** Sales

## Constructors
### `public InventoryMediaAPI()`
---
## Methods
### `public static string uploadInventoryMedia(String imageBody)`
### `public static List<Inventory_Images__c> createInventoryMedia(Vehicle_Inventory__c vehicle, List<File> uploadResults)`
### `public static List<InventoryMediaService.Image> getInventoryMedia(String stockNumber)`
### `public static void processExternalMediaUpload()`

`FUTURE`

processExternalMediaUpload makes call to middleware endpoint to retrieve external csv with image urls to upload. Can be called from schedulable.

---
## Classes
### calloutWrapper
#### Fields

##### `private sessionId` → `String`


##### `private url` → `String`


---

### UploadWrapper
#### Constructors
##### `public UploadWrapper(String orgId, Boolean isSandbox, String imageBody)`
---
#### Fields

##### `private orgId` → `String`


##### `private isSandbox` → `Boolean`


##### `private imageBody` → `String`


##### `private maxWidth` → `Decimal`


##### `private thumbWidth` → `Decimal`


---

### ResponseWrapper
#### Fields

##### `public Results` → `List&lt;File&gt;`


##### `public Errors` → `List&lt;String&gt;`


---

### File
#### Fields

##### `public imageMeta` → `Inventory_Images__c`


##### `public ETag` → `String`


##### `public VersionId` → `String`


##### `public Location` → `String`


##### `public Key` → `String`


##### `public MainWidth` → `Decimal`


##### `public MainHeight` → `Decimal`


##### `public Mime` → `String`


##### `public Bucket` → `String`


##### `public ThumbLocation` → `String`


##### `public ThumbWidth` → `Decimal`


##### `public ThumbHeight` → `Decimal`


---

---
