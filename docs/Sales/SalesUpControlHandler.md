---
layout: default
---
# SalesUpControlHandler

SalesUpControlHandler is a class that handles the domain layer logic for the Sales Up object


**Group** Sales

## Fields

### `private instance` → `SalesUpControlHandler`


instance private variable that holds the current instance of the class

### `private salesUpIds` → `List<Id>`


List&lt;Id&gt; salesUpIds the Ids of TriggerNew

### `private newSerVehList` → `List<Service_Vehicle__c>`


List&lt;Service_Vehicle__c&gt; newSerVehList Service Vehicles related to the sales ups

### `private vin` → `List<String>`


List&lt;String&gt; description vin VINs related to desired vehicle inventory used for querying

### `private stock` → `Set<Id>`


Set&lt;Id&gt; description stock Ids of desired vehicle inventory used for querying

### `public accounts` → `Set<Id>`


Set&lt;Id&gt; description accounts Ids of customer accounts used for querying

### `public buyers` → `Set<Id>`


Set&lt;Id&gt; description buyers Ids of buyer contacts used for querying

### `private vinNoSet` → `Set<String>`


Set&lt;String&gt; description vinNoSet VINs of Trades used for querying Service Vehicles

### `private setActiveUserIds` → `Set<Id>`


Set&lt;Id&gt; description setActiveUserIds used to determine if users related to the deal are active

### `private newVinNoSet` → `Set<String>`


Set&lt;String&gt; description newVinNoSet VINs of new Trades that do not exist in database as Service Vehicles

### `private serVehicleIds` → `Set<Id>`


Set&lt;Id&gt; description serVehicleIds Ids of related Service Vehicles for querying

### `private setOwnerIds` → `Set<Id>`


Set&lt;Id&gt; description setOwnerIds Ids of owner and salespeople used for querying

### `private fetchDeals` → `Boolean`


Boolean fetchDeals anti-recursion variable used to limit deal queries

### `public custAccounts` → `Map<Id,Account>`


Map&lt;Id, Account&gt; custAccounts map that holds Accounts by Id

### `public customers` → `Map<Id,Contact>`


Map&lt;Id, Contact&gt; customers map that holds Contacts by Id

### `private locations` → `Map<Id,Dealer_Location__c>`


Map&lt;Id, Dealer_Location__c&gt; locations Dealer Locations organized by Id

### `private locationByCompanyNumber` → `Map<String,Id>`


Map&lt;String, Id&gt; locationsByCompanyNumber location Ids organized by Company Number

### `private userRecords` → `Map<Id,User>`


Map&lt;Id, User&gt; userRecords map of related Users organized by Id, used to determine users who are active

### `private userDivisionMap` → `Map<Id,Dealer_Location__c>`


Map&lt;Id, User&gt; Map of users and the Location assigned to their User ERP Custom Setting

### `private serVehMap` → `Map<String,Service_Vehicle__c>`


Map&lt;String,Service_Vehicle__c&gt; description queried Service Vehicles organized by VIN on Sales Up

### `public inv` → `Map<Id,dealer__Vehicle_Inventory__c>`


Map&lt;Id, Vehicle_Inventory__c&gt; description map of queried Vehicle Inventories organized by Id, used for populating vehicle fields on the Sales Up

### `public carDealsId` → `Map<Id,dealer__Sales_Up__c>`


&lt;Id,dealer__Sales_Up__c&gt; description Ids of related deals used to query

### `private svMap` → `Map<Id,Service_Vehicle__c>`


Map&lt;Id,Service_Vehicle__c&gt; description map of Service Vehicles ordered by Id

### `public dispositions` → `List<dealer__SalesDispositions__c>`


dealer__SalesDispositions__c description list of all Sales Dispositions

### `public serVehicleMap` → `Map<Id,dealer__Service_Vehicle__c>`


Map&lt;Id, Service_Vehicle__c&gt; description map of Service Vehicles organized by Id

### `public dv` → `List<dealer__Desired_Vehicle__c>`


List&lt;Desired_Vehicle__c&gt; description list of desired vehicles related to Sales Ups

### `public dvMap` → `Map<Id,Map<Id,Desired_Vehicle__c>>`


Map&lt;Id, Map&lt;Id, Desired_Vehicle__c&gt;&gt; description map of a map of desired vehicles ordered by vehicle inventory Id in the inner map and Sales Up Id in the outer map to get a Desired Vehicle matching Sales Up and Vehicle Inventory

### `public svOld` → `Map<Id,dealer__Service_Vehicle__c>`


Map&lt;Id, Service_Vehicle__c&gt; description map of Service Vehicles organized by Id, holds Service Vehicles of trades for comparing for changes during trigger operation

### `public appraisalVehList` → `List<dealer__Appraisal_Vehicle__c>`


List&lt;Appraisal_Vehicle__c&gt; description list of Appraisal Vehicles related to the Sales Ups used to update Service Vehicle on Sales Up

### `private orgSettings` → `dealer__CRMSettings__c`


dealer__CRMSettings__c description Org Defaults for CRM Settings custom setting for retrieving Sales_Up_Record_Prefix__c

### `private crm` → `dealer__CRMSettings__c`


dealer__CRMSettings__c description CRM Settings custom setting for the current user

### `private nameString` → `String`


String description teh name of the Sales Up

---
## Methods
### `public static SalesUpControlHandler getInstance()`

getInstance handles returning the running instance of SalesUpControlHandler, will create if one doesn't exist

#### Returns

|Type|Description|
|---|---|
|`SalesUpControlHandler`|return description|

