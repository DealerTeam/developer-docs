---
layout: default
---
# ServiceRepairOrder
## Constructors
### `public ServiceRepairOrder(Id sroId)`
### `public ServiceRepairOrder(Id sroId, Boolean enforceSecurity)`

Constructor that strips inaccessible fields from the sro object

#### Parameters

|Param|Description|
|---|---|
|`sroId`|sroId description|
|`enforceSecurity`|enforceSecurity Boolean used to apply stripInaccessible|

### `public ServiceRepairOrder()`

Empty constructor used to create the sro wrapper with all objects instantiated


**Method** ServiceRepairOrder

---
## Fields

### `public sro` → `Service_Repair_Order__c`

`AURAENABLED` 

### `public claim` → `Claim__c`

`AURAENABLED` 

### `public company` → `Dealer_Location__c`

`AURAENABLED` 

### `public customer` → `Account`

`AURAENABLED` 

### `public contact` → `Contact`

`AURAENABLED` 

### `public deal` → `Deal__c`

`AURAENABLED` 

### `public partsInvoice` → `Parts_Invoice__c`

`AURAENABLED` 

### `public serviceVehicle` → `Service_Vehicle__c`

`AURAENABLED` 

### `public vehicleInventory` → `Vehicle_Inventory__c`

`AURAENABLED` 

### `public jobLines` → `List<Service_Job__c>`

`AURAENABLED` 

### `public taxZone` → `Tax_Zones__c`

`AURAENABLED` 

### `public payments` → `List<Cashering__c>`


### `public orderLines` → `List<PartsOrderLine__c>`

`AURAENABLED` 

### `public purchaseOrderLines` → `List<Purchase_Order_Line__c>`

`AURAENABLED` 

### `public ledgersByPartsLine` → `Map<Id,List<Parts_Ledger__c>>`

`AURAENABLED` 

### `public fieldSets` → `Map<String,List<Utility.fieldSetWrapper>>`

`AURAENABLED` 

---
## Methods
### `private void getData(Id sroId, Boolean enforceSecurity)`
### `private Map<Id,List<Parts_Ledger__c>> getLedgers(List<Service_Job__c> jobs)`
---
