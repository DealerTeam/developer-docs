# Utility

`APIVERSION: 45`

`STATUS: ACTIVE`
## Fields

### `isAdmin` → `Boolean`


This method determins if the running user is a System Administrator

### `locationMapById` → `Map<Id,Dealer_Location__c>`


### `locationMapbyNumber` → `Map<String,Dealer_Location__c>`


### `locationMapbyUser` → `Map<Id,Dealer_Location__c>`


Instance map to hold dealer locations by User Id

### `userMapById` → `Map<Id,User>`


---
## Methods
### `static getInstance()`

getInstance handles returning the running instance of Utility, will create if one doesn't exist. Only way to create an instance of Utility

#### Return

**Type**

Utility

**Description**

return description

### `static isContactInfoChanged(Contact newContact, Contact oldContact)`
### `static isAccountInfoChanged(Account newAccount, Account oldAccount)`
### `static isSUContactInfoDifferent(dealer__Sales_Up__c s, Contact c)`
### `static isSUAccountInfoDifferent(dealer__Sales_Up__c s, Account a)`
### `static isValidId(String idString)`
### `static isGreaterThanZero(Decimal val)`
### `static eval(String evalString, sObject obj)`
### `static getSobjectValue(sObject obj, string fieldName)`
### `static stringToDateTime(String datestring)`
### `static stringToDate(String datestring)`
### `static applicableLocations()`
### `static GetKeyPrefix(String ObjId)`
### `static classAccess(String className)`

classAccess : Determine if a user has access to a named Class

#### Parameters

|Param|Description|
|---|---|
|`String`|Name of the Class to search if access exists for|

#### Return

**Type**

Boolean

**Description**

Boolean


**Notes** Used to determine if a user has access to a resource.  Prodimately used to render buttons on visualforce pages.

### `static pageAccess(String pageName)`

pageAccess : Determine if a user has access to a named visualforce page

#### Parameters

|Param|Description|
|---|---|
|`String`|Name of the page to search if access exists for|

#### Return

**Type**

Boolean

**Description**

Boolean


**Notes** Used to determine if a user has access to a resource.  Prodimately used to render buttons on visualforce pages.  This is first released on v. 1.572

### `static findContactId(String objectName, Id objectRecordId)`
### `static formatPhoneTen(String p)`
### `static emailValid(String email)`
### `static timeDistance_Minutes(Long s, Long e)`
### `static personsAccountsEnabled()`
### `static lookupParentAccount(String pid)`
### `static isBlank(String s)`

Check if a string is blank

#### Parameters

|Param|Description|
|---|---|
|`s`|String|

#### Return

**Type**

Boolean

**Description**

boolean

### `static queryAllFields(String objectName, String objectId)`
### `static queryAllAccessible(Id recordId)`

Performs a faster query by requiring less processing of data

#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|

#### Return

**Type**

SObject

**Description**

return description


**Method** queryAllAccessible

### `static queryAllAccessible(Set<Id> recordIds, Boolean securityEnforced)`

Performs a faster query by requiring less processing of data

#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|

#### Return

**Type**

List&lt;SObject&gt;

**Description**

return description


**Method** queryAllAccessible

### `static queryAllAccessible(Set<Id> recordIds, Set<String> additionalFields, Boolean securityEnforced)`

Performs a faster query by requiring less processing of data

#### Parameters

|Param|Description|
|---|---|
|`recordIds`|- Set of ids to return all field data for|
|`additionalFields`|-  additional record fields to include in query such as relationship fields|
|`securityEnforced`|- controls whether the database query enforces FLS or runs in system context|

#### Return

**Type**

List&lt;SObject&gt;

**Description**

return description


**Method** queryAllAccessible

### `static queryAllAccessibleRelated(String parentObject, Set<String> additionalFields, String childObject, Set<Id> parentIds, Boolean securityEnforced)`

Performs a faster query by requiring less processing of data

#### Parameters

|Param|Description|
|---|---|
|`recordIds`|- Set of ids to return all field data for|
|`additionalFields`|-  additional record fields to include in query such as relationship fields|
|`securityEnforced`|- controls whether the database query enforces FLS or runs in system context|
|`childObject`|- child object in SOQL query WHERE Clause. Example: ... WHERE *Deal__c* IN ...|
|`parentIds`|- Ids|

#### Return

**Type**

List&lt;SObject&gt;

