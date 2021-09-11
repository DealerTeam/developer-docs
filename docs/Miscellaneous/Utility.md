# Utility class

 Date            |Developer            |Work# Notes 13/01/17           Sneha Utture         ||W-000897 Added trigger handler Interface method and migrated AccountControl trigger on Account and ContactControl trigger on Contact

---
## Methods
### `DMSConfiguration(String featureName)` → `String`

retrieves the string value of a DMS Configuration metadata if it is enabled.

#### Parameters
|Param|Description|
|-----|-----------|
|`featureName` |  name of the custom metadata Record |

#### Return

**Type**

String

**Description**

String value of the configuration file.

### `emailAsyncHandler(String payload)` → `void`

retrieves middleware endpoint

#### Parameters
|Param|Description|
|-----|-----------|
|`featureName` |  DMS Config record to retrieve |
|`` | d |

#### Return

**Type**

void

**Description**

return description

### `getDMSSettings()` → `dealer__DMS_Settings__c`

 getDMSSettings

#### Return

**Type**

dealer__DMS_Settings__c

**Description**

default dms settings (Custom Setting)

### `isDMSFeatureEnabled(String featureName)` → `boolean`

 isDMSFeatureEnabled

### `nextDealNumber()` → `Integer`

 Get the Dealership Location of Running User

#### Return

**Type**

Integer

**Description**

Integer

### `queryAllFields(String objectName, String objectId)` → `Sobject`

 classAccess : Determine if a user has access to a named Class

#### Parameters
|Param|Description|
|-----|-----------|
|`String` |  Name of the Class to search if access exists for |
|`String` |  Name of the page to search if access exists for |
|`s` |  [String] |

#### Return

**Type**

Sobject

**Description**

[boolean]

### `queryAllFields(String objectName, List<String> objectIdList)` → `List<Sobject>`

Performs a faster query by requiring less processing of data

#### Parameters
|Param|Description|
|-----|-----------|
|`recordId` |  recordId description |

#### Return

**Type**

List&lt;Sobject&gt;

**Description**

return description

---
## Inner Classes

### Utility.UtilityException class

This class provides data objects for formula render /** Wrapper class used to return record type info used by combo box options

---
