---
layout: default
---
# PartsReturn
## Constructors
### `public PartsReturn(ApexPages c)`
---
## Properties

### `public pi` → `dealer__Parts_Invoice__c`


### `public location` → `dealer__Dealer_Location__c`


### `public returnLine` → `dealer__Parts_Invoice_Line__c`


### `public deleteRowId` → `Id`


### `public purchaseOrderId` → `String`


### `public partsRecordId` → `String`


### `public lineCount` → `Integer`


---
## Methods
### `public List<SelectOption> getpoLines()`

SelectOption of all purchase orders this part was sold against that do not have a sell out line

#### Returns

|Type|Description|
|---|---|
|`List<SelectOption>`|List SelectOption - purchase order lines with PO name|


**Test** PartManagementServiceLayer.testPartsReturn

### `public PageReference reloadPOLines()`

Part selected pagereference to reload the polines


**Test** PartManagementServiceLayer.testPartsReturn

### `public PageReference voidRecord()`

Void - void if no lines are present


**Test** PartManagementServiceLayer.testPartsReturn

### `public PageReference invoiceRecord()`

Invoice - invoice the record and prepare for posting to General Ledger


**Test** PartManagementServiceLayer.testPartsReturn

### `public PageReference save()`

Save - Save the new record or update the existing record.


**Test** PartManagementServiceLayer.testPartsReturn

### `public PageReference cancel()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** cancel


**Notes** Returns to the PartsReturns page as declared on the custom tab.


**Test** PartManagementServiceLayer.testPartsReturn

### `public PageReference addReturnLine()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** addReturnLine


**Notes** Performs the process of adding a line to the Parts Return.


**Test** PartManagementServiceLayer.testPartsReturn

### `public PageReference deleteLine()`

Delete Part Line


**Test** PartManagementServiceLayer.testPartsReturn

### `public List<dealer__Parts_Invoice_Line__c> getInvoiceLines()`

Parts Lines added to the Return Invoice


**Test** PartManagementServiceLayer.testPartsReturn

---
