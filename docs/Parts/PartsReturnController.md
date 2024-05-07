---
layout: default
---
# PartsReturnController



**Group** Parts

## Methods
### `public static Parts_Invoice__c saveReturn(Parts_Invoice__c pi)`

`AURAENABLED`

updates or creates new Parts_Invoice__c record with certain fields populated

#### Parameters

|Param|Description|
|---|---|
|`recordId`|Id of the Parts_Invoice__c to upsert|

#### Returns

|Type|Description|
|---|---|
|`Parts_Invoice__c`|Parts_Invoice__c saved record with current data|


**Method** saveReturn

### `public static void voidReturn(String piId)`

`AURAENABLED`

marks Parts_Invoice__c record as void

#### Parameters

|Param|Description|
|---|---|
|`recordId`|Id of the Parts_Invoice__c to void|

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** voidReturn

### `public static void invoiceReturn(String piId)`

`AURAENABLED`

marks Parts_Invoice__c record as invoiced

#### Parameters

|Param|Description|
|---|---|
|`recordId`|Id of the Parts_Invoice__c to invoice|

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** invoiceReturn

### `public static Parts_Invoice__c getReturn(String recordId)`

`AURAENABLED`

Returns all fields from the Parts_Invoice__c record Id provided

#### Parameters

|Param|Description|
|---|---|
|`recordId`|Id of the Parts_Invoice__c to query|

#### Returns

|Type|Description|
|---|---|
|`Parts_Invoice__c`|Parts_Invoice__c with all fields queried|


**Method** getReturn

### `public static string getRecordTypeName(String rtId)`

`AURAENABLED`

Returns records type name from recordType Id

#### Parameters

|Param|Description|
|---|---|
|`rtId`|Id of the recordType to get name|

#### Returns

|Type|Description|
|---|---|
|`string`|String Name of the record type|


**Method** getRecordTypeName

### `public static List<Parts_Invoice_Line__c> getPartLines(String piId)`

`AURAENABLED`

Gets all Parts_Invoice_Line__c records for the Parts_Invoice__c Id provided

#### Parameters

|Param|Description|
|---|---|
|`piId`|Id Parts_Invoice__c record Id to retrieve lines|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Invoice_Line__c>`|List<Parts_Invoice_Line__c> on the invoice|


**Method** getPartLines

### `public static List<Parts_Inventory__c> getAvailableParts(String piId)`

`AURAENABLED`

Gets all Parts_Inventory__c records matching location from the Parts_Invoice__c Id provided

#### Parameters

|Param|Description|
|---|---|
|`piId`|Id Parts_Invoice__c record Id to retrieve location|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Inventory__c>`|List<Parts_Inventory__c> related to the location|


**Method** getAvailableParts

### `public static List<Parts_Inventory__c> getAvailablePartsWithCore(String piId, Boolean coreCharge)`

`AURAENABLED`

Gets all Parts_Inventory__c records with core charges matching location from the Parts_Invoice__c Id provided

#### Parameters

|Param|Description|
|---|---|
|`piId`|Id Parts_Invoice__c record Id to retrieve location|
|`coreCharge`|Boolean for filtering by parts with a core charge|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Inventory__c>`|List<Parts_Inventory__c> related to the location|


**Method** getAvailableParts

### `public static List<LookupSearchResult> recentPurchaseOrderResult(Id acctId)`

`AURAENABLED`

Gets all Purchase_Order_Line__c records for a given part that have not been marked returned

#### Parameters

|Param|Description|
|---|---|
|`partId`|Id Parts_Inventory__c record|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|


**Method** recentPurchaseOrderResult

### `public static List<LookupSearchResult> searchPurchaseOrders(String searchTerm, String acctId)`

`AURAENABLED`

Searches Purchase Orders

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|String|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static void saveReturnLine(Parts_Invoice_Line__c line)`

`AURAENABLED`

Process new return line, checks the order line as returned to vendor and updates ledger

#### Parameters

|Param|Description|
|---|---|
|`piId`|Id of the Parts_Invoice__c to create a line under|
|`line`|Parts_Invoice_Line__c to create|

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** saveReturnLine

### `public static void editReturnLine(Parts_Invoice_Line__c line)`

`AURAENABLED`

Process existing return line

#### Parameters

|Param|Description|
|---|---|
|`piId`|Id of the Parts_Invoice__c to create a line under|
|`line`|Parts_Invoice_Line__c to create|

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** editReturnLine

### `public static Boolean deleteLine(Parts_Invoice_Line__c line)`

`AURAENABLED`

removes a return line unchecks the order line as returned to vendor and reverses ledger

#### Parameters

|Param|Description|
|---|---|
|`lineId`|Parts_Invoice_Line__c to delete|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|true upon success|


**Method** deleteLine

### `public static List<LookupSearchResult> recentPartsInvoiceResult(Id acctId)`

`AURAENABLED`

Retrieves recent Parts Invoices

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static List<LookupSearchResult> recentPartsInvoiceResult(Id acctId, Boolean coreCharge)`

`AURAENABLED`

overloaded method for retrieving recent Parts Invoices with core charges

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static List<LookupSearchResult> searchPartsInvoice(String searchTerm, String acctId)`

`AURAENABLED`

Searches Parts Invoices

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|String|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static List<LookupSearchResult> selectedPartsInvoice(String invoiceId)`

`AURAENABLED`

Retrieves selected Parts Invoice record

#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|String|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

---
