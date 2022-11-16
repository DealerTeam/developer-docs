# DealerLocationUserControlHandler

`APIVERSION: 54`

`STATUS: ACTIVE`
## Methods
### `static validateNewLocationUser(List<Dealer_Location_User__c> triggerNew)`

Enforces a single record exists for a user and location

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** validateNewLocationUser

### `static setERPSettings(Map<Id,Dealer_Location_User__c> triggerOldMap, Map<Id,Dealer_Location_User__c> triggerNewMap)`

- After Insert / Update / delete method to update the User's ERP settings from a selected DealerShip Location User record.

---
