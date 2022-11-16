# ServiceRepairOrderControlHandler

`APIVERSION: 45`

`STATUS: ACTIVE`

ServiceRepairOrderControlHandler performs domain layer.  Trigger based events are processed here.


**Group** Service

## Methods
### `static RestrictCompanyUpdate(List<Service_Repair_Order__c> SROList, Map<Id,Service_Repair_Order__c> SROOldMap)`
### `static UpdateVehicleInventoryWithVIN(List<Service_Repair_Order__c> SROList)`
### `static ResrictToEditPostedSRO(List<Service_Repair_Order__c> SROList, Map<Id,Service_Repair_Order__c> SROOldMap)`

Checks custom metadata setting for closed statuses and prevents update if RO is in one of them

#### Parameters

|Param|Description|
|---|---|
|`SROList`|SROList description|
|`SROOldMap`|SROOldMap description|


**Method** ResrictToEditPostedSRO

### `static CompanyNumberFromUser(List<Service_Repair_Order__c> SROList)`
### `static restrictDeletion(List<Service_Repair_Order__c> deleteRecords)`

restrictDeletion prevents Repair Orders from being deleted.  Conditionally this routine checks to see if charges exist.  Optionally trigger control allows deletion.

#### Parameters

|Param|Description|
|---|---|
|`deleteRecords`|List<Service_Repair_Order__c>|

#### Return

**Type**

void

**Description**

void

### `static checkForCustomSettings()`

checkForCustomSettings ensures that custom settings are present before the CRUD events on SRO

#### Return

**Type**

void

**Description**

void

### `static updateServiceVehicle(List<Service_Repair_Order__c> roList)`

updateServiceVehicle applies the data referenced from the service repair order to the service vehicle record=

#### Parameters

|Param|Description|
|---|---|
|`roList`|List<Service_Repair_Order__c>|

### `static RewardCalculationsOnSRO(List<Service_Repair_Order__c> SROList)`
### `static assignRONumber(List<Service_Repair_Order__c> roList)`

assignRONumber description

#### Parameters

|Param|Description|
|---|---|
|`roList`|roList description|


**Author** DealerTeam

### `static ChangeRONumber(List<Service_Repair_Order__c> SROList, Map<Id,Service_Repair_Order__c> SROOldMap)`
### `static preventWarrantyInvoicing(List<Service_Repair_Order__c> roList)`

preventWarrantyInvoicingSRO ensures the warranty account is populated before invoicing

#### Parameters

|Param|Description|
|---|---|
|`roList`|List<Service_Repair_Order__c>|

### `static dispatchRepairOrders(List<Service_Repair_Order__c> roList)`

DispatchRepairOrders


**Notes** Only called after insert

### `static setDispositionBasedOnStatus(List<Service_Repair_Order__c> triggerNew)`
#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||

#### Return

**Type**

void

**Description**

List&lt;Service_Repair_Order__c&gt;


**Method** setDispositionBasedOnStatus


**Descripton** Update disposition based on status

### `static GetDispositions()`

handles getting all dispositions and organizes in map of sales up statuses by sro statues


**Method** getDispositions

### `static updateSalesDisposition(List<Service_Repair_Order__c> triggerNew)`

sets sales up status based on sro status if config is set

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** updateSalesDisposition

### `static setVersionNumber(List<Service_Repair_Order__c> triggerNew)`

sets the Last Modified in Version field to the currently installed Dealerteam package version

#### Parameters

|Param|Description|
|---|---|
|`List`|<Service_Repair_Order__c> Trigger instantiated list of Repair Orders|

#### Return

**Type**

void

**Description**

void


**Method** setVersionNumber

### `static setTaxZone(List<Service_Repair_Order__c> triggerNew)`

sets the tax zone when none is present and one is matched via TaxAPI

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** setTaxZone

### `static ERPInsert(List<Service_Repair_Order__c> triggerNew)`

Inserts a SRO using the DMS Data API

#### Parameters

|Param|Description|
|---|---|
|`sro`||

### `static ERPUpdate(List<Service_Repair_Order__c> triggerNew)`

Updates a SRO using the DMS Data API

#### Parameters

|Param|Description|
|---|---|
|`sro`||

### `static updateRelatedPartsInvoice(List<Service_Repair_Order__c> triggerNew, Map<Id,Service_Repair_Order__c> triggerOldMap)`

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
