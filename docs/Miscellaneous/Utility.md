---
layout: default
---
# Utility class

 Date            |Developer            |Work# Notes 13/01/17           Sneha Utture         ||W-000897 Added trigger handler Interface method and migrated AccountControl trigger on Account and ContactControl trigger on Contact

---
## Methods
### `DMSConfiguration(String featureName)` → `String`

 DMSConfiguration

### `emailAsyncHandler(String payload)` → `void`

 isSandbox returns boolean if org is a sandbox /** emailAsyncHandler

#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `getDMSSettings()` → `dealer__DMS_Settings__c`

 getDMSSettings

### `isDMSFeatureEnabled(String featureName)` → `boolean`

 isDMSFeatureEnabled

### `nextDealNumber()` → `Integer`

 Updates related fields from an object. Compatibility for field sets on visual force pages. Added to allow saving records from custom related lists added to page. Compatible with all fields, custom or managed(dealer). /** Get the Dealership Location of Running User

### `queryAllFields(String objectName, String objectId)` → `Sobject`

 classAccess : Determine if a user has access to a named Class

#### Parameters
|Param|Description|
|-----|-----------|
|`String` |  Name of the Class to search if access exists for |
|`String` |  Name of the page to search if access exists for |
|`s` |  [String] |

### `queryAllFields(String objectName, List<String> objectIdList)` → `List<Sobject>`
---
## Inner Classes

### Utility.UtilityException class

 emailServiceAddress @return email address @notes determines the email handle for processing the integrated financials requests /** Wrapper class used to return record type info used by combo box options /** Handles returning the recordType info of provided accountId @param {Id} - AccountId to query recordType info @returns {Account} - Account object with the recordTypeId and recordType.Name used by the LWC accountConvert @test UtilityUILayer.testConvertToPersonAccount /** Handles returning all available record types available to convert to @param {Boolean} = Opposite of isPersonType used to filter records @returns {List<Selection>} - List of record type Ids & Names for combo box drop down list @test UtilityUILayer.testConvertToPersonAccount /** Called by LWC AccountConvert to convert person account to business account @param {Account} - Account to be converted @param {String} - First Name to be used for person account @param {String} - Last Name to be used for person account @param {String} - The recordTypeId the account will be updated with @test UtilityUILayer.testConvertToPersonAccount /** Called by LWC AccountConvert to convert person account to business account @param {Account} - Account to be converted @param {String} - Name to be used for business account @param {String} - The recordTypeId the account will be updated with @test UtilityUILayer.testConvertToPersonAccount /** isManaged used to verify if code is running inside a package, code in scratch orgs will return false @return   true indicates code is running inside dealer namespace, false means it is not, for example in scratch orgs /** getObjectKeyPrefix provides the 3-digit prefix of an object when provided the api name @param  objName String Object API name @return         return String Object Key Prefix /** hasCustomPermission @param  permName Api Name of the permission @notes Checks whether a custom permission is enabled @return boolean true if permission is enabled else false

---
