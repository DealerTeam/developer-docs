---
layout: default
---
# InventoryHoldControlHandler



**Group** Sales

## Methods
### `public void enforceActiveHolds(List<InventoryHold__c> triggerNew)`

enforceActiveHolds used to prevent placing a hold on a record that already has an active hold

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|List of InventoryHold__c records being inserted or updated|

### `public void setNotificationId(List<InventoryHold__c> triggerNew)`

setNotificationId sets id of customnotificationtype to be used in holds processing flow

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|

### `public void updateVehicleInventory(List<InventoryHold__c> triggerNew)`

updateVehicleInventory updates hold related fields on the vehicle inventory when active hold is created

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|list of InventoryHold__c records being inserted|

### `public void setPriorStatus(List<InventoryHold__c> triggerNew)`

setPriorStatus Sets the PriorStatus__c field with status from vehicle inventory if returnToPriorStatus__c is true

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|List<InventoryHold__c> being inserted|

### `public void returnToPriorStatus(List<InventoryHold__c> triggerNew, Map<Id,InventoryHold__c> triggerOldMap)`

returnToPriorStatus Returns vehicle to its status prior to being placed on hold and removes hold related details from fields

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|
|`triggerOldMap`|triggerOldMap description|

---
## Classes
### InventoryHoldControlHandlerException

**Inheritance**

InventoryHoldControlHandlerException


---
