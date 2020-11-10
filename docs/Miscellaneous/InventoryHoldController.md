---
layout: default
---
# InventoryHoldController class
---
## Methods
### `checkTypes()` → `List<InventoryHoldType__c>`

 checkTypes Checks to verify InventoryHoldType__c records exists, surfaces an error in LWC if not

### `getActiveHolds(Id vId)` → `List<InventoryHold__c>`

 getActiveHolds Gets any holds for the vehicle

#### Parameters
|Param|Description|
|-----|-----------|
|`vId` |  The id to check against active holds |

### `getDefaultValues(Id holdType, String holdObject)` → `InventoryHold__c`

 getDefaultValues Compares the object and hold type for a custom setting record to populate default values

#### Parameters
|Param|Description|
|-----|-----------|
|`holdType` |    The name of the hold |
|`holdObject` |  Api name of the object to be held |

### `getRelatedIds(Id refId)` → `InventoryHold__c`

 getRelatedIds returns specific lookup values based on the object page hosting the component

#### Parameters
|Param|Description|
|-----|-----------|
|`refId` |  refId the id of the record hosting the component |

### `manageSettings()` → `Boolean`

 manageSettings Checks if user has permission to edit InventoryHoldType__c fields

---
