---
layout: default
---
# TradeInControlHandler
## Methods
### `public static void setName(List<Trade_In__c> triggerNew)`

setName Handles populating the Name from Year Make and Model of the trade in record

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|

### `public static void createServiceVehicleFromTrade(List<dealer__Trade_In__c> newTrade)`
### `public static void updateServiceVehicleOnUpdate(List<Trade_In__c> triggerNew, Map<Id,Trade_In__c> triggerOldMap)`

updates sv odometer when trade in odometer is updated

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||
|`triggerOldMap`||


**Method** updateServiceVehicleOnUpdate

---
