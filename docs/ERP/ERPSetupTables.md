---
layout: default
---
# ERPSetupTables

This class deals with methods to sync tables to local storage in the Lightning Platform


**Group** ERP

## Constructors
### `global ERPSetupTables()`
### `public ERPSetupTables(Boolean instantiateData)`
---
## Fields

### `public chartOfAccountMap` → `Map<String,Map<String,Object>>`


### `public dealSaleAccountMap` → `Map<String,Map<String,Object>>`


---
## Methods
### `global static void dealsaleaccountselect()`

dealsaleaccountselect obtains the select data for populating sale accounts on vehicle inventory


**Author** DealerTeam

### `global static void partsinventorysourcesetup()`

partsinventorysourcesetup table syncronization method.  This method writes the table data to PartSource__c


**Test** 

### `global static void chartOfAccounts()`

chartOfAccounts obtains the COA From Accounting and stores it in a commmon local sObject


**Author** DealerTeam

### `global static void miscChargeCodeSetup()`

Retreives Misc Charge Codes From DSSP


**Author** DealerTeam

### `global Map<String,LegalOrganization__c> getLegalOrgFromRecords(Map<String,Object> erpData)`

getLegalOrgFromRecords iterates a series of records

#### Returns

|Type|Description|
|---|---|
|`Map<String,LegalOrganization__c>`|return Map keyed by String of the Legal Organizations used in the inherited record set|


**Author** DealerTeam

### `public static void checkDatabaseConnection()`

Runs a simple query to the connected database to retrieve connection status.

#### Returns

|Type|Description|
|---|---|
|`void`||

### `public static void createDatabase(CreateDatabaseOption opt, Map<String,String> args)`
### `public static void installChart(Map<String,String> args)`
### `public static void installChartOfAccounts()`
### `private void storeChartOfAccountMap()`

storeChartOfAccountMap obtains chart of accounts and saves it to this classe's public variable chartOfAccountMap

#### Returns

|Type|Description|
|---|---|
|`void`|void|

### `private void storeDealSaleAccounts()`

dealsaleaccountselect  obtains Deal Sale Account Data and saves it to this classe's public variable dealSaleAccountMap

#### Returns

|Type|Description|
|---|---|
|`void`|void|

---
## Enums
### CreateDatabaseOption

---
## Classes
### CreateDatabaseBody
#### Fields

##### `public sourceDb` → `string`


##### `public destDb` → `string`


##### `public template` → `string`


---

---
