---
layout: default
---
# DealerMetadata class

@description

---
## Properties

### `configMap` → `DMSConfig__mdt>`

---
## Methods
### `getAllFieldSchema(String objectApiName)` → `fieldResult>`
### `getAllRequiredFields(Schema.DescribeSObjectResult obj, String layoutName)` → `>`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | j |
|`` | e |

### `getAssignedPageLayoutAPIName(String objectName)` → `String`
### `getConfigValue(String configName)` → `String`

Checks values of a given config and return subscriber entered value if one exists otherwise returns package default. Will throw error if no config is found.

#### Parameters
|Param|Description|
|-----|-----------|
|`configName` |  DeveloperName of the config to get a value for. |

### `getFieldLabels(String objectName)` → `>`
### `getFieldSchema(String objectApiName, List<String> fieldApiNames)` → `fieldResult>`
### `getHttpResponseBody(String query)` → `String`
### `getLayoutRequiredFields(String layoutName)` → `>`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |

### `getObjectRequiredFields(Schema.DescribeSObjectResult obj)` → `>`

 getObjectRequiredFields

#### Parameters
|Param|Description|
|-----|-----------|
|`` | j |

### `getObjectTabUrl(String objectName)` → `String`
### `getRecord(String objectApiName, List<String> fields, String recordId)` → `List<SObject>`
### `getRecordTypes(String sObjectName)` → `recordTypeWrapper`
### `getSobjectPicklistValues(String sObecjtName, String fieldName)` → `List<String>`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | e |
|`` | e |

### `objectId(String objectName)` → `String`
---
## Inner Classes

### DealerMetadata.DMSConfigValue class
---
#### Constructors
##### `DMSConfigValue(String configName)`
---
#### Properties

##### `enabled` → `boolean`

##### `value` → `String`

---
### DealerMetadata.DealerMetadataException class
---
### DealerMetadata.MyCallback class
---
#### Methods
##### `handleResult(Metadata.DeployResult result,Metadata.DeployCallbackContext context)` → `void`
---
### DealerMetadata.fieldResult class
---
#### Constructors
##### `fieldResult()`
---
#### Properties

##### `accessible` → `Boolean`

##### `fieldApiName` → `String`

##### `isCheckbox` → `Boolean`

##### `isCurrency` → `Boolean`

##### `isDate` → `Boolean`

##### `isDateTime` → `Boolean`

##### `isDouble` → `Boolean`

##### `isPicklist` → `Boolean`

##### `isRelated` → `Boolean`

##### `isText` → `Boolean`

##### `label` → `String`

##### `objectApiName` → `String`

##### `relatedTo` → `String`

##### `required` → `Boolean`

##### `type` → `String`

##### `useCustomInput` → `Boolean`

---
### DealerMetadata.recordTypeWrapper class
---
#### Constructors
##### `recordTypeWrapper(RecordType defaultType, List<RecordType> types)`
---
#### Properties

##### `defaultType` → `RecordType`

##### `types` → `List<RecordType>`

---
