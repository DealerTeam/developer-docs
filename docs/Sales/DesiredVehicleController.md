---
layout: default
---
# DesiredVehicleController



**Group** Sales

## Methods
### `public static desiredVehicleWrapper getDesiredVehicles(Id supId)`

`AURAENABLED`
### `public static List<dealer__Desired_Vehicle__c> getVehicles(Id supId)`

`AURAENABLED`
### `public static List<dealer__Desired_Vehicle__c> getPrimaryVehicle(Id supId)`

`AURAENABLED`
### `public static dealer__Vehicle_Inventory__c getVehicleInventoryRecord(Id vehicleId)`

`AURAENABLED`
### `public static SObject getVehicleMasterRecord(Id vehicleMasterId)`

`AURAENABLED`

method for getting vehicle Master record(vehicleModel__c)

#### Parameters

|Param|Description|
|---|---|
|`vehicleMasterId`|Id of selected vehicle master|

#### Returns

|Type|Description|
|---|---|
|`SObject`|returns selected vehicle master|

### `public static string setPrimary(Id dvId, Id supId)`

`AURAENABLED`
### `public static string removePrimaryVehicle(Id dvId, Id supId)`

`AURAENABLED`
### `public static Sales_Up__c getSalesUp(Id recordId)`

`AURAENABLED`
### `public static void deleteDesiredVehicle(Id desiredVehicleId, Id supId)`

`AURAENABLED`

deleteDesiredVehicle - handles deleting a desired vehicle and clearing sup fields if no more DVs exist

#### Parameters

|Param|Description|
|---|---|
|`desiredVehicleId`|- desired vehicle to delete|
|`supId`|- parent sup record|

### `public static string getObjectName(String objId)`

`AURAENABLED`

Calls utility class to return the object type for a given record id

#### Parameters

|Param|Description|
|---|---|
|`objId`|objId record id to retrieve the object type|

#### Returns

|Type|Description|
|---|---|
|`string`|return String the object api name of the provided id|


**Method** getObjectName

---
## Classes
### desiredVehicleWrapper
#### Constructors
##### `public desiredVehicleWrapper(List&lt;Desired_Vehicle__c&gt; vehicles, List&lt;Desired_Vehicle__c&gt; primaryVehicle)`
---
#### Fields

##### `public vehicles` → `List&lt;Desired_Vehicle__c&gt;`

`AURAENABLED` 

##### `public primaryVehicle` → `List&lt;Desired_Vehicle__c&gt;`

`AURAENABLED` 

---

---
