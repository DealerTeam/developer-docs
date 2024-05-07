---
layout: default
---
# CustomLookUpController



**Class** CustomLookUpController

## Methods
### `public static List<Result> getResults(String ObjectName, String value)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`ObjectName`||
|`value`||

#### Returns

|Type|Description|
|---|---|
|`List<Result>`|List<Result>|


**Method** getResults

### `public static List<Result> getPreLoadedRecord(String ObjectName, String recordId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`ObjectName`||
|`recordId`||

#### Returns

|Type|Description|
|---|---|
|`List<Result>`|List<Result>|


**Method** getPreLoadedRecord

### `public static String getIconUrl(String objectName)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`objectName`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getIconUrl

### `public static String Name(sObject obj, String ObjectName)`
#### Parameters

|Param|Description|
|---|---|
|`obj`||
|`ObjectName`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** Name

### `public static String Description(sObject obj, String ObjectName)`
#### Parameters

|Param|Description|
|---|---|
|`obj`||
|`ObjectName`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** Description

---
## Classes
### Result

Wrapper class to allow custom descriptions

#### Constructors
##### `public Result(String nameT, String descriptionT, sObject recordT)`
---
#### Properties

##### `public name` → `String`

`AURAENABLED` 

##### `public description` → `String`

`AURAENABLED` 

##### `public record` → `sObject`

`AURAENABLED` 

---

---
