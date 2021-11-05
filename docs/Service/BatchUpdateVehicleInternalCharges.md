# BatchUpdateVehicleInternalCharges class

Batch Class to populate Vehicle Inventory internal charges fields from related SROs upon package installation

---
## Methods
### `execute(Database.BatchableContext BC, List<dealer__Vehicle_Inventory__c> vehicleList)` → `void`

Process each batch of records

#### Parameters

| Param | Description |
| ----- | ----------- |
|`` | C |
|`` | t |

#### Return

**Type**

void

**Description**

void

### `finish(Database.BatchableContext BC)` → `void`
#### Parameters

| Param | Description |
| ----- | ----------- |
|`` | C |

#### Return

**Type**

void

**Description**

void

### `start(Database.BatchableContext BC)` → `Database.QueryLocator`

Collect the batches of records to be passed to execute

#### Parameters

| Param | Description |
| ----- | ----------- |
|`` | C |

---
