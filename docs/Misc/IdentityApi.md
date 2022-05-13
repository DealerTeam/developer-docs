# IdentityApi

`APIVERSION: 45`

`STATUS: ACTIVE`

Identiy API provides access to a number of external consumer databases.  
 * The purposes of these API&apos;s are to assist the end user with additional 
 * data related to the Account records he/she is working with. First Available in 1.601 https://success.dealerteam.com/Middleware/API_Guide/Caller_Identification

## Methods
### `static callerIdentification(String searchNumber)`

[callerIdentification description]

#### Parameters
|Param|Description|
|---|---|
|`searchNumber`|[description]|

#### Return

**Type**

List&lt;caller&gt;

**Description**

[description]

### `static performCallout(String api, String searchParameter)`

[performCallout description]

#### Parameters
|Param|Description|
|---|---|

#### Return

**Type**

String

**Description**

body

---
## Classes
### caller
#### Properties

##### `FirstName` → `String`


##### `LastName` → `String`


##### `MiddleName` → `String`


##### `PersonMailingCity` → `String`


##### `PersonMailingCountry` → `String`


##### `PersonMailingPostalCode` → `String`


##### `PersonMailingState` → `String`


##### `PersonMailingStreet` → `String`


##### `Salutation` → `String`


##### `Suffix` → `String`


##### `do_not_call` → `boolean`


##### `is_connected` → `boolean`


##### `is_valid` → `boolean`


##### `line_type` → `String`


---

---
