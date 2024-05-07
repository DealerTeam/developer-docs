---
layout: default
---
# Prospect_Mobile
## Methods
### `public Sales_up__c assignAccountToSup(dealer__Sales_Up__c sup, String actId)`

A method to connect a newly created Account to a Sales Up

#### Parameters

|Param|Description|
|---|---|
|`act`|An Account object|
|`sup`|a Sales_Up__c object|

#### Returns

|Type|Description|
|---|---|
|`Sales_up__c`|boolen true id successful|

### `public actResult accountFromSup(dealer__Sales_Up__c nup, Boolean checkDupli)`

A Method to return the associated Account and Contact of a newly created accout that can be associated with a Sales Up

#### Parameters

|Param|Description|
|---|---|
|`nup`|THe sales up record to create the account from|

#### Returns

|Type|Description|
|---|---|
|`actResult`|Returns Map<String,sObject> with Keys ['a','c'].|

### `public static resultWrap upsertProspect(dealer__Sales_Up__c nup)`

`AURAENABLED`

Upsert a new Sales Up

#### Parameters

|Param|Description|
|---|---|
|`nup`|Sales_Up__c to insert|
|`acct`|Account to associate with Nup|
|`chkAcct`|Boolean a boolean to turn off account duplicate checking|

#### Returns

|Type|Description|
|---|---|
|`resultWrap`|A resultWrap object|

### `public static resultWrap upsertProSkip(dealer__Sales_Up__c nup)`

`AURAENABLED`

Upsert a Sales_Up__c skipping account duplicate checking

#### Parameters

|Param|Description|
|---|---|
|`nup`|Sales_Up__c|

#### Returns

|Type|Description|
|---|---|
|`resultWrap`|resultWrap object|

### `public resultWrap upsertProWOAcct(dealer__Sales_Up__c nup, Boolean skipAcctDupli)`

Upsert a Sales Up without checking for duplicate Accounts

#### Parameters

|Param|Description|
|---|---|
|`nup`|Sales_Up__c|
|`skipAcctDupli`|Boolean|

#### Returns

|Type|Description|
|---|---|
|`resultWrap`|resultWrap Object|

### `public List<sObject> getDuplicateList(Database error)`

Get a list of duplicate sObjects

#### Parameters

|Param|Description|
|---|---|
|`error`|a Database.DuplicateError object|

#### Returns

|Type|Description|
|---|---|
|`List<sObject>`|Returns a lits of sObjects|

### `public static resultWrap upsertUpOverride(dealer__Sales_Up__c nup)`

`AURAENABLED`

Upsert Sales_Up__c and override the duplicate settings.

#### Parameters

|Param|Description|
|---|---|
|`nup`|Sales_Up__c to insert|

#### Returns

|Type|Description|
|---|---|
|`resultWrap`|A resultWrap object|

---
## Classes
### resultWrap

A Wrapper class to send back to the a lightning component.

#### Constructors
##### `public resultWrap(String resultId, List&lt;dealer__Sales_Up__c&gt; dupes, List&lt;Account&gt; aDupes)`
---
#### Properties

##### `public hasDups` → `boolean`

`AURAENABLED` 

##### `public dupeType` → `String`

`AURAENABLED` 

##### `public Id` → `String`

`AURAENABLED` 

##### `public dSups` → `List&lt;dealer__Sales_Up__c&gt;`

`AURAENABLED` 

##### `public dActs` → `List&lt;Account&gt;`

`AURAENABLED` 

---

### actResult

Act Result Class: a wrapper class so we know if account creation has duplicates or not.

#### Constructors
##### `public actResult(resultWrap wrap, Account act)`
---
#### Properties

##### `public hasDupes` → `Boolean`

`AURAENABLED` 

##### `public daWrap` → `resultWrap`

`AURAENABLED` 

##### `public acct` → `Account`

`AURAENABLED` 

---

### prospectException

**Inheritance**

prospectException


---
