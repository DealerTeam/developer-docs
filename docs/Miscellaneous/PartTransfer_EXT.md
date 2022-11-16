# PartTransfer_EXT

`APIVERSION: 45`

`STATUS: ACTIVE`

PartTransfer_EXT keeps control of transfering parts between two locaitons

## Constructors
### `PartTransfer_EXT(ApexPages.StandardController controller)`
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
### `create()`
#### Return

**Type**

PageReference

**Description**

PageRefernce of the created record PartTransfer__C


**Method** create

### `commitTransfer()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** commitTransfer


**Notes** locks the transfer, creates the purchase order with lines

### `reverseTransfer()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** reverseTransfer


**Notes** reverses the transfer record and unwind the transaction in the General Ledger.  This is prevented if the transfer is complete

### `save()`
### `cancel()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** cancel


**Notes** return user to the part transfer tab

### `addPartInvoiceLine()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** addPartInvoiceLine

### `removeLine()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** removeLine


**Notes** Removes the parts invoice line, returns to stock and corrects ledger as well as removes the purchase order line.  If this fails an ApexPages error is thrown.

### `createFromOrderRequest()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** createFromOrderRequest


**Notes** Used as a special method to create the transfer from the "Order"

### `voidTransfer()`

void method for the transfer record

#### Return

**Type**

PageReference

**Description**

PageReference


**Method** void

### `lookupPartsInvoice(Id invoiceId)`
#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|record id of the invoice that we will be looking up|

#### Return

**Type**

dealer__Parts_Invoice__c

**Description**

dealer__Parts_Invoice__c


**Method** lookupPartsInvoice

### `getInvoiceLines()`
#### Return

**Type**

List&lt;dealer__Parts_Invoice_Line__c&gt;

**Description**

List&lt;dealer__Parts_Invoice_Line__c&gt;


**Method** getInvoiceLines


**Notes** getter returning list of invoice lines from the partsinvoiceapi based on the public invoice variable

### `lookupPurchaseOrder(Id poId)`
#### Parameters

|Param|Description|
|---|---|
|`poId`|record Id of the purchase order that you are interested looking up|

#### Return

**Type**

dealer__Purchase_Order__c

**Description**

dealer__Purchase_Order__c


**Method** lookupPurchaseOrder

### `getPurchaseOrderLines()`
#### Return

**Type**

List&lt;dealer__Purchase_Order_Line__c&gt;

**Description**

List&lt;dealer__Purchase_Order_Line__c&gt;


**Method** getPurchaseOrderLines


**Notes** getter method to retern list of purchase order lines based on the public variable po

---
