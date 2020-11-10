---
layout: default
---
# ServiceEstimateAPI class

 ServiceEstimateAPI - Service Controller for the public facing service estimate solutions.

---
## Methods
### `createEstimateLine(Service_Estimate_Line__c line)` → `Service_Estimate_Line__c`
### `createSubLine(Service_Estimate_SubLine__c subLine)` → `Service_Estimate_SubLine__c`
### `deleteEstimateLine(Id lineId)` → `Boolean`
### `deleteSubLine(Id subLine)` → `void`
### `estimateLines(Id estimateId)` → `List<Service_Estimate_Line__c>`
### `estimateSubLines(Id lineId)` → `List<Service_Estimate_SubLine__c>`
### `miscChargeCodes(Id locationId)` → `List<MiscChargeCode__c>`
### `readSubLines(Id serviceEstimateLineId)` → `List<Service_Estimate_SubLine__c>`
### `readSubLines(set<Id> estimateLines)` → `List<Service_Estimate_SubLine__c>`
### `readSubLines(Id serviceEstimateLineId, String sublineType)` → `List<Service_Estimate_SubLine__c>`
### `updateEstimateLine(Service_Estimate_Line__c line)` → `Service_Estimate_Line__c`
### `updateSubLine(Service_Estimate_SubLine__c subLine)` → `Service_Estimate_SubLine__c`
---
## Inner Classes

### ServiceEstimateAPI.ServiceEstimateAPIException class
---
