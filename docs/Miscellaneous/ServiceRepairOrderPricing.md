---
layout: default
---
# ServiceRepairOrderPricing

Support class for Trigger based Service Repair Order calcuations

## Constructors
### `private ServiceRepairOrderPricing()`

Private constructor is to prevent instantiating without getInstance method


**Method** Utility

---
## Fields

### `private instance` → `ServiceRepairOrderPricing`


instance private variable that holds the current instance of the class

### `private processedROMap` → `Map<Id,Service_Repair_Order__c>`


### `public contacts` → `Map<Id,Contact>`


### `private contactKey` → `Map<String,Contact>`


### `private vehicles` → `Map<Id,dealer__Service_Vehicle__c>`


### `private vehicleKey` → `Map<String,dealer__Service_Vehicle__c>`


---
## Methods
### `public static ServiceRepairOrderPricing getInstance()`

getInstance handles returning the running instance of the class, will create if one doesn't exist. Only way to create an instance

#### Returns

|Type|Description|
|---|---|
|`ServiceRepairOrderPricing`|return description|

### `public static void invoiceCalc(List<dealer__Service_Repair_Order__c> SROList, Map<Id,Service_Repair_Order__c> SROOldMap)`

SROCalculations description

#### Parameters

|Param|Description|
|---|---|
|`SROList`|SROList description|
|`SROOldMap`|SROOldMap description|

### `public void CalculateChargeAndCustomSettings(List<dealer__Service_Repair_Order__c> SROList)`

CalculateChargeAndCustomSettings description

#### Parameters

|Param|Description|
|---|---|
|`SROList`|SROList description|


**Author** DealerTeam

### `public void applyInternalCharges(List<Service_Repair_Order__c> roList)`

RollUpInternalChargesOnVehicle description

#### Parameters

|Param|Description|
|---|---|
|`roList`|List<Service_Repair_Order__c>|

#### Returns

|Type|Description|
|---|---|
|`void`|void|

### `public void applyInternalCharges(List<Purchase_Order_Line__c> polList)`

Apply internal charges to vehicle inventories related to the PO Lines

#### Parameters

|Param|Description|
|---|---|
|`polList`|polList description|

### `public void calculateChargesByVehicles(Set<Id> vehIds)`

Get ROs and PO Lines related to the vehicle inventory Ids and update internal charge fields on the vehicles

#### Parameters

|Param|Description|
|---|---|
|`vehIds`|vehIds description|

### `private void initializeVehicleFields(Vehicle_Inventory__c vi)`

Checks vehicle currency fields for null values prior to calculation and sets to 0 if any nulls are found

#### Parameters

|Param|Description|
|---|---|
|`vi`|vi description|

### `private void initializeROFields(Service_Repair_Order__c sro)`

Checks vehicle currency fields for null values prior to calculation and sets to 0 if any nulls are found

#### Parameters

|Param|Description|
|---|---|
|`vi`|vi description|

### `public void calculatePOCharges(Vehicle_Inventory__c vi, Purchase_Order_Line__c line)`

Update internal charge fields on Vehicle from the provided PO Line

#### Parameters

|Param|Description|
|---|---|
|`vi`|vi description|
|`line`|line description|

### `public void calculateROCharges(Vehicle_Inventory__c vi, Service_Repair_Order__c sro)`

Update internal charge fields on Vehicle from the provided RO

#### Parameters

|Param|Description|
|---|---|
|`vi`|vi description|
|`sro`|sro description|

---
