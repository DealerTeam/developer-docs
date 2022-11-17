# DesiredVehicleController

`APIVERSION: 46`

`STATUS: ACTIVE`



**Group** Sales

## Methods
### `static getDesiredVehicles(Id supId)`

`AURAENABLED`
### `static getVehicles(Id supId)`

`AURAENABLED`
### `static getPrimaryVehicle(Id supId)`

`AURAENABLED`
### `static getVehicleInventoryRecord(Id vehicleId)`

`AURAENABLED`
### `static getVehicleMasterRecord(Id vehicleMasterId)`

`AURAENABLED`

method for getting vehicle Master record(vehicleModel__c)

#### Parameters

|Param|Description|
|---|---|
|`vehicleMasterId`|Id of selected vehicle master|

#### Return

**Type**

SObject

**Description**

returns selected vehicle master

### `static setPrimary(Id dvId, Id supId)`

`AURAENABLED`
### `static removePrimaryVehicle(Id dvId, Id supId)`

`AURAENABLED`
### `static getSalesUp(Id recordId)`

`AURAENABLED`
### `static getObjectName(String objId)`

`AURAENABLED`

Calls utility class to return the object type for a given record id

#### Parameters

|Param|Description|
|---|---|
|`objId`|objId record id to retrieve the object type|

#### Return

**Type**

string

**Description**

return String the object api name of the provided id


**Method** getObjectName

---
## Classes
### desiredVehicleWrapper
#### Constructors
##### `desiredVehicleWrapper(List&lt;Desired_Vehicle__c&gt; vehicles, List&lt;Desired_Vehicle__c&gt; primaryVehicle)`
---
#### Fields

##### `primaryVehicle` → `List&lt;Desired_Vehicle__c&gt;`

`AURAENABLED` 

##### `vehicles` → `List&lt;Desired_Vehicle__c&gt;`

`AURAENABLED` 

---

---
