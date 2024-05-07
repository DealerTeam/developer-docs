---
layout: default
---
# InventoryHoldController
## Methods
### `public static InventoryHold__c getRelatedIds(Id refId)`

`AURAENABLED`

getRelatedIds returns specific lookup values based on the object page hosting the component

#### Parameters

|Param|Description|
|---|---|
|`refId`|refId the id of the record hosting the component|

#### Returns

|Type|Description|
|---|---|
|`InventoryHold__c`|InventoryHold__c Hold object with lookup fields populated as needed|


**Group** Sales

### `public static List<InventoryHold__c> getActiveHolds(Id vId)`

`AURAENABLED`

getActiveHolds Gets any holds for the vehicle

#### Parameters

|Param|Description|
|---|---|
|`vId`|The id to check against active holds|

#### Returns

|Type|Description|
|---|---|
|`List<InventoryHold__c>`|List<InventoryHold__c> any active holds for the given id|


**Notes** will need updated to accept other objects such as equipment

### `public static InventoryHold__c getDefaultValues(Id holdType, String holdObject)`

`AURAENABLED`

getDefaultValues Compares the object and hold type for a custom setting record to populate default values

#### Parameters

|Param|Description|
|---|---|
|`holdType`|The name of the hold|
|`holdObject`|Api name of the object to be held|

#### Returns

|Type|Description|
|---|---|
|`InventoryHold__c`|InventoryHold__c Hold object with default values populated from the custom setting|

### `public static List<InventoryHoldType__c> checkTypes()`

`AURAENABLED`

checkTypes Checks to verify InventoryHoldType__c records exists, surfaces an error in LWC if not

#### Returns

|Type|Description|
|---|---|
|`List<InventoryHoldType__c>`|returns InventoryHoldType__c records or null if none exist|

### `public static Boolean manageSettings()`

`AURAENABLED`

manageSettings Checks if user has permission to edit InventoryHoldType__c fields

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean true if user can update Name field, otherwise false|

---
