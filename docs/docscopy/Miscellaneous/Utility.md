---
layout: default
---
# Utility class

 Date            |Developer            |Work# Notes 13/01/17           Sneha Utture         ||W-000897 Added trigger handler Interface method and migrated AccountControl trigger on Account and ContactControl trigger on Contact

---
## Methods
### `DMSConfiguration(String featureName)` → `String`

 DMSConfiguration

### `GetKeyPrefix(String ObjId)` → `String`
### `Modulus(Decimal dec)` → `Integer`

 Apex does not have a Modulus(decimal) method, so we create one.

### `UpdateAccountSalesUp(Map<Id, Account> newAccountMap, Map<Id, Account> oldAccountMap)` → `void`
### `UpdateContactSalesUp(Map<Id, Contact> newContactMap, Map<Id, Contact> oldContactMap)` → `void`
### `applicableLocations()` → `Id>`
### `classAccess(String className)` → `Boolean`

 classAccess : Determine if a user has access to a named Class

#### Parameters
|Param|Description|
|-----|-----------|
|`String` |  Name of the Class to search if access exists for |

### `convertToBusinessAccount(Account acct, String Name, String RTId)` → `Boolean`

 Called by LWC AccountConvert to convert person account to business account

#### Parameters
|Param|Description|
|-----|-----------|
|`{Account}` |  - Account to be converted |
|`{String}` |  - Name to be used for business account |
|`{String}` |  - The recordTypeId the account will be updated with |

### `convertToPersonAccount(Account acct, String First, String Last, String RTId)` → `Boolean`

 Called by LWC AccountConvert to convert person account to business account

#### Parameters
|Param|Description|
|-----|-----------|
|`{Account}` |  - Account to be converted |
|`{String}` |  - First Name to be used for person account |
|`{String}` |  - Last Name to be used for person account |
|`{String}` |  - The recordTypeId the account will be updated with |

### `daysBetweenDatetime(DateTime firstDate, DateTime secondDate)` → `decimal`

 Returns the days between two datetime objects. Expects two datetime arguments

### `emailAsyncHandler(String payload)` → `void`

 emailAsyncHandler

#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `emailValid(String email)` → `boolean`
### `eval(String evalString, sObject obj)` → `Decimal`
### `evaluateFormula(String formula)` → `String`
### `findContactId(String objectName, Id objectRecordId)` → `Id`
### `formatPhoneTen(String p)` → `String`
### `generateDoc(String fileName, String bodyString)` → `String`

 emailServiceAddress

### `generateGuid()` → `String`
### `getDMSSettings()` → `dealer__DMS_Settings__c`

 getDMSSettings

### `getEarliestDate(List<Date> dates)` → `Date`
### `getLatestDate(List<Date> dates)` → `Date`
### `getObjectKeyPrefix(String objName)` → `String`

 getObjectKeyPrefix provides the 3-digit prefix of an object when provided the api name

#### Parameters
|Param|Description|
|-----|-----------|
|`objName` |  String Object API name |

### `getRecordSelect(Boolean b2b)` → `List<Selection>`

 Handles returning all available record types available to convert to

#### Parameters
|Param|Description|
|-----|-----------|
|`{Boolean}` |  = Opposite of isPersonType used to filter records |

### `getRecordType(Id acctId)` → `Account`

 Handles returning the recordType info of provided accountId

#### Parameters
|Param|Description|
|-----|-----------|
|`{Id}` |  - AccountId to query recordType info |

### `getSobjectValue(sObject obj, string fieldName)` → `Object`
### `hasCustomPermission(String permName)` → `Boolean`

 hasCustomPermission

#### Parameters
|Param|Description|
|-----|-----------|
|`permName` |  Api Name of the permission |

### `isAccountInfoChanged(Account newAccount, Account oldAccount)` → `boolean`
### `isBlank(String s)` → `Boolean`

 Check if a string is blank

#### Parameters
|Param|Description|
|-----|-----------|
|`s` |  [String] |

### `isContactInfoChanged(Contact newContact, Contact oldContact)` → `boolean`
### `isDMSFeatureEnabled(String featureName)` → `boolean`

 isDMSFeatureEnabled

### `isGreaterThanZero(Decimal val)` → `boolean`
### `isManaged()` → `boolean`

 isManaged used to verify if code is running inside a package, code in scratch orgs will return false

### `isSUAccountInfoDifferent(dealer__Sales_Up__c s, Account a)` → `dealer__Sales_Up__c`
### `isSUContactInfoDifferent(dealer__Sales_Up__c s, Contact c)` → `dealer__Sales_Up__c`
### `isSandbox()` → `Boolean`

 isSandbox returns boolean if org is a sandbox

### `isValidId(String idString)` → `Boolean`
### `lookupParentAccount(String pid)` → `Id`
### `lookupUserLocation()` → `Id`

 Get the Dealership Location of Running User

### `methodOverride(String className, String methodName)` → `DealerMethodOverride__mdt`
### `nextDealNumber()` → `Integer`

 nextDealNumber

### `pageAccess(String pageName)` → `Boolean`

 pageAccess : Determine if a user has access to a named visualforce page

#### Parameters
|Param|Description|
|-----|-----------|
|`String` |  Name of the page to search if access exists for |

### `personsAccountsEnabled()` → `Boolean`
### `protectedStatusCodes(String objectName)` → `Set<String>`

 protectedStatusCodes - returns a list of strings reprsenting status codes protected for the object requested

### `queryAllFields(String objectName, String objectId)` → `Sobject`
### `queryAllFields(String objectName, List<String> objectIdList)` → `List<Sobject>`
### `sObjectRelatedListComponent(String objectName)` → `Component.Apex.OutputPanel`
### `stringToDate(String datestring)` → `Date`
### `stringToDateTime(String datestring)` → `datetime`
### `timeDistance_Minutes(Long s, Long e)` → `Integer`
### `updateRelatedObjects(sObject obj)` → `void`

 Updates related fields from an object. Compatibility for field sets on visual force pages. Added to allow saving records from custom related lists added to page. Compatible with all fields, custom or managed(dealer).

### `userLocation(Id userId)` → `Dealer_Location__c`

 Obtain Dealereship Location by User Division

### `validSearchTerm(String searchStr)` → `Boolean`
### `writesObjectJSON(ObjectWrapper objW, SObjectType objectType, Map<String,String> fieldValueMap)` → `String`
---
## Inner Classes

### Utility.Attributes class
---
#### Properties

##### `type` → `String`

---
### Utility.ObjectWrapper class
---
#### Properties

##### `attributes` → `Attributes`

---
### Utility.Selection class

 Wrapper class used to return record type info used by combo box options

---
#### Constructors
##### `Selection(String RTName, Id RTI, String RTDesc)`
---
#### Properties

##### `label` → `String`

##### `value` → `String`

---
### Utility.UtilityException class
---
### Utility.formulaRender class
---
#### Properties

##### `status` → `string`

##### `value` → `string`

---
