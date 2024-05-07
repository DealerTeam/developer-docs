---
layout: default
---
# DealerLocationUserControlHandler
## Methods
### `public static void validateNewLocationUser(List<Dealer_Location_User__c> triggerNew)`

Enforces a single record exists for a user and location

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** validateNewLocationUser

### `public static void validateExistingLocationUsers(List<Dealer_Location_User__c> triggerNew)`

validateExistingLocationUsers - validates a user only has one DLU selected

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|- incoming trigger new records|

### `public static void setERPSettings(Map<Id,Dealer_Location_User__c> triggerNewMap)`

- After Insert / Update / delete method to update the User's ERP settings from a selected DealerShip Location User record.

---
