---
layout: default
---
# CustomInvoice



**Class** CustomInvoice


**Group** Service

## Methods
### `public dealer__Service_Repair_Order__c createROFromDeal(dealer__Deal__c dealObject)`
#### Parameters

|Param|Description|
|---|---|
|`dealObject`||


**Method** createROFromDeal

### `public Boolean createLines(dealer__Service_Repair_Order__c ro, dealer__Deal__c dealObject)`

JVK1 - Moved to seperate method so we can re-create lines if necessary

#### Parameters

|Param|Description|
|---|---|
|`ro`||
|`dealObject`||

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|


**Method** createLines

### `public static List<dealer__Service_Estimate__c> createServEst(List<dealer__Inspection_Report__c> inspReports, dealer__Deal__c dealObject)`
#### Parameters

|Param|Description|
|---|---|
|`inspReports`||
|`dealObject`||

#### Returns

|Type|Description|
|---|---|
|`List<dealer__Service_Estimate__c>`|List<dealer__Service_Estimate__c>|


**Method** createServEst

---
