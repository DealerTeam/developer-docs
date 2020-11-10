---
layout: default
---
# TechTimeEntry_EXT class
---
## Constructors
### `TechTimeEntry_EXT(ApexPages.StandardController controller)`
---
## Properties

### `fixedOpsSettings` → `dealer__FixedOperationsSettings__c`

### `jl` → `dealer__Service_Job__c[]`

### `jobId` → `String`

### `recordId` → `Id`

### `ro` → `dealer__Service_Repair_Order__c`

### `selectedTech` → `String`

### `timeEntry` → `techActualTime`

### `timeTechTime` → `String`

### `times` → `List<dealer__Technician_Job_Time__c>`

### `tt` → `dealer__Technician_Job_Time__c`

### `ttime` → `dealer__Technician_Job_Time__c`

---
## Methods
### `QueryRO(String roId)` → `dealer__Service_Repair_Order__c`
### `addActualTime()` → `PageReference`
### `endJobClock()` → `PageReference`
### `getElapsedTime(Time startTime, Time endTime)` → `Time`
### `getJobLines()` → `dealer__Service_Job__c[]`
### `getPartsLines()` → `dealer__Parts_Invoice_Line__c[]`
### `getRo()` → `dealer__Service_Repair_Order__c`
### `getServiceHistoryJSON()` → `String`
### `getTechItems()` → `List<SelectOption>`
### `jobLines(Id rId)` → `dealer__Service_Job__c[]`
### `partsLines(Id rId)` → `dealer__Parts_Invoice_Line__c[]`
### `saveCCCLine(String jsOBJ)` → `boolean`
### `saveFlatHours(String linedata)` → `boolean`
### `saveHeader()` → `PageReference`
### `saveJobStatus(String linestat)` → `boolean`
### `saveTechToLine(String tId)` → `boolean`
### `setTechTime(String s)` → `dealer__Technician_Job_Time__c`
### `startJobDiag()` → `PageReference`
### `startJobRepair()` → `PageReference`
---
## Inner Classes

### TechTimeEntry_EXT.techActualTime class
---
#### Properties

##### `actualAmount` → `Decimal`

##### `actualDate` → `Date`

##### `actualTechnician` → `User`

---
