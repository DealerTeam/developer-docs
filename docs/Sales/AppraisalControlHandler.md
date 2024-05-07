---
layout: default
---
# AppraisalControlHandler



**Group** Sales

## Methods
### `public static void setAppraisalFields(List<Appraisal__c> triggerNew)`
### `public static void updateTradeOnInsert(List<Appraisal__c> triggerNew)`
### `public static void updateTradeOnUpdate(List<Appraisal__c> triggerNew, Map<Id,Appraisal__c> triggerOldMap)`
### `public static void updateServiceVehicleOnUpdate(List<Appraisal__c> triggerNew, Map<Id,Appraisal__c> triggerOldMap)`

updates sv odometer when appraisal odometer is updated

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||
|`triggerOldMap`||


**Method** updateServiceVehicleOnUpdate

### `public static void createAppraisalVehicle(List<Appraisal__c> triggerNew)`

createAppraisalVehicle Creates an appraisal vehicle related to the sales up and service vehicle if one does not exist

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|

---
