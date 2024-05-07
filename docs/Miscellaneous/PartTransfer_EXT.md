---
layout: default
---
# PartTransfer_EXT

PartTransfer_EXT keeps control of transfering parts between two locaitons

## Constructors
### `public PartTransfer_EXT(ApexPages controller)`
---
## Properties

### `public transfer` → `dealer__PartTransfer__c`


### `public isOpen` → `boolean`


### `public po` → `dealer__Purchase_Order__c`


### `public invoice` → `dealer__Parts_Invoice__c`


### `public from_location` → `dealer__Dealer_Location__c`


### `public to_location` → `dealer__Dealer_Location__c`


### `public addLine` → `dealer__Parts_Invoice_Line__c`


### `public addPartId` → `Id`


### `public removePartId` → `Id`


### `public addPartQty` → `Decimal`


### `public lineComment` → `String`


### `public partOrder` → `dealer__Parts_Order__c`


### `public lineCount` → `Decimal`


### `public orderNumber` → `String`


### `public ops` → `dealer__FixedOperationsSettings__c`


### `public postingURL` → `String`


### `public ol_list` → `List<POvSOCheckboxWrapper>`


### `public so` → `dealer__Stock_Order__c`


---
## Methods
### `public PageReference create()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageRefernce of the created record PartTransfer__C|


**Method** create

### `public PageReference commitTransfer()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** commitTransfer


**Notes** locks the transfer, creates the purchase order with lines

### `public PageReference reverseTransfer()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** reverseTransfer


**Notes** reverses the transfer record and unwind the transaction in the General Ledger.  This is prevented if the transfer is complete

### `public PageReference save()`
### `public PageReference cancel()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** cancel


**Notes** return user to the part transfer tab

### `public PageReference addPartInvoiceLine()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** addPartInvoiceLine

### `public PageReference removeLine()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** removeLine


**Notes** Removes the parts invoice line, returns to stock and corrects ledger as well as removes the purchase order line.  If this fails an ApexPages error is thrown.

### `public PageReference createFromOrderRequest()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** createFromOrderRequest


**Notes** Used as a special method to create the transfer from the "Order"

### `public PageReference void()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** void


**Notes** void method for the transfer record

### `public dealer__Parts_Invoice__c lookupPartsInvoice(Id invoiceId)`
#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|record id of the invoice that we will be looking up|

#### Returns

|Type|Description|
|---|---|
|`dealer__Parts_Invoice__c`|dealer__Parts_Invoice__c|


**Method** lookupPartsInvoice

### `public List<dealer__Parts_Invoice_Line__c> getInvoiceLines()`
#### Returns

|Type|Description|
|---|---|
|`List<dealer__Parts_Invoice_Line__c>`|List<dealer__Parts_Invoice_Line__c>|


**Method** getInvoiceLines


**Notes** getter returning list of invoice lines from the partsinvoiceapi based on the public invoice variable

### `public dealer__Purchase_Order__c lookupPurchaseOrder(Id poId)`
#### Parameters

|Param|Description|
|---|---|
|`poId`|record Id of the purchase order that you are interested looking up|

#### Returns

|Type|Description|
|---|---|
|`dealer__Purchase_Order__c`|dealer__Purchase_Order__c|


**Method** lookupPurchaseOrder

### `public List<dealer__Purchase_Order_Line__c> getPurchaseOrderLines()`
#### Returns

|Type|Description|
|---|---|
|`List<dealer__Purchase_Order_Line__c>`|List<dealer__Purchase_Order_Line__c>|


**Method** getPurchaseOrderLines


**Notes** getter method to retern list of purchase order lines based on the public variable po

---
