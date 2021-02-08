# ServiceEstimatePrint class
---
## Constructors
### `ServiceEstimatePrint(ApexPages.standardController sc)`
---
## Properties

### `estimateRecord` → `Service_Estimate__c`

---
## Methods
### `generateDocument()` → `estimate`
### `getEstimate()` → `estimate`
---
## Inner Classes

### ServiceEstimatePrint.estimate class
---
#### Properties

##### `customer` → `Account`

##### `header` → `Service_Estimate__c`

##### `lines` → `List<line>`

##### `location` → `Dealer_Location__c`

##### `logoUrl` → `String`

##### `printDateTime` → `DateTime`

##### `vehicle` → `Service_Vehicle__c`

---
### ServiceEstimatePrint.line class
---
#### Properties

##### `data` → `Service_Estimate_Line__c`

##### `subdata` → `List<Service_Estimate_SubLine__c>`

---
