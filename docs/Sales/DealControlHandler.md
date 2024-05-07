---
layout: default
---
# DealControlHandler

This class is exclusively for handling trigger context operations on the Deal__c object


**Class** DealControlHandler


**Group** Sales

## Constructors
### `public DealControlHandler()`
### `public DealControlHandler(List<dealer__Deal__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||


**Method** DealControlHandler

---
## Properties

### `public enumbers` → `Set<String>`


### `public companies` → `Set<String>`


### `public customerExternalReference` → `Set<String>`


### `public customerIds` → `Set<ID>`


### `public accountIds` → `Set<Id>`


### `public vehicleExtRef` → `Set<String>`


### `public availableCategories` → `Set<String>`


### `public accountsToUpdate` → `Set<Account>`


### `public custContacts` → `Map<Id,Contact>`


### `public relatedContacts` → `Map<Id,List<Contact>>`


### `public custAccounts` → `Map<Id,Account>`


### `public contactKey` → `Map<String,Contact>`


### `public activeUserMap` → `Map<Id,User>`


### `public vehicleMap` → `Map<Id,Vehicle_Inventory__c>`


### `public SalesUpID` → `Map<Id,dealer__Deal__c>`


### `public dealStatus` → `Map<String,String>`


### `public dispositions` → `List<dealer__SalesDispositions__c>`


### `public dmsConfiguration` → `Map<String,DMSConfig__mdt>`


---
## Methods
### `public void setDefaults(List<Deal__c> triggerNew)`

Set defaults in deal create based on the mapped configurations

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** setDefaults

### `public void setDealCategory(List<Deal__c> triggerNew)`

setDealCategory description

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|

### `private static void setDefaultNumericFieldValues(List<Deal__c> triggerNew)`
### `private string getConfigValue(String configName)`

compares a string for dmsConfiguration records and returns the subscriber value if present otherwise the packaged default

#### Parameters

|Param|Description|
|---|---|
|`configName`|configName description|

#### Returns

|Type|Description|
|---|---|
|`string`|String value of the given configuration|


**Method** getConfigValue

### `public List<Deal__c> dataLoadSupport(List<Deal__c> triggerNew)`

Foreign key support for data loading

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||

#### Returns

|Type|Description|
|---|---|
|`List<Deal__c>`|List<Deal__c>|


**Method** dataLoadSupport

### `public List<Deal__c> setConversionDescription(List<Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
### `public List<Deal__c> setDealDispositionBasedOnStatus(List<Deal__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||

#### Returns

|Type|Description|
|---|---|
|`List<Deal__c>`|List<Deal__c>|


**Method** setDealDispositionBasedOnStatus


**Descripton** // 1) Set Owner Id// 2) Set Location & Company Number// 3) Set Status by Disposition

### `public void updateDealerFields(List<dealer__Deal__c> allDealer)`

updateDealerFields Before Insert

#### Parameters

|Param|Description|
|---|---|
|`allDealer`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** updateDealerFields

### `public void updateBuyerContactBySUP(List<Deal__c> allDealer, Set<Id> supIds)`

assigns contacts to deals by the related sales up customer

#### Parameters

|Param|Description|
|---|---|
|`allDealer`|- deal records with a related salesUp and no buyer_Contact__c|
|`supIds`|-  related salesup records|


**Method** updateBuyerContactBySUP

### `public void customersToUpdateMethod(List<dealer__Deal__c> allDealer)`

Update customersToUpdateMethod - After Insert Method

#### Parameters

|Param|Description|
|---|---|
|`allDealer`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** customersToUpdateMethod

### `public void salesUpMethod(List<dealer__Deal__c> allDealer)`

pdate SalesUpMethod - After Method

#### Parameters

|Param|Description|
|---|---|
|`allDealer`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** salesUpMethod

### `private void initLists()`
#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** initLists

### `private void loadLists(List<dealer__Deal__c> allDealer)`
#### Parameters

|Param|Description|
|---|---|
|`allDealer`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** loadLists

### `public void sumTaxes(List<Deal__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** sumTaxes

### `public void salesFeesUpdateMethod(Map<Id,Deal__c> triggerNewMap, Map<Id,Deal__c> triggerOldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNewMap`||
|`triggerOldMap`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** salesFeesUpdateMethod

