---
layout: default
---
# AccountConvertController

This class provides lightning components conversion methods for accounts


**Group** Sales

## Methods
### `public static Account getRecordType(Id acctId)`

`AURAENABLED`

getRecordType Provides record type of respective Account

#### Returns

|Type|Description|
|---|---|
|`Account`|Account|

### `public static List<Utility.Selection> getRecordSelect(Boolean b2b)`

`AURAENABLED`

getRecordSelect

#### Returns

|Type|Description|
|---|---|
|`List<Utility.Selection>`|List<Utility.Selection>|

### `public static Boolean convertToPersonAccount(Account acct, String First, String Last, String RTId)`

`AURAENABLED`

convertToPersonAccount returns true if the account was succesfully converted to Person Acct, false if the record type conversion failed.

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|


**Test** UtilityUILayer

### `public static Boolean convertToBusinessAccount(Account acct, String Name, String RTId)`

`AURAENABLED`

convertToBusinessAccount returns true if the account was succesfully converted to Business Acct, false if the record type conversion failed.

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|

### `public static List<LookupSearchResult> recentAccountResult()`

`AURAENABLED`

Retrieves recent Accounts

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static List<LookupSearchResult> searchAccounts(String searchTerm)`

`AURAENABLED`

Searches Accounts

#### Parameters

|Param|Description|
|---|---|
|`searchTerm`|String|

#### Returns

|Type|Description|
|---|---|
|`List<LookupSearchResult>`|List<LookupSearchResult>|

### `public static void mergeAccount(String acctId, String masterAcct)`

`AURAENABLED`
---
