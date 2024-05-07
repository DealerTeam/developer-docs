---
layout: default
---
# DesiredVehicleControlHandler
## Fields

### `private Sales_Up_TaskList` → `List<Task>`


### `private salesUpMap` → `Map<String,Sales_Up__c>`


### `private salesUpIds` → `Set<String>`


---
## Methods
### `public void handleAfter(List<Desired_Vehicle__c> desireVehiclesList)`
### `public void updateRelatedSalesUp(List<dealer__Desired_Vehicle__c> triggerNew, Map<Id,dealer__Desired_Vehicle__c> oldMap)`

Push updates of the desired vehicle to related sales ups


**Test** Desired_Vehicle_Trigger_TC.desiredVehicleTriggerTest

### `public void relateToSalesUp(Map<Id,Desired_Vehicle__c> triggerNewMap)`

Updates the related sales up if no desired vehicle exists on the sales up

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** relateToSalesUp

---
