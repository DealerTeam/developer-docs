# ServiceVehicleHistoryController

`APIVERSION: 52`

`STATUS: ACTIVE`
## Methods
### `static getTreeGridData(Id serviceVehicleId)`

`AURAENABLED`

Populates wrapped service vehicle data for display in tree grid component

#### Parameters

|Param|Description|
|---|---|
|`serviceVehicleId`|- service vehicle to display data for|

#### Return

**Type**

ServiceVehicleHistory

**Description**

svHistory - wrapper object containing tree grid data and column definitions


**Method** getTreeGridData

### `static getSvFromLookup(Id serviceVehicleId)`

`AURAENABLED`

Retreieves the Service Vehicle Id from the lookup of the passed in object

#### Parameters

|Param|Description|
|---|---|
|`serviceVehicleId`|- recordId of object SV is being retrieved from|

#### Return

**Type**

Id

**Description**

returns related service vehicle from rootId Object


**Method** getSvFromLookup

### `static getSVFromObject(Id svId, String objectName)`

Returns the Service Vehicle Id based on a Record Id and the Object it is located on

#### Parameters

|Param|Description|
|---|---|
|`svId`|svId description|
|`objectName`|objectName description|

#### Return

**Type**

Id

**Description**

return description

### `static getTabUrl(String sobjectName)`

`AURAENABLED`

gets service vehicle tab icon to supply to component

#### Parameters

|Param|Description|
|---|---|
|`sobjectName`|- object to get tab for|

#### Return

**Type**

String

**Description**

returns icon source


**Method** getTabUrl

---
## Classes
### ServiceVehicleHistory
#### Properties

##### `baseUrl` → `string`

`AURAENABLED` 

##### `contractFS` → `Map&lt;String,List&lt;Utility.fieldSetWrapper&gt;&gt;`

`AURAENABLED` 

##### `contracts` → `List&lt;Service_Contract__c&gt;`

`AURAENABLED` 

##### `estLineFS` → `Map&lt;String,List&lt;Utility.fieldSetWrapper&gt;&gt;`

`AURAENABLED` 

##### `estimates` → `List&lt;Service_Estimate__c&gt;`

`AURAENABLED` 

##### `jobLineFS` → `Map&lt;String,List&lt;Utility.fieldSetWrapper&gt;&gt;`

`AURAENABLED` 

##### `sroHeaders` → `List&lt;Service_Repair_Order__c&gt;`

`AURAENABLED` 

##### `svId` → `string`

`AURAENABLED` 

---

---
