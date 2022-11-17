# PartsInventory_EXT

`APIVERSION: 51`

`STATUS: ACTIVE`

The PartsInventory_EXT class extends the visualforce functionality of part modification and interaction with the parts inventory.


**Group** Parts

## Constructors
### `PartsInventory_EXT(ApexPages.standardController controller)`

PartsInventory_EXT Constructor

#### Parameters

|Param|Description|
|---|---|
|`controller`|Standard Visualforce Page Controller|


**Notes** This constructor is currently used within the Part, PartNew, PartQTYAdjust VF Pages.

---
## Properties

### `inventoryItemIncreaseValue` → `Decimal`


### `inventoryRecord` → `dealer__Parts_Inventory__c`


### `myFixedOperationsSettings` → `FixedOperationsSettings__c`


### `onHandFlag` → `Boolean`


### `partAPI` → `PartInventoryAPI`


### `pm` → `dealer__Parts_Master__c`


### `reasonforchange` → `String`


---
## Methods
### `setPartAPI()`
### `getPartHistory()`
#### Return

**Type**

List&lt;dealer__Part_Inventory_History__c&gt;

**Description**

List&lt;dealer__Part_Inventory_History__c&gt;


**Method** getPartHistory


**Notes** returns a list of the inventory history records for this part


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `getPartLedger()`
#### Return

**Type**

List&lt;dealer__Parts_Ledger__c&gt;

**Description**

List&lt;dealer__Parts_Ledger__c&gt;


**Method** getPartLedger


**Notes** get the list of ledger entries for the part record.


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `partManagement()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** partManagment - redirects the user to the part management page


**Notes** Performs page redirect to send the user to the parts management page


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `partPrintLabel()`
### `cancel()`
### `validateReasonForChange()`

validateReasonForChange - validate 'Reason for Change' field must have value.

#### Return

**Type**

boolean

**Description**

boolean - true if reasonforchange is blank


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `adjustCost()`

adjustCost - Performs cost adjustment on the part record

#### Return

**Type**

PageReference

**Description**

PageReference


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `adjustOrder()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** adjustOrder - Performs order adjustment on the part record


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `adjustOnHand()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** adjustOnHand


**Notes** Used to adjust the onhand quantity of part in physical inventory.  This is specifically for Manual Adjustments.


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `save()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** save


**Notes** Overloaded save method on standard object Parts_Inventory__c.


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `getisPartManagementAccessible()`
### `returnToPart()`
### `static searchExistingParts(String pn)`

`REMOTEACTION`
### `static partsMasterSearch(String pn)`

`REMOTEACTION`
---
