---
layout: default
---
# LocationServiceAPI
## Constructors
### `public LocationServiceAPI(List<String> locationIds, String provider)`

LocationServiceAPI constructor creates a map of key dealerLocation Ids to a value of its corresponding location service

#### Parameters

|Param|Description|
|---|---|
|`locationIds`|- locations to return location services for|
|`provider`|- location service to search for|

---
## Fields

### `public locationMap` → `Map<Id,Location>`


---
## Methods
### `public String buildExportJSON()`

buildExportJSON description

#### Returns

|Type|Description|
|---|---|
|`String`|returns JSON from constructed location service map|

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

---
