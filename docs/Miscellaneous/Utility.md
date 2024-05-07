---
layout: default
---
# Utility

Utility provides base system functions common to multiple classes


**Test** TestUtility.apex


**Notes** This class specifically uses without sharing to overcome potential access rights when performing tasks the user must complete but only via managed code.          For example, Casheiring a payment when the parent record is locked in an approval process

## Constructors
### `private Utility()`

Private constructor is to prevent instantiating without getInstance method


**Method** Utility

---
## Fields

### `private instance` → `Utility`


instance private variable that holds the current instance of the class

### `public locationMapbyUser` → `Map<Id,Dealer_Location__c>`


Instance map to hold dealer locations by User Id

### `public locationMapbyNumber` → `Map<String,Dealer_Location__c>`


### `public locationMapById` → `Map<Id,Dealer_Location__c>`


### `public userMapById` → `Map<Id,User>`


### `private gd` → `Map<String,Schema.SObjectType>`


### `private keyPrefixMap` → `Map<String,String>`


### `private keyPrefixSet` → `Set<String>`


### `public isAdmin` → `Boolean`


This method determins if the running user is a System Administrator

---
## Methods
### `public static Utility getInstance()`

getInstance handles returning the running instance of Utility, will create if one doesn't exist. Only way to create an instance of Utility

#### Returns

|Type|Description|
|---|---|
|`Utility`|return description|

### `public static boolean isContactInfoChanged(Contact newContact, Contact oldContact)`
### `public static boolean isAccountInfoChanged(Account newAccount, Account oldAccount)`
### `public static dealer__Sales_Up__c isSUContactInfoDifferent(dealer__Sales_Up__c s, Contact c)`
### `public static dealer__Sales_Up__c isSUAccountInfoDifferent(dealer__Sales_Up__c s, Account a)`
### `public static Boolean isValidId(String idString)`
### `public static boolean isGreaterThanZero(Decimal val)`
### `public static Decimal eval(String evalString, sObject obj)`
### `public static Object getSobjectValue(sObject obj, string fieldName)`
### `public static datetime stringToDateTime(String datestring)`
### `public static Date stringToDate(String datestring)`
### `public static Map<Id,Id> applicableLocations()`
### `public static String GetKeyPrefix(String ObjId)`
### `private static void schemaInit()`
### `public static Boolean classAccess(String className)`

classAccess : Determine if a user has access to a named Class

#### Parameters

|Param|Description|
|---|---|
|`String`|Name of the Class to search if access exists for|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|


**Notes** Used to determine if a user has access to a resource.  Prodimately used to render buttons on visualforce pages.

### `public static Boolean pageAccess(String pageName)`

pageAccess : Determine if a user has access to a named visualforce page

#### Parameters

|Param|Description|
|---|---|
|`String`|Name of the page to search if access exists for|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|


**Notes** Used to determine if a user has access to a resource.  Prodimately used to render buttons on visualforce pages.  This is first released on v. 1.572

### `public static Id findContactId(String objectName, Id objectRecordId)`
### `public static String formatPhoneTen(String p)`
### `public static String stripPhoneFormat(String p)`

Removes non-digits from provided string unless string begins with '+', following Salesforce guidelines

#### Parameters

|Param|Description|
|---|---|
|`p`|Phone number to remove special characters|

#### Returns

|Type|Description|
|---|---|
|`String`|return description|

### `public static boolean emailValid(String email)`
### `public static Integer timeDistance_Minutes(Long s, Long e)`
### `public static Boolean personsAccountsEnabled()`
### `public static Id lookupParentAccount(String pid)`
### `public static Boolean isBlank(String s)`

Check if a string is blank

#### Parameters

|Param|Description|
|---|---|
|`s`|String|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|boolean|

### `global static Sobject queryAllFields(String objectName, String objectId)`
### `public static SObject queryAllAccessible(Id recordId)`

Performs a faster query by requiring less processing of data

#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|

#### Returns

|Type|Description|
|---|---|
|`SObject`|return description|


**Method** queryAllAccessible

### `public static List<SObject> queryAllAccessible(Set<Id> recordIds, Boolean securityEnforced)`

Performs a faster query by requiring less processing of data

#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|

#### Returns

|Type|Description|
|---|---|
|`List<SObject>`|return description|


**Method** queryAllAccessible

