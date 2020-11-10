---
layout: default
---
# SalesUpControlHandler class

 W-001431

---
## Properties

### `accounts` → `Set<Id>`

Lists * /** Sets and Maps *

### `appraisalVehList` → `List<dealer__Appraisal_Vehicle__c>`

### `buyers` → `Set<Id>`

### `carDealsId` → `Map<Id,dealer__Sales_Up__c>`

### `custAccounts` → `Account>`

### `customers` → `Contact>`

### `dispositions` → `List<dealer__SalesDispositions__c>`

### `dv` → `List<dealer__Desired_Vehicle__c>`

### `dvMap` → `Desired_Vehicle__c>>`

### `inv` → `dealer__Vehicle_Inventory__c>`

### `serVehicleMap` → `dealer__Service_Vehicle__c>`

### `svOld` → `dealer__Service_Vehicle__c>`

---
## Methods
### `OnBeforeInsert(List<dealer__Sales_Up__c> salesUpList)` → `void`

 Create new Service Vehicle when SUP Trade Vin is set Update related Service Vehicle Contact and Account with SUP Contact and Account data

#### Parameters
|Param|Description|
|-----|-----------|
|`List<dealer__Sales_Up__c>` |  salesUpList |
|`List<dealer__Sales_Up__c>` |  salesUpList |

### `OnBeforeUpdate(Map<Id,dealer__Sales_Up__c> oldSalesUpMap, List<dealer__Sales_Up__c> salesUpList)` → `void`
### `alignEndUser(List<Sales_Up__c> triggerNew)` → `void`

 Fetch Locations /** Fetch Active Users who own SUP records /** Get vehicle information By Stocknumber OR VIN /** Get Deals Status By Car Deal Ids in SUPs /** assignEndUser Aligns End User Accounts and End Contacts Context: Before Insert, Before Update

#### Parameters
|Param|Description|
|-----|-----------|
|`triggerNew` |  List of Sales ups in update call |

### `createOpportunity(List<dealer__Sales_Up__c> triggerNew)` → `void`

 Updates or Creates the Desired Vehicle record with the attached Conversion (parts kit lookup) @test - SalesUpDomainLayer.testCreateDesiredVehicle /** Handles creating or updating existing opportunity when sales up is inserted if Sales Cloud Connector setting is enabled

### `handleIsAfter(List<dealer__Sales_Up__c> oldSalesUpMap, List<dealer__Sales_Up__c> salesUpList, Map<ID, dealer__Sales_Up__c> salesUpMap)` → `void`
### `handleIsBefore(List<dealer__Sales_Up__c> salesUpList)` → `void`

 Fetch Account and Contact records affected

### `mapData(List<dealer__Sales_Up__c> salesUpList)` → `void`

 Stores Sales Up related IDs

#### Parameters
|Param|Description|
|-----|-----------|
|`Sales` |  Up list |

### `updateFromDesiredVehicle(List<dealer__Sales_Up__c> triggerNew, Map<Id, dealer__Sales_Up__c> oldMap)` → `void`

 Updates vehicle fields via the Desired Vehicle record in desiredVehicle__c

### `updateOpportunity(List<dealer__Sales_Up__c> triggerNew)` → `void`
---
## Inner Classes

### SalesUpControlHandler.endUserHelper class
---
#### Constructors
##### `endUserHelper(Sales_Up__c sup, Contact contc, Account acct)`
---
#### Properties

##### `account` → `public`

##### `contact` → `public`

---
