---
layout: default
---
# ServiceEstimateWorksheet_EXT



**Group** Service

## Constructors
### `public ServiceEstimateWorksheet_EXT(ApexPages sc)`
---
## Properties

### `public est` → `Service_Estimate__c`


### `public location` → `Dealer_Location__c`


### `public symbol` → `String`


---
## Methods
### `public String getDealerLocation()`
### `public Service_Estimate_Line__c reloadDetail()`
### `public static List<StandardOpCode__c> operationCodes()`

`REMOTEACTION`
### `public static Service_Estimate_Line__c createEstimateLine(String jLine)`

`REMOTEACTION`
### `public static Service_Estimate_Line__c updateEstimateLine(String line)`

`REMOTEACTION`
### `public static Boolean deleteEstimateLine(String lineId)`

`REMOTEACTION`
### `public static Service_Estimate_SubLine__c createSubLine(String subLine)`

`REMOTEACTION`
### `public static List<Service_Estimate_SubLine__c> readSubLines(String lineRequest)`

`REMOTEACTION`
### `public static Service_Estimate_SubLine__c updateSubLine(String lineRequest)`

`REMOTEACTION`
### `public static void deleteSubLine(String subLineId)`

`REMOTEACTION`
### `public static List<Service_Estimate_Line__c> estimateLines(String estimateId)`

`REMOTEACTION`
### `public static Id convertToRepairOrder(Id estimateId)`

`REMOTEACTION`
### `public static Decimal matrix(String pl)`

`REMOTEACTION`
### `public static Id appendToRepairOrder(Id estimateId)`

`REMOTEACTION`
### `public static List<MiscChargeCode__c> miscChargeCodes(String locationId)`

`REMOTEACTION`
---
## Classes
### ServiceEstimateAPIException

**Inheritance**

ServiceEstimateAPIException


---
