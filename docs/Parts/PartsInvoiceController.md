---
layout: default
---
# PartsInvoiceController



**Group** Parts

## Methods
### `public static List<LookupSearchResult> searchAccounts(String searchTerm, Boolean isVendor)`

`AURAENABLED`
### `public static List<LookupSearchResult> getSelection(Id recordId, String objectName)`

`AURAENABLED`

returns lookupSearchResult for an Id and object name

#### Parameters

|Param|Description|
|---|---|
|`recordId`|Id of record to get lookupsearchresult to display in lookup component|
|`objectName`|api name of the object for matching correct lookupsearch class|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult> a single result in the list for populating lookup component|


**Method** getSelection

### `public static List<LookupSearchResult> recentAccounts(Boolean isVendor)`

`AURAENABLED`

Returns recently viewed Account records

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static Parts_Invoice__c saveInvoice(Parts_Invoice__c pi)`

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

### `public static List<Parts_Invoice_Line__c> availableInvoiceLines(Id returnId, Id invoiceId, Id partId, Id acctId)`

`AURAENABLED`

queries Parts_Invoice_Line__c records related to the invoice or part provided

#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|Id of the parent Parts_Invoice__c|
|`partId`|Id of the related Parts_Inventory__c|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Invoice_Line__c>`|List<Parts_Invoice_Line__c> lines related to the given inputs|


**Method** availableInvoiceLines

### `public static List<Parts_Invoice_Line__c> selectedInvoiceLines(Id returnId)`

`AURAENABLED`

queries Parts_Invoice_Line__c records related to the return invoice id

#### Parameters

|Param|Description|
|---|---|
|`returnId`|Id of the parent Parts_Invoice__c|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Invoice_Line__c>`|List<Parts_Invoice_Line__c> lines related to the given inputs|


**Method** selectedInvoiceLines

### `public static List<Purchase_Order_Line__c> availableOrderLines(Id returnId, Id orderId, Id partId, Id acctId)`

`AURAENABLED`

queries Purchase_Order_Line__c records related to the purchase order or part provided

#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|Id of the parent Purchase_Order__c|
|`partId`|Id of the related Parts_Inventory__c|

#### Returns

|Type|Description|
|---|---|
|`List<Purchase_Order_Line__c>`|List<Parts_Invoice_Line__c> lines related to the given inputs|


**Method** availableOrderLines

### `private static List<Parts_Invoice_Line__c> filterAvailableInvoiceLines(List<Parts_Invoice_Line__c> available, List<Parts_Invoice_Line__c> selected)`

Removes avaialble lines that have no remaining quantity or have already been related to a return line on the invoice

#### Parameters

|Param|Description|
|---|---|
|`available`|available lines related to the part or invoice|
|`selected`|selected return lines|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Invoice_Line__c>`|return description|


**Method** filterAvailable

### `private static List<Purchase_Order_Line__c> filterAvailablePurchaseOrderLines(List<Purchase_Order_Line__c> available, List<Parts_Invoice_Line__c> selected)`

Removes avaialble lines that have no remaining quantity or have already been related to a return line on the invoice

#### Parameters

|Param|Description|
|---|---|
|`available`|available lines related to the part or invoice|
|`selected`|selected return lines|

#### Returns

|Type|Description|
|---|---|
|`List<Purchase_Order_Line__c>`|return description|


**Method** filterAvailable

### `public static DealController invoiceLines(Id returnId, Id invoiceId, Id partId, Id acctId)`

`AURAENABLED`
### `public static DealController coreLines(Id returnId, Id invoiceId, Id partId, Id acctId)`

`AURAENABLED`

overloaded method for supplying selector lines to core return pi's

#### Parameters

|Param|Description|
|---|---|
|`returnId`||
|`invoiceId`||
|`partId`||
|`acctId`||

#### Returns

|Type|Description|
|---|---|
|`DealController`|DealController.Lines wrapped list of selected and available records|


**Method** coreLines

### `public static DealController orderLines(Id returnId, Id orderId, Id partId, Id acctId)`

`AURAENABLED`
### `public static Parts_Invoice__c getInvoice(String recordId)`

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


**Method** getInvoice

### `public static List<Parts_Service_Pricing_Strategy__c> getStrategies(String currentStrategy, String newStrategy)`

`AURAENABLED`

Returns two pricing strategies where first is current and second is new, for displaying record detail in LWC

#### Parameters

|Param|Description|
|---|---|
|`currentStrategy`|Id of the current pricing strategy to query|
|`newStrategy`|Id of the proposed pricing strategy to query|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Service_Pricing_Strategy__c>`|List<Parts_Service_Pricing_Strategy__c> with all fields queried|


**Method** getStrategies

### `public static List<Decimal> calculateStrategyPricing(List<Parts_Inventory__c> parts, Id pricingStratId)`

`AURAENABLED`
### `public static AccountContactWrapper getRelatedContacts(Id acctId)`

`AURAENABLED`
### `public static List<LookupSearchResult> searchContacts(String searchTerm, String accId)`

`AURAENABLED`

search contacts related to an account for a given string

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|term to search|
|`accId`|account to find related contacts|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult> contacts to display in lookup component|


**Method** searchContacts

### `public static List<LookupSearchResult> relatedContacts(String accountId)`

`AURAENABLED`

returns all contacts related to a given account

#### Parameters

|Param|Description|
|---|---|
|`accountId`|account to find related contacts|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult> contacts to display in lookup component|


**Method** relatedContacts

### `public static void reopenInvoice(Id invoiceId)`

`AURAENABLED`

checks an invoice is closed and if true will reopen and update dates

#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|invoiceId description|


**Method** reopenInvoice

### `public static void postInvoice(Id invoiceId)`

`AURAENABLED`

sets invoice to posted if it is fully paid

#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|invoiceId description|


**Method** postInvoice

---
## Classes
### AccountContactWrapper
#### Constructors
##### `public AccountContactWrapper(Account acct, List&lt;String&gt; conList)`
---
#### Fields

##### `public account` → `Account`

`AURAENABLED` 

##### `public contactIds` → `List&lt;String&gt;`

`AURAENABLED` 

---

---
