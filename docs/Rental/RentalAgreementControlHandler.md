---
layout: default
---
# RentalAgreementControlHandler



**Group** Rental

## Constructors
### `public RentalAgreementControlHandler()`
---
## Methods
### `public void checkMultipleAgreements(List<Rental_Agreements__c> triggerNew)`

Before insert method ensuring inserted record agreements follow multiple agreement dt configuration

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|incoming trigger records|


**Method** checkMultipleAgreements

### `public void manageRentalScheduleEvents(List<Rental_Agreements__c> triggerNew)`
### `public void manageRentalScheduleEvents(List<Rental_Agreements__c> triggerNew, Map<Id,Rental_Agreements__c> triggerOldMap)`
### `public void setDispositionBasedOnStatus(List<Rental_Agreements__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||

#### Returns

|Type|Description|
|---|---|
|`void`|List<Rental_Agreements__c>|


**Method** setDispositionBasedOnStatus


**Descripton** Update disposition based on status

### `public void UpdateSalesDisposition(List<Rental_Agreements__c> triggerNew)`

sets sales up status based on rental agreement status if config is set

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** updateSalesDisposition

---
