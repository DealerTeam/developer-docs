# TechTimeEntry_EXT

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Service

## Constructors
### `TechTimeEntry_EXT(ApexPages.StandardController controller)`
---
## Fields

### `jl` → `dealer__Service_Job__c[]`


### `ro` → `dealer__Service_Repair_Order__c`


### `tt` → `dealer__Technician_Job_Time__c`


---
## Properties

### `fixedOpsSettings` → `dealer__FixedOperationsSettings__c`


### `jobId` → `String`


### `recordId` → `Id`


### `selectedTech` → `String`


### `timeEntry` → `techActualTime`


### `timeTechTime` → `String`


### `times` → `List<dealer__Technician_Job_Time__c>`


### `ttime` → `dealer__Technician_Job_Time__c`


---
## Methods
### `getTechItems()`
### `getRo()`
### `getJobLines()`
### `getPartsLines()`
### `QueryRO(String roId)`
### `jobLines(Id rId)`
### `partsLines(Id rId)`
### `startJobDiag()`
### `saveHeader()`
### `startJobRepair()`
### `endJobClock()`
### `addActualTime()`
### `getServiceHistoryJSON()`
### `static saveJobStatus(String linestat)`

`REMOTEACTION`
### `static saveFlatHours(String linedata)`

`REMOTEACTION`
### `static setTechTime(String s)`

`REMOTEACTION`
### `static saveCCCLine(String jsOBJ)`

`REMOTEACTION`
### `static saveTechToLine(String tId)`

`REMOTEACTION`
### `static getElapsedTime(Time startTime, Time endTime)`
---
## Classes
### techActualTime
#### Properties

##### `actualAmount` → `Decimal`


##### `actualDate` → `Date`


##### `actualTechnician` → `User`


---

---
