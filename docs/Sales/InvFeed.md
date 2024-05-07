---
layout: default
---
# InvFeed

InvFeed : Manages and produces feed output for sharing venicle inventory via JSON.  This controller and InvWebFeed.page can be included in Salesforce Sites for syndication


**Test** Test_InventoryFeedManager


**Author** jarrett kuljis


**Group** Sales


**Notes** 

## Constructors
### `public InvFeed()`

InvFeed Constructor


**Notes** The constructor load the inventory feed items in a public list for VF Page consumption

---
## Fields

### `public urlParameters` → `Map<String,String>`


### `public invWrap` → `List<InventoryWrapper>`


---
## Properties

### `public id` → `String`


### `public vin` → `String`


### `public stock` → `String`


### `public recordtype` → `String`


### `public publishToWeb` → `String`


### `public storeId` → `String`


### `public nuo` → `String`


### `public hasURLParams` → `Boolean`


### `public xmlOutput` → `Boolean`


### `public contentTypeVar` → `String`


### `public feedItems` → `List<dealer__InventoryFeed__c>`


### `public xmlFields` → `List<String>`


### `public vehicle_inventory_fields` → `List<String>`


### `public image_fields` → `List<String>`


### `public equip_fields` → `List<String>`


### `public veh_equip_fields` → `List<String>`


---
## Methods
### `public void readURLParameters()`

readURLParameters The read parameters routine will allow specific field filters.  The filters are specifically as follows.  		RecordID, RecordType, VIN, StockNumber, PublishToWeb, StoreLocation, NUO

### `public PageReference loadFeedTable()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|pagereferece null|


**Method** loadFeedTabe - Erases and re-creates the feed table items

### `public void loadFeedItems()`
#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** loadFeedItems


**Notes** performs SOQL to get all inventory feed items into the public list of feed items

### `public void buildQueryStrings()`
#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** buildQueryStrings


**Notes** builds list of strings for the selected fields.

### `public List<dealer__Vehicle_Inventory__c> queryVehicleInventory()`
#### Returns

|Type|Description|
|---|---|
|`List<dealer__Vehicle_Inventory__c>`|List<Vehicle_Inventory__c>|


**Method** queryVehicleInventory


**Notes** performs SOQL to get all inventory feed items into the public list of feed items

### `public Map<Id,List<Decode_Values__b>> queryServiceVehicles(Set<Id> serviceVehicleIds)`
#### Returns

|Type|Description|
|---|---|
|`Map<Id,List<Decode_Values__b>>`|Map<Id, List<Decode_Values__b>>|


**Method** queryServiceVehicles


**Notes** performs SOQL to get all service vehicles into the public set of service vehicles

### `public Map<Id,List<Equipment__c>> getEquipmentMap(List<Vehicle_Inventory__c> vehicleList)`
#### Returns

|Type|Description|
|---|---|
|`Map<Id,List<Equipment__c>>`|Map<Id, List<Equipment__c>>|


**Method** getEquipmentMap


**Notes** Map&lt;service vehicle Id,  Equipment list for that Service Vehicle&gt; (Non-vin decoded equipment)

### `public Map<Id,List<Vehicle_Equipment__c>> getVehicleEquipmentMap(List<Vehicle_Inventory__c> vehicleList)`
### `public List<InventoryWrapper> getInventory()`

getInventory - returns inventoryWrapper class of the inventory and equipment

#### Returns

|Type|Description|
|---|---|
|`List<InventoryWrapper>`|List (inventoryWrapper.class)|

### `public String formatFeed()`

formatFeed - take the list of inventory and create json from the feed

#### Returns

|Type|Description|
|---|---|
|`String`|String (JSON)|


**Notes** Generate a json feed based on the selected items for the feed

### `public String formatXmlFeed()`
### `public String getDisplayFeed()`
#### Returns

|Type|Description|
|---|---|
|`String`|String (JSON)|


**Method** getDisplayFeed


**Notes** Getter for the VF Page InvWebFeed

### `public static boolean saveInclude(String s)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`String`|: Id of the field to include in the results of the Feed|

#### Returns

|Type|Description|
|---|---|
|`boolean`|Boolean|


**Method** saveInclude

### `public static boolean saveLabel(String sI)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`String`|colon seperated name:id|

#### Returns

|Type|Description|
|---|---|
|`boolean`|Boolean|


**Method** saveLabel


**Notes** sets the value of the output field in the JSON Feed

---
## Classes
### InventoryWrapper
#### Properties

##### `public vehicle` → `Vehicle_Inventory__c`


##### `public equipment` → `List&lt;Equipment__c&gt;`


##### `public vehicleEquipment` → `List&lt;Vehicle_Equipment__c&gt;`


##### `public decoderValues` → `List&lt;Decode_Values__b&gt;`


---

### InventoryFeedException

**Inheritance**

InventoryFeedException


---
