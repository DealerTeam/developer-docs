---
layout: default
---
# CustomLookupAPI
## Methods
### `public static List<LookupSearchResult> searchLocation(String searchTerm)`

`AURAENABLED`

allows custom lookups on DT components to search for Dealer_Locations

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|searchTerm to match Dealer_Locations against|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult> List of records matching the search term|


**Method** searchLocation

### `public static List<LookupSearchResult> getRecentLocations()`

`AURAENABLED`

returns recently viewed locations for populating custom lookups on DT components

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<lookupSearchResult>|


**Method** getRecentLocations

### `public static List<LookupSearchResult> selectedLocation(String locId)`

`AURAENABLED`

returns Location for populating lookup based on id

#### Parameters

|Param|Description|
|---|---|
|`locId`|- location to populate lookup with|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<lookupSearchResult>|


**Method** selectedLocation

### `public static List<LookupSearchResult> getVehicleInventory(String viId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`viId`||

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<lookupSearchResult>|


**Method** Returns VehicleInventory based on id

### `public static List<LookupSearchResult> searchVehicleInventory(String searchTerm)`

`AURAENABLED`

Searches for VehicleInventory

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`||

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<lookupSearchResult>|

### `public static List<LookupSearchResult> recentVehicles()`

`AURAENABLED`

Returns recently viewed Vehicle records

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|


**Method** recentVehicles

### `public static List<LookupSearchResult> getServiceVehicle(Id svId)`

`AURAENABLED`

returns service vehicle for populating lookup component

#### Parameters

|Param|Description|
|---|---|
|`svId`|record to populate lookup with|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|


**Method** getServiceVehicle

### `public static List<LookupSearchResult> searchServiceVehicles(String searchTerm)`

`AURAENABLED`

Searches for ServiceVehicle

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`||

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<lookupSearchResult>|

### `public static List<LookupSearchResult> relatedServiceVehicles(String accountId)`

`AURAENABLED`

returns all service vehicles related to a given account

#### Parameters

|Param|Description|
|---|---|
|`accountId`|account to find related contacts|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult> service vehicles to display in lookup component|


**Method** relatedServiceVehicles

### `public static List<LookupSearchResult> searchAccounts(String searchTerm)`

`AURAENABLED`

allows custom lookups on DT components to search for accounts

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|searchTerm to match accounts against|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult> List of records matching hte search term|


**Method** searchAccounts

### `public static List<LookupSearchResult> recentAccounts()`

`AURAENABLED`

Returns recently viewed Account records

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static List<LookupSearchResult> relatedContacts(String accountId)`

`AURAENABLED`

returns all contacts related to a given account

#### Parameters

|Param|Description|
|---|---|
|`accountId`|account to find related contacts|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult> contacts to display in lookup component|


**Method** relatedContacts

### `public static List<LookupSearchResult> searchContacts(String searchTerm, String accId)`

`AURAENABLED`

search contacts related to an account for a given string

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|term to search|
|`accId`|account to find related contacts|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult> contacts to display in lookup component|


**Method** searchContacts

### `public static List<LookupSearchResult> getSelection(Id recordId, String objectName)`

`AURAENABLED`

returns lookupSearchResult for an Id and object name

#### Parameters

|Param|Description|
|---|---|
|`recordId`|Id of record to get lookupsearchresult to display in lookup component|
|`objectName`|api name of the object for matching correct lookupsearch class|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult> a single result in the list for populating lookup component|


**Method** getSelection

---
