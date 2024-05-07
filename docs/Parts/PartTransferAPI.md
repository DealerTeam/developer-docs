---
layout: default
---
# PartTransferAPI

PartTransferAPI - Service Layer encapsulation


**Group** Parts

## Methods
### `public static List<Parts_Invoice_Line__c> createTransferLine(PartTransfer__c transfer, Parts_Invoice__c invoice, List<POvSOCheckboxWrapper> lineWrapperList, String comment)`
#### Parameters

|Param|Description|
|---|---|
|`PartTransfer__c`||
|`Parts_Invoice__c`||
|`List`|<POvSOCheckboxWrapper>, Holds parts master, order Id and Quantity|
|`String`|, line comment|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Invoice_Line__c>`|Parts_Invoice__c|


**Method** createPartInvoiceLine


**Test** PartManagementServiceLayer.testNewTransfer

---
## Classes
### PartTransferAPIException

**Inheritance**

PartTransferAPIException


---
