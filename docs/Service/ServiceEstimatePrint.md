---
layout: default
---
# ServiceEstimatePrint

ServiceEstimatePrint - Print Class


**Group** Service

## Constructors
### `global ServiceEstimatePrint(ApexPages sc)`
---
## Properties

### `public symbol` → `String`


### `global estimateRecord` → `Service_Estimate__c`


---
## Methods
### `global estimate getEstimate()`
### `global estimate generateDocument()`
### `private static Service_Estimate__c queryHeader(Id estId)`
### `private static List<Service_Estimate_Line__c> queryLines(Id estId)`
### `private static List<Service_Estimate_SubLine__c> querySubLines(Set<Id> lineIds)`
### `private static Account queryAccount(Id acctId)`
### `private static Service_Vehicle__c queryVehicle(Id vehId)`
### `private static Dealer_Location__c queryLocation(Id locId)`
### `private static String logo_url(Id locationId)`
---
## Classes
### estimate
#### Constructors
##### `private estimate(Id estimateId)`
---
#### Properties

##### `global logoUrl` → `String`


##### `global location` → `Dealer_Location__c`


##### `global customer` → `Account`


##### `global vehicle` → `Service_Vehicle__c`


##### `global printDateTime` → `DateTime`


##### `global header` → `Service_Estimate__c`


##### `global lines` → `List&lt;line&gt;`


---

### line
#### Constructors
##### `private line(Service_Estimate_Line__c sl, List&lt;Service_Estimate_SubLine__c&gt; allSubLines)`
---
#### Properties

##### `global data` → `Service_Estimate_Line__c`


##### `global subdata` → `List&lt;Service_Estimate_SubLine__c&gt;`


---

---
