---
layout: default
---
# FeatureManager

FeatureManager abstracts the Feature Parameters found on the LMA Record.  This abstraction
             serves up the feature and allows the feature setting to be overloaded in the event this is
             required.  One example is to overload the DealershipManagementSystemId in Beta packages
             as Beta packages do not create an LMA record.  Without the LMA record there is no FeatureParameterRecord


**Group** Platform


**Test** FeatureManagerTest

## Methods
### `public static Integer clientId()`

This funtion providees the DMS Client ID based on Feature Parameter.  In the event the              feature parameter does not exist, such as in beta testing instances the parater is hard              coded.

#### Returns

|Type|Description|
|---|---|
|`Integer`|Integer|


**Test** FeatureManagerTest.validateClientId

---
