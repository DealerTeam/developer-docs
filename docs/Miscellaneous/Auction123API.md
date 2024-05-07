---
layout: default
---
# Auction123API

Creates Inventory Data from a list of locations for Auction 123 Web Services


**Class** Auction123API

## Constructors
### `public Auction123API(List<String> locationIds)`

Auction123API Constructor

#### Parameters

|Param|Description|
|---|---|
|`locationIds`|locationIds|

---
## Fields

### `public vehicles` → `List<Vehicle>`


### `public locationMap` → `Map<Id,Location>`


---
## Methods
### `public String buildExportJSON()`

buildExportJSON description

#### Returns

|Type|Description|
|---|---|
|`String`|returns JSON with Auction123 JSON Data|

---
## Classes
### Location

Location class holds location and Dealer ID from a Location Services

#### Constructors
##### `public Location(Dealer_Location__c storeLocation, String DealerId)`
---
#### Fields

##### `private storeLocation` → `Dealer_Location__c`


##### `private DealerId` → `String`


---

### Vehicle

Data required for Auction123 CSV.

#### Fields

##### `public Dealer_ID` → `String`


##### `public Stock_Number` → `String`


##### `public VIN` → `String`


##### `public Year` → `String`


##### `public Make` → `String`


##### `public Model` → `String`


##### `public Trim_Level` → `String`


##### `public Condition` → `String`


##### `public OEM_Model_Code` → `String`


##### `public Exterior_Color` → `String`


##### `public Exterior_Color_Code` → `String`


##### `public Interior_Color` → `String`


##### `public Interior_Color_Code` → `String`


##### `public Engine` → `String`


##### `public Transmission` → `String`


##### `public Drive_Train` → `String`


##### `public Doors` → `Decimal`


##### `public Body_Type` → `String`


##### `public Inventory_Since` → `String`


##### `public In_Service_Date` → `String`


##### `public Mileage` → `Decimal`


##### `public Sticker_Price` → `Decimal`


##### `public Internet_Price` → `Decimal`


##### `public Invoice_Price` → `Decimal`


##### `public MSRP` → `Decimal`


##### `public Third_Party_Price` → `Decimal`


##### `public Internet_Special` → `Integer`


##### `public Dealer_Certified` → `Integer`


##### `public OEM_Certified` → `Integer`


##### `public Certification_Number` → `String`


##### `public Warranty` → `String`


##### `public Lot_Location` → `String`


##### `public Vehicle_Description` → `String`


##### `public Third_Party_Description` → `String`


##### `public Showroom_Title` → `String`


##### `public Picture_URLs` → `String`


##### `public Options` → `String`


##### `public Option_Codes` → `String`


##### `public Vehicle_Type` → `String`


##### `public Postal_Code` → `String`


---

### Auction123APIException

**Inheritance**

Auction123APIException


---
