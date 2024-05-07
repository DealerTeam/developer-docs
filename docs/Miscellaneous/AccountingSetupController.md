---
layout: default
---
# AccountingSetupController
## Constructors
### `public AccountingSetupController()`
---
## Methods
### `public static void runDealSaleAccountScript()`

`AURAENABLED`

runs deal sale account scripts

### `public static void runPartsSourceScript()`

`AURAENABLED`

Runs part source scripts

### `public static void runChartOfAccountScript()`

`AURAENABLED`

runs Chart of Accounts scripts

### `public static void runMiscChargeSetup()`

`AURAENABLED`

runs Misc Charge Accounts scripts

### `public static void createDatabase(String action, Map<String,String> args)`

`AURAENABLED`
### `public static void installChartOfAccounts(Map<String,String> args)`

`AURAENABLED`
### `public static ComponentWrapper getComponentWrapper()`

`AURAENABLED`

builds the component wrapper, this method is cacheable.

#### Returns

|Type|Description|
|---|---|
|`ComponentWrapper`|ComponentWrapper class|

---
## Classes
### ComponentWrapper
#### Constructors
##### `public ComponentWrapper()`
---
#### Fields

##### `public locations` → `List&lt;Dealer_Location__c&gt;`

`AURAENABLED` 

##### `public legalOrganizations` → `List&lt;LegalOrganization__c&gt;`

`AURAENABLED` 

##### `public erpSettings` → `List&lt;Object&gt;`

`AURAENABLED` 

##### `public erpUserSettingStep` → `MainStep`

`AURAENABLED` 

##### `public connectDatabaseStep` → `MainStep`

`AURAENABLED` 

---
#### Methods
##### `private MainStep erpUserSettingStep()`

generates ERP User setting steps

###### Returns

|Type|Description|
|---|---|
|`MainStep`|return MainStep|

##### `private MainStep connectDatabaseStep()`

generates Connect Database steps

###### Returns

|Type|Description|
|---|---|
|`MainStep`|return MainStep|

##### `private SubStep addUsersStep()`

generates add users step

###### Returns

|Type|Description|
|---|---|
|`SubStep`|return SubStep|

##### `private SubStep addIntegrationUserStep()`

generates add integration user step

###### Returns

|Type|Description|
|---|---|
|`SubStep`|return SubStep|

##### `private SubStep legalOrganizationStep()`

generates Legal Organization step

###### Returns

|Type|Description|
|---|---|
|`SubStep`|return SubStep|

##### `private SubStep storeLocationStep()`

generates Store Location step

###### Returns

|Type|Description|
|---|---|
|`SubStep`|return SubStep|

##### `private SubStep selectedStoreLocationStep()`

generates Selected Store Location step

###### Returns

|Type|Description|
|---|---|
|`SubStep`|return SubStep|

##### `private SubStep erpUserSettingSubStep()`

generates ERP User Setting step

###### Returns

|Type|Description|
|---|---|
|`SubStep`|return SubStep|

##### `private SubStep databaseConnectedStep()`

generates Database Status step

###### Returns

|Type|Description|
|---|---|
|`SubStep`|return SubStep|

##### `private SubStep dealSaleAccountStep()`

generates deal Sale Account step

###### Returns

|Type|Description|
|---|---|
|`SubStep`|return SubStep|

##### `private SubStep partsInventorySourceStep()`

generates Parts Inventory Source step

###### Returns

|Type|Description|
|---|---|
|`SubStep`|return SubStep|

##### `private SubStep chartOfAccountsStep()`

generates Chart of Accounts step

###### Returns

|Type|Description|
|---|---|
|`SubStep`|return SubStep|

##### `private SubStep miscChargeCodeStep()`

generates Misc Charge Code step

###### Returns

|Type|Description|
|---|---|
|`SubStep`|return SubStep|

---

### MainStep
#### Constructors
##### `public MainStep()`
---
#### Fields

##### `public completed` → `boolean`

`AURAENABLED` 

##### `public data` → `List&lt;Object&gt;`

`AURAENABLED` 

##### `public steps` → `List&lt;SubStep&gt;`

`AURAENABLED` 

---

### SubStep
#### Fields

##### `public label` → `String`

`AURAENABLED` 

##### `public completed` → `boolean`

`AURAENABLED` 

##### `public data` → `List&lt;Object&gt;`

`AURAENABLED` 

---

### ERPSetting
#### Constructors
##### `public ERPSetting(User user, ERPUserSetting__c setting, Boolean valid)`
---
#### Fields

##### `public user` → `User`

`AURAENABLED` 

##### `public setting` → `ERPUserSetting__c`

`AURAENABLED` 

##### `public valid` → `Boolean`

`AURAENABLED` 

---

---
