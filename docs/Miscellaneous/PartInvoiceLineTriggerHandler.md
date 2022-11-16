# PartInvoiceLineTriggerHandler

`APIVERSION: 45`

`STATUS: ACTIVE`
## Constructors
### `PartInvoiceLineTriggerHandler()`
---
## Properties

### `dms` → `DMS_Settings__c`


### `fops` → `FixedOperationsSettings__c`


### `inventoryAdjustments` → `List<Parts_Inventory__c>`


### `invoiceMap` → `Map<Id,Parts_Invoice__c>`


### `partMap` → `Map<Id,Parts_Inventory__c>`


### `pricingStrategyMap` → `Map<Id,Parts_Service_Pricing_Strategy__c>`


### `svcJobs` → `Map<Id,Service_Job__c>`


---
## Methods
### `handleBeforeInsert(List<Parts_Invoice_Line__c> ListDealerInvoice)`
### `handleBeforeUpdate(List<Parts_Invoice_Line__c> ListDealerInvoice, Map<Id,Parts_Invoice_Line__c> OldMapDealerParts)`
### `calculateSaleLineTotal(Parts_Invoice_Line__c newSaleLine, Parts_Invoice_Line__c oldSaleLine)`

calculates various fields related to the total price of the parts invoice line for sales

#### Parameters

|Param|Description|
|---|---|
|`newSaleLine`|newSaleLine description|
|`oldSaleLine`|oldSaleLine description|

#### Return

**Type**

Parts_Inventory__c

**Description**

return description


**Method** calculateSaleLineTotal

### `handlePayType(List<Parts_Invoice_Line__c> ListDealerInvoice)`
### `setLineType(List<Parts_Invoice_Line__c> triggerNew)`

Strictly enforces part/misc code exclusivity as well as populating line type

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setLineType

### `handleUpdateLineType(List<Parts_Invoice_Line__c> triggerNew, Map<Id,Parts_Invoice_Line__c> triggerOldMap)`

check for changes that require lineType logic to fire

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|


**Method** handleUpdateLineType

### `handleAfterRollup(List<Parts_Invoice_Line__c> ListDealerInvoice)`
### `handleAfterInsertHistory(List<Parts_Invoice_Line__c> listInvoiceLine)`
### `handleDeleteMethod(List<Parts_Invoice_Line__c> ListDealerInvoice)`
### `calculateNet(Parts_Invoice_Line__c partLine)`

checks the pricing strategy on the invoice to determine net value to use

#### Parameters

|Param|Description|
|---|---|
|`partLine`|partLine description|

#### Return

**Type**

Decimal

**Description**

return description


**Method** calculateNet

### `queryInvoices(Set<Id> invoiceIds)`

Queries invoices to get fields from the pricing strategy on the invoice

#### Parameters

|Param|Description|
|---|---|
|`invoiceIds`|invoiceIds description|


**Method** queryInvoices

### `queryParts(Set<Id> partIds)`

Queries parts to return pricing fields used in net calculation

#### Parameters

|Param|Description|
|---|---|
|`partIds`|partIds description|


**Method** queryParts

### `queryStrategies(Set<Id> psIds)`

Queries pricing strategies to return fields used in net calculation

#### Parameters

|Param|Description|
|---|---|
|`psIds`|psIds description|


**Method** queryParts

---