**Description**

return description


**Method** queryAllAccessibleRelated

### `static queryAllFields(String objectName, List<String> objectIdList)`
### `static getFormattedDateOrTime(String dt)`

pass in 'date' or 'time' or to get formatted date or time in user's current timezone.

#### Parameters

|Param|Description|
|---|---|
|`dt`|Only accepts 'date' or 'time'|

#### Return

**Type**

String

**Description**

date or time in the YYYY-MM-DD / 24h formats.

### `static writesObjectJSON(ObjectWrapper objW, SObjectType objectType, Map<String,String> fieldValueMap)`
### `static updateRelatedObjects(sObject obj)`
### `refreshLocationMap()`

used for cases when location maps are stale, primarily used in test classes


**Method** refreshLocationMap

### `lookupUserLocation()`
#### Return

**Type**

Dealer_Location__c

**Description**

Dealership Location Id


**Method** Get the Dealership Location of Running User

### `userLocation(Id userId)`

Obtain Dealereship Location by User Division

### `getLocation(Id locId)`

returns a location record matching the given id, used to ensure location query only runs once on transactions

#### Parameters

|Param|Description|
|---|---|
|`locId`|locId description|

#### Return

**Type**

Dealer_Location__c

**Description**

return description


**Method** getLocation

### `getUser(Id userId)`
### `getUserMap(Set<Id> userIds)`

returns the userId map for the running utility instance

#### Parameters

|Param|Description|
|---|---|
|`userIds`|- set of Ids to retrieve user objects for|

#### Return

**Type**

Map&lt;Id,User&gt;

**Description**

userMapById - instance var, map of users in memory for current utility instance

### `getLocationByNumber(String companyNumber)`

returns a location record matching the given company number, used to ensure location query only runs once on transactions

#### Parameters

|Param|Description|
|---|---|
|`companyNumber`|companyNumber description|

#### Return

**Type**

Dealer_Location__c

**Description**

return description


**Method** getLocationByNumber

### `static Modulus(Decimal dec)`

Apex does not have a Modulus(decimal) method, so we create one.

#### Return

**Type**

Integer

**Description**

Integer

### `static daysBetweenDatetime(DateTime firstDate, DateTime secondDate)`

Returns the days between two datetime objects. Expects two datetime arguments

#### Return

**Type**

decimal

**Description**

Decimal with Modulus ( 1.5  = 1 day 12 hours).

### `static protectedStatusCodes(String objectName)`

protectedStatusCodes - returns a list of strings reprsenting status codes protected for the object requested

### `static methodOverride(String className, String methodName)`
### `static nextDealNumber()`
#### Return

**Type**

Integer

**Description**

Integer


**Method** nextDealNumber


**Notes** Issue Deal Number from the DMS Settings (Protected Setting)

### `static generateGuid()`
### `static UpdateAccountSalesUp(Map<Id,Account> newAccountMap, Map<Id,Account> oldAccountMap)`
### `static UpdateContactSalesUp(Map<Id,Contact> newContactMap, Map<Id,Contact> oldContactMap)`
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

### `static MiddleWareEndpoint()`

`AURAENABLED`

retrieves middleware endpoint

#### Return

**Type**

string

**Description**

return description

### `static isSandbox()`

isSandbox returns boolean if org is a sandbox

### `static sendEmail(String emailAddress, String message)`
### `static emailAsyncHandler(String payload)`
#### Parameters

|Param|Description|
|---|---|
|`payload`||


**Method** emailAsyncHandler

### `static getEarliestDate(List<Date> dates)`
### `static getLatestDate(List<Date> dates)`
### `static generateDoc(String fileName, String bodyString)`
### `static sObjectRelatedListComponent(String objectName)`
### `static getRecordType(Id acctId)`

`AURAENABLED`

Handles returning the recordType info of provided accountId

#### Parameters

|Param|Description|
|---|---|
|`Id`|- AccountId to query recordType info|

#### Return

**Type**

Account

**Description**

s Account - Account object with the recordTypeId and recordType.Name used by the LWC accountConvert


**Test** UtilityUILayer.testConvertToPersonAccount

### `static getRecordSelect(Boolean b2b)`

`AURAENABLED`

Handles returning all available record types available to convert to

#### Parameters

|Param|Description|
|---|---|
|`Boolean`|= Opposite of isPersonType used to filter records|

#### Return

