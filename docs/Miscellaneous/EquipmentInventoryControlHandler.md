---
layout: default
---
# EquipmentInventoryControlHandler class
---
## Methods
### `updatePricingFromMaster(List<EquipmentInventory__c> triggerNew, Map<Id, EquipmentInventory__c> triggerOldMap)` → `void`

 updatePricingFromMaster Refreshes pricing on Equipment Inventory when Equipment Master is changed

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |     triggerNew description |
|`triggerOldMap` |  triggerOldMap description |

### `updateRelatedDeal(List<EquipmentInventory__c> triggerNew, Map<Id, EquipmentInventory__c> triggerOldMap)` → `void`

 updateRelatedDeal Pushes pricing changes to any related deals and throw error if those deals are closed

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |     triggerNew description |
|`triggerOldMap` |  triggerOldMap description |

---
## Inner Classes

### EquipmentInventoryControlHandler.EquipmentInventoryControlHandlerException class
---
