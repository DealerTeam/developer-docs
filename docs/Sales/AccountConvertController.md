# AccountConvertController

`APIVERSION: 46`

`STATUS: ACTIVE`

This class provides lightning components conversion methods for accounts


**Group** Sales

## Methods
### `static getRecordType(Id acctId)`

`AURAENABLED`

getRecordType Provides record type of respective Account

#### Return

**Type**

Account

**Description**

Account

### `static getRecordSelect(Boolean b2b)`

`AURAENABLED`

getRecordSelect

#### Return

**Type**

List&lt;Utility.Selection&gt;

**Description**

List&lt;Utility.Selection&gt;

### `static convertToPersonAccount(Account acct, String First, String Last, String RTId)`

`AURAENABLED`

convertToPersonAccount returns true if the account was succesfully converted to Person Acct, false if the record type conversion failed.

#### Return

**Type**

Boolean

**Description**

Boolean


**Test** UtilityUILayer

### `static convertToBusinessAccount(Account acct, String Name, String RTId)`

`AURAENABLED`

convertToBusinessAccount returns true if the account was succesfully converted to Business Acct, false if the record type conversion failed.

#### Return

**Type**

Boolean

**Description**

Boolean

### `static recentAccountResult()`

`AURAENABLED`

Retrieves recent Accounts

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt;

### `static searchAccounts(String searchTerm)`

`AURAENABLED`

Searches Accounts

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|String|

#### Return

**Type**

List&lt;LookupSearchResult&gt;

**Description**

List&lt;LookupSearchResult&gt;

### `static mergeAccount(String acctId, String masterAcct)`

`AURAENABLED`
---
