# DealControlHandler

`APIVERSION: 45`

`STATUS: ACTIVE`

This class is exclusively for handling trigger context operations on the Deal__c object


**Class** DealControlHandler


**Group** Sales

## Constructors
### `DealControlHandler()`
### `DealControlHandler(List<dealer__Deal__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||


**Method** DealControlHandler

---
## Properties

### `SalesUpID` → `Map<Id,dealer__Deal__c>`


### `accountIds` → `Set<Id>`


### `accountsToUpdate` → `Set<Account>`


### `activeUserMap` → `Map<Id,User>`


### `companies` → `Set<String>`


### `contactKey` → `Map<String,Contact>`


### `custAccounts` → `Map<Id,Account>`


### `custContacts` → `Map<Id,Contact>`


### `customerExternalReference` → `Set<String>`


### `customerIds` → `Set<ID>`


### `dealStatus` → `Map<String,String>`


### `dispositions` → `List<dealer__SalesDispositions__c>`


### `dmsConfiguration` → `Map<String,DMSConfig__mdt>`


### `enumbers` → `Set<String>`


### `relatedContacts` → `Map<Id,List<Contact>>`


### `vehicleExtRef` → `Set<String>`


### `vehicleMap` → `Map<Id,Vehicle_Inventory__c>`


---
## Methods
### `setDefaults(List<Deal__c> triggerNew)`

Set defaults in deal create based on the mapped configurations

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||

#### Return

**Type**

void

**Description**

void


**Method** setDefaults

### `dataLoadSupport(List<Deal__c> triggerNew)`

Foreign key support for data loading

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||

#### Return

**Type**

List&lt;Deal__c&gt;

**Description**

List&lt;Deal__c&gt;


**Method** dataLoadSupport

### `setConversionDescription(List<Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
### `setDealDispositionBasedOnStatus(List<Deal__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||

#### Return

**Type**

List&lt;Deal__c&gt;

**Description**

List&lt;Deal__c&gt;


**Method** setDealDispositionBasedOnStatus


**Descripton** // 1) Set Owner Id// 2) Set Location & Company Number// 3) Set Status by Disposition

### `updateDealerFields(List<dealer__Deal__c> allDealer)`

updateDealerFields Before Insert

#### Parameters

|Param|Description|
|---|---|
|`allDealer`||

#### Return

**Type**

void

**Description**

void


**Method** updateDealerFields

### `updateBuyerContactBySUP(List<Deal__c> allDealer, Set<Id> supIds)`

assigns contacts to deals by the related sales up customer

#### Parameters

|Param|Description|
|---|---|
|`allDealer`|- deal records with a related salesUp and no buyer_Contact__c|
|`supIds`|-  related salesup records|


**Method** updateBuyerContactBySUP

### `customersToUpdateMethod(List<dealer__Deal__c> allDealer)`

Update customersToUpdateMethod - After Insert Method

#### Parameters

|Param|Description|
|---|---|
|`allDealer`||

#### Return

**Type**

void

**Description**

void


**Method** customersToUpdateMethod

### `salesUpMethod(List<dealer__Deal__c> allDealer)`

pdate SalesUpMethod - After Method

#### Parameters

|Param|Description|
|---|---|
|`allDealer`||

#### Return

**Type**

void

**Description**

void


**Method** salesUpMethod

### `sumTaxes(List<Deal__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||

#### Return

**Type**

void

**Description**

void


**Method** sumTaxes

### `salesFeesUpdateMethod(Map<Id,Deal__c> triggerNewMap, Map<Id,Deal__c> triggerOldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNewMap`||
|`triggerOldMap`||

#### Return

**Type**

void

**Description**

void


**Method** salesFeesUpdateMethod

### `deleteDealFees(List<Deal__c> deals)`
#### Parameters

|Param|Description|
|---|---|
|`deals`||

#### Return

**Type**

void

**Description**

void


**Method** deleteDealFees

### `createDefaultFees(List<Deal__c> deals)`
#### Return

**Type**

void

**Description**

void


**Method** createDefaultFees

### `updateOpportunity(List<dealer__Deal__c> triggerNew)`

