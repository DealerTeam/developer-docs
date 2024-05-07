---
layout: default
---
# TechTimeEntry_EXT



**Group** Service

## Constructors
### `public TechTimeEntry_EXT(ApexPages controller)`
---
## Fields

### `public tt` → `dealer__Technician_Job_Time__c`


### `public ro` → `dealer__Service_Repair_Order__c`


### `public jl` → `dealer__Service_Job__c`


---
## Properties

### `public timeEntry` → `techActualTime`


### `public ttime` → `dealer__Technician_Job_Time__c`


### `public times` → `List<dealer__Technician_Job_Time__c>`


### `public timeTechTime` → `String`


### `public selectedTech` → `String`


### `public recordId` → `Id`


### `public jobId` → `String`


### `public fixedOpsSettings` → `dealer__FixedOperationsSettings__c`


---
## Methods
### `public List<SelectOption> getTechItems()`
### `public dealer__Service_Repair_Order__c getRo()`
### `public dealer__Service_Job__c getJobLines()`
### `public dealer__Parts_Invoice_Line__c getPartsLines()`
### `public dealer__Service_Repair_Order__c QueryRO(String roId)`
### `public dealer__Service_Job__c jobLines(Id rId)`
### `public dealer__Parts_Invoice_Line__c partsLines(Id rId)`
### `public PageReference startJobDiag()`
### `public PageReference saveHeader()`
### `public PageReference startJobRepair()`
### `public PageReference endJobClock()`
### `public PageReference addActualTime()`
### `public String getServiceHistoryJSON()`
### `public static boolean saveJobStatus(String linestat)`

`REMOTEACTION`
### `public static boolean saveFlatHours(String linedata)`

`REMOTEACTION`
### `public static dealer__Technician_Job_Time__c setTechTime(String s)`

`REMOTEACTION`
### `public static boolean saveCCCLine(String jsOBJ)`

`REMOTEACTION`
### `public static boolean saveTechToLine(String tId)`

`REMOTEACTION`
### `public static Time getElapsedTime(Time startTime, Time endTime)`
---
## Classes
### techActualTime
#### Properties

##### `public actualDate` → `Date`


##### `public actualTechnician` → `User`


##### `public actualAmount` → `Decimal`


---

---
