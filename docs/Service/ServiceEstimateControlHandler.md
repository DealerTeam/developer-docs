# ServiceEstimateControlHandler

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Service

## Methods
### `static setTaxable(List<Service_Estimate__c> estimateList)`
### `static setLocation(List<Service_Estimate__c> estimateList)`
### `static setCompanyNumber(List<Service_Estimate__c> estimateList)`
### `static setAccountVehicleByROReference(List<Service_Estimate__c> estimateList)`
### `static beforeUpdate(List<dealer__Service_Estimate__c> ServiceEstimateList, Map<Id,dealer__Service_Estimate__c> ServiceEstimateOldMap)`
### `static ServiceVehicleForServiceEstimate(List<dealer__Service_Estimate__c> ServiceEstimateList)`
### `static updateTaxableCalculation(List<dealer__Service_Estimate__c> SEList, Map<Id,dealer__Service_Estimate__c> ServiceEstimateOldMap)`
### `static updateServiceLineTax(List<dealer__Service_Estimate_Line__c> ListServiceEstimateLine)`
### `static updateAppraisal(List<Service_Estimate__c> triggerNew)`
### `static updateAppraisal(List<Service_Estimate__c> triggerNew, Map<Id,Service_Estimate__c> triggerOldMap)`
### `static setVersionNumber(List<Service_Estimate__c> triggerNew)`

sets the Last Modified in Version field to the currently installed Dealerteam package version

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setVersionNumber

---
