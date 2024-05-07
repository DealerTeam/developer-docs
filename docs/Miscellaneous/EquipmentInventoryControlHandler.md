---
layout: default
---
# EquipmentInventoryControlHandler
## Methods
### `public static void updatePricingFromMaster(List<EquipmentInventory__c> triggerNew, Map<Id,EquipmentInventory__c> triggerOldMap)`

updatePricingFromMaster Refreshes pricing on Equipment Inventory when Equipment Master is changed

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|

### `public static void updateRelatedDeal(List<EquipmentInventory__c> triggerNew, Map<Id,EquipmentInventory__c> triggerOldMap)`

updateRelatedDeal Pushes pricing changes to any related deals and throw error if those deals are closed

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|

---
## Classes
### EquipmentInventoryControlHandlerException

**Inheritance**

EquipmentInventoryControlHandlerException


---
