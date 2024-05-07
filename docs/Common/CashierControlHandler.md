---
layout: default
---
# CashierControlHandler

This class is used in Trigger Context to set domain layer logic related to cashiering


**Group** common


**Notes** The without sharing annotation was added to allow Approval Processes to run without record blocking

## Methods
### `public static void setDealCashierTotals(List<Cashering__c> triggerNew)`
### `public static void setInvoiceCashierTotals(List<Cashering__c> triggerNew)`

updates cashier related fields on parts invoice

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setInvoiceCashierTotals

### `public static void setDefaults(List<Cashering__c> triggerNew)`
### `public static void sroRentalTotals(List<Cashering__c> triggerNew)`
---
## Classes
### CashierTotal
#### Constructors
##### `public CashierTotal(Decimal total, Decimal deposit)`
---
#### Fields

##### `public total` → `Decimal`


##### `public deposit` → `Decimal`


---

---
