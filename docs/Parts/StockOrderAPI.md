---
layout: default
---
# StockOrderAPI



**Group** Parts

## Constructors
### `public StockOrderAPI()`
---
## Methods
### `public void processStockOrder(Parts_invoice_Line__c invoiceLine)`

Converts single invoiceLine to a list to be accepted by processStockOrders

#### Parameters

|Param|Description|
|---|---|
|`Parts_Invoice_Line__c`|- invoice line to process stock order from|


**Method** processStockOrder


**Test** PartOrderingServiceLayer.testPartInvoiceAPI

### `public void processStockOrders(List<Parts_invoice_Line__c> invoiceLines)`

Creates a stock order from invoice lines if needed

#### Parameters

|Param|Description|
|---|---|
|`List`|<Parts_Invoice_Line__c> - invoice line to process stock order from|


**Function** processStockOrders


**Test** PartOrderingServiceLayer.testPartInvoiceAPI

### `public Map<Id,Stock_Order__c> NewStockOrders(List<Parts_Invoice_Line__c> linesWithoutSO, Map<Id,Parts_Inventory__c> partMap)`

Instantiates a List of Stock Orders and returns it.

#### Parameters

|Param|Description|
|---|---|
|`List`|<Parts_Invoice_Line__c> - parts invoice lines that need a stock order|
|`Map`|<Id, Parts_inventory__c> - map of parts to reference location info|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,Stock_Order__c>`|Map<Id, Stock_Order__c> - Map of locations and new stock orders|


**Function** NewStockOrders


**Test** PartOrderingServiceLayer.testPartInvoiceAPI

### `public Parts_Order__c PartsOrderLine(Parts_Invoice_Line__c piLine, Parts_Order__c partsOrder, Stock_Order__c stockOrder)`

Creates a new Parts Order Object if one does not exist or updates a Parts Order with new Data

#### Parameters

|Param|Description|
|---|---|
|`Parts_Invoice_Line__c`|- line used to populate new Parts Order|
|`Parts_Order__c`|- updates existing Part Order Line if this is not null|
|`Stock_Order__c`|- creates new Part Order Line if not updating existing|

#### Returns

|Type|Description|
|---|---|
|`Parts_Order__c`|Parts_Order__c - Order with updated or newly created Part Order Line|


**Function** PartsOrderLine


**Test** PartOrderingServiceLayer.testPartInvoiceAPI

---
