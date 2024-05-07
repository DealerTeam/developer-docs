---
layout: default
---
# PartsPhysicalController
## Methods
### `public static List<PartsPhysicalDetail__c> getDetailLines(Id inventoryId)`

`AURAENABLED`

Get parts physical lines

#### Parameters

|Param|Description|
|---|---|
|`inventoryId`|inventoryId description|

#### Returns

|Type|Description|
|---|---|
|`List<PartsPhysicalDetail__c>`|return description|

### `public static List<AsyncApexJob> getBatchStatus(Id inventoryId)`

`AURAENABLED`

Get batch related to the Parts Physical Inventory

#### Parameters

|Param|Description|
|---|---|
|`inventoryId`|inventoryId description|

#### Returns

|Type|Description|
|---|---|
|`List<AsyncApexJob>`|return description|

### `public static string completePhysical(Id inventoryId)`

`AURAENABLED`

Call API to start start the complete batch method

#### Parameters

|Param|Description|
|---|---|
|`inventoryId`|inventoryId description|

#### Returns

|Type|Description|
|---|---|
|`string`|return description|

### `public static String saveCounts(List<PartsPhysicalDetail__c> lines, Id inventoryId)`

`AURAENABLED`
---
