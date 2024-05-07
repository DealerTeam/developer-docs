---
layout: default
---
# PurchaseOrderLineControlHandler

Handler for PurchaseOrderLineControl trigger Test class: PurchaseOrderLineControlTest


**Group** Parts

## Constructors
### `private PurchaseOrderLineControlHandler(List<Purchase_Order_Line__c> newLines, List<Purchase_Order_Line__c> oldLines)`

PurchaseOrderLineControlHandler constructor in private scope for singleton pattern


**Constructor** 

---
## Fields

### `private instance` → `PurchaseOrderLineControlHandler`


### `private jobs` → `List<Service_Job__c>`


### `private invLines` → `Map<Id,Parts_Invoice_Line__c>`


### `private parts` → `Map<Id,Parts_Inventory__c>`


---
## Methods
### `public static PurchaseOrderLineControlHandler getInstance(List<Purchase_Order_Line__c> newLines, List<Purchase_Order_Line__c> oldLines)`

getInstance applies the Lazy Load pattern Singleton approach

### `public static Boolean isRunning()`

Checks for an instance of the class without constructing one

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|

### `public void updateParts(Set<Id> newPartIds)`

Used to refresh data on specific part IDs when the data becomes stale, currently called by Parts Inventory trigger

#### Parameters

|Param|Description|
|---|---|
|`newPartIds`|newPartIds description|

### `private void queryJobs(List<Purchase_Order_Line__c> newLines)`

queryJobs uses soqlFactory to query service jobs once and return previous results on subsequent calls

#### Parameters

|Param|Description|
|---|---|
|`newLines`|incoming trigger records to check for ids|

### `private void queryParts(List<Purchase_Order_Line__c> newLines)`

queryParts uses soqlFactory to query parts once and return previous results on subsequent calls

#### Parameters

|Param|Description|
|---|---|
|`newLines`|incoming trigger records to check for ids|

### `private void queryInvoiceLines(List<Purchase_Order_Line__c> newLines)`

queryInvoiceLines uses soqlFactory to query invoice lines once and return previous results on subsequent calls

#### Parameters

|Param|Description|
|---|---|
|`newLines`|incoming trigger records to check for ids|

### `public void handleBeforeInsertUpdate(List<Purchase_Order_Line__c> purchaseOrderLineList)`

This method runs on before insert / update context

#### Parameters

|Param|Description|
|---|---|
|`Purchase_Order_Line__c`|list|

### `public void handleBeforeDelete(List<Purchase_Order_Line__c> purchaseOrderLineOldList)`

This method runs on before delete context

#### Parameters

|Param|Description|
|---|---|
|`Purchase_Order_Line__c`|Old list|

### `public void handleBeforeUpdate(List<Purchase_Order_Line__c> purchaseOrderLineList, Map<Id,Purchase_Order_Line__c> purchaseOrderLineOldMap)`

This method runs on before update context

#### Parameters

|Param|Description|
|---|---|
|`Purchase_Order_Line__c`|list|
|`Id`|, Purchase_Order_Line__c Old Map|

### `public void handleBeforeInsert(List<Purchase_Order_Line__c> purchaseOrderLineList)`

This method runs on before insert context

#### Parameters

|Param|Description|
|---|---|
|`Purchase_Order_Line__c`|list|

### `public void handleAfterUpdate(List<Purchase_Order_Line__c> purchaseOrderLineList, Map<Id,Purchase_Order_Line__c> purchaseOrderLineOldMap)`

This method runs on after update context

#### Parameters

|Param|Description|
|---|---|
|`Purchase_Order_Line__c`|list|
|`Id`|, Purchase_Order_Line__c Old Map|

### `public void handleAfterDelete(List<Purchase_Order_Line__c> purchaseOrderLineOldList)`

This method runs on after delete context

#### Parameters

|Param|Description|
|---|---|
|`Purchase_Order_Line__c`|Old list|

### `public void handleAfterInsertUpdate(List<Purchase_Order_Line__c> purchaseOrderLineList, Map<Id,Purchase_Order_Line__c> purchaseOrderLineOldMap)`
### `public void setLineType(List<Purchase_Order_Line__c> triggerNew, Map<Id,Purchase_Order_Line__c> triggerOldMap)`

Validates line type exclusivity and sets the line type field

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|


**Method** setLineType

### `public void setCoreCharge(List<Purchase_Order_Line__c> triggerNew)`

updates the total core charge as product of Part Qty and Core

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setCoreCharge

### `public void preventDuplicateLines(List<Purchase_Order_Line__c> triggerNew)`

Executed when config is set to verify only one line exists on a PO for each master record

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|

### `private void processPartsAndLedgers(Map<Id,Purchase_Order_Line__c> partsInvPOLineMap, Map<Id,Purchase_Order_Line__c> purchaseOrderLineOldMap)`

Handles updates to Parts Inventory and Ledgers based on lines

#### Parameters

|Param|Description|
|---|---|
|`partsInvPOLineMap`|Map of Purchase Order Lines by Part Id|
|`purchaseOrderLineOldMap`|Trigger Old Map|

### `private Map<Id,Integer> getPartCount(Map<Id,Purchase_Order_Line__c> partsInvPOLineMap, Map<Id,Purchase_Order_Line__c> purchaseOrderLineOldMap)`

Get the quantity changed for each part inclusive of pack quantity

#### Parameters

|Param|Description|
|---|---|
|`partsInvPOLineMap`|partsInvPOLineMap description|
|`purchaseOrderLineOldMap`|purchaseOrderLineOldMap description|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,Integer>`|return description|

### `private String getMasterRecordId(Purchase_Order_Line__c line)`

Used to determine which related object is the driving record for the line

#### Parameters

|Param|Description|
|---|---|
|`line`|line description|

#### Returns

|Type|Description|
|---|---|
|`String`|return description|

### `private List<Parts_Ledger__c> updateRelatedLedgers(Purchase_Order_Line__c line, Integer qty, Map<Id,Parts_Ledger__c> existingLedgers)`

Instantiate ledgers based on line and changes in quantity

#### Parameters

|Param|Description|
|---|---|
|`line`|Purchase Order Line being processed|
|`qty`|Number of ledgers to process inclusive of pack|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Ledger__c>`|return description|

### `private static void deleteRelatedLedgers(Map<Id,Integer> linesWithCount)`

Delete or remove PO reference for lines where quantity is reduced

#### Parameters

|Param|Description|
|---|---|
|`linesWithCount`|linesWithCount description|

### `public void beforeDeleteProcessLedgers(Map<Id,Purchase_Order_Line__c> triggerOldMap)`

Update ledgers related to an invoice, otherwise delete

#### Parameters

|Param|Description|
|---|---|
|`triggerOldMap`|triggerOldMap description|

### `private static void removeOrDeleteLedgers(List<Parts_Ledger__c> ledgers)`

Remove PO reference if an invoice line is related to the ledger, otherwise delete

#### Parameters

|Param|Description|
|---|---|
|`ledgers`|ledgers description|

#### Returns

|Type|Description|
|---|---|
|`void`|return description|

### `private static Set<Id> getRelatedInvoiceLines(Set<Id> poLineIds)`
---
