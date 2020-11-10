---
layout: default
---
# AccountConvertController class

This class provides lightning components conversion methods for accounts

---
## Methods
### `convertToBusinessAccount(Account acct, String Name, String RTId)` → `Boolean`

returns true if the account was succesfully converted to Business Acct, false if the record type conversion failed.

### `convertToPersonAccount(Account acct, String First, String Last, String RTId)` → `Boolean`

returns true if the account was succesfully converted to Person Acct, false if the record type conversion failed.

### `getRecordSelect(Boolean b2b)` → `List<Utility.Selection>`
### `getRecordType(Id acctId)` → `Account`

Provides record type of respective Account

### `mergeAccount(String acctId, String masterAcct)` → `void`
### `recentAccountResult()` → `List<LookupSearchResult>`

 Retrieves recent Accounts

#### Parameters
|Param|Description|
|-----|-----------|
|`acctId` |  String |

### `searchAccounts(String searchTerm)` → `List<LookupSearchResult>`

 Searches Accounts

#### Parameters
|Param|Description|
|-----|-----------|
|`searchTerm` |  String |

---
