---
layout: default
---
# PartsOrderLineControlHandler
## Constructors
### `private PartsOrderLineControlHandler(List<PartsOrderLine__c> newLines, List<PartsOrderLine__c> oldLines)`

PurchaseOrderLineControlHandler constructor in private scope for singleton pattern


**Constructor** 

---
## Fields

### `private instance` → `PartsOrderLineControlHandler`


### `private invLines` → `List<Parts_Invoice_Line__c>`


### `private parts` → `Map<Id,Parts_Inventory__c>`


### `private partMapToUpdate` → `Map<Id,Parts_Inventory__c>`


### `private negativeLedgersOnInvoice` → `Map<Id,List<Parts_Ledger__c>>`


### `private negativeLedgers` → `Map<Id,List<Parts_Ledger__c>>`


### `private submittedLedgers` → `Map<Id,List<Parts_Ledger__c>>`


### `private ledgersToUpsert` → `List<Parts_Ledger__c>`


### `private statusList` → `Set<String>`


---
## Methods
### `public static PartsOrderLineControlHandler getInstance(List<PartsOrderLine__c> newLines, List<PartsOrderLine__c> oldLines)`

getInstance applies the Lazy Load pattern Singleton approach

### `public static Boolean isRunning()`

Checks for an instance of the class without constructing one

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|

### `public void setLineName(List<PartsOrderLine__c> triggerNew)`

Sets the line count and Name based on the Manifest header and related lines

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|

### `public void setPartFromMaster(List<PartsOrderLine__c> triggerNew)`

Populate parts inventory from master if null

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|

### `public void setLineStatus(List<PartsOrderLine__c> triggerNew, Map<Id,PartsOrderLine__c> triggerOldMap)`
### `public void processLineQuantity(List<PartsOrderLine__c> triggerNew, Map<Id,PartsOrderLine__c> triggerOldMap)`

When quantity processed is changed on a line, update ledgers and parts inventory records to reflect stock change

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|

### `public void handleAfterDelete(List<PartsOrderLine__c> triggerOld)`

update related part quantities when order line is deleted

#### Parameters

|Param|Description|
|---|---|
|`triggerOld`|triggerOld description|

### `private void handleQuantityChange(PartsOrderLine__c line, PartsOrderLine__c oldLine)`

Runs when the quantity field is changed on an order line to update Part

#### Parameters

|Param|Description|
|---|---|
|`line`|line description|
|`oldLine`|oldLine description|

### `private void handleQuantityReduction(PartsOrderLine__c line, Integer qty)`
### `private void handleProcessedChange(PartsOrderLine__c line, PartsOrderLine__c oldLine)`

Update part and ledgers based on qty processed changes

#### Parameters

|Param|Description|
|---|---|
|`line`|New Parts Order Line|
|`oldLine`|Old Parts Order Line|

### `private void handleStatusChange(PartsOrderLine__c line, PartsOrderLine__c oldLine)`

Update ledger status if line status changes

#### Parameters

|Param|Description|
|---|---|
|`line`|New line|
|`oldLine`|Old line|

### `public void updateHeader(List<PartsOrderLine__c> triggerRecords, Map<Id,PartsOrderLine__c> triggerOldMap)`

Update header values based on line changes

#### Parameters

|Param|Description|
|---|---|
|`triggerRecords`|triggerRecords description|
|`triggerOldMap`|triggerOldMap description|

### `public void updateInvoiceLines(List<PartsOrderLine__c> triggerNew, Map<Id,PartsOrderLine__c> triggerOldMap)`
### `public void performDML()`

Handles the dml for various related record collections after trigger is finished

### `private List<Parts_Ledger__c> updateRelatedLedgers(PartsOrderLine__c line, Integer qty, Boolean received)`

Update or create ledger records based on line and qty inputs

#### Parameters

|Param|Description|
|---|---|
|`line`|New Parts Order Line|
|`qty`|Number of ledgers to process|
|`received`|Indicates if the change is based on line qty or processed qty|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Ledger__c>`|return description|

### `private Map<Id,PartsOrder__c> getParentOrders(List<PartsOrderLine__c> lines)`
### `private void getCageCount(PartsOrder__c order)`

Returns the number of unique cages across all lines for the order

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|
|`orderMap`|orderMap description|

#### Returns

|Type|Description|
|---|---|
|`void`|return description|

### `private Integer getLineQuantity(PartsOrderLine__c line, PartsOrderLine__c oldLine, Boolean processed)`

Returns pack-inclusive change in quantity

#### Parameters

|Param|Description|
|---|---|
|`line`|New Parts Order Line|
|`oldLine`|Old Parts Order Line|
|`processed`|Indicates if the change is based on line qty or processed qty|

#### Returns

|Type|Description|
|---|---|
|`Integer`|return description|

### `private void queryParts(Set<Id> partIds)`

queryParts uses soqlFactory to query parts once and return previous results on subsequent calls

#### Parameters

|Param|Description|
|---|---|
|`newLines`|incoming trigger records to check for ids|

### `private Map<Id,PartsOrderLine__c> getChangedLines(List<PartsOrderLine__c> newLines, Map<Id,PartsOrderLine__c> triggerOldMap)`

Returns a map of lines where Quantity or Quantity Processed changed

#### Parameters

|Param|Description|
|---|---|
|`newLines`|newLines description|
|`triggerOldMap`|triggerOldMap description|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,PartsOrderLine__c>`|return description|

### `private Boolean hasLineChanged(PartsOrderLine__c newLine, PartsOrderLine__c oldLine)`
### `private Map<Id,PartsOrderLine__c> getProcessedChanged(List<PartsOrderLine__c> newLines, Map<Id,PartsOrderLine__c> triggerOldMap)`
### `private Map<Id,PartsOrderLine__c> getQuantityReductionAndStatusChange(List<PartsOrderLine__c> newLines, Map<Id,PartsOrderLine__c> triggerOldMap)`
### `private void queryNegativeLedgers(List<PartsOrderLine__c> lines)`

Queries negative ledgers related to a set of invoice line Ids

#### Parameters

|Param|Description|
|---|---|
|`invoiceLineIds`|invoiceLineIds description|

### `private void queryRelatedLedgers(List<PartsOrderLine__c> lines)`

Queries negative ledgers related to a set of invoice line Ids

#### Parameters

|Param|Description|
|---|---|
|`invoiceLineIds`|invoiceLineIds description|

### `public void beforeDeleteProcessLedgers(Map<Id,PartsOrderLine__c> triggerOldMap)`

Update ledgers related to an invoice, otherwise delete

#### Parameters

|Param|Description|
|---|---|
|`triggerOldMap`|triggerOldMap description|

### `private void removeOrDeleteLedgers(List<Parts_Ledger__c> ledgers)`

Remove PO reference if an invoice line is related to the ledger, otherwise delete

#### Parameters

|Param|Description|
|---|---|
|`ledgers`|ledgers description|

#### Returns

|Type|Description|
|---|---|
|`void`|return description|

### `private void decrementLedger(Parts_Ledger__c ledger)`

Sets values of ledgers to be decremented

#### Parameters

|Param|Description|
|---|---|
|`ledger`|ledger description|

### `private static Set<Id> getRelatedInvoiceLines(Set<Id> poLineIds)`
---
