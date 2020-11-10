---
layout: default
---
# InvFeed class

 InvFeed : Manages and produces feed output for sharing venicle inventory via JSON. 			 This controller and InvWebFeed.page can be included in Salesforce Sites for syndication Tested By: Test_InventoryFeedManager

---
## Constructors
### `InvFeed()`

 InvFeed Constructor @notes The constructor load the inventory feed items in a public list for VF Page consumption
---
## Properties

### `contentTypeVar` → `String`

### `equip_fields` → `List<String>`

### `feedItems` → `List<dealer__InventoryFeed__c>`

### `hasURLParams` → `Boolean`

### `id` → `String`

### `image_fields` → `List<String>`

### `invWrap` → `List<InventoryWrapper>`

### `nuo` → `String`

### `publishToWeb` → `String`

### `recordtype` → `String`

### `stock` → `String`

### `storeId` → `String`

### `urlParameters` → `String>`

### `veh_equip_fields` → `List<String>`

### `vehicle_inventory_fields` → `List<String>`

### `vin` → `String`

### `xmlFields` → `List<String>`

### `xmlOutput` → `Boolean`

---
## Methods
### `buildQueryStrings()` → `void`

 buildQueryStrings

### `formatFeed()` → `String`

 formatFeed - take the list of inventory and create json from the feed

### `formatXmlFeed()` → `String`
### `getDisplayFeed()` → `String`

 getDisplayFeed

### `getEquipmentMap(List<Vehicle_Inventory__c> vehicleList)` → `List<Equipment__c>>`

 getEquipmentMap

### `getInventory()` → `List<InventoryWrapper>`

 getInventory - returns inventoryWrapper class of the inventory and equipment

### `getVehicleEquipmentMap(List<Vehicle_Inventory__c> vehicleList)` → `List<Vehicle_Equipment__c>>`
### `loadFeedItems()` → `void`

 loadFeedItems

### `loadFeedTable()` → `PageReference`

 loadFeedTabe - Erases and re-creates the feed table items

### `queryServiceVehicles(Set<Id> serviceVehicleIds)` → `List<Decode_Values__b>>`

 queryServiceVehicles

### `queryVehicleInventory()` → `List<dealer__Vehicle_Inventory__c>`

 queryVehicleInventory

### `readURLParameters()` → `void`

 	readURLParameters 	@notes The read parameters routine will allow specific field filters.  The filters are specifically as follows. 		RecordID, RecordType, VIN, StockNumber, PublishToWeb, StoreLocation, NUO

### `saveInclude(String s)` → `boolean`

 saveInclude

#### Parameters
|Param|Description|
|-----|-----------|
|`String` |  : Id of the field to include in the results of the Feed |

### `saveLabel(String sI)` → `boolean`

 saveLabel

#### Parameters
|Param|Description|
|-----|-----------|
|`String` |  colon seperated name:id |

---
## Inner Classes

### InvFeed.InventoryFeedException class
---
### InvFeed.InventoryWrapper class
---
#### Properties

##### `decoderValues` → `List<Decode_Values__b>`

##### `equipment` → `List<Equipment__c>`

##### `vehicle` → `Vehicle_Inventory__c`

##### `vehicleEquipment` → `List<Vehicle_Equipment__c>`

---
