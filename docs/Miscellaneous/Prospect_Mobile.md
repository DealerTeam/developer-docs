# Prospect_Mobile

`APIVERSION: 45`

`STATUS: ACTIVE`
## Methods
### `assignAccountToSup(dealer__Sales_Up__c sup, String actId)`

A method to connect a newly created Account to a Sales Up

#### Parameters

|Param|Description|
|---|---|
|`act`|An Account object|
|`sup`|a Sales_Up__c object|

#### Return

**Type**

Sales_up__c

**Description**

boolen true id successful

### `accountFromSup(dealer__Sales_Up__c nup, Boolean checkDupli)`

A Method to return the associated Account and Contact of a newly created accout that can be associated with a Sales Up

#### Parameters

|Param|Description|
|---|---|
|`nup`|THe sales up record to create the account from|

#### Return

**Type**

actResult

**Description**

Returns Map&lt;String,sObject&gt; with Keys ['a','c'].

### `static upsertProspect(dealer__Sales_Up__c nup)`

`AURAENABLED`

Upsert a new Sales Up

#### Parameters

|Param|Description|
|---|---|
|`nup`|Sales_Up__c to insert|
|`acct`|Account to associate with Nup|
|`chkAcct`|Boolean a boolean to turn off account duplicate checking|

#### Return

**Type**

resultWrap

**Description**

A resultWrap object

### `static upsertProSkip(dealer__Sales_Up__c nup)`

`AURAENABLED`

Upsert a Sales_Up__c skipping account duplicate checking

#### Parameters

|Param|Description|
|---|---|
|`nup`|Sales_Up__c|

#### Return

**Type**

resultWrap

**Description**

resultWrap object

### `upsertProWOAcct(dealer__Sales_Up__c nup, Boolean skipAcctDupli)`

Upsert a Sales Up without checking for duplicate Accounts

#### Parameters

|Param|Description|
|---|---|
|`nup`|Sales_Up__c|
|`skipAcctDupli`|Boolean|

#### Return

**Type**

resultWrap

**Description**

resultWrap Object

### `getDuplicateList(Database.Error error)`

Get a list of duplicate sObjects

#### Parameters

|Param|Description|
|---|---|
|`error`|a Database.DuplicateError object|

#### Return

**Type**

List&lt;sObject&gt;

**Description**

Returns a lits of sObjects

### `static upsertUpOverride(dealer__Sales_Up__c nup)`

`AURAENABLED`

Upsert Sales_Up__c and override the duplicate settings.

#### Parameters

|Param|Description|
|---|---|
|`nup`|Sales_Up__c to insert|

#### Return

**Type**

resultWrap

**Description**

A resultWrap object

---
## Classes
### actResult

Act Result Class: a wrapper class so we know if account creation has duplicates or not.

#### Constructors
##### `actResult(resultWrap wrap, Account act)`
---
#### Properties

##### `acct` → `Account`

`AURAENABLED` 

##### `daWrap` → `resultWrap`

`AURAENABLED` 

##### `hasDupes` → `Boolean`

`AURAENABLED` 

---

### prospectException

**Inheritance**

prospectException


### resultWrap

A Wrapper class to send back to the a lightning component.

#### Constructors
##### `resultWrap(String resultId, List&lt;dealer__Sales_Up__c&gt; dupes, List&lt;Account&gt; aDupes)`
---
#### Properties

##### `Id` → `String`

`AURAENABLED` 

##### `dActs` → `List&lt;Account&gt;`

`AURAENABLED` 

##### `dSups` → `List&lt;dealer__Sales_Up__c&gt;`

`AURAENABLED` 

##### `dupeType` → `String`

`AURAENABLED` 

##### `hasDups` → `boolean`

`AURAENABLED` 

---

---
