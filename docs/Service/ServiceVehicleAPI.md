---
layout: default
---
# ServiceVehicleAPI



**Group** Service

## Methods
### `global static sv svData(Id svId)`
### `public static Service_Vehicle__c createServiceVehicleWithVIN(string VIN)`
---
## Classes
### sv

Wrapper class for sv data and related records.

#### Constructors
##### `global sv()`
---
#### Properties

##### `global svHeader` → `Service_Vehicle__c`


##### `global ownerAcct` → `Account`


##### `global ownerContact` → `Contact`


##### `global employee` → `User`


##### `global vehicle` → `Vehicle_Inventory__c`


##### `global conversion` → `Parts_Kit__c`


##### `global equipmentInvs` → `List&lt;dealer__Equipment__c&gt;`


##### `global inspectionReports` → `List&lt;dealer__Inspection_Report__c&gt;`


##### `global appraisals` → `List&lt;Appraisal__c&gt;`


##### `global sro` → `List&lt;Service_Repair_Order__c&gt;`


##### `global contract` → `List&lt;Service_Contract__c&gt;`


---

### ServiceVehicleException

**Inheritance**

ServiceVehicleException


---
