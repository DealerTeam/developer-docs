# DynamicRecordController

`APIVERSION: 48`

`STATUS: ACTIVE`
## Methods
### `static getFieldSet(Id recordId, String fieldName, String fieldSetName)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`:`|recordId - Id of the record referencing the related record|
|`:`|fieldName - API name of the target field to display related data|
|`:`|fieldSetName - API name of a field set on target object that controls which fields are displayed|

#### Return

**Type**

dynamicWrapper

**Description**

: dynamicWrapper holding data in the dynamicWrapper inner class


**Method** : getFieldSet


**Description** : Processes inputs to return information about a related record.

### `static getFieldSetMembers(String objRef, String setName)`

: Gets fields from a provided field set and returns as a wrapper with the api name and required status from field set

#### Parameters

|Param|Description|
|---|---|
|`:`|objRef object API name that contains the field set|
|`:`|setName - API name of the field set to retrieve values|

#### Return

**Type**

List&lt;SalesUpController.fieldSetWrapper&gt;

**Description**

: List&lt;SalesUpController.fieldSetWrapper&gt; Field names and required status from the field set


**Method** : getFieldSetMembers

---
## Classes
### dynamicWrapper

Wrapper class that holds information needed to display fields on LWC

#### Fields

##### `fields` → `List&lt;SalesUpController.fieldSetWrapper&gt;`

`AURAENABLED` 

##### `objType` → `String`

`AURAENABLED` 

##### `recordData` → `sObject`

`AURAENABLED` 

##### `recordId` → `String`

`AURAENABLED` 

---

---
