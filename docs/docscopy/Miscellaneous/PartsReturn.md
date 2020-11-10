---
layout: default
---
# PartsReturn class

 	PartsReturn processes the return of parts to a purchasing vendor 		Without Sharing - This class accesses Read Only objects for historical tracking (Parts Ledger) 		to-do : pre-populate the shipping address of the vendor based on the account record. 				return value to be at LIFO and tied to a purchase order line item *Mandatory Field, derive value from the purchase order this was purchased on 				add a tracking number 				add a reason for return (Open Notes Field) /** 2016-1-24	|Jarrett Kuljis		|W-000614 Correct quantity issue when adding a line to a return 2016-12-21 	|Jarrett Kuljis		|W-000837 Price field was not present resulting in failure when adding a new return line.

---
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
### `addReturnLine()` → `PageReference`

 addReturnLine

### `cancel()` → `PageReference`

 cancel

### `deleteLine()` → `PageReference`

 	Delete Part Line @test PartManagementServiceLayer.testPartsReturn

### `getInvoiceLines()` → `List<dealer__Parts_Invoice_Line__c>`

 	Parts Lines added to the Return Invoice @test PartManagementServiceLayer.testPartsReturn

### `getpoLines()` → `List<SelectOption>`

 	SelectOption of all purchase orders this part was sold against that do not have a sell out line

### `invoiceRecord()` → `PageReference`

 	Invoice - invoice the record and prepare for posting to General Ledger @test PartManagementServiceLayer.testPartsReturn

### `reloadPOLines()` → `PageReference`

 	Part selected pagereference to reload the polines @test PartManagementServiceLayer.testPartsReturn

### `save()` → `PageReference`

 	Save - Save the new record or update the existing record. @test PartManagementServiceLayer.testPartsReturn

### `voidRecord()` → `PageReference`

 	Void - void if no lines are present @test PartManagementServiceLayer.testPartsReturn

---
