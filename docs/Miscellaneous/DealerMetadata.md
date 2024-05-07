---
layout: default
---
# DealerMetadata



**Class** DealerMetadata

## Properties

### `public configMap` → `Map<String,DMSConfig__mdt>`


---
## Methods
### `public static Map<String,fieldResult> getAllFieldSchema(String objectApiName)`

`AURAENABLED`
### `public static Map<String,fieldResult> getFieldSchema(String objectApiName, List<String> fieldApiNames)`

`AURAENABLED`

getFieldSchema obtains the schema data for a field referenced in an LWC

#### Parameters

|Param|Description|
|---|---|
|`objectApiName`|objectApiName description|
|`fieldApiNames`|fieldApiNames description|

#### Returns

|Type|Description|
|---|---|
|`Map<String,fieldResult>`|return description|

### `public static List<SObject> getRecord(String objectApiName, List<String> fields, String recordId)`

`AURAENABLED`
### `public static recordTypeWrapper getRecordTypes(String sObjectName)`

`AURAENABLED`
### `public static Map<String,Boolean> getAllRequiredFields(Schema obj, String layoutName)`
#### Parameters

|Param|Description|
|---|---|
|`obj`||
|`layoutName`||

#### Returns

|Type|Description|
|---|---|
|`Map<String,Boolean>`|Map < String, Boolean >|


**Method** getAllRequiredFields

### `public static Map<String,Boolean> getLayoutRequiredFields(String layoutName)`
#### Parameters

|Param|Description|
|---|---|
|`layoutName`||

#### Returns

|Type|Description|
|---|---|
|`Map<String,Boolean>`|Map < String, Boolean >|


**Method** getLayoutRequiredFields

### `public static Map<String,Boolean> getObjectRequiredFields(Schema obj)`
#### Parameters

|Param|Description|
|---|---|
|`obj`||

#### Returns

|Type|Description|
|---|---|
|`Map<String,Boolean>`|Map < String, Boolean >|


**Method** getObjectRequiredFields

### `public static Map<String,String> getFieldLabels(String objectName)`

`AURAENABLED`
### `public static String getAssignedPageLayoutAPIName(String objectName)`
### `public static String objectId(String objectName)`
### `public static String getObjectTabUrl(String objectName)`
### `public static String getHttpResponseBody(String query)`
### `public static String getConfigValue(String configName)`

Checks values of a given config and return subscriber entered value if one exists otherwise returns package default. Will throw error if no config is found.

#### Parameters

|Param|Description|
|---|---|
|`configName`|DeveloperName of the config to get a value for.|

#### Returns

|Type|Description|
|---|---|
|`String`|String - Config value for the given config, null if it is not enabled.|


**Method** getConfigValue

### `private static Map<String,DMSConfig__mdt> dmsConfiguration()`
### `public static Map<String,Schema.PicklistEntry> getPicklistValues(Schema field)`

getPicklistValues - returns the active picklist entries for a given sobject field

#### Parameters

|Param|Description|
|---|---|
|`field`|- example getPicklistValues(Discount_Rebate__c.Type__c)|

#### Returns

|Type|Description|
|---|---|
|`Map<String,Schema.PicklistEntry>`|return - Map of type <String,Schema.PicklistEntry>, keyed by the picklist entries apiname/value|

---
## Classes
### fieldResult
#### Constructors
##### `public fieldResult()`
---
#### Fields

##### `public objectApiName` → `String`

`AURAENABLED` 

##### `public fieldApiName` → `String`

`AURAENABLED` 

##### `public label` → `String`

`AURAENABLED` 

##### `public required` → `Boolean`

`AURAENABLED` 

##### `public accessible` → `Boolean`

`AURAENABLED` 

##### `public type` → `String`

`AURAENABLED` 

##### `public useCustomInput` → `Boolean`

`AURAENABLED` 

##### `public relatedTo` → `String`

`AURAENABLED` 

##### `public isCheckbox` → `Boolean`

`AURAENABLED` 

##### `public isCurrency` → `Boolean`

`AURAENABLED` 

##### `public isDouble` → `Boolean`

`AURAENABLED` 

##### `public isRelated` → `Boolean`

`AURAENABLED` 

##### `public isPicklist` → `Boolean`

`AURAENABLED` 

##### `public isText` → `Boolean`

`AURAENABLED` 

##### `public isDate` → `Boolean`

`AURAENABLED` 

##### `public isDateTime` → `Boolean`

`AURAENABLED` 

---

### recordTypeWrapper
#### Constructors
##### `public recordTypeWrapper(RecordType defaultType, List&lt;RecordType&gt; types)`
---
#### Properties

##### `public defaultType` → `RecordType`

`AURAENABLED` 

##### `public types` → `List&lt;RecordType&gt;`

`AURAENABLED` 

---

### MyCallback

**Implemented types**

[Metadata.DeployCallback](Metadata.DeployCallback)

#### Methods
##### `public void handleResult(Metadata result, Metadata context)`
---

### DMSConfigValue
#### Constructors
##### `public DMSConfigValue(String configName)`
---
#### Fields

##### `public enabled` → `boolean`

`AURAENABLED` 

##### `public value` → `String`

`AURAENABLED` 

---

### DealerMetadataException

**Inheritance**

DealerMetadataException


---
