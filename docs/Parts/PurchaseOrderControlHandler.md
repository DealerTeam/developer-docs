# PurchaseOrderControlHandler

`APIVERSION: 49`

`STATUS: ACTIVE`



**Group** Parts

## Fields

### `closedStatuses` → `Set<String>`


---
## Methods
### `populateVIN(List<Purchase_Order__c> triggerNew)`
### `validateStatus(List<Purchase_Order__c> triggerNew, Map<Id,Purchase_Order__c> triggerOldMap)`
### `updatePartTransfers(List<Purchase_Order__c> triggerNew, Map<Id,Purchase_Order__c> triggerOldMap)`
### `static protectReceiveRecords(List<Purchase_Order_Receiving__c> triggerEvents)`

Prevent edits, deletion of records This context should only apply to update/delete


**Test** PartOrderingDomainLayer.testPOTrigger

### `updateVendorInfo(List<Purchase_Order__c> triggerNew)`
### `preventDelete(List<Purchase_Order__c> triggerOld)`
### `validateLinesReceived(Map<Id,Purchase_Order__c> triggerNewMap)`

Checks that the sum of Purchase Order Receiving Lines is equal to Total PO Amount

#### Parameters

|Param|Description|
|---|---|
|`triggerNewMap`|triggerNewMap description|


**Method** validateLinesReceived

### `setTotalOrder(List<Purchase_Order__c> triggerNew)`

calculates the TotalOrder__c for the Purchase Order

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setTotalOrder

### `setVersionNumber(List<Purchase_Order__c> triggerNew)`

sets the Last Modified in Version field to the currently installed Dealerteam package version

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setVersionNumber

---
