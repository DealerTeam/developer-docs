# ServiceEstimatePrint

`APIVERSION: 45`

`STATUS: ACTIVE`

ServiceEstimatePrint - Print Class


**Group** Service

## Constructors
### `ServiceEstimatePrint(ApexPages.standardController sc)`
---
## Properties

### `estimateRecord` → `Service_Estimate__c`


---
## Methods
### `getEstimate()`
### `generateDocument()`
---
## Classes
### estimate
#### Properties

##### `customer` → `Account`


##### `header` → `Service_Estimate__c`


##### `lines` → `List&lt;line&gt;`


##### `location` → `Dealer_Location__c`


##### `logoUrl` → `String`


##### `printDateTime` → `DateTime`


##### `vehicle` → `Service_Vehicle__c`


---

### line
#### Properties

##### `data` → `Service_Estimate_Line__c`


##### `subdata` → `List&lt;Service_Estimate_SubLine__c&gt;`


---

---
