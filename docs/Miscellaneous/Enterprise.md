---
layout: default
---
# Enterprise

The enterprise class extends the native force.com dms to other Salesforce Platform services.


**Notes** This class was created prior to the DMSSync classes.  It is global however is scheduled for deprecation. //TODO determine if this class is able to be deprecated.  Move test coverage if keeping.

## Methods
### `global static String call(EnterpriseRequest requestCall)`

call Performs an HTTP Event Call with the external stack

#### Parameters

|Param|Description|
|---|---|
|`requestedCall`|Object defining the call details|

#### Returns

|Type|Description|
|---|---|
|`String`|String        JSON encapsulated return of the request|

---
## Classes
### EnterpriseRequest
#### Properties

##### `global resource` → `String`


##### `global jsonObject` → `String`


##### `global method` → `String`


---

---
