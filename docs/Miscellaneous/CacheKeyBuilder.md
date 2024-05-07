---
layout: default
---
# CacheKeyBuilder

CacheKeyBuilder holds the logic and object structure for record collections stored in the platform cache

## Fields

### `public finCompCacheMapFields` → `List<String>`


### `public viCacheMapFields` → `List<String>`


### `public locCacheMapFields` → `List<String>`


---
## Methods
### `public static void buildFinCompCache()`

stores finance company records in managed platform cache partition for faster access


**Method** buildFinCompCache

### `public static void buildVehicleCache()`

stores most recently updated vehicle inventory records in managed platform cache partition for faster access


**Method** buildVehicleCache

### `public static void buildLocationCache()`

stores most recently updated location records in managed platform cache partition for faster access


**Method** buildLocationCache

### `private static String buildQuery(List<String> fieldsToRetrieve, String fromString)`

buildQuery       - reference a set of strings to construct a database query

#### Parameters

|Param|Description|
|---|---|
|`fieldsToRetrieve`|- fields to construct into a query string for a given object|
|`fromString`|- object to pull from as well as additional modifiers|

#### Returns

|Type|Description|
|---|---|
|`String`|return           - dynamic soql string|

### `private static void putMapInCache(String cacheKey, Map<Id,Object> cacheValue)`

putMapInCache - attempts to put a collection in the cache and will iterate the reducesize method if a item exceeds 100kb until it succeeds

#### Parameters

|Param|Description|
|---|---|
|`cacheKey`|- key to store|
|`cacheValue`|- value to store|

### `private static Map<Id,Object> reduceSize(Map<Id,Object> mapToReduce)`

reduceSize - if a map collection fails to put in the cache the method will reduce the list size by 5% in order to retry storing the value

#### Parameters

|Param|Description|
|---|---|
|`mapToReduce`|- collection for caching greater than 100kb serialized|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,Object>`|return - returns the original map with 5% of its key value pairs removed|

---
## Classes
### CachedFinanceCompany
#### Constructors
##### `public CachedFinanceCompany(Finance_Company__c finComp)`

CachedFinanceCompany - Constructor method for creating a finance company class object

###### Parameters

|Param|Description|
|---|---|
|`finComp`|- sObject to initialize class from|

---
#### Fields

##### `public Id` → `String`


##### `public ExternalId` → `String`


##### `public Name` → `String`


##### `public Bank_Address` → `String`


##### `public Reserve_Percentage` → `Decimal`


##### `public New_Vehicle_Rate` → `Decimal`


##### `public Used_Vehicle_Rate` → `Decimal`


##### `public NewVehicleBuyRate` → `Decimal`


##### `public UsedVehicleBuyRate` → `Decimal`


---
#### Methods
##### `public Finance_Company__c ToSobject()`

ToSobject - call to return a finance_company__c object from a CachedFinanceCompany class

###### Returns

|Type|Description|
|---|---|
|`Finance_Company__c`|cached finance_company__c record|

---

### CachedVehicleInventory
#### Constructors
##### `public CachedVehicleInventory(Vehicle_Inventory__c vi)`

CachedVehicleInventory - Constructor method for creating a vehicle inventory class object

###### Parameters

|Param|Description|
|---|---|
|`vi`|- sObject to initialize class from|

---
#### Fields

##### `public Id` → `String`


##### `public VIN` → `String`


##### `public Stock_Number` → `String`


##### `public Conversion_Description` → `String`


---
#### Methods
##### `public Vehicle_Inventory__c ToSobject()`

ToSobject - call to return a Vehicle_Inventory__c object from a CachedFinanceCompany class

###### Returns

|Type|Description|
|---|---|
|`Vehicle_Inventory__c`|cached Vehicle_Inventory__c record|

---

### CachedDealerLocation
#### Constructors
##### `public CachedDealerLocation(Dealer_Location__c loc)`

CachedDealerLocation - Constructor method for creating a dealer location class object

###### Parameters

|Param|Description|
|---|---|
|`loc`|- sObject to initialize class from|

---
#### Fields

##### `public Id` → `String`


##### `public Name` → `String`


##### `public Company_Number` → `String`


---
#### Methods
##### `public Dealer_Location__c ToSobject()`

ToSobject - call to return a Dealer_Location__c object from a CachedFinanceCompany class

###### Returns

|Type|Description|
|---|---|
|`Dealer_Location__c`|cached Dealer_Location__c record|

---

---
