---
layout: default
---
# PartInventoryAPI class
---
## Methods
### `ValidateSameStore(List<Parts_Inventory__c> partList)` → `void`
### `adjustOnHand(List<Part_Inventory_History__c> partHistory, Boolean updateEmail)` → `void`

 adjustOnHand handles updating on-hand adjustments to parts inventory

#### Parameters
|Param|Description|
|-----|-----------|
|`partHistory` |  list of history records used to update existing parts inventory |

### `canEditParts()` → `void`

 canEditParts Checks for custom permission BulkPartsAdjustment

### `getPartHistory(String partId)` → `List<Part_Inventory_History__c>`

 getPartHistory

### `getPartLedger(String partId)` → `List<Parts_Ledger__c>`

 getPartLedger

### `makeAdjustment(List<Part_Inventory_History__c> partHistory)` → `void`

 makeAdjustment Handles adjusting on_order__c or Cost__c

#### Parameters
|Param|Description|
|-----|-----------|
|`partHistory` |  List of history with values needed to update parts inventory |

### `validateAdjustment(List<Part_Inventory_History__c> partHistory)` → `List<Parts_Inventory__c>`

 validateAdjustment checks the part_inventory_history__c records are valid for updating

#### Parameters
|Param|Description|
|-----|-----------|
|`partHistory` |  List<Part_Inventory_History__c> records with changes to validate |

---
## Inner Classes

### PartInventoryAPI.PartInventoryAPIException class
---
