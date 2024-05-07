---
layout: default
---
# ServiceVehicleHistoryController
## Methods
### `public static ServiceVehicleHistory getTreeGridData(Id serviceVehicleId)`

`AURAENABLED`

Populates wrapped service vehicle data for display in tree grid component

#### Parameters

|Param|Description|
|---|---|
|`serviceVehicleId`|- service vehicle to display data for|

#### Returns

|Type|Description|
|---|---|
|`ServiceVehicleHistory`|svHistory - wrapper object containing tree grid data and column definitions|


**Method** getTreeGridData

### `public static Id getSvFromLookup(Id serviceVehicleId)`

`AURAENABLED`

Retreieves the Service Vehicle Id from the lookup of the passed in object

#### Parameters

|Param|Description|
|---|---|
|`serviceVehicleId`|- recordId of object SV is being retrieved from|

#### Returns

|Type|Description|
|---|---|
|`Id`|returns related service vehicle from rootId Object|


**Method** getSvFromLookup

### `public static Id getSVFromObject(Id svId, String objectName)`

Returns the Service Vehicle Id based on a Record Id and the Object it is located on

#### Parameters

|Param|Description|
|---|---|
|`svId`|svId description|
|`objectName`|objectName description|

#### Returns

|Type|Description|
|---|---|
|`Id`|return description|

### `public static String getTabUrl(String sobjectName)`

`AURAENABLED`

gets service vehicle tab icon to supply to component

#### Parameters

|Param|Description|
|---|---|
|`sobjectName`|- object to get tab for|

#### Returns

|Type|Description|
|---|---|
|`String`|returns icon source|


**Method** getTabUrl

---
## Classes
### ServiceVehicleHistory
#### Properties

##### `public svId` → `string`

`AURAENABLED` 

##### `public baseUrl` → `string`

`AURAENABLED` 

##### `public sroHeaders` → `List&lt;Service_Repair_Order__c&gt;`

`AURAENABLED` 

##### `public estimates` → `List&lt;Service_Estimate__c&gt;`

`AURAENABLED` 

##### `public contracts` → `List&lt;Service_Contract__c&gt;`

`AURAENABLED` 

##### `public jobLineFS` → `Map&lt;String,List&lt;Utility.fieldSetWrapper&gt;&gt;`

`AURAENABLED` 

##### `public estLineFS` → `Map&lt;String,List&lt;Utility.fieldSetWrapper&gt;&gt;`

`AURAENABLED` 

##### `public contractFS` → `Map&lt;String,List&lt;Utility.fieldSetWrapper&gt;&gt;`

`AURAENABLED` 

---

---
