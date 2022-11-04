# Utility

`APIVERSION: 45`

`STATUS: ACTIVE`
## Methods
### `static queryAllFields(String objectName, String objectId)`
### `static queryAllFields(String objectName, List<String> objectIdList)`
### `static nextDealNumber()`
#### Return

**Type**

Integer

**Description**

Integer


**Method** nextDealNumber


**Notes** Issue Deal Number from the DMS Settings (Protected Setting)

### `static getDMSSettings()`
#### Return

**Type**

dealer__DMS_Settings__c

**Description**

default dms settings (Custom Setting)


**Method** getDMSSettings


**Notes** Used to retrieve the active default dms settings

### `static isDMSFeatureEnabled(String featureName)`

**Method** isDMSFeatureEnabled

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

String value of the configuration file.


**Method** DMSConfiguration

### `static emailAsyncHandler(String payload)`
#### Parameters

|Param|Description|
|---|---|
|`payload`||


**Method** emailAsyncHandler

---
## Classes
### UtilityException

**Inheritance**

UtilityException


---
