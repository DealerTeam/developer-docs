# PartsReturn

`APIVERSION: 45`

`STATUS: ACTIVE`
## Constructors
### `PartsReturn(ApexPages.StandardController c)`
---
## Properties

### `deleteRowId` → `Id`


### `lineCount` → `Integer`


### `location` → `dealer__Dealer_Location__c`


### `partsRecordId` → `String`


### `pi` → `dealer__Parts_Invoice__c`


### `purchaseOrderId` → `String`


### `returnLine` → `dealer__Parts_Invoice_Line__c`


---
## Methods
### `getpoLines()`

SelectOption of all purchase orders this part was sold against that do not have a sell out line

#### Return

**Type**

List&lt;SelectOption&gt;

**Description**

List SelectOption - purchase order lines with PO name


**Test** PartManagementServiceLayer.testPartsReturn

### `reloadPOLines()`

Part selected pagereference to reload the polines


**Test** PartManagementServiceLayer.testPartsReturn

### `voidRecord()`

Void - void if no lines are present


**Test** PartManagementServiceLayer.testPartsReturn

### `invoiceRecord()`

Invoice - invoice the record and prepare for posting to General Ledger


**Test** PartManagementServiceLayer.testPartsReturn

### `save()`

Save - Save the new record or update the existing record.


**Test** PartManagementServiceLayer.testPartsReturn

### `cancel()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** cancel


**Notes** Returns to the PartsReturns page as declared on the custom tab.


**Test** PartManagementServiceLayer.testPartsReturn

### `addReturnLine()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** addReturnLine


**Notes** Performs the process of adding a line to the Parts Return.


**Test** PartManagementServiceLayer.testPartsReturn

### `deleteLine()`

Delete Part Line


**Test** PartManagementServiceLayer.testPartsReturn

### `getInvoiceLines()`

Parts Lines added to the Return Invoice


**Test** PartManagementServiceLayer.testPartsReturn

---
