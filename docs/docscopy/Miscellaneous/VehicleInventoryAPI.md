---
layout: default
---
# VehicleInventoryAPI class

 VehicleInventoryAPI Test Class: TestVehicleInventoryAPI

---
## Enums
### StockNumberAssigmentMethod

---
## Properties

### `dms` → `DMS_Settings__c`

---
## Methods
### `createInventoryFromTrades(List<Trade_In__c> tradeList)` → `List<Vehicle_Inventory__c>`
### `getActiveHolds(Set<Id> vehicleIds)` → `List<InventoryHold__c>`

 getActiveHolds returns a list of Vehicles with active holds

#### Parameters
|Param|Description|
|-----|-----------|
|`vehicleIds` |  vehicleIds vehicles to check for active holds |

### `getAssignmentMethod()` → `StockNumberAssigmentMethod`
### `getNextStockNumber(String vin)` → `String`

 Note: Method currently only supports sequence or VIN, future logic should include other options

### `getStockByCustomField(dealer__Vehicle_Inventory__c veh, dealer__DMS_Settings__c dms)` → `Object>`
### `getStockByLastOfVIN(dealer__Vehicle_Inventory__c veh,dealer__DMS_Settings__c dms)` → `string`
### `getStockByLastOfVON(dealer__Vehicle_Inventory__c veh,dealer__DMS_Settings__c dms)` → `string`
### `getStockBySequence()` → `string`
### `getStockByStockBook(String RecordTypeId, dealer__Dealer_Location__c loc)` → `List<StockNumberBookEntry>`
### `getStockNumberByDate(Vehicle_Inventory__c veh, DMS_Settings__c dms)` → `String`
### `markSold(List<Deal__c> deals)` → `List<Vehicle_Inventory__c>`
### `resetStockSequence()` → `void`

 resetStockSequence creates a scheduled job to run at the start of each month to reset Stock_Number_Current_Index__c to 0

### `selectAllFields(Id inventoryRecordId)` → `Vehicle_Inventory__c`
### `selectHoldDefaults(Id holdType, String objectType)` → `InventoryHold__c`

 selectDefaults finds if custom setting exists for a given hold type and returns values

#### Parameters
|Param|Description|
|-----|-----------|
|`String` |  holdType Hold Type to check against custom settings |
|`String` |  objectType Object api name of hold to check against custom settings (Ex: Vehicle Hold would be dealer__Vehicle_Inventory__c) |

### `simpleVINDecode(String VIN)` → `Service_Vehicle__c`
---
## Inner Classes

### VehicleInventoryAPI.StockNumberBookEntry class
---
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
### VehicleInventoryAPI.VehicleInventoryAPIException class
---
