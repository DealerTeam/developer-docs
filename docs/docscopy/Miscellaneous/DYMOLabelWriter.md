---
layout: default
---
# DYMOLabelWriter class
---
## Constructors
### `DYMOLabelWriter(ApexPages.StandardController controller)`

 Queries and returns the info needed to create a part label
#### Parameters
|Param|Description|
|-----|-----------|
|`` | r |

---
## Methods
### `getPaObject()` → `PaObject`
### `setDefaultPrinter(String printerName)` → `boolean`

 Sets provided string as default label printer in FixedOperationSettings

#### Parameters
|Param|Description|
|-----|-----------|
|`String` |  printer name |

---
## Inner Classes

### DYMOLabelWriter.PaObject class
---
#### Constructors
##### `PaObject()`
---
#### Properties

##### `defaultPrinterName` → `String`

##### `labelQuantity` → `Integer`

##### `printBarcode` → `String`

##### `settings` → `dealer__FixedOperationsSettings__c`

---
#### Methods
##### `getAddressLabelXml()` → `String`
##### `getImageSrc()` → `String`
##### `getPart()` → `dealer__Parts_Inventory__c`
##### `getPartDescription()` → `String`
##### `getPartFullName()` → `String`
##### `setImageSrc(String value)` → `void`
##### `setPartFullName()` → `String`
---
