---
layout: default
---
# DMSImportsAPI



**Class** DMSImportsAPI

## Methods
### `public static String upsertAccounts(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** upsertAccounts

### `public static String upsertLocations(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** upsertLocations

### `public static String upsertStandardOpCodes(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** upsertStandardOpCodes

### `public static String upsertVehicleInventory(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** upsertVehicleInventory

### `public static String deleteVehicleInventory(String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** upsertServiceVehicle

### `public static String upsertServiceVehicle(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** upsertServiceVehicle

### `public static String upsertServiceRepairOrders(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** upsertServiceRepairOrders

### `public static String upsertDeals(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** upsertDeals

### `public static String upsertPartsMasters(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** upsertPartsMasters

### `public static String upsertServiceJobLines(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** upsertServiceJobLines

### `public static String upsertSalesFees(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** upsertSalesFees

### `public static String upsertTradeIns(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** upsertTradeIns

### `public static String upsertPartsInventory(String jobId, String objJSON)`
#### Parameters

|Param|Description|
|---|---|
|`jobId`||
|`objJSON`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** upsertPartsInventory

### `public static String routeObject(String type, String objJSON, String jobId)`

Routes Object to correct method

#### Parameters

|Param|Description|
|---|---|
|`type`||
|`objJSON`||
|`jobId`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|

### `public static void cleanAccounts(List<Account> sfAccts, List<Account> dmsAccts)`

compares data from DMS to CRM and removes invalid External Ids from Accounts


**Method** cleanAccounts

### `public static String cleanRecords(String type, String objJSON)`
### `public static void syncAccount(String AccountJSON)`
---
## Classes
### vehicleResult
#### Constructors
##### `public vehicleResult(Map&lt;Id,Vehicle_Inventory__c&gt; Successes, List&lt;String&gt; Errors)`
---
#### Fields

##### `public Successes` → `Map&lt;Id,Vehicle_Inventory__c&gt;`


##### `public Errors` → `List&lt;String&gt;`


---

### result


#### Constructors
##### `public result(List&lt;STring&gt; successes, List&lt;String&gt; errors)`
---
#### Fields

##### `public Successes` → `List&lt;String&gt;`


##### `public Errors` → `List&lt;String&gt;`


---

---
