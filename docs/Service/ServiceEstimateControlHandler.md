---
layout: default
---
# ServiceEstimateControlHandler



**Group** Service

## Methods
### `public static void setTaxable(List<Service_Estimate__c> estimateList)`
### `public static void setLocation(List<Service_Estimate__c> estimateList)`
### `public static void setCompanyNumber(List<Service_Estimate__c> estimateList)`
### `public static void setAccountVehicleByROReference(List<Service_Estimate__c> estimateList)`
### `public static void beforeUpdate(List<dealer__Service_Estimate__c> ServiceEstimateList, Map<Id,dealer__Service_Estimate__c> ServiceEstimateOldMap)`
### `public static void ServiceVehicleForServiceEstimate(List<dealer__Service_Estimate__c> ServiceEstimateList)`

Populates Service Vehicle when only a Vehicle Inventory is set on an Estimate

#### Parameters

|Param|Description|
|---|---|
|`ServiceEstimateList`||

### `public static void updateTaxableCalculation(List<dealer__Service_Estimate__c> SeList, Map<Id,dealer__Service_Estimate__c> ServiceEstimateOldMap)`

updateTaxableCalculation - Handles service estimate tax calculation by looking to the location taxable settings and summing appropriate line values

#### Parameters

|Param|Description|
|---|---|
|`SeList`|- trigger new records|
|`ServiceEstimateOldMap`|- trigger old records|

### `public static void updateAppraisal(List<Service_Estimate__c> triggerNew)`
### `public static void updateAppraisal(List<Service_Estimate__c> triggerNew, Map<Id,Service_Estimate__c> triggerOldMap)`
### `public static void setVersionNumber(List<Service_Estimate__c> triggerNew)`

sets the Last Modified in Version field to the currently installed Dealerteam package version

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setVersionNumber

---