### `public static List<SObject> queryAllAccessible(Set<Id> recordIds, Set<String> additionalFields, Boolean securityEnforced)`

Performs a faster query by requiring less processing of data

#### Parameters

|Param|Description|
|---|---|
|`recordIds`|- Set of ids to return all field data for|
|`additionalFields`|-  additional record fields to include in query such as relationship fields|
|`securityEnforced`|- controls whether the database query enforces FLS or runs in system context|

#### Returns

|Type|Description|
|---|---|
|`List<SObject>`|return description|


**Method** queryAllAccessible

### `public static List<SObject> queryAllAccessibleRelated(String parentObject, Set<String> additionalFields, String childObject, Set<Id> parentIds, Boolean securityEnforced)`

Performs a faster query by requiring less processing of data

#### Parameters

|Param|Description|
|---|---|
|`recordIds`|- Set of ids to return all field data for|
|`additionalFields`|-  additional record fields to include in query such as relationship fields|
|`securityEnforced`|- controls whether the database query enforces FLS or runs in system context|
|`childObject`|- child object in SOQL query WHERE Clause. Example: ... WHERE *Deal__c* IN ...|
|`parentIds`|- Ids|

#### Returns

|Type|Description|
|---|---|
|`List<SObject>`|return description|


**Method** queryAllAccessibleRelated

### `global static List<Sobject> queryAllFields(String objectName, List<String> objectIdList)`
### `public static String getFormattedDateOrTime(String dt)`

pass in 'date' or 'time' or to get formatted date or time in user's current timezone.

#### Parameters

|Param|Description|
|---|---|
|`dt`|Only accepts 'date' or 'time'|

#### Returns

|Type|Description|
|---|---|
|`String`|date or time in the YYYY-MM-DD / 24h formats.|

### `public static String writesObjectJSON(ObjectWrapper objW, SObjectType objectType, Map<String,String> fieldValueMap)`
### `public static void updateRelatedObjects(sObject obj)`
### `private void buildLocationMaps()`

populates the locationMapByNumber variable


**Method** buildLocationMaps

### `public void refreshLocationMap()`

used for cases when location maps are stale, primarily used in test classes


**Method** refreshLocationMap

### `public Dealer_Location__c lookupUserLocation()`
#### Returns

|Type|Description|
|---|---|
|`Dealer_Location__c`|Dealership Location Id|


**Method** Get the Dealership Location of Running User

### `public Dealer_Location__c userLocation(Id userId)`

Obtain Dealereship Location by User Division

### `public Dealer_Location__c getLocation(Id locId)`

returns a location record matching the given id, used to ensure location query only runs once on transactions

#### Parameters

|Param|Description|
|---|---|
|`locId`|locId description|

#### Returns

|Type|Description|
|---|---|
|`Dealer_Location__c`|return description|


**Method** getLocation

### `public User getUser(Id userId)`
### `public Map<Id,User> getUserMap(Set<Id> userIds)`

returns the userId map for the running utility instance

#### Parameters

