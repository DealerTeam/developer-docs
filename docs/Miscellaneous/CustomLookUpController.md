# CustomLookUpController

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** CustomLookUpController

## Methods
### `static getResults(String ObjectName, String value)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`ObjectName`||
|`value`||

#### Return

**Type**

List&lt;Result&gt;

**Description**

List&lt;Result&gt;


**Method** getResults

### `static getPreLoadedRecord(String ObjectName, String recordId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`ObjectName`||
|`recordId`||

#### Return

**Type**

List&lt;Result&gt;

**Description**

List&lt;Result&gt;


**Method** getPreLoadedRecord

### `static getIconUrl(String objectName)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`objectName`||

#### Return

**Type**

String

**Description**

String


**Method** getIconUrl

### `static Name(sObject obj, String ObjectName)`
#### Parameters

|Param|Description|
|---|---|
|`obj`||
|`ObjectName`||

#### Return

**Type**

String

**Description**

String


**Method** Name

### `static Description(sObject obj, String ObjectName)`
#### Parameters

|Param|Description|
|---|---|
|`obj`||
|`ObjectName`||

#### Return

**Type**

String

**Description**

String


**Method** Description

---
## Classes
### Result

Wrapper class to allow custom descriptions

#### Constructors
##### `Result(String nameT, String descriptionT, sObject recordT)`
---
#### Properties

##### `description` → `String`

`AURAENABLED` 

##### `name` → `String`

`AURAENABLED` 

##### `record` → `sObject`

`AURAENABLED` 

---

---
