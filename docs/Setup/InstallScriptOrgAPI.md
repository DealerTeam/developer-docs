---
layout: default
---
# InstallScriptOrgAPI

Performs post install functions to setup the instance


**Test** TestInstallScript


**Notes** Many of these methods are Global to allow for execution within the client instance


**Group** Setup

## Methods
### `global static void createDmsSetting()`

createDmsSetting inserts the default CRM settings to the Custom Settings


**Note** These settings are being migrated to the CUSTOM METADATA configurations

### `global static void createVdcSetting()`

`DEPRECATED`
### `global static void updateVDCActiveFlag()`

`DEPRECATED`
### `global static void createCrmSetting()`
### `global static void setupPaymentMethods()`
### `global static void onUpgradeSettingUpdate()`
### `global static void onUpgradeDataUpdate()`
### `global static void createDefaultLocation()`
### `global static void createFixedOperationOrgDefaults()`
### `global static void createDefaultCashFinanceCompany()`
### `global static void createDefaultPriceStrategy()`
### `global static void setUserLocation()`
### `public static void updateDefaultCashieringPage()`

updateDefaultCashieringPage - updates locations that reference a deprecated default managed receipt page to use the new managed page

### `public static void setVehicleCodedCost()`

setVehicleCodedCost - runs an update call on in stock vehicles with a null coded cost to ensure the field is populated

### `public static void clearCache()`

Clear platform cache during upgrade process, mainly to prevent cached queries where newly added fields will not be present

### `global static void createDefaultFinanceCompany()`
### `global static void createDeafultPaymentMethodGroup()`

createDeafultPaymentMethodGroup is used to populate a Default Payment Method Group for Location based cashiering.

### `global void erpSetupTableImport()`

`DEPRECATED`
### `global static void erpSetupTableSync(String tableName)`

Performs call outs to the Accounting Setup Tables and syncs them to the Local sObjects

#### Parameters

|Param|Description|
|---|---|
|`String`|Setup Name.  Note, this is a specific String Match|

### `public static void createDefaultFeeMaster()`
### `private static void sendMethodFailureAlert(String methodName, String exceptionMessage)`

sendMethodFailureAlert sends an email alert when a install script method fails

#### Parameters

|Param|Description|
|---|---|
|`methodName`|- name of method that failed|
|`exceptionMessage`|- exception message|

---
## Classes
### InstallException

**Inheritance**

InstallException


---
