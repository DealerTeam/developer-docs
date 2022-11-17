# ERPSetupTables

`APIVERSION: 54`

`STATUS: ACTIVE`

This class deals with methods to sync tables to local storage in the Lightning Platform


**Group** ERP

## Methods
### `static dealsaleaccountselect()`

dealsaleaccountselect obtains the select data for populating sale accounts on vehicle inventory


**Author** DealerTeam

### `static partsinventorysourcesetup()`

partsinventorysourcesetup table syncronization method.  This method writes the table data to PartSource__c


**Test** 

### `static chartOfAccounts()`

chartOfAccounts obtains the COA From Accounting and stores it in a commmon local sObject


**Author** DealerTeam

### `static miscChargeCodeSetup()`

Retreives Misc Charge Codes From DSSP


**Author** DealerTeam

### `getLegalOrgFromRecords(Map<String,Object> erpData)`

getLegalOrgFromRecords iterates a series of records

#### Return

**Type**

Map&lt;String,LegalOrganization__c&gt;

**Description**

return Map keyed by String of the Legal Organizations used in the inherited record set


**Author** DealerTeam

---
