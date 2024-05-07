---
layout: default
---
# ImageEditor
## Constructors
### `public ImageEditor()`
---
## Fields

### `public vehicle` → `Vehicle_Inventory__c`


### `public recordId` → `Id`


### `public defaultMinWidth` → `Decimal`


### `public defaultMinHeight` → `Decimal`


### `private kHexChars` → `String`


---
## Properties

### `public userHasAccess` → `Boolean`


### `public userCanPublish` → `Boolean`


### `public crm` → `CRMSettings__c`


### `public maxSize` → `Decimal`


### `public displayHeight` → `Decimal`


### `public displayWidth` → `Decimal`


### `public thumbWidth` → `Decimal`


### `public thumbHeight` → `Decimal`


### `public publishDefault` → `Boolean`


### `public forceCrop` → `Boolean`


### `public cropRatio` → `String`


### `public hemiEndpoint` → `String`


### `public minWidth` → `Decimal`


### `public minHeight` → `Decimal`


### `public transparencySupport` → `Boolean`


### `public saveOriginal` → `Boolean`


### `public mList` → `List<media>`


---
## Methods
### `public PageReference retrieveMediaList()`
### `public String getvehicleImages()`
### `public dealer__Vehicle_Inventory__c getVehicle()`
### `public static boolean deleteInventoryMedia(String uuid)`

`REMOTEACTION`
### `public static Inventory_Images__c createInventoryMedia(String jsonItem)`

`REMOTEACTION`

createInventoryMedia - creates an inventory image based on an incoming jsonItem from HEMI

#### Parameters

|Param|Description|
|---|---|
|`jsonItem`|server response to convert to image|

#### Returns

|Type|Description|
|---|---|
|`Inventory_Images__c`|return -  an Inventory_Images__c for inserting once all images have been processed|

### `public static Boolean upsertImages(Inventory_Images__c imagesToUpsert)`

`REMOTEACTION`

upsertImages - inserts an array of processed images

#### Parameters

|Param|Description|
|---|---|
|`imagesToUpsert`|- inventory image array|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return - boolean denoting if the dml was successful|

### `public static boolean setOrder(String jsonItem)`

`REMOTEACTION`
### `public static boolean setPublished(string uuid)`

`REMOTEACTION`
### `public static boolean publishAll(string vid)`

`REMOTEACTION`
### `public static List<String> deleteAll(string vid)`

`REMOTEACTION`
### `public String NewGuid()`
### `private String getCharAtIndex(String str, Integer index)`
---
## Classes
### media
#### Constructors
##### `public media(Inventory_Images__c i)`
---
#### Fields

##### `public id` → `Id`


##### `public imgId` → `Id`


##### `public uuid` → `String`


##### `public sequence` → `Decimal`


##### `public order` → `Decimal`


##### `public height` → `Decimal`


##### `public width` → `Decimal`


##### `public pubstat` → `Boolean`


##### `public mimetype` → `String`


##### `public thumbnailUrl` → `String`


##### `public name` → `String`


##### `public url` → `String`


##### `public primarydisplay` → `String`


##### `public primarydisplayURL` → `String`


##### `public originalName` → `String`


---

---
