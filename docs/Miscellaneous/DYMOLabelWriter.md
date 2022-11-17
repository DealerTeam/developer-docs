# DYMOLabelWriter

`APIVERSION: 45`

`STATUS: ACTIVE`
## Constructors
### `DYMOLabelWriter(ApexPages.StandardController controller)`

Queries and returns the info needed to create a part label

#### Parameters

|Param|Description|
|---|---|
|`controller`||


**Test** PartPhysicalIventoryServiceLayer.testDYMOLabelWriter

---
## Methods
### `getPaObject()`
### `static setDefaultPrinter(String printerName)`

`REMOTEACTION`

Sets provided string as default label printer in FixedOperationSettings

#### Parameters

|Param|Description|
|---|---|
|`String`|printer name|

#### Return

**Type**

boolean

**Description**

Boolean always true


**Test** PartPhysicalIventoryServiceLayer.testDYMOLabelWriter

---
## Classes
### PaObject
#### Constructors
##### `PaObject()`
---
#### Fields

##### `settings` → `dealer__FixedOperationsSettings__c`


---
#### Properties

##### `defaultPrinterName` → `String`


##### `labelQuantity` → `Integer`


##### `printBarcode` → `String`


---
#### Methods
##### `getPart()`
##### `getPartFullName()`
##### `setPartFullName()`
##### `getPartDescription()`
##### `getAddressLabelXml()`
##### `setImageSrc(String value)`
##### `getImageSrc()`
---

---