### `public void deleteDealFees(List<Deal__c> deals)`
#### Parameters

|Param|Description|
|---|---|
|`deals`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** deleteDealFees

### `public void createDefaultFees(List<Deal__c> deals)`
#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** createDefaultFees

### `public void updateOpportunity(List<dealer__Deal__c> triggerNew)`

updates related opportunity if SalesCloudConnector is enabled

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** updateOpportunity

### `public void handleUpdateOpportunity(List<dealer__Deal__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** updateOpportunity

### `public void upsertDealERP(List<Deal__c> triggerNew)`

will sync a single Deal record to ERP.

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** updateDealERP

### `public void updateRelatedPricing(List<dealer__Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||
|`triggerOldMap`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** updateRelatedPricing

### `public void updateSchedulePricing(List<dealer__Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
### `public void handleAccountUpdate(List<dealer__Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|trigger.New|
|`triggerOldMap`|trigger.OldMap|


**Method** handleAccountUpdate updates buyer and co buyer fields from b2c account when buyer/cobuyer account is changed on a deal

### `public void handleContactUpdate(List<dealer__Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|trigger.New|
|`triggerOldMap`|trigger.OldMap|


**Method** handleContactUpdate updates buyer and co buyer fields from b2b contact when buyer/cobuyer contact is changed on a deal

### `public void updateAccount(List<dealer__Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|trigger.New|
|`triggerOldMap`|trigger.OldMap|


**Method** updateAccount pushes changes made to buyer/cobuyer fields to the associated account when the saveToAccount boolean is selected for either buyer or cobuyer

### `public static void updateVehiclePricing(List<Deal__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew inserted deals|


**Method** updateVehiclePricing updates vehicle related fields on insert

### `public static void updateVehiclePricing(List<Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew updated deals|


**Method** updateVehiclePricing updates vehicle related fields on update

### `public static void updateVehiclePricingTotals(List<Deal__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew inserted or updated deals|


**Method** updateVehiclePricingTotals updates price and cost totals on insert and update

### `public static void updateVehicleGross(List<Deal__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew inserted or updated deals|


**Method** updateVehicleGross Calculates chassis, conversion and total vehicle gross and percents

### `public static void updateVehicleMasterInfo(List<Deal__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|inserted deals|


**Method** updateVehicleMasterInfo updates year/make/model/trim with fields from vehicle master for orders if no vehicle on deal

### `private static Map<Id,Vehicle_Inventory__c> populateVehicleMap(List<String> vIds)`
### `public static void updateVehicleMasterInfo(List<Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|updated deals|


**Method** updateVehicleMasterInfo updates year/make/model/trim with fields from vehicle master for orders if no vehicle on deal

### `public static void preventDeleteEquipmentOrders(List<Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|


**Method** preventDeleteEquipmentOrders Deletes equipment inventory records of Record Type Order when removed from Deal

### `public static void updateEquipmentPricing(List<Deal__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** populateEquipmentPricing Sets Equipment Inventory pricing fields on inserted deals with equipmentInventory__c

### `public static void updateEquipmentPricing(List<Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|


**Method** populateEquipmentPricing Sets Equipment Inventory pricing fields on updated deals if equipmentInventory__c was changed

### `public static void updateRelatedEquipmentInventory(List<Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|


**Method** updateRelatedEquipmentInventory Update pricing on Order type EquipmentInventory__c records if pricing on deal changes

### `public void updateSalesTeam(List<Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`
### `public void setDealGross(List<Deal__c> triggerNew)`

Runs on insert and update to calculate front and back gross based on custom metadata type record eval string

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|


**Method** setDealGross

### `public void updateFinanceGross(List<Deal__c> triggerNew)`

Calculates finance gross based on finance company and deal values


**Method** updateFinanceGross

### `public void setTaxRate(List<Deal__c> triggerNew)`

updates the effective tax rate on insert/update


**Method** setTaxRate

### `public void setDaysToClose(List<Deal__c> triggerNew, Map<Id,Deal__c> triggerOldMap)`

Set Days to Close when Deal Close Date is changed


**Method** setDaysToClose

### `public void setTotalTaxable(List<Deal__c> triggerNew)`

Runs on insert and update to calculate dealer__TotalTaxableAmount__c

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||


**Method** setTotalTaxable

### `public void setVersionNumber(List<Deal__c> triggerNew)`

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