updates related opportunity if SalesCloudConnector is enabled

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** updateOpportunity

### `handleUpdateOpportunity(List<dealer__Deal__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||

#### Return

**Type**

void

**Description**

void


**Method** updateOpportunity

### `upsertDealERP(List<Deal__c> triggerNew)`

will sync a single Deal record to ERP.

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||

#### Return

**Type**

void

**Description**

void


**Method** updateDealERP

### `updateRelatedPricing(List<dealer__Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||
|`triggerOldMap`||

#### Return

**Type**

void

**Description**

void


**Method** updateRelatedPricing

### `updateSchedulePricing(List<dealer__Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
### `handleAccountUpdate(List<dealer__Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|trigger.New|
|`triggerOldMap`|trigger.OldMap|


**Method** handleAccountUpdate updates buyer and co buyer fields from b2c account when buyer/cobuyer account is changed on a deal

### `handleContactUpdate(List<dealer__Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|trigger.New|
|`triggerOldMap`|trigger.OldMap|


**Method** handleAccountUpdate updates buyer and co buyer fields from b2b contact when buyer/cobuyer contact is changed on a deal

### `updateAccount(List<dealer__Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|trigger.New|
|`triggerOldMap`|trigger.OldMap|


**Method** updateAccount pushes changes made to buyer/cobuyer fields to the associated account when the saveToAccount boolean is selected for either buyer or cobuyer

### `static updateVehiclePricing(List<Deal__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew inserted deals|


**Method** updateVehiclePricing updates vehicle related fields on insert

### `static updateVehiclePricing(List<Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew updated deals|


**Method** updateVehiclePricing updates vehicle related fields on update

### `static updateVehiclePricingTotals(List<Deal__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew inserted or updated deals|


**Method** updateVehiclePricingTotals updates price and cost totals on insert and update

### `static updateVehicleGross(List<Deal__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew inserted or updated deals|


**Method** updateVehicleGross Calculates chassis, conversion and total vehicle gross and percents

### `static updateVehicleMasterInfo(List<Deal__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|inserted deals|


**Method** updateVehicleMasterInfo updates year/make/model/trim with fields from vehicle master for orders if no vehicle on deal

### `static updateVehicleMasterInfo(List<Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|updated deals|


**Method** updateVehicleMasterInfo updates year/make/model/trim with fields from vehicle master for orders if no vehicle on deal

### `static preventDeleteEquipmentOrders(List<Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|


**Method** preventDeleteEquipmentOrders Deletes equipment inventory records of Record Type Order when removed from Deal

### `static updateEquipmentPricing(List<Deal__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** populateEquipmentPricing Sets Equipment Inventory pricing fields on inserted deals with equipmentInventory__c

### `static updateEquipmentPricing(List<Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|


**Method** populateEquipmentPricing Sets Equipment Inventory pricing fields on updated deals if equipmentInventory__c was changed

### `static updateRelatedEquipmentInventory(List<Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|


**Method** updateRelatedEquipmentInventory Update pricing on Order type EquipmentInventory__c records if pricing on deal changes

### `updateSalesTeam(List<Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
### `setDealGross(List<Deal__c> triggerNew)`

Runs on insert and update to calculate front and back gross based on custom metadata type record eval string

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|


**Method** setDealGross

### `updateFinanceGross(List<Deal__c> triggerNew)`

Calculates finance gross based on finance company and deal values


**Method** updateFinanceGross

### `setTaxRate(List<Deal__c> triggerNew)`

updates the effective tax rate on insert/update


**Method** setTaxRate

### `setDaysToClose(List<Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`

Set Days to Close when Deal Close Date is changed


**Method** setDaysToClose

### `setTotalTaxable(List<Deal__c> triggerNew)`

Runs on insert and update to calculate dealer__TotalTaxableAmount__c

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||


**Method** setTotalTaxable

### `setVersionNumber(List<Deal__c> triggerNew)`

sets the Last Modified in Version field to the currently installed Dealerteam package version

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setVersionNumber

---
## Classes
### DealControlHandlerException

**Inheritance**

DealControlHandlerException


---
