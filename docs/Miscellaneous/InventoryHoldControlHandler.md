---
layout: default
---
# InventoryHoldControlHandler class
---
## Methods
### `enforceActiveHolds(List<InventoryHold__c> triggerNew)` → `void`

 enforceActiveHolds used to prevent placing a hold on a record that already has an active hold

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |  List of InventoryHold__c records being inserted or updated |

### `returnToPriorStatus(List<InventoryHold__c> triggerNew, Map<Id, InventoryHold__c> triggerOldMap)` → `void`

 returnToPriorStatus Returns vehicle to its status prior to being placed on hold and removes hold related details from fields

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |     triggerNew description |
|`triggerOldMap` |  triggerOldMap description |

### `setNotificationId(List<InventoryHold__c> triggerNew)` → `void`

 setNotificationId sets id of customnotificationtype to be used in holds processing flow

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |  triggerNew description |

### `setPriorStatus(List<InventoryHold__c> triggerNew)` → `void`

 setPriorStatus Sets the PriorStatus__c field with status from vehicle inventory if returnToPriorStatus__c is true

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |  List<InventoryHold__c> being inserted |

### `updateVehicleInventory(List<InventoryHold__c> triggerNew)` → `void`

 updateVehicleInventory updates hold related fields on the vehicle inventory when active hold is created

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |  list of InventoryHold__c records being inserted |

---
## Inner Classes

### InventoryHoldControlHandler.InventoryHoldControlHandlerException class
---
