# PartInvoiceAPI class
---
## Methods
### `addInvoiceLine(Id invoiceId, Id jobLineId, Id partId, Decimal quantity, Decimal salePrice, String comment)` → `Parts_Invoice_Line__c`
### `addInvoiceLines(List<Parts_Invoice_Line__c> lines)` → `List<Parts_Invoice_Line__c>`
### `addMiscLines(List<Parts_Invoice_Line__c> lines)` → `List<Parts_Invoice_Line__c>`

creates miscellaneous invoice lines, this must be limited to a single parent invoice

#### Parameters
|Param|Description|
|-----|-----------|
|`lines` |  lines description |

#### Return

**Type**

List&lt;Parts_Invoice_Line__c&gt;

**Description**

return description

### `createInvoice(Parts_Invoice__c ivs)` → `Parts_Invoice__c`
### `invoice(Id invoiceId)` → `Parts_Invoice__c`
### `invoiceLines(Id invoiceId)` → `List<dealer__Parts_Invoice_Line__c>`

 [invoiceLines description]

#### Parameters
|Param|Description|
|-----|-----------|
|`invoiceId` |  [description] |

#### Return

**Type**

List&lt;dealer__Parts_Invoice_Line__c&gt;

**Description**

[description]

### `removeInvoiceLine(Id invoiceLineId)` → `Boolean`

 	removeInvoiceLine - Removes an invoice line from the parts invoice, resets inventory and re-assigns stock.

#### Parameters
|Param|Description|
|-----|-----------|
|`Id` |  of the invoice line requesting removal |

### `removeInvoiceLine(List<Parts_Invoice_Line__c> partInvoiceLines)` → `Boolean`

 removeInvoiceLine - removes an invoice line or many by list of invoice lines

#### Parameters
|Param|Description|
|-----|-----------|
|`List` |  of Parts Invoice Lines |

### `updateInvoiceLine(List<InvoiceLineWrapper> lines)` → `List<Parts_Invoice_Line__c>`

processes updates to a collectino of invoice lines

#### Parameters
|Param|Description|
|-----|-----------|
|`lineId` |     lineId description |
|`quantity` |   quantity description |
|`salePrice` |  salePrice description |
|`comment` |    comment description |

#### Return

**Type**

List&lt;Parts_Invoice_Line__c&gt;

**Description**

return description

### `updateInvoiceLine(Id lineId, Decimal quantity, Decimal salePrice, String comment)` → `Parts_Invoice_Line__c`
### `updateMiscLines(List<Parts_Invoice_Line__c> lines)` → `List<Parts_Invoice_Line__c>`

update existing miscellaneous invoice lines, this must be limited to a single parent invoice

#### Parameters
|Param|Description|
|-----|-----------|
|`lines` |  lines description |

#### Return

**Type**

List&lt;Parts_Invoice_Line__c&gt;

**Description**

return description

---
## Inner Classes

### PartInvoiceAPI.InvoiceLineWrapper class
---
#### Properties

##### `comment` → `String`

##### `corePrice` → `Decimal`

##### `lineId` → `Id`

##### `quantity` → `Decimal`

##### `salePrice` → `Decimal`

##### `taxable` → `Boolean`

---
### PartInvoiceAPI.PartInvoiceAPIException class

Handles finding and updating the related ledgers for a collection of parts line updates @param  invLineId   invLineId description @param  qtyReturned qtyReturned description @return             return description

---
