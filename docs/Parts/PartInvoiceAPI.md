# PartInvoiceAPI

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Parts

## Methods
### `static invoice(Id invoiceId)`
### `static createInvoice(Parts_Invoice__c ivs)`
### `static addInvoiceLine(Id invoiceId, Id jobLineId, Id partId, Decimal quantity, Decimal salePrice, String comment)`
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
### `static invoiceLines(Id invoiceId)`
#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|description|

#### Return

**Type**

List&lt;dealer__Parts_Invoice_Line__c&gt;

**Description**

description


**Method** invoiceLines

### `static postInvoice(Id invoiceId)`
### `static declineLines(List<Parts_Invoice_Line__c> lines)`

Sets Part Invoice Lines to declined status and update related Parts

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|

#### Return

**Type**

List&lt;Parts_Invoice_Line__c&gt;

**Description**

return description

### `static updatePartQuantities(Parts_Invoice_Line__c line, InvoiceLineWrapper lineWrapper, Parts_Inventory__c part, String status)`

Set Part Invoice Lines to allocated and update related Part quantities

#### Parameters

|Param|Description|
|---|---|
|`line`|line that needs to update part quantities|
|`lineWrapper`|wrapper with new quantities for update|
|`part`|inventory record whose various quantity fields will be update depending upon status|
|`status`|Status the line is moving into|

### `static invoke(List<InvocableParams> params)`

`INVOCABLEMETHOD`

Method used to call supported methods via invocable apex

#### Parameters

|Param|Description|
|---|---|
|`params`|params description|

#### Return

**Type**

List&lt;InvocableResponse&gt;

**Description**

return description


**Method** invoke

---
## Classes
### InvocableParams

Wrapper to hold all invocable variable inputs needed for invoke method

#### Fields

##### `methodName` → `String`

`INVOCABLEVARIABLE` 

##### `partLines` → `List&lt;Parts_Invoice_Line__c&gt;`

`INVOCABLEVARIABLE` 

---

### InvocableResponse

Wrapper to hold data returned by invocable

#### Fields

##### `message` → `String`

`INVOCABLEVARIABLE` 

##### `partLines` → `List&lt;Parts_Invoice_Line__c&gt;`

`INVOCABLEVARIABLE` 

##### `status` → `String`

`INVOCABLEVARIABLE` 

---

### InvoiceLineWrapper
#### Fields

##### `comment` → `String`


##### `corePrice` → `Decimal`


##### `ledgers` → `List&lt;Parts_Ledger__c&gt;`


##### `lineId` → `Id`


##### `quantity` → `Decimal`


##### `quantityFilled` → `Decimal`


##### `salePrice` → `Decimal`


##### `status` → `String`


##### `taxable` → `Boolean`


---

### PartInvoiceAPIException

**Inheritance**

PartInvoiceAPIException


---
