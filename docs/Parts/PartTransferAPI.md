# PartTransferAPI

`APIVERSION: 45`

`STATUS: ACTIVE`

PartTransferAPI - Service Layer encapsulation


**Group** Parts

## Methods
### `static createTransferLine(PartTransfer__c transfer, Parts_Invoice__c invoice, List<POvSOCheckboxWrapper> lineWrapperList, String comment)`
#### Parameters

|Param|Description|
|---|---|
|`PartTransfer__c`||
|`Parts_Invoice__c`||
|`List`|<POvSOCheckboxWrapper>, Holds parts master, order Id and Quantity|
|`String`|, line comment|

#### Return

**Type**

List&lt;Parts_Invoice_Line__c&gt;

**Description**

Parts_Invoice__c


**Method** createPartInvoiceLine


**Test** PartManagementServiceLayer.testNewTransfer

---
## Classes
### PartTransferAPIException

**Inheritance**

PartTransferAPIException


---
