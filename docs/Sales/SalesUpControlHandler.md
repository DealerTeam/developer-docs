# SalesUpControlHandler

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Sales

## Fields

### `accounts` → `Set<Id>`


Set&lt;Id&gt; description accounts Ids of customer accounts used for querying

### `appraisalVehList` → `List<dealer__Appraisal_Vehicle__c>`


List&lt;Appraisal_Vehicle__c&gt; description list of Appraisal Vehicles related to the Sales Ups used to update Service Vehicle on Sales Up

### `buyers` → `Set<Id>`


Set&lt;Id&gt; description buyers Ids of buyer contacts used for querying

### `carDealsId` → `Map<Id,dealer__Sales_Up__c>`


&lt;Id,dealer__Sales_Up__c&gt; description Ids of related deals used to query

### `custAccounts` → `Map<Id,Account>`


Map&lt;Id, Account&gt; custAccounts map that holds Accounts by Id

### `customers` → `Map<Id,Contact>`


Map&lt;Id, Contact&gt; customers map that holds Contacts by Id

### `dispositions` → `List<dealer__SalesDispositions__c>`


dealer__SalesDispositions__c description list of all Sales Dispositions

### `dv` → `List<dealer__Desired_Vehicle__c>`


List&lt;Desired_Vehicle__c&gt; description list of desired vehicles related to Sales Ups

### `dvMap` → `Map<Id,Map<Id,Desired_Vehicle__c>>`


Map&lt;Id, Map&lt;Id, Desired_Vehicle__c&gt;&gt; description map of a map of desired vehicles ordered by vehicle inventory Id in the inner map and Sales Up Id in the outer map to get a Desired Vehicle matching Sales Up and Vehicle Inventory

### `inv` → `Map<Id,dealer__Vehicle_Inventory__c>`


Map&lt;Id, Vehicle_Inventory__c&gt; description map of queried Vehicle Inventories organized by Id, used for populating vehicle fields on the Sales Up

### `serVehicleMap` → `Map<Id,dealer__Service_Vehicle__c>`


Map&lt;Id, Service_Vehicle__c&gt; description map of Service Vehicles organized by Id

### `svOld` → `Map<Id,dealer__Service_Vehicle__c>`


Map&lt;Id, Service_Vehicle__c&gt; description map of Service Vehicles organized by Id, holds Service Vehicles of trades for comparing for changes during trigger operation

---
## Methods
### `static getInstance()`

getInstance handles returning the running instance of SalesUpControlHandler, will create if one doesn't exist

#### Return

**Type**

SalesUpControlHandler

**Description**

return description

### `mapData(List<dealer__Sales_Up__c> salesUpList)`

Stores Sales Up related IDs

#### Parameters

|Param|Description|
|---|---|
|`Sales`|Up list|

### `handleIsBefore(List<dealer__Sales_Up__c> salesUpList)`
### `getLookUpRecords(List<Sales_Up__c> triggerNew)`
### `alignEndUser(List<Sales_Up__c> triggerNew)`

assignEndUser Aligns End User Accounts and End Contacts Context: Before Insert, Before Update

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|List of Sales ups in update call|

### `OnBeforeInsert(List<dealer__Sales_Up__c> salesUpList)`
### `OnBeforeUpdate(Map<Id,dealer__Sales_Up__c> oldSalesUpMap, List<dealer__Sales_Up__c> salesUpList)`
### `setSalespersonSharing(List<Sales_Up__c> triggerNew)`

provides apex sharing to salesperson 1 and 2

#### Parameters

|Param|Description|
|---|---|
|`oldSalesUpMap`|oldSalesUpMap description|
|`triggerNew`|triggerNew description|
|`salesUpMap`|salesUpMap description|


**Method** setSalespersonSharing

### `handleIsAfter(List<dealer__Sales_Up__c> oldSalesUpMap, List<dealer__Sales_Up__c> salesUpList, Map<ID,dealer__Sales_Up__c> salesUpMap)`
### `createOpportunity(List<dealer__Sales_Up__c> triggerNew)`

creates opportunity related to sales up if SalesCloudConnector is enabled

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** createOpportunity

### `handleCreateOpportunity(List<dealer__Sales_Up__c> triggerNew)`

Handles creating or updating existing opportunity when sales up is inserted if Sales Cloud Connector setting is enabled

### `updateOpportunity(List<Sales_Up__c> triggerNew)`

updates opportunity related to sales up if SalesCloudConnector is enabled

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** updateOpportunity

### `handleUpdateOpportunity(List<dealer__Sales_Up__c> triggerNew)`
### `handleUpdateName(List<Sales_Up__c> triggerNew)`

updates sales up name on update context to ensure it is always correct

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|incoming sales up records|


**Method** handleUpdateName

### `updateFromDesiredVehicle(List<dealer__Sales_Up__c> triggerNew, Map<Id,dealer__Sales_Up__c> oldMap)`

Updates vehicle fields via the Desired Vehicle record in desiredVehicle__c

### `createDesiredVehicleOnInsert(List<Sales_Up__c> triggerNew)`

Creates desired vehicles before inserting sales up

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** createDesiredVehicleOnInsert

### `createNewDesiredVehicle(List<Sales_Up__c> triggerNew)`

Creates new desired vehicles from list of sales ups and returns the list

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|List of sales ups to create desired vehicles from|

#### Return

**Type**

List&lt;Desired_Vehicle__c&gt;

**Description**




**Method** createNewDesiredVehicle

### `updateRelatedDesiredVehicle(List<Sales_Up__c> triggerNew)`

populates sales up lookup on desired vehicle objects after insert


**Method** updateRelatedDesiredVehicle

---
## Classes
### endUserHelper
#### Constructors
##### `endUserHelper(Sales_Up__c sup, Contact contc, Account acct)`
---
#### Fields

##### `account` → `account`


##### `contact` → `contact`


---

---
