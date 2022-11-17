# DMSImportsAPI

`APIVERSION: 46`

`STATUS: ACTIVE`



**Class** DMSImportsAPI

## Methods
### `static upsertAccounts(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Return

**Type**

String

**Description**

String


**Method** upsertAccounts

### `static upsertLocations(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Return

**Type**

String

**Description**

String


**Method** upsertLocations

### `static upsertStandardOpCodes(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Return

**Type**

String

**Description**

String


**Method** upsertStandardOpCodes

### `static upsertVehicleInventory(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Return

**Type**

String

**Description**

String


**Method** upsertVehicleInventory

### `static deleteVehicleInventory(String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Return

**Type**

String

**Description**

String


**Method** upsertServiceVehicle

### `static upsertServiceVehicle(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Return

**Type**

String

**Description**

String


**Method** upsertServiceVehicle

### `static upsertServiceRepairOrders(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Return

**Type**

String

**Description**

String


**Method** upsertServiceRepairOrders

### `static upsertDeals(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Return

**Type**

String

**Description**

String


**Method** upsertDeals

### `static upsertPartsMasters(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Return

**Type**

String

**Description**

String


**Method** upsertPartsMasters

### `static upsertServiceJobLines(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Return

**Type**

String

**Description**

String


**Method** upsertServiceJobLines

### `static upsertSalesFees(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Return

**Type**

String

**Description**

String


**Method** upsertSalesFees

### `static upsertTradeIns(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Return

**Type**

String

**Description**

String


**Method** upsertTradeIns

### `static upsertPartsInventory(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Return

**Type**

String

**Description**

String


**Method** upsertPartsInventory

### `static routeObject(String type, String objJSON, String jobId)`

Routes Object to correct method

#### Parameters

|Param|Description|
|---|---|
|`type`||
|`objJSON`||
|`jobId`||

#### Return

**Type**

String

**Description**

String

### `static cleanAccounts(List<Account> sfAccts, List<Account> dmsAccts)`

compares data from DMS to CRM and removes invalid External Ids from Accounts


**Method** cleanAccounts

### `static cleanRecords(String type, String objJSON)`
### `static syncAccount(String AccountJSON)`
---
## Classes
### result


#### Constructors
##### `result(List&lt;STring&gt; successes, List&lt;String&gt; errors)`
---
#### Fields

##### `Errors` → `List&lt;String&gt;`


##### `Successes` → `List&lt;String&gt;`


---

### vehicleResult
#### Constructors
##### `vehicleResult(Map&lt;Id,Vehicle_Inventory__c&gt; Successes, List&lt;String&gt; Errors)`
---
#### Fields

##### `Errors` → `List&lt;String&gt;`


##### `Successes` → `Map&lt;Id,Vehicle_Inventory__c&gt;`


---

---
