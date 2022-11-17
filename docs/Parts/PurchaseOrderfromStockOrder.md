# PurchaseOrderfromStockOrder

`APIVERSION: 45`

`STATUS: ACTIVE`

PurchaseOrderFromStockOrder - Class to take values from the staged orders and create the stock orders and assocated as either purchase orders or transfers


**Group** Parts

## Constructors
### `PurchaseOrderfromStockOrder()`

**Method** PurchaseOrderfromStockOrder


**Notes** class constructor


**Vfparams** OrderId : Order record


**Test** PartOrderingServiceLayer.testPurchaseOrderfromStockOrder

---
## Properties

### `itemForRemoval` → `String`


### `lineCount` → `Integer`


### `orderId` → `String`


### `orderLines` → `List<dealer__Parts_Order__c>`


### `orderValue` → `Decimal`


### `po` → `dealer__Purchase_Order__c`


### `poLines` → `List<POvSOCheckboxWrapper>`


### `selectedLines` → `List<POvSOCheckboxWrapper>`


### `so` → `dealer__Stock_Order__c`


---
## Methods
### `createWithSelected()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** createWithSelected


**Notes** create a purchase order with the selected line items


**Test** PartOrderingServiceLayer.testPurchaseOrderfromStockOrder

### `removeItem()`
#### Return

**Type**

PageReference

**Description**

description


**Method** removeItem


**Notes** - deprecated


**Test** PartOrderingServiceLayer.testPurchaseOrderfromStockOrder

---
## Classes
### POCreationException

**Inheritance**

POCreationException


---
