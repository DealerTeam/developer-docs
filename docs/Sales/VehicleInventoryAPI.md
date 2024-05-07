---
layout: default
---
# VehicleInventoryAPI



**Test** TestVehicleInventoryAPI


**Group** Sales

## Properties

### `public dms` → `DMS_Settings__c`


---
## Methods
### `public List<Vehicle_Inventory__c> markSold(List<Deal__c> deals)`
### `public List<Vehicle_Inventory__c> createInventoryFromTrades(List<Trade_In__c> tradeList)`
### `private String defaultInventoryStatusValue()`
### `public String getNextStockNumber(String vin)`

Method currently only supports sequence or VIN, future logic should include other options

### `public static string getStockByLastOfVIN(dealer__Vehicle_Inventory__c veh, dealer__DMS_Settings__c dms)`
### `public static String getStockNumberByDate(Vehicle_Inventory__c veh, DMS_Settings__c dms)`
### `public static void resetStockSequence()`

resetStockSequence creates a scheduled job to run at the start of each month to reset Stock_Number_Current_Index__c to 0

### `public static string getStockBySequence()`
### `public static List<StockNumberBookEntry> getStockByStockBook(String RecordTypeId, dealer__Dealer_Location__c loc)`
### `public static Map<String,Object> getStockByCustomField(dealer__Vehicle_Inventory__c veh, dealer__DMS_Settings__c dms)`
### `public static string getStockByLastOfVON(dealer__Vehicle_Inventory__c veh, dealer__DMS_Settings__c dms)`
### `public static Vehicle_Inventory__c selectAllFields(Id inventoryRecordId)`
### `public StockNumberAssigmentMethod getAssignmentMethod()`
### `public static List<InventoryHold__c> getActiveHolds(Set<Id> vehicleIds)`

getActiveHolds returns a list of Vehicles with active holds

#### Parameters

|Param|Description|
|---|---|
|`vehicleIds`|vehicleIds vehicles to check for active holds|

#### Returns

|Type|Description|
|---|---|
|`List<InventoryHold__c>`|return list of active InventoryHold__c records from the set of Ids|

### `public static InventoryHold__c selectHoldDefaults(Id holdType, String objectType)`

selectDefaults finds if custom setting exists for a given hold type and returns values

#### Parameters

|Param|Description|
|---|---|
|`String`|holdType Hold Type to check against custom settings|
|`String`|objectType Object api name of hold to check against custom settings (Ex: Vehicle Hold would be dealer__Vehicle_Inventory__c)|

#### Returns

|Type|Description|
|---|---|
|`InventoryHold__c`|InventoryHold__c returns an InventoryHold__c object with default values taken from custom setting for that type|

### `public static Service_Vehicle__c simpleVINDecode(String VIN)`
---
## Enums
### StockNumberAssigmentMethod

---
## Classes
### StockNumberBookEntry
#### Constructors
##### `public StockNumberBookEntry(dealer__Stock_Number_Book__c objStockNumberBook)`
---
#### Properties

##### `public isSelected` → `Boolean`


##### `public Name` → `String`


##### `public Location` → `String`


##### `public recordTypeId` → `String`


##### `public recordType` → `String`


##### `public customStockNumber` → `String`


##### `public sequence` → `Decimal`


---

### VehicleInventoryAPIException

**Inheritance**

VehicleInventoryAPIException


---
