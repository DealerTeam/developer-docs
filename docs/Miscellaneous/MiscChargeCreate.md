---
layout: default
---
# MiscChargeCreate

Helper class that should run without sharing to ensure Codes are created in their entirety every time

## Methods
### `public List<MiscChargeCode__c> createCodesFromMaster(List<MiscChargeMaster__c> masters, Id locId)`

Create new Misc Charge Codes at a given Location for the list of Misc Charge Masters

#### Parameters

|Param|Description|
|---|---|
|`masters`|Misc Charge Masters used to create Codes|
|`locId`|Location where Codes are related|

#### Returns

|Type|Description|
|---|---|
|`List<MiscChargeCode__c>`|List of all Misc Charge Codes created|

### `public List<MiscChargeCode__c> getCodesByLocation(Set<Id> masterIds, Id locId)`

Returns Misc Charge Codes related to the Location and Misc Charge Master Ids, will create new codes if none exist at Location

#### Parameters

|Param|Description|
|---|---|
|`masterIds`|Master Ids to retrieve related Misc Charge Codes|
|`locId`|Location where the Misc Charge Codes are related|

#### Returns

|Type|Description|
|---|---|
|`List<MiscChargeCode__c>`|List of Misc Charge Codes related to the Masters and Location|

---
