---
layout: default
---
# InvocableRecordUpdate
## Methods
### `global static List<myResponse> updateRecords(List<myRequest> request)`

`INVOCABLEMETHOD`

Invocable method to call for record updates using managed logic

#### Parameters

|Param|Description|
|---|---|
|`request`|List<myRequest> data needed for the update transaction|

#### Returns

|Type|Description|
|---|---|
|`List<myResponse>`|records saved|


**Method** updateRecords

### `private static List<myResponse> handleDealSave(List<SObject> records)`

validates data and calls the DealAPI.saveDeal method

#### Parameters

|Param|Description|
|---|---|
|`records`|List<SObject> containing a single deal to save|

#### Returns

|Type|Description|
|---|---|
|`List<myResponse>`|saved deal|


**Method** handleDealSave

---
## Classes
### myRequest

Global class used to hold invocable variables used throughout the class to process the update

#### Fields

##### `global records` → `List&lt;SObject&gt;`

`INVOCABLEVARIABLE` 

---

### myResponse

Global class used to hold invocable variables used to return information to the declarative tool invoking the method

#### Fields

##### `global records` → `List&lt;SObject&gt;`

`INVOCABLEVARIABLE` 

---

### InvocableException

**Inheritance**

InvocableException


---
