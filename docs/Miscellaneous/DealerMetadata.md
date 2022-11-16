# DealerMetadata

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** DealerMetadata

## Properties

### `configMap` → `Map<String,DMSConfig__mdt>`


---
## Methods
### `static getAllFieldSchema(String objectApiName)`

`AURAENABLED`
### `static getFieldSchema(String objectApiName, List<String> fieldApiNames)`

`AURAENABLED`
### `static getRecord(String objectApiName, List<String> fields, String recordId)`

`AURAENABLED`
### `static getRecordTypes(String sObjectName)`

`AURAENABLED`
### `static getAllRequiredFields(Schema.DescribeSObjectResult obj, String layoutName)`
#### Parameters

|Param|Description|
|---|---|
|`obj`||
|`layoutName`||

#### Return

**Type**

Map&lt;String,Boolean&gt;

**Description**

Map &lt; String, Boolean &gt;


**Method** getAllRequiredFields

### `static getLayoutRequiredFields(String layoutName)`
#### Parameters

|Param|Description|
|---|---|
|`layoutName`||

#### Return

**Type**

Map&lt;String,Boolean&gt;

**Description**

Map &lt; String, Boolean &gt;


**Method** getLayoutRequiredFields

### `static getObjectRequiredFields(Schema.DescribeSObjectResult obj)`
#### Parameters

|Param|Description|
|---|---|
|`obj`||

#### Return

**Type**

Map&lt;String,Boolean&gt;

**Description**

Map &lt; String, Boolean &gt;


**Method** getObjectRequiredFields

### `static getSobjectPicklistValues(String sObecjtName, String fieldName)`
#### Parameters

|Param|Description|
|---|---|
|`sObecjtName`||
|`fieldName`||

#### Return

**Type**

List&lt;String&gt;

**Description**

List&lt;String&gt;


**Method** getSobjectPicklistValues

### `static getFieldLabels(String objectName)`

`AURAENABLED`
### `static getAssignedPageLayoutAPIName(String objectName)`
### `static objectId(String objectName)`
### `static getObjectTabUrl(String objectName)`
### `static getHttpResponseBody(String query)`
### `static getConfigValue(String configName)`

Checks values of a given config and return subscriber entered value if one exists otherwise returns package default. Will throw error if no config is found.

#### Parameters

|Param|Description|
|---|---|
|`configName`|DeveloperName of the config to get a value for.|

#### Return

**Type**

String

**Description**

String - Config value for the given config, null if it is not enabled.


**Method** getConfigValue

---
## Classes
### DMSConfigValue
#### Constructors
##### `DMSConfigValue(String configName)`
---
#### Fields

##### `enabled` → `boolean`

`AURAENABLED` 

##### `value` → `String`

`AURAENABLED` 

---

### DealerMetadataException

**Inheritance**

DealerMetadataException


### MyCallback

**Implemented types**

[Metadata.DeployCallback](Metadata.DeployCallback)

#### Methods
##### `handleResult(Metadata.DeployResult result, Metadata.DeployCallbackContext context)`
---

### fieldResult
#### Constructors
##### `fieldResult()`
---
#### Fields

##### `accessible` → `Boolean`

`AURAENABLED` 

##### `fieldApiName` → `String`

`AURAENABLED` 

##### `isCheckbox` → `Boolean`

`AURAENABLED` 

##### `isCurrency` → `Boolean`

`AURAENABLED` 

##### `isDate` → `Boolean`

`AURAENABLED` 

##### `isDateTime` → `Boolean`

`AURAENABLED` 

##### `isDouble` → `Boolean`

`AURAENABLED` 

##### `isPicklist` → `Boolean`

`AURAENABLED` 

##### `isRelated` → `Boolean`

`AURAENABLED` 

##### `isText` → `Boolean`

`AURAENABLED` 

##### `label` → `String`

`AURAENABLED` 

##### `objectApiName` → `String`

`AURAENABLED` 

##### `relatedTo` → `String`

`AURAENABLED` 

##### `required` → `Boolean`

`AURAENABLED` 

##### `type` → `String`

`AURAENABLED` 

##### `useCustomInput` → `Boolean`

`AURAENABLED` 

---

### recordTypeWrapper
#### Constructors
##### `recordTypeWrapper(RecordType defaultType, List&lt;RecordType&gt; types)`
---
#### Properties

##### `defaultType` → `RecordType`

`AURAENABLED` 

##### `types` → `List&lt;RecordType&gt;`

`AURAENABLED` 

---

---
