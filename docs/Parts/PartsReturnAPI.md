---
layout: default
---
# PartsReturnAPI



**Group** Parts

## Methods
### `public static Parts_Invoice__c savePartsInvoice(Parts_Invoice__c pi)`

Creates or updates a Parts Invoice

#### Parameters

|Param|Description|
|---|---|
|`pi`|Parts_Invoice__c|

### `public static void addReturnLine(Parts_Invoice_Line__c returnLine)`

Performs the process of adding a line to the Parts Return

#### Parameters

|Param|Description|
|---|---|
|`pi`|Parts Invoice|
|`returnLine`|Parts_Invoice_Line__c to return|

### `public static void editReturnLine(Parts_Invoice_Line__c returnLine)`
### `public static void addVendorLine(Parts_Invoice_Line__c returnLine)`

Performs the process of adding a line to the Vendor Return

#### Parameters

|Param|Description|
|---|---|
|`pi`|Parts Invoice|
|`returnLine`|Parts_Invoice_Line__c to return|

### `public static void addCounterLine(Parts_Invoice_Line__c returnLine)`

Performs the process of adding a line to the Counter Return

#### Parameters

|Param|Description|
|---|---|
|`returnLine`|Parts_Invoice_Line__c to return|

### `public static void addCoreLine(Parts_Invoice_Line__c returnLine)`

Database save method for Core Return Parts Invoice lines

#### Parameters

|Param|Description|
|---|---|
|`returnLine`|- parts invoice line being saved|


**Method** addCoreLine

### `public static void editVendorLine(Parts_Invoice_Line__c returnLine)`
### `public static void editCounterLine(Parts_Invoice_Line__c returnLine)`
### `public static void editCoreLine(Parts_Invoice_Line__c returnLine)`

Performs relevant database updates to core return invoice line on edit

#### Parameters

|Param|Description|
|---|---|
|`returnLine`|invoice line to edit|


**Method** editCoreLine

### `public static void deleteLine(Parts_Invoice_Line__c line)`

Deletes Part Line

#### Parameters

|Param|Description|
|---|---|
|`line`||

### `public static void deleteVendorLine(Parts_Invoice_Line__c line)`
### `public static void deleteCounterLine(Parts_Invoice_Line__c returnLine)`
### `public static void deleteCoreLine(Parts_Invoice_Line__c returnLine)`

Method for deletion of core return invoice lines

#### Parameters

|Param|Description|
|---|---|
|`returnLine`|- line to delete|


**Method** deleteCoreLine

### `public static List<SelectOption> getPoLines(Parts_Inventory__c part)`

SelectOptions of all purchase orders this part was sold against that do not have a sell out line

#### Parameters

|Param|Description|
|---|---|
|`part`|Part|

#### Returns

|Type|Description|
|---|---|
|`List<SelectOption>`|List<SelectOption>|

### `public static void voidPartsInvoice(Parts_Invoice__c pi)`

void if no lines are present

#### Parameters

|Param|Description|
|---|---|
|`pi`|Parts Invoice|

### `public static void invoiceRecord(Parts_Invoice__c pi)`

invoice the record and prepare for posting to General Ledger

#### Parameters

|Param|Description|
|---|---|
|`pi`|Parts Invoice|

### `public static List<Parts_Invoice_Line__c> getInvoiceLines(Parts_Invoice__c pi)`

Parts Lines added to the Return Invoice

#### Parameters

|Param|Description|
|---|---|
|`pi`|Parts Invoice|

### `public static void sendAccountingMessage(Parts_Invoice__c pi)`

Sends Accounting Email to accounting solution

#### Parameters

|Param|Description|
|---|---|
|`pi`|Parts Invoice|

### `public static void setRestockFee(Id invoiceId)`
### `public static String getRecordTypeName(Id recordId)`
### `private static void createReturnTaxes(Parts_Invoice_Line__c line, List<TaxTransactionItem__c> taxItems)`

creates tax transaction items based on line being returned

#### Parameters

|Param|Description|
|---|---|
|`line`|Parts_Invoice_Line__c description|


**Method** createReturnTaxes

### `private static void updateReturnTaxes(Parts_Invoice_Line__c line, List<TaxTransactionItem__c> taxItems)`

updates tax transaction items on existing return lines

#### Parameters

|Param|Description|
|---|---|
|`line`|line description|
|`taxItems`|taxItems description|


**Method** updateReturnTaxes

---
## Classes
### PartsReturnAPIException

**Inheritance**

PartsReturnAPIException


---
