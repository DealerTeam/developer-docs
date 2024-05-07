---
layout: default
---
# DYMOLabelWriter
## Constructors
### `public DYMOLabelWriter(ApexPages controller)`

Queries and returns the info needed to create a part label

#### Parameters

|Param|Description|
|---|---|
|`controller`||


**Test** PartPhysicalIventoryServiceLayer.testDYMOLabelWriter

---
## Fields

### `private m_paObject` → `paObject`


---
## Methods
### `public PaObject getPaObject()`
### `public static boolean setDefaultPrinter(String printerName)`

`REMOTEACTION`

Sets provided string as default label printer in FixedOperationSettings

#### Parameters

|Param|Description|
|---|---|
|`String`|printer name|

#### Returns

|Type|Description|
|---|---|
|`boolean`|Boolean always true|


**Test** PartPhysicalIventoryServiceLayer.testDYMOLabelWriter

---
## Classes
### PaObject
#### Constructors
##### `public PaObject()`
---
#### Fields

##### `private m_part` → `dealer__Parts_Inventory__c`


##### `public settings` → `dealer__FixedOperationsSettings__c`


##### `private formattedAddress` → `String`


##### `private imageSrc` → `String`


---
#### Properties

##### `public labelQuantity` → `Integer`


##### `public defaultPrinterName` → `String`


##### `public printBarcode` → `String`


---
#### Methods
##### `public dealer__Parts_Inventory__c getPart()`
##### `public String getPartFullName()`
##### `public String setPartFullName()`
##### `public String getPartDescription()`
##### `public String getAddressLabelXml()`
##### `public void setImageSrc(String value)`
##### `public String getImageSrc()`
---

---
