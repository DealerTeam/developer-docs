---
layout: default
---
# InventoryMediaController class
---
## Methods
### `getImages(Id recordId)` → `List<Inventory_Images__c>`

returns list all inventory images for a vehicle

#### Parameters
|Param|Description|
|-----|-----------|
|`recordId` |      The vehicle inventory Id |

### `getRelatedVehicleId(Id rootId, String relatedField)` → `sObject`

queries the record of rootId with the relatedField returned

#### Parameters
|Param|Description|
|-----|-----------|
|`rootId` |  Id of the record to query |
|`relatedField` |  field that can traverse many levels |

---
