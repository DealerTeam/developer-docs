# PartsInvoiceController

`APIVERSION: 50`

`STATUS: ACTIVE`



**Group** Parts

## Methods
### `static searchAccounts(String searchTerm, Boolean isVendor)`

`AURAENABLED`
### `static getSelection(Id recordId, String objectName)`

`AURAENABLED`

returns lookupSearchResult for an Id and object name

#### Parameters

|Param|Description|
|---|---|
|`recordId`|Id of record to get lookupsearchresult to display in lookup component|
|`objectName`|api name of the object for matching correct lookupsearch class|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt; a single result in the list for populating lookup component


**Method** getSelection

### `static recentAccounts(Boolean isVendor)`

`AURAENABLED`

Returns recently viewed Account records

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt;

### `static saveInvoice(Parts_Invoice__c pi)`

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

### `static availableInvoiceLines(Id returnId, Id invoiceId, Id partId, Id acctId)`

`AURAENABLED`

queries Parts_Invoice_Line__c records related to the invoice or part provided

#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|Id of the parent Parts_Invoice__c|
|`partId`|Id of the related Parts_Inventory__c|

#### Return

**Type**

List&lt;Parts_Invoice_Line__c&gt;

**Description**

List&lt;Parts_Invoice_Line__c&gt; lines related to the given inputs


**Method** availableInvoiceLines

### `static selectedInvoiceLines(Id returnId)`

`AURAENABLED`

queries Parts_Invoice_Line__c records related to the return invoice id

#### Parameters

|Param|Description|
|---|---|
|`returnId`|Id of the parent Parts_Invoice__c|

#### Return

**Type**

List&lt;Parts_Invoice_Line__c&gt;

**Description**

List&lt;Parts_Invoice_Line__c&gt; lines related to the given inputs


**Method** selectedInvoiceLines

### `static availableOrderLines(Id returnId, Id orderId, Id partId, Id acctId)`

`AURAENABLED`

queries Purchase_Order_Line__c records related to the purchase order or part provided

#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|Id of the parent Purchase_Order__c|
|`partId`|Id of the related Parts_Inventory__c|

#### Return

**Type**

List&lt;Purchase_Order_Line__c&gt;

**Description**

List&lt;Parts_Invoice_Line__c&gt; lines related to the given inputs


**Method** availableOrderLines

### `static invoiceLines(Id returnId, Id invoiceId, Id partId, Id acctId)`

`AURAENABLED`
### `static coreLines(Id returnId, Id invoiceId, Id partId, Id acctId)`

`AURAENABLED`

overloaded method for supplying selector lines to core return pi's

#### Parameters

|Param|Description|
|---|---|
|`returnId`||
|`invoiceId`||
|`partId`||
|`acctId`||

#### Return

**Type**

DealController.Lines

**Description**

DealController.Lines wrapped list of selected and available records


**Method** coreLines

### `static orderLines(Id returnId, Id orderId, Id partId, Id acctId)`

`AURAENABLED`
### `static getInvoice(String recordId)`

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


**Method** getInvoice

### `static getStrategies(String currentStrategy, String newStrategy)`

`AURAENABLED`

Returns two pricing strategies where first is current and second is new, for displaying record detail in LWC

#### Parameters

|Param|Description|
|---|---|
|`currentStrategy`|Id of the current pricing strategy to query|
|`newStrategy`|Id of the proposed pricing strategy to query|

#### Return

**Type**

List&lt;Parts_Service_Pricing_Strategy__c&gt;

**Description**

List&lt;Parts_Service_Pricing_Strategy__c&gt; with all fields queried


**Method** getStrategies

### `static calculateStrategyPricing(List<Parts_Inventory__c> parts, Id pricingStratId)`

`AURAENABLED`
### `static getRelatedContacts(Id acctId)`

`AURAENABLED`
### `static searchContacts(String searchTerm, String accId)`

`AURAENABLED`

search contacts related to an account for a given string

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|term to search|
|`accId`|account to find related contacts|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt; contacts to display in lookup component


**Method** searchContacts

### `static relatedContacts(String accountId)`

`AURAENABLED`

returns all contacts related to a given account

#### Parameters

|Param|Description|
|---|---|
|`accountId`|account to find related contacts|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt; contacts to display in lookup component


**Method** relatedContacts

### `static reopenInvoice(Id invoiceId)`

`AURAENABLED`

checks an invoice is closed and if true will reopen and update dates

#### Parameters

|Param|Description|
|---|---|
|`invoiceId`|invoiceId description|


**Method** reopenInvoice

### `static postInvoice(Id invoiceId)`

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
##### `AccountContactWrapper(Account acct, List&lt;String&gt; conList)`
---
#### Fields

##### `account` → `Account`

`AURAENABLED` 

##### `contactIds` → `List&lt;String&gt;`

`AURAENABLED` 

---

---
