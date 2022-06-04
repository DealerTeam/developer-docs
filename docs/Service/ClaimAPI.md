# ClaimAPI

`APIVERSION: 45`

`STATUS: ACTIVE`

**Class** ClaimAPI


**Group** Service

## Methods
### `static claimData(Id claimId)`
#### Parameters

|Param|Description|
|---|---|
|`claimId`||

#### Return

**Type**

claim

**Description**

claim


**Method** claimData

---
## Classes
### claim

Wrapper class for claim data and related records.

#### Constructors
##### `claim()`
---
#### Properties

##### `appraisal` → `Appraisal__c`


##### `cis` → `List&lt;dealer__ClaimItem__c&gt;`


##### `claimEquipment` → `Equipment__c`


##### `claimHeader` → `claim__c`


##### `customer` → `Account`


##### `employee` → `User`


##### `equipment` → `EquipmentInventory__c`


##### `location` → `dealer_Location__c`


##### `serviceVehicle` → `Service_Vehicle__c`


##### `sro` → `Service_Repair_Order__c`


##### `vehicle` → `Vehicle_Inventory__c`


---

### claimAPIException

---
