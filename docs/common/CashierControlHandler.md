# CashierControlHandler

`APIVERSION: 49`

`STATUS: ACTIVE`

This class is used in Trigger Context to set domain layer logic related to cashiering


**Group** common


**Notes** The without sharing annotation was added to allow Approval Processes to run without record blocking

## Methods
### `static setDealCashierTotals(List<Cashering__c> triggerNew)`
### `static setInvoiceCashierTotals(List<Cashering__c> triggerNew)`

updates cashier related fields on parts invoice

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setInvoiceCashierTotals

### `static setDefaults(List<Cashering__c> triggerNew)`
### `static sroRentalTotals(List<Cashering__c> triggerNew)`
---
## Classes
### CashierTotal
#### Constructors
##### `CashierTotal(Decimal total, Decimal deposit)`
---
#### Fields

##### `deposit` → `Decimal`


##### `total` → `Decimal`


---

---
