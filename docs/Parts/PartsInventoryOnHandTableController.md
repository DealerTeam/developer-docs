---
layout: default
---
# PartsInventoryOnHandTableController



**Group** Parts

## Constructors
### `public PartsInventoryOnHandTableController()`
---
## Methods
### `public static List<Parts_Inventory__c> getInventoryLocationOnHand(Id partId)`

`AURAENABLED`

Retreive a list of Inventory Records that share a Parts Master

#### Parameters

|Param|Description|
|---|---|
|`partId`||

#### Returns

|Type|Description|
|---|---|
|`List<Parts_Inventory__c>`|List<Parts_Inventory__c>|

### `public static Boolean isQuotingEnabled()`

`AURAENABLED`

Check to see if quoting process is enabled.

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|

### `private static Id getPartMasterId(Id partId)`

Return the Parts Master Id from a given PartId

#### Parameters

|Param|Description|
|---|---|
|`partId`||

#### Returns

|Type|Description|
|---|---|
|`Id`|Id|

### `public static List<utility.fieldSetWrapper> getFieldSetMembers()`

`AURAENABLED`
---
