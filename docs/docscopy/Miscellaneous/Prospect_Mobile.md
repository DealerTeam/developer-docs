---
layout: default
---
# Prospect_Mobile class
---
## Methods
### `accountFromSup(dealer__Sales_Up__c nup, Boolean checkDupli)` → `actResult`

 A Method to return the associated Account and Contact of a newly created accout that can be associated with a Sales Up

#### Parameters
|Param|Description|
|-----|-----------|
|`nup` |   THe sales up record to create the account from |

### `assignAccountToSup(dealer__Sales_Up__c sup, String actId )` → `Sales_up__c`

 A method to connect a newly created Account to a Sales Up

#### Parameters
|Param|Description|
|-----|-----------|
|`act` |  An Account object |
|`sup` |  a Sales_Up__c object |

### `getDuplicateList(Database.Error error)` → `List<sObject>`

 Get a list of duplicate sObjects

#### Parameters
|Param|Description|
|-----|-----------|
|`error` |  a Database.DuplicateError object |

### `upsertProSkip(dealer__Sales_Up__c nup )` → `resultWrap`

 Upsert a Sales_Up__c skipping account duplicate checking

#### Parameters
|Param|Description|
|-----|-----------|
|`nup` |  Sales_Up__c |

### `upsertProWOAcct( dealer__Sales_Up__c nup, Boolean skipAcctDupli )` → `resultWrap`

 Upsert a Sales Up without checking for duplicate Accounts

#### Parameters
|Param|Description|
|-----|-----------|
|`nup` |            Sales_Up__c |
|`skipAcctDupli` |  Boolean |

### `upsertProspect(dealer__Sales_Up__c nup )` → `resultWrap`

 Upsert a new Sales Up

#### Parameters
|Param|Description|
|-----|-----------|
|`nup` |  Sales_Up__c to insert |
|`acct` |  Account to associate with Nup |
|`chkAcct` |  Boolean a boolean to turn off account duplicate checking |

### `upsertUpOverride(dealer__Sales_Up__c nup)` → `resultWrap`

 Upsert Sales_Up__c and override the duplicate settings.

#### Parameters
|Param|Description|
|-----|-----------|
|`nup` |  Sales_Up__c to insert |

---
## Inner Classes

### Prospect_Mobile.actResult class

 Act Result Class: a wrapper class so we know if account creation has duplicates or not. @param  wrap a resultWrap object to pass through

---
#### Constructors
##### `actResult(resultWrap wrap, Account act)`
---
#### Properties

##### `acct` → `Account`

##### `daWrap` → `resultWrap`

##### `hasDupes` → `Boolean`

---
### Prospect_Mobile.prospectException class
---
### Prospect_Mobile.resultWrap class

WRAPPER CLASSES ** /** A Wrapper class to send back to the a lightning component. @param savedUp  String      - the Id of the saved @param dupes    List<Sales_Up__c> - a List of duplicate Sales Up records. @param aDupes   List<Account>     - List of Accounts

---
#### Constructors
##### `resultWrap(String resultId, List<dealer__Sales_Up__c> dupes, List<Account> aDupes)`
---
#### Properties

##### `Id` → `String`

##### `dActs` → `List<Account>`

##### `dSups` → `List<dealer__Sales_Up__c>`

##### `dupeType` → `String`

##### `hasDups` → `boolean`

---
