---
layout: default
---
# ServiceEstimateAPI

ServiceEstimateAPI - Service Controller for the public facing service estimate solutions.


**Group** Service

## Methods
### `public static Service_Estimate_Line__c createEstimateLine(Service_Estimate_Line__c line)`
### `public static Service_Estimate_Line__c updateEstimateLine(Service_Estimate_Line__c line)`
### `public static Boolean deleteEstimateLine(Id lineId)`
### `public static List<Service_Estimate_SubLine__c> estimateSubLines(Id lineId)`
### `public static Service_Estimate_SubLine__c createSubLine(Service_Estimate_SubLine__c subLine)`
### `public static Service_Estimate_SubLine__c updateSubLine(Service_Estimate_SubLine__c subLine)`
### `public static void deleteSubLine(Id subLine)`
### `private static Service_Estimate_SubLine__c returnSubLine(Id subLineId)`
### `private static void createMiscCharges(Service_Estimate_SubLine__c subLine)`
### `public static List<Service_Estimate_SubLine__c> readSubLines(Id serviceEstimateLineId)`
### `public static List<Service_Estimate_SubLine__c> readSubLines(set<Id> estimateLines)`
### `public static List<Service_Estimate_SubLine__c> readSubLines(Id serviceEstimateLineId, String sublineType)`
### `public static List<Service_Estimate_Line__c> estimateLines(Id estimateId)`
### `public static List<MiscChargeCode__c> miscChargeCodes(Id locationId)`
---
## Classes
### ServiceEstimateAPIException

**Inheritance**

ServiceEstimateAPIException


---
