# PartsReturnAPI

`APIVERSION: 48`

`STATUS: ACTIVE`



**Group** Parts

## Methods
### `static savePartsInvoice(Parts_Invoice__c pi)`

Creates or updates a Parts Invoice

#### Parameters

|Param|Description|
|---|---|
|`pi`|Parts_Invoice__c|

### `static addReturnLine(Parts_Invoice_Line__c returnLine)`

Performs the process of adding a line to the Parts Return

#### Parameters

|Param|Description|
|---|---|
|`pi`|Parts Invoice|
|`returnLine`|Parts_Invoice_Line__c to return|

### `static editReturnLine(Parts_Invoice_Line__c returnLine)`
### `static addVendorLine(Parts_Invoice_Line__c returnLine)`

Performs the process of adding a line to the Vendor Return

#### Parameters

|Param|Description|
|---|---|
|`pi`|Parts Invoice|
|`returnLine`|Parts_Invoice_Line__c to return|

### `static addCounterLine(Parts_Invoice_Line__c returnLine)`

Performs the process of adding a line to the Counter Return

#### Parameters

|Param|Description|
|---|---|
|`returnLine`|Parts_Invoice_Line__c to return|

### `static addCoreLine(Parts_Invoice_Line__c returnLine)`

Database save method for Core Return Parts Invoice lines

#### Parameters

|Param|Description|
|---|---|
|`returnLine`|- parts invoice line being saved|


**Method** addCoreLine

### `static editVendorLine(Parts_Invoice_Line__c returnLine)`
### `static editCounterLine(Parts_Invoice_Line__c returnLine)`
### `static editCoreLine(Parts_Invoice_Line__c returnLine)`

Performs relevant database updates to core return invoice line on edit

#### Parameters

|Param|Description|
|---|---|
|`returnLine`|invoice line to edit|


**Method** editCoreLine

### `static deleteLine(Parts_Invoice_Line__c line)`

Deletes Part Line

#### Parameters

|Param|Description|
|---|---|
|`line`||

### `static deleteVendorLine(Parts_Invoice_Line__c line)`
### `static deleteCounterLine(Parts_Invoice_Line__c returnLine)`
### `static deleteCoreLine(Parts_Invoice_Line__c returnLine)`

Method for deletion of core return invoice lines

#### Parameters

|Param|Description|
|---|---|
|`returnLine`|- line to delete|


**Method** deleteCoreLine

### `static getPoLines(Parts_Inventory__c part)`

SelectOptions of all purchase orders this part was sold against that do not have a sell out line

#### Parameters

|Param|Description|
|---|---|
|`part`|Part|

#### Return

**Type**

List&lt;SelectOption&gt;

**Description**

List&lt;SelectOption&gt;

### `static voidPartsInvoice(Parts_Invoice__c pi)`

void if no lines are present

#### Parameters

|Param|Description|
|---|---|
|`pi`|Parts Invoice|

### `static invoiceRecord(Parts_Invoice__c pi)`

invoice the record and prepare for posting to General Ledger

#### Parameters

|Param|Description|
|---|---|
|`pi`|Parts Invoice|

### `static getInvoiceLines(Parts_Invoice__c pi)`

Parts Lines added to the Return Invoice

#### Parameters

|Param|Description|
|---|---|
|`pi`|Parts Invoice|

### `static sendAccountingMessage(Parts_Invoice__c pi)`

Sends Accounting Email to accounting solution

#### Parameters

|Param|Description|
|---|---|
|`pi`|Parts Invoice|

### `static setRestockFee(Id invoiceId)`
### `static getRecordTypeName(Id recordId)`
---
## Classes
### PartsReturnAPIException

**Inheritance**

PartsReturnAPIException


---
