---
layout: default
---
# ClaimControlHandler

Claim Control Handler - Service Layer Application Class


**Class** ClaimControlHandler


**Group** Service

## Methods
### `public void preflight(List<ClaimSubItem__c> subLines)`

Pre-clear values that are going to be saved to the object

#### Parameters

|Param|Description|
|---|---|
|`subLines`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** preflight

### `public void handleRollUp(List<ClaimSubItem__c> subLines, List<ClaimSubItem__c> beforeSubLines)`

Total Values for the parent line

#### Parameters

|Param|Description|
|---|---|
|`subLines`||
|`beforeSubLines`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** handleRollUp

### `public void handleRollUp(List<ClaimItem__c> seLines)`
#### Parameters

|Param|Description|
|---|---|
|`seLines`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** handleRollUp

### `private void performRollUp(Set<Id> estimateLineIds)`
#### Parameters

|Param|Description|
|---|---|
|`estimateLineIds`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** performRollUp

### `public void preventEdit(List<ClaimItem__c> seLines)`

Prevent Converted Estimates from being Edited

#### Parameters

|Param|Description|
|---|---|
|`seLines`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** preventEdit

### `public void BeforeHandlerforCalcultingTax(List<dealer__ClaimItem__c> ListServiceEstimateLine)`
#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** BeforeHandlerforCalcultingTax

### `public static void setLocation(List<Claim__c> estimateList)`
#### Parameters

|Param|Description|
|---|---|
|`estimateList`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** setLocation

### `public static void setCompanyNumber(List<Claim__c> estimateList)`
#### Parameters

|Param|Description|
|---|---|
|`estimateList`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** setCompanyNumber

### `public static void setAccountVehicleByROReference(List<Claim__c> estimateList)`

When creating an estimate exclusively from an RO reference, the Account and Vehicle will populate

#### Parameters

|Param|Description|
|---|---|
|`estimateList`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** setAccountVehicleByROReference

### `public static void ServiceVehicleForServiceEstimate(List<dealer__Claim__c> ServiceEstimateList)`
#### Parameters

|Param|Description|
|---|---|
|`ServiceEstimateList`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** ServiceVehicleForServiceEstimate

### `public static void updateTaxableCalculation(List<dealer__Claim__c> SEList, Map<Id,dealer__Claim__c> ServiceEstimateOldMap)`

W-001780 Begins. Forces total tax on Service Estimate to be recalculated if Taxable flag is changed by firing triggers that calculate Service Estimate Line Tax

#### Parameters

|Param|Description|
|---|---|
|`SEList`||
|`ServiceEstimateOldMap`||


**Method** updateTaxableCalculation

### `public static void updateServiceLineTax(List<dealer__ClaimItem__c> ListServiceEstimateLine)`

W-001780 Ends

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** updateServiceLineTax

### `public static void updateSRO(List<Claim__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** updateSRO description

### `public static void AssignClaimNumber(List<Claim__c> triggerNew)`

Utility method to Assign Claim Number depending upon the custom settings

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** AssignClaimNumber

### `public static void ChangeClaimNumber(List<Claim__c> triggerNew, Map<Id,Claim__c> oldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||
|`oldMap`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** ChangeClaimNumber

### `public static void updateOdometer(List<Claim__c> triggerNew, Map<Id,Claim__c> triggerOldMap)`

Updates service vehicle mileage when claim is put in finalized status

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|


**Method** updateOdometer

### `public static void setClaimItemName(List<ClaimItem__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`List`|<ClaimItem__c> trigger new context|

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** setClaimItemName - This method queries the header record and number of lines to set the ClaimItem__c.Name property based on the parent record and row count.

### `public static void setClaimSubItemName(List<ClaimSubItem__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`List`|<ClaimSubItem__c> trigger new context|

#### Returns

|Type|Description|
|---|---|
|`void`||


**Method** setClaimSubItemName - This method queries the header record and number of lines to set the ClaimSubItem__c.Name property based on the parent record and row count.

### `public static void setVersionNumber(List<Claim__c> triggerNew)`

sets the Last Modified in Version field to the currently installed Dealerteam package version

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setVersionNumber

---
## Classes
### ClaimControlHandlerException

**Inheritance**

ClaimControlHandlerException


---
