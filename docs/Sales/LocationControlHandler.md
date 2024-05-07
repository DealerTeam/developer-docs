---
layout: default
---
# LocationControlHandler

Handler for LocationControl trigger


**Class** LocationControlHandler


**Group** Sales


**Security** RunAs System given the class is only executed via trigger, therefore system mode and sharing are implied.

## Constructors
### `public LocationControlHandler()`

LocationControlHandler constructor ensures this class is only used in a trigger context

#### Throws

|Exception|Description|
|---|---|
|`DealerteamException`||

---
## Methods
### `public void handleAccounts(List<Dealer_Location__c> locationList)`

handleAccounts creates or updates accounts based on the location company number

#### Parameters

|Param|Description|
|---|---|
|`locationList`|- A list of List<Dealer_Location__c> records|

#### Returns

|Type|Description|
|---|---|
|`void`|void|

### `private Map<String,Account> searchExistingAccounts(List<Dealer_Location__c> locationList)`

searchExistingAccounts looks up existing accounts based on the External ID from the location record

#### Parameters

|Param|Description|
|---|---|
|`externalIds`|Set of Strings that represent the External ID of the location record|

#### Returns

|Type|Description|
|---|---|
|`Map<String,Account>`|Map with the key of String and value of Account|

### `private List<Account> accountsToInsert(List<Dealer_Location__c> locationList, Map<String,Account> existingAccounts)`

accountsToInsert iterates the existing accounts and determines if we need to insert a new account sobject

#### Parameters

|Param|Description|
|---|---|
|`locationList`|List of Dealership Locations|
|`existingAccounts`|Map of existing accounts that may or may not be associated with this location|

#### Returns

|Type|Description|
|---|---|
|`List<Account>`|List of Accounts to insert|

### `private Account locationToAccountMap(Dealer_Location__c loc)`

locationToAccountMap creates an Account record based on a Location Record

#### Parameters

|Param|Description|
|---|---|
|`loc`|Location record to map the account to|

#### Returns

|Type|Description|
|---|---|
|`Account`|Account record|

### `public void handleLogo(List<Dealer_Location__c> locationList)`

handleLogo - This method ensures that the logo name is set to a valid value upon insert or update of the location record

#### Parameters

|Param|Description|
|---|---|
|`locationList`|- List<Dealer_Location__c> List of trigger modified records.|

#### Returns

|Type|Description|
|---|---|
|`void`|void|

### `public void ERPInsert(Dealer_Location__c loc)`

Inserts an Dealer Location as a Store in DMS using the DMS Data API

#### Parameters

|Param|Description|
|---|---|
|`loc`|- Dealer_Location__c record|

### `public void ERPUpdate(Dealer_Location__c loc)`

Updates an Dealer Location using the DMS Data API

#### Parameters

|Param|Description|
|---|---|
|`accountId`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|

### `public void setDefaultPaymentMethod(List<Dealer_Location__c> locationList)`

setDefaultPaymentMethod associates the default Payment Group in this org with this Location.

#### Parameters

|Param|Description|
|---|---|
|`locationList`|List<Dealer_Location__c> List of trigger modified records.|

#### Returns

|Type|Description|
|---|---|
|`void`|void|

### `public void validateCache(List<Dealer_Location__c> triggerNew, Map<Id,Dealer_Location__c> oldMap)`

validateCache ensures cached record collection stays in sync with records updates

#### Parameters

|Param|Description|
|---|---|
|`triggerNew`|- incoming records|
|`oldMap`|- old records for update comparison|

#### Returns

|Type|Description|
|---|---|
|`void`|void|

---
