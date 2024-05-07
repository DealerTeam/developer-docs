---
layout: default
---
# PurchaseOrderfromStockOrder

PurchaseOrderFromStockOrder - Class to take values from the staged orders and create the stock orders and assocated as either purchase orders or transfers


**Group** Parts

## Constructors
### `public PurchaseOrderfromStockOrder()`

**Method** PurchaseOrderfromStockOrder


**Notes** class constructor


**Vfparams** OrderId : Order record


**Test** PartOrderingServiceLayer.testPurchaseOrderfromStockOrder

---
## Properties

### `public orderId` → `String`


### `public so` → `dealer__Stock_Order__c`


### `public po` → `dealer__Purchase_Order__c`


### `public orderLines` → `List<dealer__Parts_Order__c>`


### `public poLines` → `List<POvSOCheckboxWrapper>`


### `public selectedLines` → `List<POvSOCheckboxWrapper>`


### `public itemForRemoval` → `String`


### `public lineCount` → `Integer`


### `public orderValue` → `Decimal`


---
## Methods
### `public PageReference createWithSelected()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** createWithSelected


**Notes** create a purchase order with the selected line items


**Test** PartOrderingServiceLayer.testPurchaseOrderfromStockOrder

### `public PageReference removeItem()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|description|


**Method** removeItem


**Notes** - deprecated


**Test** PartOrderingServiceLayer.testPurchaseOrderfromStockOrder

---
## Classes
### POCreationException

**Inheritance**

POCreationException


---
