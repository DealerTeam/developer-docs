# VehicleInventoryAPI

`APIVERSION: 46`

`STATUS: ACTIVE`



**Test** TestVehicleInventoryAPI


**Group** Sales

## Properties

### `dms` → `DMS_Settings__c`


---
## Methods
### `markSold(List<Deal__c> deals)`
### `createInventoryFromTrades(List<Trade_In__c> tradeList)`
### `getNextStockNumber(String vin)`

Method currently only supports sequence or VIN, future logic should include other options

### `static getStockByLastOfVIN(dealer__Vehicle_Inventory__c veh, dealer__DMS_Settings__c dms)`
### `static getStockNumberByDate(Vehicle_Inventory__c veh, DMS_Settings__c dms)`
### `static resetStockSequence()`

resetStockSequence creates a scheduled job to run at the start of each month to reset Stock_Number_Current_Index__c to 0

### `static getStockBySequence()`
### `static getStockByStockBook(String RecordTypeId, dealer__Dealer_Location__c loc)`
### `static getStockByCustomField(dealer__Vehicle_Inventory__c veh, dealer__DMS_Settings__c dms)`
### `static getStockByLastOfVON(dealer__Vehicle_Inventory__c veh, dealer__DMS_Settings__c dms)`
### `static selectAllFields(Id inventoryRecordId)`
### `getAssignmentMethod()`
### `static getActiveHolds(Set<Id> vehicleIds)`

getActiveHolds returns a list of Vehicles with active holds

#### Parameters

|Param|Description|
|---|---|
|`vehicleIds`|vehicleIds vehicles to check for active holds|

#### Return

**Type**

List&lt;InventoryHold__c&gt;

**Description**

return list of active InventoryHold__c records from the set of Ids

### `static selectHoldDefaults(Id holdType, String objectType)`

selectDefaults finds if custom setting exists for a given hold type and returns values

#### Parameters

|Param|Description|
|---|---|
|`String`|holdType Hold Type to check against custom settings|
|`String`|objectType Object api name of hold to check against custom settings (Ex: Vehicle Hold would be dealer__Vehicle_Inventory__c)|

#### Return

**Type**

InventoryHold__c

**Description**

InventoryHold__c returns an InventoryHold__c object with default values taken from custom setting for that type

### `static simpleVINDecode(String VIN)`
---
## Enums
### StockNumberAssigmentMethod

---
## Classes
### StockNumberBookEntry
#### Constructors
##### `StockNumberBookEntry(dealer__Stock_Number_Book__c objStockNumberBook)`
---
#### Properties

##### `Location` → `String`


##### `Name` → `String`


##### `customStockNumber` → `String`


##### `isSelected` → `Boolean`


##### `recordType` → `String`


##### `recordTypeId` → `String`


##### `sequence` → `Decimal`


---

### VehicleInventoryAPIException

**Inheritance**

VehicleInventoryAPIException


---
