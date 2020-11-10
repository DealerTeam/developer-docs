---
layout: default
---
# ServiceEstimateWorksheet_EXT class
---
## Constructors
### `ServiceEstimateWorksheet_EXT(ApexPages.standardController sc)`
---
## Properties

### `est` → `Service_Estimate__c`

### `location` → `Dealer_Location__c`

---
## Methods
### `appendToRepairOrder(Id estimateId)` → `Id`
### `convertToRepairOrder(Id estimateId)` → `Id`
### `createEstimateLine(String jLine)` → `Service_Estimate_Line__c`
### `createSubLine(String subLine)` → `Service_Estimate_SubLine__c`
### `deleteEstimateLine(String lineId)` → `Boolean`
### `deleteSubLine(String subLineId)` → `void`
### `estimateLines(String estimateId)` → `List<Service_Estimate_Line__c>`
### `getDealerLocation()` → `String`
### `matrix(String pl)` → `Decimal`
### `miscChargeCodes(String locationId)` → `List<MiscChargeCode__c>`
### `operationCodes()` → `List<StandardOpCode__c>`
### `readSubLines(String lineRequest)` → `List<Service_Estimate_SubLine__c>`
### `reloadDetail()` → `Service_Estimate_Line__c`
### `updateEstimateLine(String line)` → `Service_Estimate_Line__c`
### `updateSubLine(String lineRequest)` → `Service_Estimate_SubLine__c`
---
## Inner Classes

### ServiceEstimateWorksheet_EXT.ServiceEstimateAPIException class
---
