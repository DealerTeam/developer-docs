---
layout: default
---
# ServiceRepairOrderPrint



**Group** Service

## Constructors
### `global ServiceRepairOrderPrint(ApexPages sc)`
---
## Properties

### `global ro` → `Service_Repair_Order__c`


---
## Methods
### `global ServiceRepairOrder getServiceRepairOrder()`
### `private static Service_Repair_Order__c queryHeader(Id sroId)`
### `private static List<Service_Job__c> queryLines(Id sroId)`
### `private static Decimal totalSublet(Id sroId)`
### `private static Decimal totalPayments(Id sroId)`
### `private static Account queryAccount(Id acctId)`
### `private static Service_Vehicle__c queryVehicle(Id vehId)`
### `private static Dealer_Location__c queryLocation(Id locId)`
### `private static List<Parts_Invoice_Line__c> queryParts(Id sroId)`
### `private static String logo_url()`
### `private static String formattedDateTime()`
---
## Classes
### ServiceRepairOrder
#### Constructors
##### `private ServiceRepairOrder(Id sroId)`
---
#### Properties

##### `global logoUrl` → `String`


##### `global location` → `Dealer_Location__c`


##### `global customer` → `Account`


##### `global printDateTime` → `String`


##### `global header` → `Service_Repair_Order__c`


##### `global userLoc` → `Dealer_Location__c`


##### `global vehicle` → `Service_Vehicle__c`


##### `global serviceJobList` → `List&lt;Service_Job__c&gt;`


##### `global servicePartsList` → `List&lt;Parts_Invoice_Line__c&gt;`


##### `global total_sublet_cust` → `Decimal`


##### `global total_payments` → `Decimal`


---

---
