---
layout: default
---
# PartInvoiceLineTriggerHandler
## Constructors
### `public PartInvoiceLineTriggerHandler()`
---
## Properties

### `public inventoryAdjustments` → `List<Parts_Inventory__c>`


### `public invoiceMap` → `Map<Id,Parts_Invoice__c>`


### `public partMap` → `Map<Id,Parts_Inventory__c>`


### `public pricingStrategyMap` → `Map<Id,Parts_Service_Pricing_Strategy__c>`


### `public svcJobs` → `Map<Id,Service_Job__c>`


### `public matrixLines` → `List<Parts_Invoice_Line__c>`


### `public fops` → `FixedOperationsSettings__c`


### `public dms` → `DMS_Settings__c`


---
## Methods
### `public void handleBeforeInsert(List<Parts_Invoice_Line__c> ListDealerInvoice)`
### `public void handleBeforeUpdate(List<Parts_Invoice_Line__c> ListDealerInvoice, Map<Id,Parts_Invoice_Line__c> OldMapDealerParts)`
### `public void roundTaxAmount(List<Parts_Invoice_Line__c> triggerNew)`

Before Insert / Update - Round total tax

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|

### `public Parts_Inventory__c calculateSaleLineTotal(Parts_Invoice_Line__c newSaleLine, Parts_Invoice_Line__c oldSaleLine)`

calculates various fields related to the total price of the parts invoice line for sales

#### Parameters

|Param|Description|
|---|---|
|`newSaleLine`|newSaleLine description|
|`oldSaleLine`|oldSaleLine description|

#### Returns

|Type|Description|
|---|---|
|`Parts_Inventory__c`|return description|


**Method** calculateSaleLineTotal

### `public void handlePayType(List<Parts_Invoice_Line__c> ListDealerInvoice)`
### `public void setLineType(List<Parts_Invoice_Line__c> triggerNew)`

Strictly enforces part/misc code exclusivity as well as populating line type

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setLineType

### `public void setLineNonTaxable(List<Parts_Invoice_Line__c> triggerNew)`

setLineNonTaxable

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|

### `public void updatePartInvoiceTotals(Map<Id,Parts_Invoice_Line__c> triggerMap)`

updatePartInvoiceTotals updates parts invoice non taxable totals

#### Parameters

|Param|Description|
|---|---|
|`triggerMap`|triggerMap description|

### `public void handleUpdateLineType(List<Parts_Invoice_Line__c> triggerNew, Map<Id,Parts_Invoice_Line__c> triggerOldMap)`

check for changes that require lineType logic to fire

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|


**Method** handleUpdateLineType

### `public void handleAfterRollup(List<Parts_Invoice_Line__c> ListDealerInvoice)`
### `public void handleAfterInsertHistory(List<Parts_Invoice_Line__c> listInvoiceLine)`
### `public void handleDeleteMethod(List<Parts_Invoice_Line__c> ListDealerInvoice)`
### `public void calculateMatrixNet(List<Parts_Invoice_Line__c> lines)`

Retrieves pricing based on matrix

#### Parameters

|Param|Description|
|---|---|
|`lines`|lines description|

### `public Decimal calculateNet(Parts_Invoice_Line__c partLine)`

checks the pricing strategy on the invoice to determine net value to use

#### Parameters

|Param|Description|
|---|---|
|`partLine`|partLine description|

#### Returns

|Type|Description|
|---|---|
|`Decimal`|return description|

### `public void queryInvoices(Set<Id> invoiceIds)`

Queries invoices to get fields from the pricing strategy on the invoice

#### Parameters

|Param|Description|
|---|---|
|`invoiceIds`|invoiceIds description|


**Method** queryInvoices

### `public void queryParts(Set<Id> partIds)`

Queries parts to return pricing fields used in net calculation

#### Parameters

|Param|Description|
|---|---|
|`partIds`|partIds description|


**Method** queryParts

### `public void queryStrategies(Set<Id> psIds)`

Queries pricing strategies to return fields used in net calculation

#### Parameters

|Param|Description|
|---|---|
|`psIds`|psIds description|


**Method** queryParts

### `public void setTotalMisc(List<Parts_Invoice_Line__c> triggerNew)`

setTotalMisc sets the total misc field on invoice lines for rolling up at the invoice header level

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|incoming trigger records|

---
