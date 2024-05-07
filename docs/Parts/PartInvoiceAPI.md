---
layout: default
---
# PartInvoiceAPI



**Group** Parts

## Fields

### `private INVOCABLE_METHODS` → `List<String>`


### `private existingLineMap` → `Map<Id,Parts_Invoice_Line__c>`


### `public serialMap` → `Map<Id,List<Parts_Ledger__c>>`


### `public skipRelateLedgers` → `Boolean`


---
## Methods
### `global static Parts_Invoice__c invoice(Id invoiceId)`
### `global static Parts_Invoice__c createInvoice(Parts_Invoice__c ivs)`
### `global static Parts_Invoice_Line__c addInvoiceLine(Id invoiceId, Id jobLineId, Id partId, Decimal quantity, Decimal salePrice, String comment)`
### `global static List<Parts_Invoice_Line__c> addMiscLines(List<Parts_Invoice_Line__c> lines)`

creates miscellaneous invoice lines, this must be limited to a single parent invoice

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Invoice_Line__c>`|return description|


**Method** addMiscLines

### `global static List<Parts_Invoice_Line__c> updateMiscLines(List<Parts_Invoice_Line__c> lines)`

update existing miscellaneous invoice lines, this must be limited to a single parent invoice

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Invoice_Line__c>`|return description|


**Method** updateMiscLines

### `global static List<Parts_Invoice_Line__c> addInvoiceLines(List<Parts_Invoice_Line__c> lines)`
### `global static Boolean removeInvoiceLine(Id invoiceLineId)`

removeInvoiceLine - Removes an invoice line from the parts invoice, resets inventory and re-assigns stock.

#### Parameters

|Param|Description|
|---|---|
|`Id`|of the invoice line requesting removal|

### `global static Boolean removeInvoiceLine(List<Parts_Invoice_Line__c> partInvoiceLines)`

removeInvoiceLine - removes an invoice line or many by list of invoice lines

#### Parameters

|Param|Description|
|---|---|
|`List`|of Parts Invoice Lines|

### `global static List<Parts_Invoice_Line__c> updateInvoiceLine(List<InvoiceLineWrapper> lines)`

processes updates to a collectino of invoice lines

#### Parameters

|Param|Description|
|---|---|
|`lineId`|lineId description|
|`quantity`|quantity description|
|`salePrice`|salePrice description|
|`comment`|comment description|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Invoice_Line__c>`|return description|

### `global static Parts_Invoice_Line__c updateInvoiceLine(Id lineId, Decimal quantity, Decimal salePrice, String comment)`
### `global static List<dealer__Parts_Invoice_Line__c> invoiceLines(Id invoiceId)`
#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|description|

#### Returns

|Type|Description|
|---|---|
|`List<dealer__Parts_Invoice_Line__c>`|description|


**Method** invoiceLines

### `public static Parts_Invoice__c postInvoice(Id invoiceId)`
### `public static List<Parts_Invoice_Line__c> declineLines(List<Parts_Invoice_Line__c> lines)`

Sets Part Invoice Lines to declined status and update related Parts

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Invoice_Line__c>`|return description|

### `public static void updatePartQuantities(Parts_Invoice_Line__c line, InvoiceLineWrapper lineWrapper, Parts_Inventory__c part, String status)`

Set Part Invoice Lines to allocated and update related Part quantities

#### Parameters

|Param|Description|
|---|---|
|`line`|line that needs to update part quantities|
|`lineWrapper`|wrapper with new quantities for update|
|`part`|inventory record whose various quantity fields will be update depending upon status|
|`status`|Status the line is moving into|

### `public static Map<String,String> getReplenishmentStatus(Set<Id> lineIds)`

Sets replenishment status based on ledgers related to the line

#### Parameters

|Param|Description|
|---|---|
|`lineIds`|lineIds description|

#### Returns

|Type|Description|
|---|---|
|`Map<String,String>`|return description|

### `public static Map<Id,List<Parts_Ledger__c>> getLedgersByInvoiceLines(Set<Id> lineIds)`
### `private Map<Id,Decimal> populatePricingStrategyMap(Map<Id,Parts_Invoice_Line__c> lineMap, Map<Id,Parts_Inventory__c> partMap)`
### `private static void populateLedgerMap(InvoiceLineWrapper lineWrapper, Parts_inventory__c part, Decimal qtyDiff)`

Add ledgers related to the wrapper to the serialMap

#### Parameters

|Param|Description|
|---|---|
|`lineWrapper`|lineWrapper description|
|`part`|part description|
|`qtyDiff`|Net change in qty|

### `private List<Parts_Ledger__c> ledger(Id partId, Id invoiceId, Decimal qtySold)`
#### Parameters

|Param|Description|
|---|---|
|`partId`|Part record Id|
|`invoiceId`|Invoice Record Id|
|`qtySold`|Quantity sold via this transaction|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Ledger__c>`|List<dealer__Parts_Ledger__c> the resulting ledger lines|


**Method** ledger


**Notes** 

### `private static Map<Id,List<Parts_Ledger__c>> bulkLedger(List<Parts_Invoice_Line__c> partSalesLines, Map<Id,List<Parts_Ledger__c>> serialLedgerMap)`

Get all positive ledgers not related to a Parts Invoice Line and relate to the provided lines

#### Parameters

|Param|Description|
|---|---|
|`partSalesLines`|invoice lines where value in the qty fields is net change|
|`serialLedgerMap`|ledgers manually provided to process first|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,List<Parts_Ledger__c>>`|return description|

### `private static List<Parts_Ledger__c> cleanAvailableLedgers(List<Parts_Ledger__c> processedLedgers, List<Parts_Ledger__c> prevAvailable)`

