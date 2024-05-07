---
layout: default
---
# DynamicRecordController
## Methods
### `public static dynamicWrapper getFieldSet(Id recordId, String fieldName, String fieldSetName)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`:`|recordId - Id of the record referencing the related record|
|`:`|fieldName - API name of the target field to display related data|
|`:`|fieldSetName - API name of a field set on target object that controls which fields are displayed|

#### Returns

|Type|Description|
|---|---|
|`dynamicWrapper`|: dynamicWrapper holding data in the dynamicWrapper inner class|


**Method** : getFieldSet


**Description** : Processes inputs to return information about a related record.

### `private static dynamicWrapper getObjectRef(Id recordId, String fieldName)`

: Gets target object type and record Id of the provided lookup field on record

#### Parameters

|Param|Description|
|---|---|
|`:`|recordId Id of record referencing the related record|
|`:`|fieldName - API name of the target field to display related data|

#### Returns

|Type|Description|
|---|---|
|`dynamicWrapper`|: dynamicWrapper with recordId and objType|


**Method** : getObjectRef

### `public static List<FieldSetWrapper> getFieldSetMembers(String objRef, String setName)`

: Gets fields from a provided field set and returns as a wrapper with the api name and required status from field set

#### Parameters

|Param|Description|
|---|---|
|`:`|objRef object API name that contains the field set|
|`:`|setName - API name of the field set to retrieve values|

#### Returns

|Type|Description|
|---|---|
|`List<FieldSetWrapper>`|: List<FieldSetWrapper> Field names and required status from the field set|


**Method** : getFieldSetMembers

---
## Classes
### dynamicWrapper

Wrapper class that holds information needed to display fields on LWC

#### Fields

##### `public recordId` → `String`

`AURAENABLED` 

##### `public objType` → `String`

`AURAENABLED` 

##### `public fields` → `List&lt;FieldSetWrapper&gt;`

`AURAENABLED` 

##### `public recordData` → `sObject`

`AURAENABLED` 

---

---
