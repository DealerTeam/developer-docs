# PartInvoiceAPI class
---
## Methods
### `addInvoiceLine(Id invoiceId, Id jobLineId, Id partId, Decimal quantity, Decimal salePrice, String comment)` → `Parts_Invoice_Line__c`
### `addInvoiceLines(List<Parts_Invoice_Line__c> lines)` → `List<Parts_Invoice_Line__c>`
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

List<dealer__Parts_Invoice_Line__c>

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

### `updateInvoiceLine(Id lineId, Decimal quantity, Decimal salePrice, String comment)` → `Parts_Invoice_Line__c`
---
## Inner Classes

### PartInvoiceAPI.PartInvoiceAPIException class

 ledger @param  partId    Part record Id @param  invoiceId Invoice Record Id @param  qtySold   Quantity sold via this transaction @return List<dealer__Parts_Ledger__c> the resulting ledger lines @notes

---