|Param|Description|
|---|---|
|`userIds`|- set of Ids to retrieve user objects for|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,User>`|userMapById - instance var, map of users in memory for current utility instance|

### `public Dealer_Location__c getLocationByNumber(String companyNumber)`

returns a location record matching the given company number, used to ensure location query only runs once on transactions

#### Parameters

|Param|Description|
|---|---|
|`companyNumber`|companyNumber description|

#### Returns

|Type|Description|
|---|---|
|`Dealer_Location__c`|return description|


**Method** getLocationByNumber

### `public static Integer Modulus(Decimal dec)`

Apex does not have a Modulus(decimal) method, so we create one.

#### Returns

|Type|Description|
|---|---|
|`Integer`|Integer|

### `public static decimal daysBetweenDatetime(DateTime firstDate, DateTime secondDate)`

Returns the days between two datetime objects. Expects two datetime arguments

#### Returns

|Type|Description|
|---|---|
|`decimal`|Decimal with Modulus ( 1.5  = 1 day 12 hours).|

### `public static Set<String> protectedStatusCodes(String objectName)`

protectedStatusCodes - returns a list of strings reprsenting status codes protected for the object requested

### `public static DealerMethodOverride__mdt methodOverride(String className, String methodName)`
### `global static Integer nextDealNumber()`
#### Returns

|Type|Description|
|---|---|
|`Integer`|Integer|


**Method** nextDealNumber


**Notes** Issue Deal Number from the DMS Settings (Protected Setting)

### `public static String generateGuid()`
### `private static Integer convertHexToInt(String hex)`
### `private static String convertIntToHex(Integer intval)`
### `public static void UpdateAccountSalesUp(Map<Id,Account> newAccountMap, Map<Id,Account> oldAccountMap)`
### `public static void UpdateContactSalesUp(Map<Id,Contact> newContactMap, Map<Id,Contact> oldContactMap)`
### `global static dealer__DMS_Settings__c getDMSSettings()`
#### Returns

|Type|Description|
|---|---|
|`dealer__DMS_Settings__c`|default dms settings (Custom Setting)|


**Method** getDMSSettings


**Notes** Used to retrieve the active default dms settings

### `global static boolean isDMSFeatureEnabled(String featureName)`

**Method** isDMSFeatureEnabled

### `global static String DMSConfiguration(String featureName)`

retrieves the string value of a DMS Configuration metadata if it is enabled.

#### Parameters

|Param|Description|
|---|---|
|`featureName`|name of the custom metadata Record|

#### Returns

|Type|Description|
|---|---|
|`String`|String value of the configuration file.|


**Method** DMSConfiguration

### `public static string MiddleWareEndpoint()`

`AURAENABLED`

retrieves middleware endpoint

#### Returns

|Type|Description|
|---|---|
|`string`|return description|

### `public static Boolean isSandbox()`

isSandbox returns boolean if org is a sandbox

### `public static Boolean isScratchOrg()`

isScratchOrg Query organization information to determine if running in a scratch org

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return Boolean|

### `public static void sendEmail(String emailAddress, String subject, String message)`

Sends email

#### Parameters

|Param|Description|
|---|---|
|`emailAddress`|emailAddress description|
|`subject`|subject description|
|`message`|message description|

### `global static void emailAsyncHandler(String payload)`
#### Parameters

|Param|Description|
|---|---|
|`payload`||


**Method** emailAsyncHandler

### `public static Date getEarliestDate(List<Date> dates)`
### `public static Date getLatestDate(List<Date> dates)`
### `private static String emailServiceAddress()`
#### Returns

|Type|Description|
|---|---|
|`String`|email address|


**Method** emailServiceAddress


**Notes** determines the email handle for processing the integrated financials requests

### `public static String generateDoc(String fileName, String bodyString)`
### `public static Component sObjectRelatedListComponent(String objectName)`
### `public static Account getRecordType(Id acctId)`

`AURAENABLED`

Handles returning the recordType info of provided accountId

#### Parameters

|Param|Description|
|---|---|
|`Id`|- AccountId to query recordType info|

#### Returns

|Type|Description|
|---|---|
|`Account`|s Account - Account object with the recordTypeId and recordType.Name used by the LWC accountConvert|


**Test** UtilityUILayer.testConvertToPersonAccount

### `public static List<Selection> getRecordSelect(Boolean b2b)`

`AURAENABLED`

Handles returning all available record types available to convert to

#### Parameters

|Param|Description|
|---|---|
|`Boolean`|= Opposite of isPersonType used to filter records|

#### Returns

|Type|Description|
|---|---|
|`List<Selection>`|List<Selection> - List of record type Ids and Names for combo box drop down list|


**Test** UtilityUILayer.testConvertToPersonAccount

### `public static Boolean validSearchTerm(String searchStr)`
### `public static Boolean convertToPersonAccount(Account acct, String First, String Last, String RTId)`

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

### `public static Boolean convertToBusinessAccount(Account acct, String Name, String RTId)`

`AURAENABLED`

Called by LWC AccountConvert to convert person account to business account

#### Parameters

|Param|Description|
|---|---|
|`Account`|- Account to be converted|
|`String`|- Name to be used for business account|
|`String`|- The recordTypeId the account will be updated with|


**Test** UtilityUILayer.testConvertToPersonAccount

### `public static boolean isManaged()`

isManaged used to verify if code is running inside a package, code in scratch orgs will return false

#### Returns

|Type|Description|
|---|---|
|`boolean`|true indicates code is running inside dealer namespace, false means it is not, for example in scratch orgs|

### `public static String getPackageVersion()`

returns the current version of Dealerteam running in an Org

#### Returns

|Type|Description|
|---|---|
|`String`|return description|


**Method** getPackageVersion

### `public static String getObjectKeyPrefix(String objName)`

getObjectKeyPrefix provides the 3-digit prefix of an object when provided the api name

#### Parameters

|Param|Description|
|---|---|
|`objName`|String Object API name|

#### Returns

|Type|Description|
|---|---|
|`String`|return String Object Key Prefix|

### `public static Boolean hasCustomPermission(String permName)`

hasCustomPermission

#### Parameters

|Param|Description|
|---|---|
|`permName`|Api Name of the permission|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|boolean true if permission is enabled else false|


**Notes** Checks whether a custom permission is enabled

### `public static String evaluateFormula(String formula)`
### `public static UserInformation getUserRecord()`

`AURAENABLED`
### `public static List<String> getRelatedContacts(Id acctId)`

`AURAENABLED`

Returns related contactIds from an account Id

#### Parameters

|Param|Description|
|---|---|
|`AcctId`|AcctId description|

#### Returns

|Type|Description|
|---|---|
|`List<String>`|return description|


**Method** getRelatedContact

### `public static Boolean getDensity(Id userId)`
### `public static Boolean containsAny(Set<String> setToCheck, Set<String> values)`

Checks for any matching values between two sets, can use to evaluate multiselect picklists

#### Parameters

|Param|Description|
|---|---|
|`setToCheck`|setToCheck description|
|`values`|values description|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|


**Method** containsAny

### `public static Object nullReplacer(Object valueToCheck, Object replacementValue)`

Reduces code complexity by replacing if null ternaries with a single method call

#### Parameters

|Param|Description|
|---|---|
|`valueToCheck`|Any object to check for a null value|
|`replacementValue`|This value is returned if the check value is null|

#### Returns

|Type|Description|
|---|---|
|`Object`|return description|

### `public static Map<String,List<fieldSetWrapper>> getFieldSets(SObject sObj)`

object agnostic method to returns all fieldsets and their fieldinfos

#### Parameters

|Param|Description|
|---|---|
|`sObj`|object record to get field sets for|

#### Returns

|Type|Description|
|---|---|
|`Map<String,List<fieldSetWrapper>>`|fieldSetMap map of field sets|


**Method** getFieldSets

### `public DateTime setDatetimeByUserTimezone(Id targetUserId, Datetime dt)`

Helper function that will accept a datetime and target user, if target user's timezone is different than running user it will apply the correct shift to target user's timezone

#### Parameters

|Param|Description|
|---|---|
|`targetUser`|targetUser User with TimeZoneSidKey field|
|`dt`|dt description|

#### Returns

|Type|Description|
|---|---|
|`DateTime`|return description|

### `public static List<String> getPicklistValuesBeforeInput(String maxValue, String objectName, String fieldName)`

Used to return ordered picklist values up to input value provided

#### Parameters

|Param|Description|
|---|---|
|`maxValue`|maxValue description|

#### Returns

|Type|Description|
|---|---|
|`List<String>`|return description|

---
## Classes
### ObjectWrapper
#### Properties

##### `public attributes` → `Attributes`


---

### Attributes
#### Properties

##### `public type` → `String`


---

### isSandboxCache

**Implemented types**

[Cache.CacheBuilder](Cache.CacheBuilder)

#### Methods
##### `public Object doLoad(String key)`
---

### fieldSetWrapper
#### Fields

##### `public fieldName` → `String`

`AURAENABLED` 

##### `public required` → `Boolean`

`AURAENABLED` 

##### `public label` → `String`

`AURAENABLED` 

##### `public type` → `String`

`AURAENABLED` 

---

### FormulaRender

This class provides data objects for formula render

#### Properties

##### `public status` → `string`


##### `public value` → `string`


---

### Selection

Wrapper class used to return record type info used by combo box options

#### Constructors
##### `public Selection(String RTName, Id RTI, String RTDesc)`
---
#### Properties

##### `public label` → `String`

`AURAENABLED` 

##### `public value` → `String`

`AURAENABLED` 

---

### UserInformation
#### Constructors
##### `public UserInformation()`
---
#### Fields

##### `public user` → `User`

`AURAENABLED` 

##### `public assignedLocation` → `Dealer_Location__c`

`AURAENABLED` 

---

### UtilityException

**Inheritance**

UtilityException


---