### `public void mapData(List<dealer__Sales_Up__c> salesUpList)`

Stores Sales Up related IDs

#### Parameters

|Param|Description|
|---|---|
|`Sales`|Up list|

### `private void getCustomers()`

Fetch Account and Contact records affected

### `private Boolean getBuyers()`
### `public void handleIsBefore(List<dealer__Sales_Up__c> salesUpList)`
### `private void getAllLocations()`

Fetch Locations

### `public void getLookUpRecords(List<Sales_Up__c> triggerNew)`
### `private void getSvMap()`
### `private void getDvMap()`

used to query and populate the dvMap


**Method** getDvMap

### `private void getRecordOwners()`

Fetch Active Users who own SUP records

### `private void getInventoryRecords()`

Get vehicle information By Stocknumber OR VIN

### `private void getCarDealStatus(List<dealer__Sales_Up__c> salesUpList)`

Get Deals Status By Car Deal Ids in SUPs

### `public void alignEndUser(List<Sales_Up__c> triggerNew)`

assignEndUser Aligns End User Accounts and End Contacts Context: Before Insert, Before Update

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|List of Sales ups in update call|

### `private void createUpdateServiceVehicles(List<dealer__Sales_Up__c> salesUpList)`

Create new Service Vehicle when SUP Trade Vin is set Update related Service Vehicle Contact and Account with SUP Contact and Account data

#### Parameters

|Param|Description|
|---|---|
|`List`|<dealer__Sales_Up__c> salesUpList|

### `private void associateServiceVehicle(List<dealer__Sales_Up__c> salesUpList)`

Insert new service vehicles & Updates account/contact owners fields on existing service vehicles

#### Parameters

|Param|Description|
|---|---|
|`List`|<dealer__Sales_Up__c> salesUpList|

### `private void getSupNamePrefix()`

Set Sales Up Name Prefix

### `private void setSalesUpFields(List<dealer__Sales_Up__c> salesUpList)`

Map Sales

### `private Integer checkLimits(Integer size)`
### `public void OnBeforeInsert(List<dealer__Sales_Up__c> salesUpList)`
### `public void OnBeforeUpdate(Map<Id,dealer__Sales_Up__c> oldSalesUpMap, List<dealer__Sales_Up__c> salesUpList)`
### `public void setSalespersonSharing(List<Sales_Up__c> triggerNew)`

provides apex sharing to salesperson 1 and 2

#### Parameters

|Param|Description|
|---|---|
|`oldSalesUpMap`|oldSalesUpMap description|
|`triggerNew`|triggerNew description|
|`salesUpMap`|salesUpMap description|


**Method** setSalespersonSharing

### `public void handleIsAfter(List<dealer__Sales_Up__c> oldSalesUpMap, List<dealer__Sales_Up__c> salesUpList, Map<ID,dealer__Sales_Up__c> salesUpMap)`
### `private List<Desired_Vehicle__c> createDesiredVehiclesConversion(Sales_Up__c sup)`

Updates or Creates the Desired Vehicle record with the attached Conversion (parts kit lookup)

#### Parameters

|Param|Description|
|---|---|
|`sup`|- incoming trigger records|

#### Returns

|Type|Description|
|---|---|
|`List<Desired_Vehicle__c>`|return - created or updated desired vehicle records|


**Method** createDesiredVehiclesConversion


**Test** SalesUpDomainLayer.testCreateDesiredVehicle

### `public void createOpportunity(List<dealer__Sales_Up__c> triggerNew)`

creates opportunity related to sales up if SalesCloudConnector is enabled

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** createOpportunity

### `public void handleCreateOpportunity(List<dealer__Sales_Up__c> triggerNew)`

Handles creating or updating existing opportunity when sales up is inserted if Sales Cloud Connector setting is enabled

### `public void updateOpportunity(List<Sales_Up__c> triggerNew)`

updates opportunity related to sales up if SalesCloudConnector is enabled

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** updateOpportunity

### `public void handleUpdateOpportunity(List<dealer__Sales_Up__c> triggerNew)`
### `public void handleUpdateName(List<Sales_Up__c> triggerNew)`

updates sales up name on update context to ensure it is always correct

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|incoming sales up records|


**Method** handleUpdateName

### `public void updateFromDesiredVehicle(List<dealer__Sales_Up__c> triggerNew, Map<Id,dealer__Sales_Up__c> oldMap)`

Updates vehicle fields via the Desired Vehicle record in desiredVehicle__c

### `public void createDesiredVehicleOnInsert(List<Sales_Up__c> triggerNew)`

Creates desired vehicles before inserting sales up

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|triggerNew description|


**Method** createDesiredVehicleOnInsert

### `public List<Desired_Vehicle__c> createNewDesiredVehicle(List<Sales_Up__c> triggerNew)`

Creates new desired vehicles from list of sales ups and returns the list

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|List of sales ups to create desired vehicles from|

#### Returns

|Type|Description|
|---|---|
|`List<Desired_Vehicle__c>`||


**Method** createNewDesiredVehicle

### `public void updateRelatedDesiredVehicle(List<Sales_Up__c> triggerNew)`

populates sales up lookup on desired vehicle objects after insert


**Method** updateRelatedDesiredVehicle

---
## Classes
### endUserHelper
#### Constructors
##### `public endUserHelper(Sales_Up__c sup, Contact contc, Account acct)`
---
#### Fields

##### `private sup` → `Sales_Up__c`


##### `public account` → `account`


##### `public contact` → `contact`


---

---
