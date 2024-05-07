---
layout: default
---
# ServiceRepairOrderControlHandler

ServiceRepairOrderControlHandler performs domain layer.  Trigger based events are processed here.


**Group** Service

## Fields

### `private dispositionStatus` → `Map<String,String>`


### `private vehicleServMap` → `Map<Id,Service_Vehicle__c>`


### `private serviceVehicleVinMap` → `Map<String,Service_Vehicle__c>`


### `private vehicleInvMap` → `Map<Id,Vehicle_Inventory__c>`


---
## Methods
### `public static void RestrictCompanyUpdate(List<Service_Repair_Order__c> SROList, Map<Id,Service_Repair_Order__c> SROOldMap)`
### `public static void UpdateVehicleInventoryWithVIN(List<Service_Repair_Order__c> SROList)`
### `public static void ResrictToEditPostedSRO(List<Service_Repair_Order__c> SROList, Map<Id,Service_Repair_Order__c> SROOldMap)`

Checks custom metadata setting for closed statuses and prevents update if RO is in one of them

#### Parameters

|Param|Description|
|---|---|
|`SROList`|SROList description|
|`SROOldMap`|SROOldMap description|


**Method** ResrictToEditPostedSRO

### `public static void CompanyNumberFromUser(List<Service_Repair_Order__c> SROList)`
### `public static void restrictDeletion(List<Service_Repair_Order__c> deleteRecords)`

restrictDeletion prevents Repair Orders from being deleted.  Conditionally this routine checks to see if charges exist.  Optionally trigger control allows deletion.

#### Parameters

|Param|Description|
|---|---|
|`deleteRecords`|List<Service_Repair_Order__c>|

#### Returns

|Type|Description|
|---|---|
|`void`|void|

### `public static void checkForCustomSettings()`

checkForCustomSettings ensures that custom settings are present before the CRUD events on SRO

#### Returns

|Type|Description|
|---|---|
|`void`|void|

### `public static void updateServiceVehicle(List<Service_Repair_Order__c> roList)`

updateServiceVehicle applies the data referenced from the service repair order to the service vehicle record=

#### Parameters

|Param|Description|
|---|---|
|`roList`|List<Service_Repair_Order__c>|

### `public static void RewardCalculationsOnSRO(List<Service_Repair_Order__c> SROList)`
### `public static void assignRONumber(List<Service_Repair_Order__c> roList)`

assignRONumber description

#### Parameters

|Param|Description|
|---|---|
|`roList`|roList description|


**Author** DealerTeam

### `public static void ChangeRONumber(List<Service_Repair_Order__c> SROList, Map<Id,Service_Repair_Order__c> SROOldMap)`
### `public static void preventWarrantyInvoicing(List<Service_Repair_Order__c> roList)`

preventWarrantyInvoicingSRO ensures the warranty account is populated before invoicing

#### Parameters

|Param|Description|
|---|---|
|`roList`|List<Service_Repair_Order__c>|

### `public static void dispatchRepairOrders(List<Service_Repair_Order__c> roList)`

DispatchRepairOrders


**Notes** Only called after insert

### `public static void setDispositionBasedOnStatus(List<Service_Repair_Order__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||

#### Returns

|Type|Description|
|---|---|
|`void`|List<Service_Repair_Order__c>|


**Method** setDispositionBasedOnStatus


**Descripton** Update disposition based on status

### `public static void GetDispositions()`

handles getting all dispositions and organizes in map of sales up statuses by sro statues


**Method** getDispositions

### `public static void updateSalesDisposition(List<Service_Repair_Order__c> triggerNew)`

sets sales up status based on sro status if config is set

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** updateSalesDisposition

### `public static void setVersionNumber(List<Service_Repair_Order__c> triggerNew)`

sets the Last Modified in Version field to the currently installed Dealerteam package version

#### Parameters

|Param|Description|
|---|---|
|`List`|<Service_Repair_Order__c> Trigger instantiated list of Repair Orders|

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** setVersionNumber

### `public static void setTaxZone(List<Service_Repair_Order__c> triggerNew)`

sets the tax zone when none is present and one is matched via TaxAPI

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setTaxZone

### `public static void ERPInsert(List<Service_Repair_Order__c> triggerNew)`

Inserts a SRO using the DMS Data API

#### Parameters

|Param|Description|
|---|---|
|`sro`||

### `public static void ERPUpdate(List<Service_Repair_Order__c> triggerNew)`

Updates a SRO using the DMS Data API

#### Parameters

|Param|Description|
|---|---|
|`sro`||

### `public static void updateRelatedPartsInvoice(List<Service_Repair_Order__c> triggerNew, Map<Id,Service_Repair_Order__c> triggerOldMap)`

updates related Parts Invoice status when RO status is updated

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|

---
## Classes
### ServiceRepairOrderControlHandlerException

**Inheritance**

ServiceRepairOrderControlHandlerException


---
