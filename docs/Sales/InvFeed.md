# InvFeed

`APIVERSION: 48`

`STATUS: ACTIVE`

InvFeed : Manages and produces feed output for sharing venicle inventory via JSON.  This controller and InvWebFeed.page can be included in Salesforce Sites for syndication


**Test** Test_InventoryFeedManager


**Author** jarrett kuljis


**Group** Sales


**Notes** 

## Constructors
### `InvFeed()`

InvFeed Constructor


**Notes** The constructor load the inventory feed items in a public list for VF Page consumption

---
## Fields

### `invWrap` → `List<InventoryWrapper>`


### `urlParameters` → `Map<String,String>`


---
## Properties

### `contentTypeVar` → `String`


### `equip_fields` → `List<String>`


### `feedItems` → `List<dealer__InventoryFeed__c>`


### `hasURLParams` → `Boolean`


### `id` → `String`


### `image_fields` → `List<String>`


### `nuo` → `String`


### `publishToWeb` → `String`


### `recordtype` → `String`


### `stock` → `String`


### `storeId` → `String`


### `veh_equip_fields` → `List<String>`


### `vehicle_inventory_fields` → `List<String>`


### `vin` → `String`


### `xmlFields` → `List<String>`


### `xmlOutput` → `Boolean`


---
## Methods
### `readURLParameters()`

readURLParameters The read parameters routine will allow specific field filters.  The filters are specifically as follows.  		RecordID, RecordType, VIN, StockNumber, PublishToWeb, StoreLocation, NUO

### `loadFeedTable()`
#### Return

**Type**

PageReference

**Description**

pagereferece null


**Method** loadFeedTabe - Erases and re-creates the feed table items

### `loadFeedItems()`
#### Return

**Type**

void

**Description**

void


**Method** loadFeedItems


**Notes** performs SOQL to get all inventory feed items into the public list of feed items

### `buildQueryStrings()`
#### Return

**Type**

void

**Description**

void


**Method** buildQueryStrings


**Notes** builds list of strings for the selected fields.

### `queryVehicleInventory()`
#### Return

**Type**

List&lt;dealer__Vehicle_Inventory__c&gt;

**Description**

List&lt;Vehicle_Inventory__c&gt;


**Method** queryVehicleInventory


**Notes** performs SOQL to get all inventory feed items into the public list of feed items

### `queryServiceVehicles(Set<Id> serviceVehicleIds)`
#### Return

**Type**

Map&lt;Id,List&lt;Decode_Values__b&gt;&gt;

**Description**

Map&lt;Id, List&lt;Decode_Values__b&gt;&gt;


**Method** queryServiceVehicles


**Notes** performs SOQL to get all service vehicles into the public set of service vehicles

### `getEquipmentMap(List<Vehicle_Inventory__c> vehicleList)`
#### Return

**Type**

Map&lt;Id,List&lt;Equipment__c&gt;&gt;

**Description**

Map&lt;Id, List&lt;Equipment__c&gt;&gt;


**Method** getEquipmentMap


**Notes** Map&lt;service vehicle Id,  Equipment list for that Service Vehicle&gt; (Non-vin decoded equipment)

### `getVehicleEquipmentMap(List<Vehicle_Inventory__c> vehicleList)`
### `getInventory()`

getInventory - returns inventoryWrapper class of the inventory and equipment

#### Return

**Type**

List&lt;InventoryWrapper&gt;

**Description**

List (inventoryWrapper.class)

### `formatFeed()`

formatFeed - take the list of inventory and create json from the feed

#### Return

**Type**

String

**Description**

String (JSON)


**Notes** Generate a json feed based on the selected items for the feed

### `formatXmlFeed()`
### `getDisplayFeed()`
#### Return

**Type**

String

**Description**

String (JSON)


**Method** getDisplayFeed


**Notes** Getter for the VF Page InvWebFeed

### `static saveInclude(String s)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`String`|: Id of the field to include in the results of the Feed|

#### Return

**Type**

boolean

**Description**

Boolean


**Method** saveInclude

### `static saveLabel(String sI)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`String`|colon seperated name:id|

#### Return

**Type**

boolean

**Description**

Boolean


**Method** saveLabel


**Notes** sets the value of the output field in the JSON Feed

---
## Classes
### InventoryFeedException

**Inheritance**

InventoryFeedException


### InventoryWrapper
#### Properties

##### `decoderValues` → `List&lt;Decode_Values__b&gt;`


##### `equipment` → `List&lt;Equipment__c&gt;`


##### `vehicle` → `Vehicle_Inventory__c`


##### `vehicleEquipment` → `List&lt;Vehicle_Equipment__c&gt;`


---

---
