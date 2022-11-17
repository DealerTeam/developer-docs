# PartsReturnController

`APIVERSION: 48`

`STATUS: ACTIVE`



**Group** Parts

## Methods
### `static saveReturn(Parts_Invoice__c pi)`

`AURAENABLED`

updates or creates new Parts_Invoice__c record with certain fields populated

#### Parameters

|Param|Description|
|---|---|
|`recordId`|Id of the Parts_Invoice__c to upsert|

#### Return

**Type**

Parts_Invoice__c

**Description**

Parts_Invoice__c saved record with current data


**Method** saveReturn

### `static voidReturn(String piId)`

`AURAENABLED`

marks Parts_Invoice__c record as void

#### Parameters

|Param|Description|
|---|---|
|`recordId`|Id of the Parts_Invoice__c to void|

#### Return

**Type**

void

**Description**

void


**Method** voidReturn

### `static invoiceReturn(String piId)`

`AURAENABLED`

marks Parts_Invoice__c record as invoiced

#### Parameters

|Param|Description|
|---|---|
|`recordId`|Id of the Parts_Invoice__c to invoice|

#### Return

**Type**

void

**Description**

void


**Method** invoiceReturn

### `static getReturn(String recordId)`

`AURAENABLED`

Returns all fields from the Parts_Invoice__c record Id provided

#### Parameters

|Param|Description|
|---|---|
|`recordId`|Id of the Parts_Invoice__c to query|

#### Return

**Type**

Parts_Invoice__c

**Description**

Parts_Invoice__c with all fields queried


**Method** getReturn

### `static getRecordTypeName(String rtId)`

`AURAENABLED`

Returns records type name from recordType Id

#### Parameters

|Param|Description|
|---|---|
|`rtId`|Id of the recordType to get name|

#### Return

**Type**

string

**Description**

String Name of the record type


**Method** getRecordTypeName

### `static getPartLines(String piId)`

`AURAENABLED`

Gets all Parts_Invoice_Line__c records for the Parts_Invoice__c Id provided

#### Parameters

|Param|Description|
|---|---|
|`piId`|Id Parts_Invoice__c record Id to retrieve lines|

#### Return

**Type**

List&lt;Parts_Invoice_Line__c&gt;

**Description**

List&lt;Parts_Invoice_Line__c&gt; on the invoice


**Method** getPartLines

### `static getAvailableParts(String piId)`

`AURAENABLED`

Gets all Parts_Inventory__c records matching location from the Parts_Invoice__c Id provided

#### Parameters

|Param|Description|
|---|---|
|`piId`|Id Parts_Invoice__c record Id to retrieve location|

#### Return

**Type**

List&lt;Parts_Inventory__c&gt;

**Description**

List&lt;Parts_Inventory__c&gt; related to the location


**Method** getAvailableParts

### `static getAvailablePartsWithCore(String piId, Boolean coreCharge)`

`AURAENABLED`

Gets all Parts_Inventory__c records with core charges matching location from the Parts_Invoice__c Id provided

#### Parameters

|Param|Description|
|---|---|
|`piId`|Id Parts_Invoice__c record Id to retrieve location|
|`coreCharge`|Boolean for filtering by parts with a core charge|

#### Return

**Type**

List&lt;Parts_Inventory__c&gt;

**Description**

List&lt;Parts_Inventory__c&gt; related to the location


**Method** getAvailableParts

### `static recentPurchaseOrderResult(Id acctId)`

`AURAENABLED`

Gets all Purchase_Order_Line__c records for a given part that have not been marked returned

#### Parameters

|Param|Description|
|---|---|
|`partId`|Id Parts_Inventory__c record|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt;


**Method** recentPurchaseOrderResult

### `static searchPurchaseOrders(String searchTerm, String acctId)`

`AURAENABLED`

Searches Purchase Orders

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|String|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt;

### `static saveReturnLine(Parts_Invoice_Line__c line)`

`AURAENABLED`

Process new return line, checks the order line as returned to vendor and updates ledger

#### Parameters

|Param|Description|
|---|---|
|`piId`|Id of the Parts_Invoice__c to create a line under|
|`line`|Parts_Invoice_Line__c to create|

#### Return

**Type**

void

**Description**

void


**Method** saveReturnLine

### `static editReturnLine(Parts_Invoice_Line__c line)`

`AURAENABLED`

Process existing return line

#### Parameters

|Param|Description|
|---|---|
|`piId`|Id of the Parts_Invoice__c to create a line under|
|`line`|Parts_Invoice_Line__c to create|

#### Return

**Type**

void

**Description**

void


**Method** editReturnLine

### `static deleteLine(Parts_Invoice_Line__c line)`

`AURAENABLED`

removes a return line unchecks the order line as returned to vendor and reverses ledger

#### Parameters

|Param|Description|
|---|---|
|`lineId`|Parts_Invoice_Line__c to delete|

#### Return

**Type**

Boolean

**Description**

true upon success


**Method** deleteLine

### `static recentPartsInvoiceResult(Id acctId)`

`AURAENABLED`

Retrieves recent Parts Invoices

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt;

### `static recentPartsInvoiceResult(Id acctId, Boolean coreCharge)`

`AURAENABLED`

overloaded method for retrieving recent Parts Invoices with core charges

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt;

### `static searchPartsInvoice(String searchTerm, String acctId)`

`AURAENABLED`

Searches Parts Invoices

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|String|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt;

### `static selectedPartsInvoice(String invoiceId)`

`AURAENABLED`

Retrieves selected Parts Invoice record

#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|String|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt;

---
