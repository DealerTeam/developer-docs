---
layout: default
---
# Sup2Deal

`SUPPRESSWARNINGS`



**Group** Sales

## Fields

### `private isEquipmentOnly` → `Boolean`


### `private sup` → `Sales_Up__c`


### `private deal` → `Deal__c`


### `private buyerAccount` → `Account`


### `private coBuyerAccount` → `Account`


### `private buyerContact` → `Contact`


### `private vehInv` → `Vehicle_Inventory__c`


### `private desiredVehicle` → `Desired_Vehicle__c`


### `private location` → `Dealer_Location__c`


### `private equipmentInventory` → `EquipmentInventory__c`


### `private conversion` → `Parts_Kit__c`


### `private appraisals` → `List<Appraisal_Vehicle__c>`


---
## Methods
### `public static Id buildDealFromSup(Id supId)`

`AURAENABLED`

AuraEnabled method for creating a deal from a sales up record

#### Parameters

|Param|Description|
|---|---|
|`supId`|- the sales up id to construct a deal from|

#### Returns

|Type|Description|
|---|---|
|`Id`|Id - the id of the newly created deal for navigating to|


**Method** buildDealFromSup

### `private static void getSalesUpData(Id supId)`

queries for a sales up record and assigns static vars based on related records

#### Parameters

|Param|Description|
|---|---|
|`supId`|- sales up record to query for|


**Method** getSalesUpData

### `private static void assignDealData()`

Handles the majority of mapping data from related records to the newly created deal


**Method** assignDealData

### `private static void assignLocation()`
### `private static void assignBuyer()`

Maps data from sales up buyer to the deal


**Method** assignBuyer

### `public static void populateB2BContactData()`

Applies contact data to buyer fields for b2b deals


**Method** populateB2BContactData

### `private static void assignCoBuyer()`

Maps data from sales up co buyer to the deal


**Method** assignCoBuyer

### `private static void assignVehicle()`

handles equipment only and vehicle assignment logic


**Method** assignVehicle

### `private static void processTrades()`

creates new trade in records based on the sales up appraisals


**Method** processTrades

### `private static void assignEquipmentOnlySup()`

handles equipment only logic


**Method** assignEquipmentOnlySup

### `private static void updateRelatedAppraisals(List<Trade_In__c> tradeList)`

relates sales up appraisals to newly created trade in and deal records

#### Parameters

|Param|Description|
|---|---|
|`tradeList`|- newly created trade in records|


**Method** updateRelatedAppraisals

---
