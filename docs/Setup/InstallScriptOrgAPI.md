# InstallScriptOrgAPI

`APIVERSION: 45`

`STATUS: ACTIVE`

Performs post install functions to setup the instance


**Test** TestInstallScript


**Group** Setup

## Methods
### `static createDmsSetting()`
### `static createVdcSetting()`

`DEPRECATED`
### `static updateVDCActiveFlag()`

`DEPRECATED`
### `static createCrmSetting()`
### `static setupPaymentMethods()`
### `static onUpgradeSettingUpdate()`
### `static onUpgradeDataUpdate()`
### `static createDefaultLocation()`
### `static createFixedOperationOrgDefaults()`
### `static createDefaultCashFinanceCompany()`
### `static createDefaultPriceStrategy()`
### `static createDefaultFinanceCompany()`
### `static createDeafultPaymentMethodGroup()`

createDeafultPaymentMethodGroup is used to populate a Default Payment Method Group for Location based cashiering.

### `erpSetupTableImport()`

`DEPRECATED`
### `static erpSetupTableSync(String tableName)`

Performs call outs to the Accounting Setup Tables and syncs them to the Local sObjects

#### Parameters

|Param|Description|
|---|---|
|`String`|Setup Name.  Note, this is a specific String Match|

---
