---
layout: default
---
# IdentityApi class

 Identiy API provides access to a number of external consumer databases. The purposes of these API's are to assist the end user with additional data related to the Account records he/she is working with. First Available in 1.601 https://success.dealerteam.com/Middleware/API_Guide/Caller_Identification

---
## Methods
### `callerIdentification(String searchNumber)` → `List<caller>`

 [callerIdentification description]

#### Parameters
|Param|Description|
|-----|-----------|
|`searchNumber` |  [description] |

### `performCallout(String api, String searchParameter)` → `String`

 [performCallout description]

---
## Inner Classes

### IdentityApi.caller class
---
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
