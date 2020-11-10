---
layout: default
---
# ServiceRepairOrderAPI class

 ServiceRepairOrderAPI - Service Layer Encapsulation of interaction with the Repair Order Object.

---
## Methods
### `calculateCharges(dealer__Service_Repair_Order__c ro)` → `void`
### `cashTransactions(String sroId)` → `>`
### `createJobLinesFromDeal(Deal__c dealObject)` → `List<Service_Job__c>`
### `createRepairOrderFromDeal(Deal__c dealObject)` → `Service_Repair_Order__c`
### `createRepairOrderFromEstimate(Service_Estimate__c estimateObject)` → `Service_Repair_Order__c`
### `findById(Id roId)` → `Service_Repair_Order__c`
### `findRecent()` → `List<Service_Repair_Order__c>`
### `findRoByName(String searchContext)` → `List<Service_Repair_Order__c>`
---
## Inner Classes

### ServiceRepairOrderAPI.ServiceRepairOrderAPIException class
---
