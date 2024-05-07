---
layout: default
---
# PartInventoryAPI



**Group** Parts

## Methods
### `public void makeAdjustment(List<Part_Inventory_History__c> partHistory)`

makeAdjustment Handles adjusting on_order__c or Cost__c

#### Parameters

|Param|Description|
|---|---|
|`partHistory`|List of history with values needed to update parts inventory|


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `public List<Parts_Inventory__c> validateAdjustment(List<Part_Inventory_History__c> partHistory)`

validateAdjustment checks the part_inventory_history__c records are valid for updating

#### Parameters

|Param|Description|
|---|---|
|`partHistory`|List<Part_Inventory_History__c> records with changes to validate|

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Inventory__c>`|List<Part_Inventory__c> organized records to update|


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `public void adjustOnHand(List<Part_Inventory_History__c> partHistory, Boolean updateEmail, Boolean isBulk)`

adjustOnHand handles updating on-hand adjustments to parts inventory

#### Parameters

|Param|Description|
|---|---|
|`partHistory`|list of history records used to update existing parts inventory|

### `public void ValidateSameStore(List<Parts_Inventory__c> partList)`
### `public List<Part_Inventory_History__c> getPartHistory(String partId)`
#### Returns

|Type|Description|
|---|---|
|`List<Part_Inventory_History__c>`|List<dealer__Part_Inventory_History__c>|


**Method** getPartHistory


**Notes** returns a list of the inventory history records for this part


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `public List<Parts_Ledger__c> getPartLedger(String partId)`
#### Returns

|Type|Description|
|---|---|
|`List<Parts_Ledger__c>`|List<dealer__Parts_Ledger__c>|


**Method** getPartLedger


**Notes** get the list of ledger entries for the part record.


**Test** PartPhysicalInventoryUILayer.testPIEXT

### `public void canEditParts()`
---
## Classes
### PartInventoryAPIException

**Inheritance**

PartInventoryAPIException


---
