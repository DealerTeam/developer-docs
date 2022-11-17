# TradeInControlHandler

`APIVERSION: 46`

`STATUS: ACTIVE`
## Methods
### `static setName(List<Trade_In__c> triggerNew)`

setName Handles populating the Name from Year Make and Model of the trade in record

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|

### `static createServiceVehicleFromTrade(List<dealer__Trade_In__c> newTrade)`
### `static updateServiceVehicleOnUpdate(List<Trade_In__c> triggerNew, Map<Id,Trade_In__c> triggerOldMap)`

updates sv odometer when trade in odometer is updated

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`||
|`triggerOldMap`||


**Method** updateServiceVehicleOnUpdate

---
