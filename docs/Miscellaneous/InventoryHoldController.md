# InventoryHoldController

`APIVERSION: 46`

`STATUS: ACTIVE`
## Methods
### `static getRelatedIds(Id refId)`

`AURAENABLED`

getRelatedIds returns specific lookup values based on the object page hosting the component

#### Parameters

|Param|Description|
|---|---|
|`refId`|refId the id of the record hosting the component|

#### Return

**Type**

InventoryHold__c

**Description**

InventoryHold__c Hold object with lookup fields populated as needed


**Group** Sales

### `static getActiveHolds(Id vId)`

`AURAENABLED`

getActiveHolds Gets any holds for the vehicle

#### Parameters

|Param|Description|
|---|---|
|`vId`|The id to check against active holds|

#### Return

**Type**

List&lt;InventoryHold__c&gt;

**Description**

List&lt;InventoryHold__c&gt; any active holds for the given id


**Notes** will need updated to accept other objects such as equipment

### `static getDefaultValues(Id holdType, String holdObject)`

`AURAENABLED`

getDefaultValues Compares the object and hold type for a custom setting record to populate default values

#### Parameters

|Param|Description|
|---|---|
|`holdType`|The name of the hold|
|`holdObject`|Api name of the object to be held|

#### Return

**Type**

InventoryHold__c

**Description**

InventoryHold__c Hold object with default values populated from the custom setting

### `static checkTypes()`

`AURAENABLED`

checkTypes Checks to verify InventoryHoldType__c records exists, surfaces an error in LWC if not

#### Return

**Type**

List&lt;InventoryHoldType__c&gt;

**Description**

returns InventoryHoldType__c records or null if none exist

### `static manageSettings()`

`AURAENABLED`

manageSettings Checks if user has permission to edit InventoryHoldType__c fields

#### Return

**Type**

Boolean

**Description**

Boolean true if user can update Name field, otherwise false

---
