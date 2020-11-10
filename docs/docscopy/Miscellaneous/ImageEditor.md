---
layout: default
---
# ImageEditor class
---
## Constructors
### `ImageEditor()`
---
## Properties

### `crm` → `CRMSettings__c`

### `mList` → `List<media>`

### `recordId` → `Id`

### `thumbWidth` → `Decimal`

### `userCanPublish` → `Boolean`

### `userHasAccess` → `Boolean`

### `vehicle` → `Vehicle_Inventory__c`

---
## Methods
### `NewGuid()` → `String`
### `addInventoryMedia(String jsonItem)` → `Map<String,Object>`

 2017-03-07    |Jarrett Kuljis     |W-000966 Add support for new fields to track the CND URL, default Cache Header of 7 Days also set on all records.

### `deleteInventoryMedia(String uuid)` → `boolean`
### `getVehicle()` → `dealer__Vehicle_Inventory__c`
### `getvehicleImages()` → `String`
### `publishAll(string vid)` → `boolean`
### `retrieveMediaList()` → `PageReference`
### `setOrder(String jsonItem)` → `boolean`
### `setPublished(string uuid)` → `boolean`
---
## Inner Classes

### ImageEditor.media class
---
#### Constructors
##### `media(Inventory_Images__c i)`
---
#### Properties

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
