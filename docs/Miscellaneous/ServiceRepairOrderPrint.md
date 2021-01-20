# ServiceRepairOrderPrint class

 		W-001569

---
## Constructors
### `ServiceRepairOrderPrint(ApexPages.standardController sc)`
---
## Properties

### `ro` → `Service_Repair_Order__c`

---
## Methods
### `getServiceRepairOrder()` → `ServiceRepairOrder`
---
## Inner Classes

### ServiceRepairOrderPrint.ServiceRepairOrder class
---
#### Properties

##### `customer` → `Account`

##### `header` → `Service_Repair_Order__c`

##### `location` → `Dealer_Location__c`

##### `logoUrl` → `String`

##### `printDateTime` → `String`

##### `serviceJobList` → `List<Service_Job__c>`

##### `servicePartsList` → `List<Parts_Invoice_Line__c>`

##### `total_payments` → `Decimal`

##### `total_sublet_cust` → `Decimal`

##### `userLoc` → `Dealer_Location__c`

##### `vehicle` → `Service_Vehicle__c`

---
