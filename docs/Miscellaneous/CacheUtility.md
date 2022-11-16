# CacheUtility

`APIVERSION: 55`

`STATUS: ACTIVE`
## Fields

### `orgPart` → `Cache.OrgPartition`


### `sessionPart` → `Cache.SessionPartition`


---
## Methods
### `static get(String key)`

retrieves stored value from platform cache partition

#### Parameters

|Param|Description|
|---|---|
|`key`|- name of the key to retrieve value from cache|

#### Return

**Type**

Object

**Description**

Object - value from cache returned as object type

### `static get(System.Type cacheBuilder, String soqlParam)`

retrieves stored value from a readthrough cache builder interface class

#### Parameters

|Param|Description|
|---|---|
|`cacheBuilder`|- name of the cacheBuilder class to use|
|`soqlParam`|- name of the parameter to filter soql search|

#### Return

**Type**

Object

**Description**

Object - value from cache returned as object type

### `static put(String key, Object value)`

puts the key value pair in the managed platform cache org storage for faster access anywhere static data needs repeatedly retrieved

#### Parameters

|Param|Description|
|---|---|
|`key`|- name of the key to associate the value with in the cache|
|`value`|- value to be stored under the referenced key|


**TimeToLive** default time to live of 24 hours

### `static sessionGet(String key)`

retrieves stored value from the platform cache session storage, which is tied to the running user

#### Parameters

|Param|Description|
|---|---|
|`key`|- name of the key to retrieve value from cache|

#### Return

**Type**

Object

**Description**

Object - value from cache returned as object type

### `static sessionPut(String key, Object value)`

stores the key value pair in the platform cache session storage, which is tied to the running user

#### Parameters

|Param|Description|
|---|---|
|`key`|- name of the key to associate the value with in the cache|
|`value`|- value to be stored under the referenced key|

### `static put(String key, Object value, Integer ttl)`
#### Parameters

|Param|Description|
|---|---|
|`key`|- name of the key to associate the value with in the cache|
|`value`|- value to be stored under the referenced key|
|`ttl`|- the time in seconds before the key/value pair will be evicted from the cache|

### `static buildFinCompCache()`

stores finance company records in managed platform cache partition for faster access


**Method** buildFinCompCache

### `static buildVehicleCache()`

stores most recently updated vehicle inventory records in managed platform cache partition for faster access


**Method** buildVehicleCache

---
