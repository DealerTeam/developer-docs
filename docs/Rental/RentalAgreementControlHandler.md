# RentalAgreementControlHandler

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Rental

## Constructors
### `RentalAgreementControlHandler()`
---
## Methods
### `checkMultipleAgreements(List<Rental_Agreements__c> triggerNew)`

Before insert method ensuring inserted record agreements follow multiple agreement dt configuration

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|incoming trigger records|


**Method** checkMultipleAgreements

### `manageRentalScheduleEvents(List<Rental_Agreements__c> triggerNew)`
### `manageRentalScheduleEvents(List<Rental_Agreements__c> triggerNew, Map<Id,Rental_Agreements__c> triggerOldMap)`
### `setDispositionBasedOnStatus(List<Rental_Agreements__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||

#### Return

**Type**

void

**Description**

List&lt;Rental_Agreements__c&gt;


**Method** setDispositionBasedOnStatus


**Descripton** Update disposition based on status

### `UpdateSalesDisposition(List<Rental_Agreements__c> triggerNew)`

sets sales up status based on rental agreement status if config is set

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** updateSalesDisposition

---
