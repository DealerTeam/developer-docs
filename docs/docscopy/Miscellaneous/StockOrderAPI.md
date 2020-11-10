---
layout: default
---
# StockOrderAPI class
---
## Constructors
### `StockOrderAPI()`
---
## Methods
### `NewStockOrders(List<Parts_Invoice_Line__c> linesWithoutSO, Map<Id,Parts_Inventory__c> partMap )` → `Map<Id,Stock_Order__c>`

 Instantiates a List of Stock Orders and returns it. @function NewStockOrders

#### Parameters
|Param|Description|
|-----|-----------|
|`{List<Parts_Invoice_Line__c>}` |  - parts invoice lines that need a stock order |
|`{Map<Id,` |  Parts_inventory__c>} - map of parts to reference location info |

### `PartsOrderLine(Parts_Invoice_Line__c piLine, Parts_Order__c partsOrder, Stock_Order__c stockOrder)` → `Parts_Order__c`

 Creates a new Parts Order Object if one does not exist or updates a Parts Order with new Data @function PartsOrderLine

#### Parameters
|Param|Description|
|-----|-----------|
|`{Parts_Invoice_Line__c}` |  - line used to populate new Parts Order |
|`{Parts_Order__c}` |  - updates existing Part Order Line if this is not null |
|`{Stock_Order__c}` |  - creates new Part Order Line if not updating existing |

### `processStockOrder(Parts_invoice_Line__c invoiceLine)` → `void`

 Converts single invoiceLine to a list to be accepted by processStockOrders @function processStockOrder

#### Parameters
|Param|Description|
|-----|-----------|
|`{Parts_Invoice_Line__c}` |  - invoice line to process stock order from |

### `processStockOrders(List<Parts_invoice_Line__c> invoiceLines)` → `void`

 Creates a stock order from invoice lines if needed @function processStockOrders

#### Parameters
|Param|Description|
|-----|-----------|
|`{List<Parts_Invoice_Line__c>}` |  - invoice line to process stock order from |

---
