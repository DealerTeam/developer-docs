---
layout: default
---
# CacheUtility
## Fields

### `private orgPart` → `Cache`


### `private sessionPart` → `Cache`


---
## Methods
### `public static Object get(String key)`

retrieves stored value from platform cache partition

#### Parameters

|Param|Description|
|---|---|
|`key`|- name of the key to retrieve value from cache|

#### Returns

|Type|Description|
|---|---|
|`Object`|Object - value from cache returned as object type|

### `public static SObject getRecordFromCachedMap(String key, Id recordId)`

retrieves a single record from platform cache partition

#### Parameters

|Param|Description|
|---|---|
|`key`|- name of the key to retrieve value from cache - specifically a cached map collection|
|`Id`|- Id of the object to retrieve value from cache|

#### Returns

|Type|Description|
|---|---|
|`SObject`|Object - (cachedRecord) value from cache returned as object type, in case of miss record is queried|

### `public static Object get(System cacheBuilder, String soqlParam)`

retrieves stored value from a readthrough cache builder interface class

#### Parameters

|Param|Description|
|---|---|
|`cacheBuilder`|- name of the cacheBuilder class to use|
|`soqlParam`|- name of the parameter to filter soql search|

#### Returns

|Type|Description|
|---|---|
|`Object`|Object - value from cache returned as object type|

### `public static void put(String key, Object value)`

puts the key value pair in the managed platform cache org storage for faster access anywhere static data needs repeatedly retrieved

#### Parameters

|Param|Description|
|---|---|
|`key`|- name of the key to associate the value with in the cache|
|`value`|- value to be stored under the referenced key|


**TimeToLive** default time to live of 24 hours

### `public static void put(String key, Object value, Integer ttl)`
#### Parameters

|Param|Description|
|---|---|
|`key`|- name of the key to associate the value with in the cache|
|`value`|- value to be stored under the referenced key|
|`ttl`|- the time in seconds before the key/value pair will be evicted from the cache|

### `public static Object sessionGet(String key)`

retrieves stored value from the platform cache session storage, which is tied to the running user

#### Parameters

|Param|Description|
|---|---|
|`key`|- name of the key to retrieve value from cache|

#### Returns

|Type|Description|
|---|---|
|`Object`|Object - value from cache returned as object type|

### `public static void sessionPut(String key, Object value)`

stores the key value pair in the platform cache session storage, which is tied to the running user

#### Parameters

|Param|Description|
|---|---|
|`key`|- name of the key to associate the value with in the cache|
|`value`|- value to be stored under the referenced key|

### `public static void clearOrgCache()`

retrieve all keys in the org cache and remove the value. This method is used until a proper salesforce api method is provided

---
