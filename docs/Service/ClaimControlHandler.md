# ClaimControlHandler

`APIVERSION: 45`

`STATUS: ACTIVE`

Claim Control Handler - Service Layer Application Class


**Class** ClaimControlHandler


**Group** Service

## Methods
### `preflight(List<ClaimSubItem__c> subLines)`

Pre-clear values that are going to be saved to the object

#### Parameters

|Param|Description|
|---|---|
|`subLines`||

#### Return

**Type**

void

**Description**

void


**Method** preflight

### `handleRollUp(List<ClaimSubItem__c> subLines, List<ClaimSubItem__c> beforeSubLines)`

Total Values for the parent line

#### Parameters

|Param|Description|
|---|---|
|`subLines`||
|`beforeSubLines`||

#### Return

**Type**

void

**Description**

void


**Method** handleRollUp

### `handleRollUp(List<ClaimItem__c> seLines)`
#### Parameters

|Param|Description|
|---|---|
|`seLines`||

#### Return

**Type**

void

**Description**

void


**Method** handleRollUp

### `preventEdit(List<ClaimItem__c> seLines)`

Prevent Converted Estimates from being Edited

#### Parameters

|Param|Description|
|---|---|
|`seLines`||

#### Return

**Type**

void

**Description**

void


**Method** preventEdit

### `BeforeHandlerforCalcultingTax(List<dealer__ClaimItem__c> ListServiceEstimateLine)`
#### Return

**Type**

void

**Description**

void


**Method** BeforeHandlerforCalcultingTax

### `static setLocation(List<Claim__c> estimateList)`
#### Parameters

|Param|Description|
|---|---|
|`estimateList`||

#### Return

**Type**

void

**Description**

void


**Method** setLocation

### `static setCompanyNumber(List<Claim__c> estimateList)`
#### Parameters

|Param|Description|
|---|---|
|`estimateList`||

#### Return

**Type**

void

**Description**

void


**Method** setCompanyNumber

### `static setAccountVehicleByROReference(List<Claim__c> estimateList)`

When creating an estimate exclusively from an RO reference, the Account and Vehicle will populate

#### Parameters

|Param|Description|
|---|---|
|`estimateList`||

#### Return

**Type**

void

**Description**

void


**Method** setAccountVehicleByROReference

### `static ServiceVehicleForServiceEstimate(List<dealer__Claim__c> ServiceEstimateList)`
#### Parameters

|Param|Description|
|---|---|
|`ServiceEstimateList`||

#### Return

**Type**

void

**Description**

void


**Method** ServiceVehicleForServiceEstimate

### `static updateTaxableCalculation(List<dealer__Claim__c> SEList, Map<Id,dealer__Claim__c> ServiceEstimateOldMap)`

W-001780 Begins. Forces total tax on Service Estimate to be recalculated if Taxable flag is changed by firing triggers that calculate Service Estimate Line Tax

#### Parameters

|Param|Description|
|---|---|
|`SEList`||
|`ServiceEstimateOldMap`||


**Method** updateTaxableCalculation

### `static updateServiceLineTax(List<dealer__ClaimItem__c> ListServiceEstimateLine)`

W-001780 Ends

#### Return

**Type**

void

**Description**

void


**Method** updateServiceLineTax

### `static updateSRO(List<Claim__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||

#### Return

**Type**

void

**Description**

void


**Method** updateSRO description

### `static AssignClaimNumber(List<Claim__c> triggerNew)`

Utility method to Assign Claim Number depending upon the custom settings

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||

#### Return

**Type**

void

**Description**

void


**Method** AssignClaimNumber

### `static ChangeClaimNumber(List<Claim__c> triggerNew, Map<Id,Claim__c> oldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||
|`oldMap`||

#### Return

**Type**

void

**Description**

void


**Method** ChangeClaimNumber

### `static updateOdometer(List<Claim__c> triggerNew, Map<Id,Claim__c> triggerOldMap)`

Updates service vehicle mileage when claim is put in finalized status

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|


**Method** updateOdometer

### `static setClaimItemName(List<ClaimItem__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`List`|<ClaimItem__c> trigger new context|

#### Return

**Type**

void

**Description**

void


**Method** setClaimItemName - This method queries the header record and number of lines to set the ClaimItem__c.Name property based on the parent record and row count.

### `static setClaimSubItemName(List<ClaimSubItem__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`List`|<ClaimSubItem__c> trigger new context|

#### Return

**Type**

void

**Description**




**Method** setClaimSubItemName - This method queries the header record and number of lines to set the ClaimSubItem__c.Name property based on the parent record and row count.

### `static setVersionNumber(List<Claim__c> triggerNew)`

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
