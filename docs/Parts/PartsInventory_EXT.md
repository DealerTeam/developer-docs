---
layout: default
---
# PartsInventory_EXT

The PartsInventory_EXT class extends the visualforce functionality of part modification and interaction with the parts inventory.


**Group** Parts

## Constructors
### `public PartsInventory_EXT(ApexPages controller)`

PartsInventory_EXT Constructor

#### Parameters

|Param|Description|
|---|---|
|`controller`|Standard Visualforce Page Controller|


**Notes** This constructor is currently used within the Part, PartNew, PartQTYAdjust VF Pages.

---
## Properties

### `public reasonforchange` → `String`


### `public onHandFlag` → `Boolean`


### `public inventoryItemIncreaseValue` → `Decimal`


### `public inventoryRecord` → `dealer__Parts_Inventory__c`


### `public pm` → `dealer__Parts_Master__c`


### `public myFixedOperationsSettings` → `FixedOperationsSettings__c`


### `public partAPI` → `PartInventoryAPI`


---
## Methods
### `public void setPartAPI()`
### `public List<dealer__Part_Inventory_History__c> getPartHistory()`
#### Returns

|Type|Description|
|---|---|
|`List<dealer__Part_Inventory_History__c>`|List<dealer__Part_Inventory_History__c>|


**Method** getPartHistory


**Notes** returns a list of the inventory history records for this part


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `public List<dealer__Parts_Ledger__c> getPartLedger()`
#### Returns

|Type|Description|
|---|---|
|`List<dealer__Parts_Ledger__c>`|List<dealer__Parts_Ledger__c>|


**Method** getPartLedger


**Notes** get the list of ledger entries for the part record.


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `public PageReference partManagement()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** partManagment - redirects the user to the part management page


**Notes** Performs page redirect to send the user to the parts management page


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `public PageReference partPrintLabel()`
### `public PageReference cancel()`
### `public boolean validateReasonForChange()`

validateReasonForChange - validate 'Reason for Change' field must have value.

#### Returns

|Type|Description|
|---|---|
|`boolean`|boolean - true if reasonforchange is blank|


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `public PageReference adjustCost()`

adjustCost - Performs cost adjustment on the part record

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `public PageReference adjustOrder()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** adjustOrder - Performs order adjustment on the part record


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `public PageReference adjustOnHand()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** adjustOnHand


**Notes** Used to adjust the onhand quantity of part in physical inventory.  This is specifically for Manual Adjustments.


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `public PageReference save()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** save


**Notes** Overloaded save method on standard object Parts_Inventory__c.


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `public Boolean getisPartManagementAccessible()`
### `public PageReference returnToPart()`
### `public static List<dealer__Parts_Inventory__c> searchExistingParts(String pn)`

`REMOTEACTION`
### `public static List<dealer__Parts_Master__c> partsMasterSearch(String pn)`

`REMOTEACTION`
---
