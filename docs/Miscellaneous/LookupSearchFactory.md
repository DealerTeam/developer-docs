---
layout: default
---
# LookupSearchFactory
## Fields

### `private instance` → `LookupSearchFactory`

`TESTVISIBLE` 

---
## Methods
### `public static LookupSearchFactory getInstance()`

getInstance Singleton patter application for repeated calls within the stack

#### Returns

|Type|Description|
|---|---|
|`LookupSearchFactory`|LookupSearchFactory|


**Notes** Static instance of class Lazy Loaded

### `public LookupSearch getLookupSearch(String sObjectName)`

getLookupSearch decides what implements class to use based on sobjectname

#### Parameters

|Param|Description|
|---|---|
|`sObjectName`|String|

#### Returns

|Type|Description|
|---|---|
|`LookupSearch`|LookupSearch returns an inteface instance based on object name|

---
## Classes
### LookupSearchFactoryException

**Inheritance**

LookupSearchFactoryException


---
