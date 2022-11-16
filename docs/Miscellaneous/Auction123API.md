# Auction123API

`APIVERSION: 52`

`STATUS: ACTIVE`

Creates Inventory Data from a list of locations for Auction 123 Web Services


**Class** Auction123API

## Constructors
### `Auction123API(List<String> locationIds)`

Auction123API Constructor

#### Parameters

|Param|Description|
|---|---|
|`locationIds`|locationIds|

---
## Fields

### `locationMap` → `Map<Id,Location>`


### `vehicles` → `List<Vehicle>`


---
## Methods
### `buildExportJSON()`

buildExportJSON description

#### Return

**Type**

String

**Description**

returns JSON with Auction123 JSON Data

---
## Classes
### Auction123APIException

**Inheritance**

Auction123APIException


### Location

Location class holds location and Dealer ID from a Location Services

#### Constructors
##### `Location(Dealer_Location__c storeLocation, String DealerId)`
---

### Vehicle

Data required for Auction123 CSV.

#### Fields

##### `Body_Type` → `String`


##### `Certification_Number` → `String`


##### `Condition` → `String`


##### `Dealer_Certified` → `Integer`


##### `Dealer_ID` → `String`


##### `Doors` → `Decimal`


##### `Drive_Train` → `String`


##### `Engine` → `String`


##### `Exterior_Color` → `String`


##### `Exterior_Color_Code` → `String`


##### `In_Service_Date` → `String`


##### `Interior_Color` → `String`


##### `Interior_Color_Code` → `String`


##### `Internet_Price` → `Decimal`


##### `Internet_Special` → `Integer`


##### `Inventory_Since` → `String`


##### `Invoice_Price` → `Decimal`


##### `Lot_Location` → `String`


##### `MSRP` → `Decimal`


##### `Make` → `String`


##### `Mileage` → `Decimal`


##### `Model` → `String`


##### `OEM_Certified` → `Integer`


##### `OEM_Model_Code` → `String`


##### `Option_Codes` → `String`


##### `Options` → `String`


##### `Picture_URLs` → `String`


##### `Postal_Code` → `String`


##### `Showroom_Title` → `String`


##### `Sticker_Price` → `Decimal`


##### `Stock_Number` → `String`


##### `Third_Party_Description` → `String`


##### `Third_Party_Price` → `Decimal`


##### `Transmission` → `String`


##### `Trim_Level` → `String`


##### `VIN` → `String`


##### `Vehicle_Description` → `String`


##### `Vehicle_Type` → `String`


##### `Warranty` → `String`


##### `Year` → `String`


---

---
