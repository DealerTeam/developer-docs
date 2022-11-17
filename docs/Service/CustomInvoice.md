# CustomInvoice

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** CustomInvoice


**Group** Service

## Methods
### `createROFromDeal(dealer__Deal__c dealObject)`
#### Parameters

|Param|Description|
|---|---|
|`dealObject`||


**Method** createROFromDeal

### `createLines(dealer__Service_Repair_Order__c ro, dealer__Deal__c dealObject)`

JVK1 - Moved to seperate method so we can re-create lines if necessary

#### Parameters

|Param|Description|
|---|---|
|`ro`||
|`dealObject`||

#### Return

**Type**

Boolean

**Description**

Boolean


**Method** createLines

### `static createServEst(List<dealer__Inspection_Report__c> inspReports, dealer__Deal__c dealObject)`
#### Parameters

|Param|Description|
|---|---|
|`inspReports`||
|`dealObject`||

#### Return

**Type**

List&lt;dealer__Service_Estimate__c&gt;

**Description**

List&lt;dealer__Service_Estimate__c&gt;


**Method** createServEst

---
