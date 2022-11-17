# PartInvoiceLineManagerController

`APIVERSION: 47`

`STATUS: ACTIVE`



**Group** Parts

## Constructors
### `PartInvoiceLineManagerController()`
---
## Methods
### `static getPartDetails(Id partId)`

`AURAENABLED`

returns part inventory record given a part inventory id

#### Parameters

|Param|Description|
|---|---|
|`partId`|partId description|

#### Return

**Type**

dealer__Parts_Inventory__c

**Description**

return description


**Method** getPartDetails

### `static partSearchByLocation(string searchTerm, Id locationId)`

`AURAENABLED`

returns parts matching a location and searchTerm formatted for custom input component

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|searchTerm description|
|`locationId`|locationId description|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

return description


**Method** partSearchByLocation

### `static partsMasterSearchByMfg(string searchTerm, String mfg)`

`AURAENABLED`

returns parts matching a manufacturer and searchTerm formatted fro custom input component

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|searchTerm description|
|`mfg`|mfg description|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

return description


**Method** partsMasterSearchByMfg

### `static getPartByMasterLocation(string masterId, Id locationId)`

`AURAENABLED`

returns the location part given the parts master and location IDs

#### Parameters

|Param|Description|
|---|---|
|`masterId`|masterId description|
|`locationId`|locationId description|

#### Return

**Type**

Parts_Inventory__c

**Description**

return description


**Method** getPartByMasterLocation

### `static searchMiscCodes(String searchTerm, String recordId)`

`AURAENABLED`

returns MiscChargeCodes related to an invoice's location and searchTerm

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|searchTerm description|
|`recordId`|recordId description|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

return description


**Method** searchMiscCodes

### `static addInvoicePartLine(List<Parts_Invoice_Line__c> partLines)`

`AURAENABLED`

creates a list of Parts Invoice Lines

#### Parameters

|Param|Description|
|---|---|
|`partLines`|partLines description|

#### Return

**Type**

List&lt;Parts_Invoice_Line__c&gt;

**Description**

return description


**Method** addInvoicePartLine

### `static updatePartLine(Id lineId, Decimal quantity, Decimal salePrice, String comment)`

`AURAENABLED`

lhandles single part line update from LWC

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


**Method** updatePartLine

### `static updatePartLine(List<Parts_Invoice_Line__c> updateLines, Map<Id,List<Parts_Ledger__c>> ledgerMap)`

`AURAENABLED`

updates a list of Parts Invoice Lines via the PartInvoiceAPI

#### Parameters

|Param|Description|
|---|---|
|`updateLines`|updateLines description|
|`ledgerMap`|Map of ledgers organized by line Id that contain serialized ledgers to relate to an invoice line|

#### Return

**Type**

List&lt;Parts_Invoice_Line__c&gt;

**Description**

return description


**Method** updatePartLine

### `static updateInvoiceLines(List<Parts_Invoice_Line__c> lines)`

`AURAENABLED`

updates

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|


**Method** updateInvoiceLines

### `static addMiscPartLines(List<Parts_Invoice_Line__c> lines)`

`AURAENABLED`

accepts a list of part lines related to a single invoice to create as miscellaneous, which do not have any part-related logic involved. Returns all lines related to the invoice.

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|

#### Return

**Type**

List&lt;Parts_Invoice_Line__c&gt;

**Description**

return description


**Method** addMiscPartLines

### `static updateMiscPartLines(List<Parts_Invoice_Line__c> lines)`

`AURAENABLED`

accepts a list of part lines related to a single invoice to update as miscellaneous, which do not have any part-related logic involved. Returns all lines related to the invoice.

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|

#### Return

**Type**

List&lt;Parts_Invoice_Line__c&gt;

**Description**

return description


**Method** updateMiscPartLines

### `static getPartLinesByInvoice(Id invoiceId)`

`AURAENABLED`

returns all Parts Invoice Lines belonging to a Parts Invoice

#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|invoiceId description|

#### Return

**Type**

List&lt;Parts_Invoice_Line__c&gt;

**Description**

return description


**Method** getPartLinesByInvoice

### `static deletePartLine(Id lineId)`

`AURAENABLED`

delete a Parts Invoice line by the provided Id

#### Parameters

|Param|Description|
|---|---|
|`lineId`|lineId description|

#### Return

**Type**

Boolean

**Description**

return description


**Method** deletePartLine

### `static calculateStrategyPricing(Parts_Inventory__c part, Id pricingStratId)`

`AURAENABLED`

applies a price to a Parts Inventory record according to provided Pricing Strategy ID

#### Parameters

|Param|Description|
|---|---|
|`part`|part description|
|`pricingStratId`|pricingStratId description|

#### Return

**Type**

Decimal

**Description**

return description


**Method** calculateStrategyPricing

### `static getCoreCharges(Id invoiceId)`

`AURAENABLED`

returns core charge records sold on the parts invoice Id provided

#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|Parts Invoice the cores were sold on|

#### Return

**Type**

List&lt;CoreCharge__c&gt;

**Description**

List&lt;CoreCharge__c&gt; related core charges


**Method** getCoreCharges

### `static getMiscCodeById(String codeId)`

`AURAENABLED`

getMiscCodeById

#### Parameters

|Param|Description|
|---|---|
|`codeId`|codeId description|

#### Return

**Type**

MiscChargeCode__c

**Description**

return description

### `static declineLines(List<Parts_Invoice_Line__c> lines)`

`AURAENABLED`

Set line status and update quantity of related parts

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|

#### Return

**Type**

Boolean

**Description**

return description

### `static getSerializedLedgers(List<Parts_Invoice_Line__c> lines)`

`AURAENABLED`

Get ledgers with a serial number related to  the parts line or the part

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|

#### Return

**Type**

List&lt;Parts_Ledger__c&gt;

**Description**

return description

---
## Classes
### PartLine
#### Fields

##### `partDescription` → `String`

`AURAENABLED` 

##### `partId` → `String`

`AURAENABLED` 

##### `partName` → `String`

`AURAENABLED` 

---

---
