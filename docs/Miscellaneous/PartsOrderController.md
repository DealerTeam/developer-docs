---
layout: default
---
# PartsOrderController
## Methods
### `public static List<PartsOrder__c> getOpenOrderByMFG(String mfgId, String locId)`

`AURAENABLED`

Returns orders created today matching mfg input, user location and has a status value prior to pending review

#### Parameters

|Param|Description|
|---|---|
|`mfgId`|Manufacturer to check for open orders|

#### Returns

|Type|Description|
|---|---|
|`List<PartsOrder__c>`|return description|

### `public static PartsOrder__c saveOrder(PartsOrder__c order)`

`AURAENABLED`

Sets location if blank and inserts the Parts Order

#### Parameters

|Param|Description|
|---|---|
|`order`|Parts Order to be created|

#### Returns

|Type|Description|
|---|---|
|`PartsOrder__c`|return description|

### `public static List<PartsOrderLine__c> getLinesToApprove(Id shipmentId)`

`AURAENABLED`

Returns all lines with quantity received greater than the quantity processed

#### Parameters

|Param|Description|
|---|---|
|`shipmentId`|shipmentId description|

#### Returns

|Type|Description|
|---|---|
|`List<PartsOrderLine__c>`|return description|

### `public static Boolean approveLines(List<PartsOrderLine__c> lines)`

`AURAENABLED`

Sets processed value of Parts Order Lines equal to the received quantity.

#### Parameters

|Param|Description|
|---|---|
|`lines`|Parts Order Lines to process|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|

### `public static List<Parts_Invoice_Line__c> getPartLinesByInvoice(Id invoiceId)`

`AURAENABLED`
### `public static Boolean savePartsOrderLines(List<PartsOrderLine__c> lines)`

`AURAENABLED`
### `public static List<PartsOrderLine__c> getOrderLinesByInvoice(Id invoiceId)`

`AURAENABLED`

Returns all parts order lines related to invoice lines on the provided invoice

#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|invoiceId description|

#### Returns

|Type|Description|
|---|---|
|`List<PartsOrderLine__c>`|return description|

### `public static List<Parts_Invoice_Line__c> getAvailableInvoiceLines(Id invoiceId, String mfgId)`

`AURAENABLED`

Returns all parts invoice lines related to a parts invoice or service job line that are not already on an order

#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|invoiceId description|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Invoice_Line__c>`|return description|

### `public static List<Parts_Inventory__c> getPartsForStock(String mfgId, String orderId)`

`AURAENABLED`

Get all parts related to the provided manufacturer

#### Parameters

|Param|Description|
|---|---|
|`mfgId`|Manufacturer Id used to query parts|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Inventory__c>`|return description|

### `public static List<PartsOrderLine__c> getOpenOrderLinesByOrder(String orderId)`

`AURAENABLED`
### `public static Boolean reparentOrderLines(List<PartsOrderLine__c> linesToReparent)`

`AURAENABLED`

Move lines from one Parts Order and allow for partial movement

#### Parameters

|Param|Description|
|---|---|
|`linesToReparent`|linesToReparent description|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|

---
