---
layout: default
---
# UserLocationAPI

Transports for User records with their associated ERPUserSetting custom settings.


**Group** Accounting


**Test** UserLocationERPServiceLayer


**Security Review** Ready

## Constructors
### `public UserLocationAPI(List<User> users)`

UserLocationAPI constructor overload - Upon load ERP Settings are obtained for the User records.

#### Parameters

|Param|Description|
|---|---|
|`users`|users description|

---
## Fields

### `private userList` → `List<User>`


### `private erpSettingsMap` → `Map<Id,ERPUserSetting__c>`


---
## Methods
### `public static LegalOrganization__c getLegalOrganization(String legalOrgNumber)`

getLegalOrganization - Retrieves the legal organization record by its entity number.

#### Parameters

|Param|Description|
|---|---|
|`legalOrgNumber`|Entity Numberr of the Legal Organization (External ID)|

#### Returns

|Type|Description|
|---|---|
|`LegalOrganization__c`|LegalOrganization__c based on Entity Number|

### `public static void updateERPUserSettingsByLocationUser(Map<Id,Dealer_Location_User__c> locationUserMap)`

updates ERP Settings from Dealer Location User records where CurrentlySelected__c = true.

#### Parameters

|Param|Description|
|---|---|
|`locationUsers`||

### `public static void updateUsers(String userJSON)`

`FUTURE`
### `public void handleUserERPEvent()`

If the ERP Setting or Accounting API key for a specified user is missing this method will generate and store the ERP record to DMS.

### `private static void upsertErpUserSettingAsync(String settingListJSON)`

`TESTVISIBLE`

`FUTURE`

Asnychronously updates ERP user settings.

### `private static void sync(String globalUserRequestJSON)`

`FUTURE`

sync will commit User Settings to DMS.

### `public static List<ERPUserSetting__c> updateUserSettingsByLocationId(Map<Id,List<User>> locationUserMap)`

updates users' ERP settings to match a Location Record and its affiliated Legal Organization

#### Parameters

|Param|Description|
|---|---|
|`Map`|<Id, List<User>> List of Users by Location ID|

#### Returns

|Type|Description|
|---|---|
|`List<ERPUserSetting__c>`|List of ERP User Setting|

### `private List<GlobalUserRequest> buildGlobalUserRequest(List<User> users)`

buids the GlobalUserRequest list for callout

#### Parameters

|Param|Description|
|---|---|
|`users`|- List of Users to process|

#### Returns

|Type|Description|
|---|---|
|`List<GlobalUserRequest>`|List<GlobalUserRequest> contining the User Request Payload|


**Notes** SOQL uses System Mode as this method may be called from a trigger context or a user that does not have read access to the User object.

### `public static Dealer_Location__c userLocation(Id userId)`
### `public static Map<Id,Dealer_Location__c> userDivisionMap(List<User> users)`

Returns User's Divisions from theri stored ERPUserSetting custom Setting. This method returns cached data without querying the Dealer LOcation Record

#### Returns

|Type|Description|
|---|---|
|`Map<Id,Dealer_Location__c>`|Map<Id, Dealer_Location__c>|

### `public static Dealer_Location__c userLocationFromDisc(Id userId)`
### `public static Map<Id,Dealer_Location__c> userDivisionMapFromDisc(List<User> users)`

Returns User's Divisions from theri stored ERPUserSetting custom Setting. This method will query for the newest version of the Dealer Location record. Dealer Location query can be added to.

#### Returns

|Type|Description|
|---|---|
|`Map<Id,Dealer_Location__c>`|Map<Id, Dealer_Location__c>|

### `private static String createERPAPIToken()`

generates a 128 bit AES key used for Authenticating a user to the DMS API.

### `public static Map<Id,ERPUserSetting__c> getERPSettings(List<User> users)`

returns erp settings for a list of Users

#### Returns

|Type|Description|
|---|---|
|`Map<Id,ERPUserSetting__c>`|Map<Id,ERPUserSettings__c>|

### `public static ERPUserSetting__c instantiateERPSetting(User u)`

instantiates a new ERP setting record for a User

---
## Classes
### GlobalUserRequest

Wrapper to define a user request payload to DMS.

#### Constructors
##### `private GlobalUserRequest(User u, ERPUserSetting__c erpSetting)`
---
#### Properties

##### `private username` → `String`


##### `private employeeNumber` → `String`


##### `private email` → `String`


##### `private division` → `String`


##### `private orgId` → `String`


##### `private storeId` → `String`


##### `private companyId` → `String`


##### `private apiKey` → `String`


##### `private clientId` → `String`


##### `private lastChangedDate` → `String`


##### `private lastChangedTime` → `String`


##### `private lastChangedBy` → `String`


##### `private createdDate` → `String`


##### `private createdBy` → `String`


---

---
