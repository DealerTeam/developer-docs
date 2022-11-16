# ImageEditor

`APIVERSION: 45`

`STATUS: ACTIVE`
## Constructors
### `ImageEditor()`
---
## Fields

### `defaultMinHeight` → `Decimal`


### `defaultMinWidth` → `Decimal`


### `recordId` → `Id`


### `vehicle` → `Vehicle_Inventory__c`


---
## Properties

### `crm` → `CRMSettings__c`


### `cropRatio` → `String`


### `displayHeight` → `Decimal`


### `displayWidth` → `Decimal`


### `forceCrop` → `Boolean`


### `mList` → `List<media>`


### `maxSize` → `Decimal`


### `minHeight` → `Decimal`


### `minWidth` → `Decimal`


### `publishDefault` → `Boolean`


### `thumbHeight` → `Decimal`


### `thumbWidth` → `Decimal`


### `userCanPublish` → `Boolean`


### `userHasAccess` → `Boolean`


---
## Methods
### `retrieveMediaList()`
### `getvehicleImages()`
### `getVehicle()`
### `static deleteInventoryMedia(String uuid)`

`REMOTEACTION`
### `static addInventoryMedia(String jsonItem)`

`REMOTEACTION`
### `static setOrder(String jsonItem)`

`REMOTEACTION`
### `static setPublished(string uuid)`

`REMOTEACTION`
### `static publishAll(string vid)`

`REMOTEACTION`
### `NewGuid()`
---
## Classes
### media
#### Constructors
##### `media(Inventory_Images__c i)`
---
#### Fields

##### `height` → `Decimal`


##### `id` → `Id`


##### `imgId` → `Id`


##### `mimetype` → `String`


##### `name` → `String`


##### `order` → `Decimal`


##### `primarydisplay` → `String`


##### `primarydisplayURL` → `String`


##### `pubstat` → `Boolean`


##### `sequence` → `Decimal`


##### `thumbnailUrl` → `String`


##### `url` → `String`


##### `uuid` → `String`


##### `width` → `Decimal`


---

---
