# UserLocationAPI

`APIVERSION: 52`

`STATUS: ACTIVE`

Transports for User records with their associated ERPUserSetting custom settings.


**Group** Accounting

## Constructors
### `UserLocationAPI(List<User> users)`
---
## Fields

### `erpSettingsMap` → `Map<Id,ERPUserSetting__c>`


### `locations` → `Map<Id,Dealer_Location__c>`


---
## Methods
### `static getLegalOrganization(String legalOrgNumber)`
### `static updateERPUserSettingsByLocationUser(Map<Id,Dealer_Location_User__c> locationUserMap)`

updates ERP Settings from Dealer Location User records where CurrentlySelected__c = true.

#### Parameters

|Param|Description|
|---|---|
|`locationUsers`||

### `static updateUsers(String userJSON)`

`FUTURE`
### `handleUserERPEvent()`

If the ERP Setting or Accounting API key for a specified user is missing this method will generate and store the ERP record to DMS.

### `static updateUserSettingsByLocationId(Map<Id,List<User>> locationUserMap)`

updates users' ERP settings to match a Location Record and its affiliated Legal Organization

#### Parameters

|Param|Description|
|---|---|
|`Map`|<Id, List<User>> List of Users by Location ID|

#### Return

**Type**

List&lt;ERPUserSetting__c&gt;

**Description**

List of ERP User Setting

### `static userLocation(Id userId)`
### `static userDivisionMap(List<User> users)`

Returns User's Divisions from theri stored ERPUserSetting custom Setting. This method returns cached data without querying the Dealer LOcation Record

#### Return

**Type**

Map&lt;Id,Dealer_Location__c&gt;

**Description**

Map&lt;Id, Dealer_Location__c&gt;

### `static userLocationFromDisc(Id userId)`
### `static userDivisionMapFromDisc(List<User> users)`

Returns User's Divisions from theri stored ERPUserSetting custom Setting. This method will query for the newest version of the Dealer Location record. Dealer Location query can be added to.

#### Return

**Type**

Map&lt;Id,Dealer_Location__c&gt;

**Description**

Map&lt;Id, Dealer_Location__c&gt;

### `static getERPSettings(List<User> users)`

returns erp settings for a list of Users

#### Return

**Type**

Map&lt;Id,ERPUserSetting__c&gt;

**Description**

Map&lt;Id,ERPUserSettings__c&gt;

### `static instantiateERPSetting(User u)`

instantiates a new ERP setting record for a User

---
