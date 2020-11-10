---
layout: default
---
# PartInvoiceLineTriggerHandler class

 Date            |Developer            |Work# Notes ---------------------------------------------------------------------------- 2017.01.05       |Gaurav               |W-000858 Modified PartsSalesLine trigger for rolling up cost into Parent Service Job Line. @test PartInvoicingDomainLayer @test PartInvoicingServiceLayer

---
## Constructors
### `PartInvoiceLineTriggerHandler()`
---
## Properties

### `inventoryAdjustments` → `List<Parts_Inventory__c>`

### `invoiceMap` → `Parts_Invoice__c>`

### `partMap` → `Parts_Inventory__c>`

### `pricingStrategyMap` → `Parts_Service_Pricing_Strategy__c>`

### `svcJobs` → `Service_Job__c>`

---
## Methods
### `calculateNet(Parts_Invoice_Line__c partLine)` → `Decimal`

checks the pricing strategy on the invoice to determine net value to use

#### Parameters
|Param|Description|
|-----|-----------|
|`partLine` |  partLine description |

### `handleAfterInsertHistory(List<Parts_Invoice_Line__c> listInvoiceLine)` → `void`
### `handleAfterRollup(List<Parts_Invoice_Line__c> ListDealerInvoice)` → `void`
### `handleBeforeInsert(List<Parts_Invoice_Line__c> ListDealerInvoice)` → `void`
### `handleBeforeUpdate(List<Parts_Invoice_Line__c> ListDealerInvoice,Map<Id,Parts_Invoice_Line__c> OldMapDealerParts)` → `void`
### `handleDeleteMethod(List<Parts_Invoice_Line__c> ListDealerInvoice)` → `void`
### `handlePayType(List<Parts_Invoice_Line__c> ListDealerInvoice)` → `void`
### `queryInvoices(Set<Id> invoiceIds)` → `void`

Queries invoices to get fields from the pricing strategy on the invoice

#### Parameters
|Param|Description|
|-----|-----------|
|`invoiceIds` |  invoiceIds description |

### `queryParts(Set<Id> partIds)` → `void`

Queries parts to return pricing fields used in net calculation

#### Parameters
|Param|Description|
|-----|-----------|
|`partIds` |  partIds description |

### `queryStrategies(Set<Id> psIds)` → `void`

Queries pricing strategies to return fields used in net calculation

#### Parameters
|Param|Description|
|-----|-----------|
|`psIds` |  psIds description |

---