Used to reassess which ledgers are available for processing

#### Parameters

|Param|Description|
|---|---|
|`processedLedgers`|Ledgers related to a sale in last iteration|
|`prevAvailable`|Ledgers available to sell prior to last iteration|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Ledger__c>`|Ledgers unrelated to a sale and still available|

### `private static List<Parts_Ledger__c> ledgerProcessFIFO(Parts_Invoice_Line__c invoiceLine, List<Parts_Ledger__c> availableLedgerLines, Integer quantity)`

Relate an ledgers to a line or create negative ledgers if needed

#### Parameters

|Param|Description|
|---|---|
|`invoiceLine`|invoiceLine description|
|`availableLedgerLines`|Ledgers can be available ledgers to sell or specified serials or reserve ledgers|
|`quantity`|Number of ledgers to process|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Ledger__c>`|return description|

### `private static List<Parts_Ledger__c> processFilledLedgers(Parts_Invoice_Line__c invoiceLine, List<Parts_Ledger__c> existingLedgerLines, List<Parts_Ledger__c> processedLedgers)`
### `private static List<Parts_Ledger__c> createNegativeLedger(Parts_Invoice_Line__c invoiceLine, Decimal qty)`

Instantiate and return new negative sale ledgers based on the line

#### Parameters

|Param|Description|
|---|---|
|`invoiceLine`|Line used to build the ledgers|
|`qty`|Number of ledgers to be created|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Ledger__c>`|List of instantiated but not committed ledgers|

### `private static List<Parts_Ledger__c> relateExistingLedger(Parts_Invoice_Line__c invoiceLine, Decimal qty, List<Parts_Ledger__c> existingLedgers)`

Instantiates a list of ledgers based on a list of existing ledgers, an invoice line and a quantity to create

#### Parameters

|Param|Description|
|---|---|
|`invoiceLine`|Line used to relate ledgers|
|`qty`|Number of ledgers to be created|
|`existingLedgers`|Ledgers that will be processed|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Ledger__c>`|List of related ledgers not commited to database|

### `private List<Parts_Ledger__c> ledgerRemoveFromInvoice(Map<Id,Integer> lineMap, Map<Id,Integer> refMap)`

Handles finding and updating the related ledgers for a collection of parts line updates

#### Parameters

|Param|Description|
|---|---|
|`lineMap`|Map of ledger Id and number of ledgers to return to stock|
|`refMap`|Map of ledger Ids and number of ledgers to only remove lookup to the invoice line. Used for allocated lines that have not been decremented|
|`invLineId`|invLineId description|
|`qtyReturned`|qtyReturned description|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Ledger__c>`|return description|


**Method** ledgerRemoveFromInvoice

### `private static void calculateInvoiceTax(Id invoiceId)`
### `private static void removeTaxTransactionItems(List<Parts_Invoice_Line__c> lines)`
### `global static List<InvocableResponse> invoke(List<InvocableParams> params)`

`INVOCABLEMETHOD`

Method used to call supported methods via invocable apex

#### Parameters

|Param|Description|
|---|---|
|`params`|params description|

#### Returns

|Type|Description|
|---|---|
|`List<InvocableResponse>`|return description|


**Method** invoke

### `private static void validateInputs(List<InvocableParams> params)`

Verify the inputs are valid for the invoked method

#### Parameters

|Param|Description|
|---|---|
|`params`|params description|


**Method** validateInputs

### `private static List<Parts_Invoice_Line__c> setLineStatus(List<Parts_Invoice_Line__c> statusLines, Map<Id,Parts_Invoice__c> invoiceMap)`

Sets blank line status to Quoting if feature enabled otherwise Filled

#### Parameters

|Param|Description|
|---|---|
|`statusLines`|statusLines description|
|`invoiceMap`|map holding parent invoices to check record type|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Invoice_Line__c>`|return description|


**Method** setLineStatus

### `private static Parts_Invoice_Line__c assignLineCostFromLedgers(Parts_Invoice_Line__c line, List<Parts_Ledger__c> ledgers)`

assignLineCostFromLedgers - sets the incoming invoice line cost from the sum of ledgers

#### Parameters

|Param|Description|
|---|---|
|`line`|- incoming invoice line|
|`ledgers`|- related ledgers to sum|

#### Returns

|Type|Description|
|---|---|
|`Parts_Invoice_Line__c`|- updated line|

---
## Classes
### InvoiceLineWrapper
#### Fields

##### `global lineId` → `Id`


##### `global quantity` → `Decimal`


##### `global quantityFilled` → `Decimal`


##### `global salePrice` → `Decimal`


##### `global comment` → `String`


##### `global taxable` → `Boolean`


##### `global corePrice` → `Decimal`


##### `global status` → `String`


##### `global ledgers` → `List&lt;Parts_Ledger__c&gt;`


---

### PartInvoiceAPIException

**Inheritance**

PartInvoiceAPIException


### InvocableParams

Wrapper to hold all invocable variable inputs needed for invoke method

#### Fields

##### `global methodName` → `String`

`INVOCABLEVARIABLE` 

##### `global partInvoice` → `Parts_Invoice__c`

`INVOCABLEVARIABLE` 

##### `global partLines` → `List&lt;Parts_Invoice_Line__c&gt;`

`INVOCABLEVARIABLE` 

---

### InvocableResponse

Wrapper to hold data returned by invocable

#### Fields

##### `global partLines` → `List&lt;Parts_Invoice_Line__c&gt;`

`INVOCABLEVARIABLE` 

##### `global status` → `String`

`INVOCABLEVARIABLE` 

##### `global message` → `String`

`INVOCABLEVARIABLE` 

---

---
