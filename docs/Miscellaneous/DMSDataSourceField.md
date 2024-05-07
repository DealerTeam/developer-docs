---
layout: default
---
# DMSDataSourceField

Wrapper  class for the DMS Data source Objects.

## Constructors
### `public DMSDataSourceField(String fieldName, string type)`

Constructor with Fieldname / Type

#### Parameters

|Param|Description|
|---|---|
|`fieldName`||
|`type`||

### `public DMSDataSourceField(String fieldName, string type, Integer length)`

Constructor with Fieldname,Type, Length

#### Parameters

|Param|Description|
|---|---|
|`fieldName`||
|`type`||

### `public DMSDataSourceField(String fieldName, string type, String domain, String referenceTargetField)`

Constructor with all data types

#### Parameters

|Param|Description|
|---|---|
|`fieldName`||
|`type`||
|`domain`||
|`referenceTargetField`||

---
## Fields

### `public fieldName` → `string`


### `public type` → `string`


### `public length` → `Integer`


### `public domain` → `String`


### `public referenceTargetField` → `String`


---
## Methods
### `private void setDefaultLength(String type)`

Sets default length on a field based on field type

#### Parameters

|Param|Description|
|---|---|
|`fieldName`||
|`type`||

#### Returns

|Type|Description|
|---|---|
|`void`||

---
