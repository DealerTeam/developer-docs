---
layout: default
---
# InventoryMediaController



**Group** Sales

## Methods
### `public static sObject getRelatedVehicleId(Id rootId, String relatedField)`

`AURAENABLED`

queries the record of rootId with the relatedField returned

#### Parameters

|Param|Description|
|---|---|
|`rootId`|Id of the record to query|
|`relatedField`|field that can traverse many levels|

#### Returns

|Type|Description|
|---|---|
|`sObject`|sObject holding the field with a vehicleId|


**Method** getRelatedVehicleId

### `public static List<Inventory_Images__c> getImages(Id recordId)`

`AURAENABLED`

returns list all inventory images for a vehicle

#### Parameters

|Param|Description|
|---|---|
|`recordId`|The vehicle inventory Id|

#### Returns

|Type|Description|
|---|---|
|`List<Inventory_Images__c>`|List<Inventory_Images__c> all images for the vehicle|


**Method** getImages

---
