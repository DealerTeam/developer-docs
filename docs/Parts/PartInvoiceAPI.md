# PartInvoiceAPI

`APIVERSION: 45`

`STATUS: ACTIVE`

**Group** Parts

## Methods
### `static invoice(Id invoiceId)`
#### Parameters
|Param|Description|
|---|---|

### `static createInvoice(Parts_Invoice__c ivs)`
#### Parameters
|Param|Description|
|---|---|

### `static addInvoiceLine(Id invoiceId, Id jobLineId, Id partId, Decimal quantity, Decimal salePrice, String comment)`
#### Parameters
|Param|Description|
|---|---|

### `static addMiscLines(List<Parts_Invoice_Line__c> lines)`

creates miscellaneous invoice lines, this must be limited to a single parent invoice

#### Parameters
|Param|Description|
|---|---|
|`lines`|lines description|

#### Return

**Type**

List&lt;Parts_Invoice_Line__c&gt;

**Description**

return description


**Method** addMiscLines

### `static updateMiscLines(List<Parts_Invoice_Line__c> lines)`

update existing miscellaneous invoice lines, this must be limited to a single parent invoice

#### Parameters
|Param|Description|
|---|---|
|`lines`|lines description|

#### Return

**Type**

List&lt;Parts_Invoice_Line__c&gt;

**Description**

return description


**Method** updateMiscLines

### `static addInvoiceLines(List<Parts_Invoice_Line__c> lines)`
#### Parameters
|Param|Description|
|---|---|

### `static removeInvoiceLine(Id invoiceLineId)`

removeInvoiceLine - Removes an invoice line from the parts invoice, resets inventory and re-assigns stock.

#### Parameters
|Param|Description|
|---|---|
|`Id`|of the invoice line requesting removal|

### `static removeInvoiceLine(List<Parts_Invoice_Line__c> partInvoiceLines)`

removeInvoiceLine - removes an invoice line or many by list of invoice lines

#### Parameters
|Param|Description|
|---|---|
|`List`|of Parts Invoice Lines|

### `static updateInvoiceLine(List<InvoiceLineWrapper> lines)`

processes updates to a collectino of invoice lines

#### Parameters
|Param|Description|
|---|---|
|`lineId`|lineId description|
|`quantity`|quantity description|
|`salePrice`|salePrice description|
|`comment`|comment description|

#### Return

**Type**

List&lt;Parts_Invoice_Line__c&gt;

**Description**

return description

### `static updateInvoiceLine(Id lineId, Decimal quantity, Decimal salePrice, String comment)`
#### Parameters
|Param|Description|
|---|---|

### `static invoiceLines(Id invoiceId)`

[invoiceLines description]

#### Parameters
|Param|Description|
|---|---|
|`invoiceId`|[description]|

#### Return

**Type**

List&lt;dealer__Parts_Invoice_Line__c&gt;

**Description**

[description]

---
## Classes
### InvoiceLineWrapper
#### Fields

##### `comment` → `String`


##### `corePrice` → `Decimal`


##### `lineId` → `Id`


##### `quantity` → `Decimal`


##### `salePrice` → `Decimal`


##### `taxable` → `Boolean`


---

### PartInvoiceAPIException

---
