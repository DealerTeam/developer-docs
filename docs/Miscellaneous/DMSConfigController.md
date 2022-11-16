# DMSConfigController

`APIVERSION: 46`

`STATUS: ACTIVE`



**Class** DMSConfigController

## Methods
### `static getDMSApplications()`

`AURAENABLED`
#### Return

**Type**

List&lt;DMSWrapper&gt;

**Description**

List&lt;DMSWrapper&gt;


**Method** getDMSApplications

### `static getDMSFeature(Id featureId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`featureId`||

#### Return

**Type**

dealer__DMSFeature__mdt

**Description**

dealer__DMSFeature__mdt


**Method** getDMSFeature

### `static getDMSSettings(Id featureId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`featureId`||

#### Return

**Type**

List&lt;dealer__DMSConfig__mdt&gt;

**Description**

List&lt;dealer__DMSConfig__mdt&gt;


**Method** getDMSSettings

### `static updateSettings(dealer__DMSConfig__mdt setting)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`setting`||

#### Return

**Type**

void

**Description**

void


**Method** updateSettings

---
## Classes
### DMSWrapper


#### Constructors
##### `DMSWrapper()`
---
#### Properties

##### `dmsApp` → `dealer__DMSApplication__mdt`

`AURAENABLED` 

##### `dmsFeature` → `List&lt;dealer__DMSFeature__mdt&gt;`

`AURAENABLED` 

---

---
