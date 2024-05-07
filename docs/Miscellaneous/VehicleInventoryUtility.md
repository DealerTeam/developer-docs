---
layout: default
---
# VehicleInventoryUtility
## Fields

### `private vehiclePriceFormula` → `String`


---
## Methods
### `public static void beforeInsert(List<dealer__Vehicle_Inventory__c> newVehicle)`
### `public static boolean afterInsert(List<dealer__Vehicle_Inventory__c> newVehicle)`
### `public static void afterInsertStockBookUpdate(List<dealer__Vehicle_Inventory__c> newVehicle)`
### `public static void beforeUpdate(List<dealer__Vehicle_Inventory__c> newVehicle, Map<ID,dealer__Vehicle_Inventory__c> oldVehicleMap)`
### `public static boolean afterUpdate(List<dealer__Vehicle_Inventory__c> newVehicle, Map<ID,dealer__Vehicle_Inventory__c> newVehicleMap, Map<ID,dealer__Vehicle_Inventory__c> oldVehicleMap)`
### `public static void createStatusCode(List<dealer__Vehicle_Inventory__c> newVehicle, Boolean isUpdate, Map<ID,dealer__Vehicle_Inventory__c> oldVehicleMap)`
### `public static boolean createServiceVehicle(List<dealer__Vehicle_Inventory__c> newVehicle, Map<ID,dealer__Vehicle_Inventory__c> oldVehicleMap, Boolean isUpdate)`
### `private static Boolean checkCreateServiceVehicle(List<dealer__Vehicle_Inventory__c> newVehicle, Map<ID,dealer__Vehicle_Inventory__c> oldVehicleMap, Boolean isUpdate)`
### `private static Boolean isVehicleInfoChanged(dealer__Vehicle_Inventory__c i, Map<ID,dealer__Vehicle_Inventory__c> oldVehicleMap)`

Method to check if vehicle information has changed

#### Parameters

|Param|Description|
|---|---|
|`i`|The new vehicle inventory record|
|`oldVehicleMap`|Map of old vehicle inventory records keyed by ID|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean indicating if vehicle information has changed|

### `public static void populateConversionData(List<dealer__Vehicle_Inventory__c> triggerNew)`
### `public static void vehicleMarkedInStock(List<Vehicle_Inventory__c> changedVehicles)`

Accepts vehicles that have been marked as in stock and queries for related vehicles to check for existing VINs

#### Parameters

|Param|Description|
|---|---|
|`changedVehicles`|changedVehicles description|

### `private static Decimal getDiscountPriceFormula(Vehicle_Inventory__c vehicleToEvaluate)`

getDiscountPriceFormula evaluates the decimal value of the formula expression in the VehiclePriceFormula Dealerteam configuraation

#### Returns

|Type|Description|
|---|---|
|`Decimal`|return description|

### `private static void preventDuplicateVINs(Vehicle_Inventory__c vi, Service_Vehicle__c sv)`

Checks existing related vehicle inventories and asserts no in stock vehicles with the same vin exist

#### Parameters

|Param|Description|
|---|---|
|`vi`|New or updated vehicle to check|
|`sv`|Service Vehicle with related inventory records to check|

---