**Type**

List&lt;Selection&gt;

**Description**

List&lt;Selection&gt; - List of record type Ids and Names for combo box drop down list


**Test** UtilityUILayer.testConvertToPersonAccount

### `static validSearchTerm(String searchStr)`
### `static convertToPersonAccount(Account acct, String First, String Last, String RTId)`

`AURAENABLED`

Called by LWC AccountConvert to convert person account to business account

#### Parameters

|Param|Description|
|---|---|
|`Account`|- Account to be converted|
|`String`|- First Name to be used for person account|
|`String`|- Last Name to be used for person account|
|`String`|- The recordTypeId the account will be updated with|


**Test** UtilityUILayer.testConvertToPersonAccount

### `static convertToBusinessAccount(Account acct, String Name, String RTId)`

`AURAENABLED`

Called by LWC AccountConvert to convert person account to business account

#### Parameters

|Param|Description|
|---|---|
|`Account`|- Account to be converted|
|`String`|- Name to be used for business account|
|`String`|- The recordTypeId the account will be updated with|


**Test** UtilityUILayer.testConvertToPersonAccount

### `static isManaged()`

isManaged used to verify if code is running inside a package, code in scratch orgs will return false

#### Return

**Type**

boolean

**Description**

true indicates code is running inside dealer namespace, false means it is not, for example in scratch orgs

### `static getPackageVersion()`

returns the current version of Dealerteam running in an Org

#### Return

**Type**

String

**Description**

return description


**Method** getPackageVersion

### `static getObjectKeyPrefix(String objName)`

getObjectKeyPrefix provides the 3-digit prefix of an object when provided the api name

#### Parameters

|Param|Description|
|---|---|
|`objName`|String Object API name|

#### Return

**Type**

String

**Description**

return String Object Key Prefix

### `static hasCustomPermission(String permName)`

hasCustomPermission

#### Parameters

|Param|Description|
|---|---|
|`permName`|Api Name of the permission|

#### Return

**Type**

Boolean

**Description**

boolean true if permission is enabled else false


**Notes** Checks whether a custom permission is enabled

### `static evaluateFormula(String formula)`
### `static getUserRecord()`

`AURAENABLED`
### `static getRelatedContacts(Id acctId)`

`AURAENABLED`

Returns related contactIds from an account Id

#### Parameters

|Param|Description|
|---|---|
|`AcctId`|AcctId description|

#### Return

**Type**

List&lt;String&gt;

**Description**

return description


**Method** getRelatedContact

### `static getDensity(Id userId)`
### `static containsAny(Set<String> setToCheck, Set<String> values)`

Checks for any matching values between two sets, can use to evaluate multiselect picklists

#### Parameters

|Param|Description|
|---|---|
|`setToCheck`|setToCheck description|
|`values`|values description|

#### Return

**Type**

Boolean

**Description**

return description


**Method** containsAny

### `static getFieldSets(SObject sObj)`

object agnostic method to returns all fieldsets and their fieldinfos

#### Parameters

|Param|Description|
|---|---|
|`sObj`|object record to get field sets for|

#### Return

**Type**

Map&lt;String,List&lt;fieldSetWrapper&gt;&gt;

**Description**

fieldSetMap map of field sets


**Method** getFieldSets

---
## Classes
### Attributes
#### Properties

##### `type` → `String`


---

### FormulaRender

This class provides data objects for formula render

#### Properties

##### `status` → `string`


##### `value` → `string`


---

### ObjectWrapper
#### Properties

##### `attributes` → `Attributes`


---

### Selection

Wrapper class used to return record type info used by combo box options

#### Constructors
##### `Selection(String RTName, Id RTI, String RTDesc)`
---
#### Properties

##### `label` → `String`

`AURAENABLED` 

##### `value` → `String`

`AURAENABLED` 

---

### UserInformation
#### Constructors
##### `UserInformation()`
---
#### Fields

##### `assignedLocation` → `Dealer_Location__c`

`AURAENABLED` 

##### `user` → `User`

`AURAENABLED` 

---

### UtilityException

**Inheritance**

UtilityException


### fieldSetWrapper
#### Fields

##### `fieldName` → `String`

`AURAENABLED` 

##### `label` → `String`

`AURAENABLED` 

##### `required` → `Boolean`

`AURAENABLED` 

##### `type` → `String`

`AURAENABLED` 

---

---
