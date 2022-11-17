# InventoryMediaController

`APIVERSION: 48`

`STATUS: ACTIVE`



**Group** Sales

## Methods
### `static getRelatedVehicleId(Id rootId, String relatedField)`

`AURAENABLED`

queries the record of rootId with the relatedField returned

#### Parameters

|Param|Description|
|---|---|
|`rootId`|Id of the record to query|
|`relatedField`|field that can traverse many levels|

#### Return

**Type**

sObject

**Description**

sObject holding the field with a vehicleId


**Method** getRelatedVehicleId

### `static getImages(Id recordId)`

`AURAENABLED`

returns list all inventory images for a vehicle

#### Parameters

|Param|Description|
|---|---|
|`recordId`|The vehicle inventory Id|

#### Return

**Type**

List&lt;Inventory_Images__c&gt;

**Description**

List&lt;Inventory_Images__c&gt; all images for the vehicle


**Method** getImages

---
