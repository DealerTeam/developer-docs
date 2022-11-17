# AppraisalControlHandler

`APIVERSION: 47`

`STATUS: ACTIVE`



**Group** Sales

## Methods
### `static setAppraisalFields(List<Appraisal__c> triggerNew)`
### `static updateTradeOnInsert(List<Appraisal__c> triggerNew)`
### `static updateTradeOnUpdate(List<Appraisal__c> triggerNew, Map<Id,Appraisal__c> triggerOldMap)`
### `static updateServiceVehicleOnUpdate(List<Appraisal__c> triggerNew, Map<Id,Appraisal__c> triggerOldMap)`

updates sv odometer when appraisal odometer is updated

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||
|`triggerOldMap`||


**Method** updateServiceVehicleOnUpdate

### `static createAppraisalVehicle(List<Appraisal__c> triggerNew)`

createAppraisalVehicle Creates an appraisal vehicle related to the sales up and service vehicle if one does not exist

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|

---
