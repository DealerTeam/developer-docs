# ServiceEstimateAPI

`APIVERSION: 45`

`STATUS: ACTIVE`

ServiceEstimateAPI - Service Controller for the public facing service estimate solutions.


**Group** Service

## Methods
### `static createEstimateLine(Service_Estimate_Line__c line)`
### `static updateEstimateLine(Service_Estimate_Line__c line)`
### `static deleteEstimateLine(Id lineId)`
### `static estimateSubLines(Id lineId)`
### `static createSubLine(Service_Estimate_SubLine__c subLine)`
### `static updateSubLine(Service_Estimate_SubLine__c subLine)`
### `static deleteSubLine(Id subLine)`
### `static readSubLines(Id serviceEstimateLineId)`
### `static readSubLines(set<Id> estimateLines)`
### `static readSubLines(Id serviceEstimateLineId, String sublineType)`
### `static estimateLines(Id estimateId)`
### `static miscChargeCodes(Id locationId)`
---
## Classes
### ServiceEstimateAPIException

**Inheritance**

ServiceEstimateAPIException


---
