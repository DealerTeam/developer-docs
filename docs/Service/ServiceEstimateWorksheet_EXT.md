# ServiceEstimateWorksheet_EXT

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Service

## Constructors
### `ServiceEstimateWorksheet_EXT(ApexPages.standardController sc)`
---
## Properties

### `est` → `Service_Estimate__c`


### `location` → `Dealer_Location__c`


---
## Methods
### `getDealerLocation()`
### `reloadDetail()`
### `static operationCodes()`

`REMOTEACTION`
### `static createEstimateLine(String jLine)`

`REMOTEACTION`
### `static updateEstimateLine(String line)`

`REMOTEACTION`
### `static deleteEstimateLine(String lineId)`

`REMOTEACTION`
### `static createSubLine(String subLine)`

`REMOTEACTION`
### `static readSubLines(String lineRequest)`

`REMOTEACTION`
### `static updateSubLine(String lineRequest)`

`REMOTEACTION`
### `static deleteSubLine(String subLineId)`

`REMOTEACTION`
### `static estimateLines(String estimateId)`

`REMOTEACTION`
### `static convertToRepairOrder(Id estimateId)`

`REMOTEACTION`
### `static matrix(String pl)`

`REMOTEACTION`
### `static appendToRepairOrder(Id estimateId)`

`REMOTEACTION`
### `static miscChargeCodes(String locationId)`

`REMOTEACTION`
---
## Classes
### ServiceEstimateAPIException

**Inheritance**

ServiceEstimateAPIException


---
