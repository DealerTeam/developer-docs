# PartInventoryAPI

`APIVERSION: 47`

`STATUS: ACTIVE`



**Group** Parts

## Methods
### `makeAdjustment(List<Part_Inventory_History__c> partHistory)`

makeAdjustment Handles adjusting on_order__c or Cost__c

#### Parameters

|Param|Description|
|---|---|
|`partHistory`|List of history with values needed to update parts inventory|


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `validateAdjustment(List<Part_Inventory_History__c> partHistory)`

validateAdjustment checks the part_inventory_history__c records are valid for updating

#### Parameters

|Param|Description|
|---|---|
|`partHistory`|List<Part_Inventory_History__c> records with changes to validate|

#### Return

**Type**

List&lt;Parts_Inventory__c&gt;

**Description**

List&lt;Part_Inventory__c&gt; organized records to update


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `adjustOnHand(List<Part_Inventory_History__c> partHistory, Boolean updateEmail, Boolean isBulk)`

adjustOnHand handles updating on-hand adjustments to parts inventory

#### Parameters

|Param|Description|
|---|---|
|`partHistory`|list of history records used to update existing parts inventory|

### `ValidateSameStore(List<Parts_Inventory__c> partList)`
### `getPartHistory(String partId)`
#### Return

**Type**

List&lt;Part_Inventory_History__c&gt;

**Description**

List&lt;dealer__Part_Inventory_History__c&gt;


**Method** getPartHistory


**Notes** returns a list of the inventory history records for this part


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `getPartLedger(String partId)`
#### Return

**Type**

List&lt;Parts_Ledger__c&gt;

**Description**

List&lt;dealer__Parts_Ledger__c&gt;


**Method** getPartLedger


**Notes** get the list of ledger entries for the part record.


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `canEditParts()`
---
## Classes
### PartInventoryAPIException

**Inheritance**

PartInventoryAPIException


---
