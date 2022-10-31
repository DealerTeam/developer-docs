# Utility

`APIVERSION: 45`

`STATUS: ACTIVE`

Date            |Developer            |Work# Notes 13/01/17           Sneha Utture         ||W-000897 Added trigger handler Interface method and migrated AccountControl trigger on Account and ContactControl trigger on Contact

## Methods
### `static queryAllFields(String objectName, String objectId)`
#### Parameters
|Param|Description|
|---|---|

### `static queryAllFields(String objectName, List<String> objectIdList)`
#### Parameters
|Param|Description|
|---|---|

### `static nextDealNumber()`

nextDealNumber

#### Return

**Type**

Integer

**Description**

Integer


**Notes** Issue Deal Number from the DMS Settings (Protected Setting)

### `static getDMSSettings()`

getDMSSettings

#### Return

**Type**

dealer__DMS_Settings__c

**Description**

default dms settings (Custom Setting)


**Notes** Used to retrieve the active default dms settings

### `static isDMSFeatureEnabled(String featureName)`

isDMSFeatureEnabled

#### Parameters
|Param|Description|
|---|---|

### `static DMSConfiguration(String featureName)`

retrieves the string value of a DMS Configuration metadata if it is enabled.

#### Parameters
|Param|Description|
|---|---|
|`featureName`|name of the custom metadata Record|

#### Return

**Type**

String

**Description**

String value of the configuration file. DMSConfiguration

### `static emailAsyncHandler(String payload)`
#### Parameters
|Param|Description|
|---|---|

---
## Classes
### UtilityException

---
