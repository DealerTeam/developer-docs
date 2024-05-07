---
layout: default
---
# DMSConfigController



**Class** DMSConfigController

## Methods
### `public static List<DMSWrapper> getDMSApplications()`

`AURAENABLED`
#### Returns

|Type|Description|
|---|---|
|`List<DMSWrapper>`|List<DMSWrapper>|


**Method** getDMSApplications

### `public static dealer__DMSFeature__mdt getDMSFeature(Id featureId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`featureId`||

#### Returns

|Type|Description|
|---|---|
|`dealer__DMSFeature__mdt`|dealer__DMSFeature__mdt|


**Method** getDMSFeature

### `public static List<dealer__DMSConfig__mdt> getDMSSettings(Id featureId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`featureId`||

#### Returns

|Type|Description|
|---|---|
|`List<dealer__DMSConfig__mdt>`|List<dealer__DMSConfig__mdt>|


**Method** getDMSSettings

### `public static String updateSettings(DMSConfig__mdt setting)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`setting`||

#### Returns

|Type|Description|
|---|---|
|`String`|void|


**Method** updateSettings

---
## Classes
### DMSWrapper


#### Constructors
##### `public DMSWrapper()`
---
#### Properties

##### `public dmsApp` → `dealer__DMSApplication__mdt`

`AURAENABLED` 

##### `public dmsFeature` → `List&lt;dealer__DMSFeature__mdt&gt;`

`AURAENABLED` 

---

---
