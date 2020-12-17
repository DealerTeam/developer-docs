# ServiceRepairOrderAPI class

Service Layer Encapsulation of interaction with the Repair Order Object.

---
## Methods
### `createJobLinesFromDeal(Deal__c dealObject)` → `List<Service_Job__c>`
### `createRepairOrderFromDeal(Deal__c dealObject)` → `Service_Repair_Order__c`

This method serves to create repair orders from deals.  These repair orders are often referred to as delivery repair orders.

#### Parameters
|Param|Description|
|-----|-----------|
|`dealObject` |  sObject Deal |

#### Return

**Type**

Service_Repair_Order__c

**Description**

Returns the Service Repair Order sobject created.

### `createRepairOrderFromEstimate(Service_Estimate__c estimateObject)` → `Service_Repair_Order__c`

Tbhis method converts a Service Estimate to a Service Repair Order

#### Parameters
|Param|Description|
|-----|-----------|
|`estimateObject` |  The estimateObject parameter is a complete or at minimum stored Service Estimate including Record ID |

#### Return

**Type**

Service_Repair_Order__c

**Description**

Returns a Service Repair Order

---
## Inner Classes

### ServiceRepairOrderAPI.ServiceRepairOrderAPIException class
---
