---
layout: default
---
# PurchaseOrderfromStockOrder class

 PurchaseOrderFromStockOrder - Class to take values from the staged orders and create the stock orders and assocated as either purchase orders or transfers

---
## Constructors
### `PurchaseOrderfromStockOrder()`

 PurchaseOrderfromStockOrder
---
## Properties

### `itemForRemoval` → `String`

### `lineCount` → `Integer`

 lineCount @return integer @test PartOrderingServiceLayer.testPurchaseOrderfromStockOrder

### `orderId` → `String`

### `orderLines` → `List<dealer__Parts_Order__c>`

### `orderValue` → `Decimal`

 orderValue @return Decimal @test PartOrderingServiceLayer.testPurchaseOrderfromStockOrder

### `po` → `dealer__Purchase_Order__c`

### `poLines` → `List<POvSOCheckboxWrapper>`

### `selectedLines` → `List<POvSOCheckboxWrapper>`

### `so` → `dealer__Stock_Order__c`

---
## Methods
### `createWithSelected()` → `PageReference`

 createWithSelected

### `removeItem()` → `PageReference`

 removeItem

---
## Inner Classes

### PurchaseOrderfromStockOrder.POCreationException class
---
