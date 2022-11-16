# CustomLookupAPI

`APIVERSION: 48`

`STATUS: ACTIVE`
## Methods
### `static searchLocation(String searchTerm)`

`AURAENABLED`

allows custom lookups on DT components to search for Dealer_Locations

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|searchTerm to match Dealer_Locations against|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt; List of records matching the search term


**Method** searchLocation

### `static getRecentLocations()`

`AURAENABLED`

returns recently viewed locations for populating custom lookups on DT components

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;lookupSearchResult&gt;


**Method** getRecentLocations

### `static selectedLocation(String locId)`

`AURAENABLED`

returns Location for populating lookup based on id

#### Parameters

|Param|Description|
|---|---|
|`locId`|- location to populate lookup with|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;lookupSearchResult&gt;


**Method** selectedLocation

### `static getVehicleInventory(String viId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`viId`||

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;lookupSearchResult&gt;


**Method** Returns VehicleInventory based on id

### `static searchVehicleInventory(String searchTerm)`

`AURAENABLED`

Searches for VehicleInventory

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`||

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;lookupSearchResult&gt;

### `static recentVehicles()`

`AURAENABLED`

Returns recently viewed Vehicle records

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt;


**Method** recentVehicles

### `static getServiceVehicle(Id svId)`

`AURAENABLED`

returns service vehicle for populating lookup component

#### Parameters

|Param|Description|
|---|---|
|`svId`|record to populate lookup with|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt;


**Method** getServiceVehicle

### `static searchServiceVehicles(String searchTerm)`

`AURAENABLED`

Searches for ServiceVehicle

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`||

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;lookupSearchResult&gt;

### `static relatedServiceVehicles(String accountId)`

`AURAENABLED`

returns all service vehicles related to a given account

#### Parameters

|Param|Description|
|---|---|
|`accountId`|account to find related contacts|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt; service vehicles to display in lookup component


**Method** relatedServiceVehicles

### `static searchAccounts(String searchTerm)`

`AURAENABLED`

allows custom lookups on DT components to search for accounts

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|searchTerm to match accounts against|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt; List of records matching hte search term


**Method** searchAccounts

### `static recentAccounts()`

`AURAENABLED`

Returns recently viewed Account records

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt;

### `static relatedContacts(String accountId)`

`AURAENABLED`

returns all contacts related to a given account

#### Parameters

|Param|Description|
|---|---|
|`accountId`|account to find related contacts|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt; contacts to display in lookup component


**Method** relatedContacts

### `static searchContacts(String searchTerm, String accId)`

`AURAENABLED`

search contacts related to an account for a given string

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|term to search|
|`accId`|account to find related contacts|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt; contacts to display in lookup component


**Method** searchContacts

### `static getSelection(Id recordId, String objectName)`

`AURAENABLED`

returns lookupSearchResult for an Id and object name

#### Parameters

|Param|Description|
|---|---|
|`recordId`|Id of record to get lookupsearchresult to display in lookup component|
|`objectName`|api name of the object for matching correct lookupsearch class|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt; a single result in the list for populating lookup component


**Method** getSelection

---
