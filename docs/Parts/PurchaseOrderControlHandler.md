---
layout: default
---
# PurchaseOrderControlHandler

Domain layer controller for Purchase_Order__c


**Group** Parts


**Test** //TODO


**Notes** Sharing is inheritted as this class is commonly used within the context of a trigger

## Fields

### `public closedStatuses` → `Set<String>`


---
## Methods
### `public void setDefaultValues(List<Purchase_Order__c> triggerNew)`

set Default values within the insert/update context of the Purchase Order header

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|List<Purchase_Order__c> new trigger context|

### `public void populateVIN(List<Purchase_Order__c> triggerNew)`
### `public void validateStatus(List<Purchase_Order__c> triggerNew, Map<Id,Purchase_Order__c> triggerOldMap)`
### `public void updatePartTransfers(List<Purchase_Order__c> triggerNew, Map<Id,Purchase_Order__c> triggerOldMap)`
### `public static void protectReceiveRecords(List<Purchase_Order_Receiving__c> triggerEvents)`

Prevent edits, deletion of records This context should only apply to update/delete


**Test** PartOrderingDomainLayer.testPOTrigger

### `public void updateVendorInfo(List<Purchase_Order__c> triggerNew)`
### `public void preventDelete(List<Purchase_Order__c> triggerOld)`
### `public void validateLinesReceived(Map<Id,Purchase_Order__c> triggerNewMap)`

Checks that the sum of Purchase Order Receiving Lines is equal to Total PO Amount

#### Parameters

|Param|Description|
|---|---|
|`triggerNewMap`|triggerNewMap description|


**Method** validateLinesReceived

### `public void setTotalOrder(List<Purchase_Order__c> triggerNew)`

calculates the TotalOrder__c for the Purchase Order

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setTotalOrder

### `public void setVersionNumber(List<Purchase_Order__c> triggerNew)`

sets the Last Modified in Version field to the currently installed Dealerteam package version

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setVersionNumber

### `public void checkVendorIsDealerActive(List<Purchase_Order__c> triggerNew)`
---
