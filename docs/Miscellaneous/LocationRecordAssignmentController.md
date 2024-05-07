---
layout: default
---
# LocationRecordAssignmentController
## Methods
### `public static MasterData getMasterData(Id locationId, String sObjectName)`

`AURAENABLED`

Get masters and their children assigned to the location

#### Parameters

|Param|Description|
|---|---|
|`locationId`|Location used to query records|
|`sObjectName`|Name of the child object, used to determine which set of records to return|

#### Returns

|Type|Description|
|---|---|
|`MasterData`|return description|

---
## Classes
### MasterData

Nested wrapper class

#### Constructors
##### `public MasterData(String locId, String sObjectName)`
---
#### Properties

##### `public availableRecords` → `List&lt;Object&gt;`

`AURAENABLED` 

List of form sobjects available for printing

##### `public selectedRecords` → `List&lt;Object&gt;`

`AURAENABLED` 

List of records assigned from masters on the location

---
#### Methods
##### `public void getFees(String locId)`

Query the Location Fees as selected and Fee Masters with no related Location Fee as available

###### Parameters

|Param|Description|
|---|---|
|`locId`|Location the fees are related to|

##### `public void getCodes(String locId)`

Query the Misc Charge Codes as selected and Misc Charge Masters with no related Misc Charge Code as available

###### Parameters

|Param|Description|
|---|---|
|`locId`|Location the charges are related to|

---

---
