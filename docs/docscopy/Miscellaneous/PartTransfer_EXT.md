---
layout: default
---
# PartTransfer_EXT class

 PartTransfer_EXT keeps control of transfering parts between two locaitons /** 2016-09-19       |Jarrett Kuljis     |W-000541 Support for partial parts purchases on transfer PO 2016-10-24       |Jarrett Kuljis     |W-000538 add cancel pagereference for return to tab, add 3rd party financial accounting inetgration to the commit/reverse methods. 2016.10.27       |Jarrett Kuljis     |W-000623 Add jobline to new part invoice line Id, if created from an RO

---
## Constructors
### `PartTransfer_EXT(ApexPages.StandardController controller)`

 __Constructor
---
## Properties

### `addLine` → `dealer__Parts_Invoice_Line__c`

### `addPartId` → `Id`

### `addPartQty` → `Decimal`

### `from_location` → `dealer__Dealer_Location__c`

### `invoice` → `dealer__Parts_Invoice__c`

### `isOpen` → `boolean`

### `lineComment` → `String`

### `lineCount` → `Decimal`

### `ol_list` → `List<POvSOCheckboxWrapper>`

### `ops` → `dealer__FixedOperationsSettings__c`

### `orderNumber` → `String`

### `partOrder` → `dealer__Parts_Order__c`

### `po` → `dealer__Purchase_Order__c`

### `postingURL` → `String`

### `removePartId` → `Id`

### `so` → `dealer__Stock_Order__c`

### `to_location` → `dealer__Dealer_Location__c`

### `transfer` → `dealer__PartTransfer__c`

---
## Methods
### `addPartInvoiceLine()` → `PageReference`

 addPartInvoiceLine

### `cancel()` → `PageReference`

 cancel

### `commitTransfer()` → `PageReference`

 commitTransfer

### `create()` → `PageReference`

 create

### `createFromOrderRequest()` → `PageReference`

 createFromOrderRequest

### `getInvoiceLines()` → `List<dealer__Parts_Invoice_Line__c>`

 getInvoiceLines

### `getPurchaseOrderLines()` → `List<dealer__Purchase_Order_Line__c>`

 getPurchaseOrderLines

### `lookupPartsInvoice(Id invoiceId)` → `dealer__Parts_Invoice__c`

 lookupPartsInvoice

#### Parameters
|Param|Description|
|-----|-----------|
|`invoiceId` |  record id of the invoice that we will be looking up |

### `lookupPurchaseOrder(Id poId)` → `dealer__Purchase_Order__c`

 lookupPurchaseOrder

#### Parameters
|Param|Description|
|-----|-----------|
|`poId` |  record Id of the purchase order that you are interested looking up |

### `removeLine()` → `PageReference`

 removeLine

### `reverseTransfer()` → `PageReference`

 reverseTransfer

### `save()` → `PageReference`

 [save description]

### `void()` → `PageReference`

 void

---
