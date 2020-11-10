---
layout: default
---
# Deal_EXT class

@description

---
## Constructors
### `Deal_EXT(ApexPages.StandardController stdController)`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | r |

---
## Properties

### `DateofFirstPayment` → `Date`

@description

### `Days` → `Decimal`

@description

### `DealDate` → `Date`

 @desciption Default Settings for a new Deal

### `DocFee` → `Decimal`

@description

### `PPY` → `Decimal`

@description

### `Rate` → `Decimal`

@description

### `Term` → `Decimal`

@description

### `buyer` → `Contact`

@description

### `dealDefaults` → `list<dealer__DMS_Settings__c>`

@description

### `dealTitle` → `String`

@description

### `forms` → `List<dealer__Form__c>`

@description

---
## Methods
### `getdealTitle()` → `String`
### `lookupBuyer(String bid)` → `Contact`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `populateBuyerData(Contact c)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | c |

### `save()` → `PageReference`
### `selectStockNumber(String stkno)` → `List<dealer__Vehicle_Inventory__c>`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | o |

### `updateSalesUp(List<Id> supIdLst)` → `void`
---
## Inner Classes

### Deal_EXT.DealException class
---
