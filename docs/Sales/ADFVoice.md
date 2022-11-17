# ADFVoice

`APIVERSION: 45`

`STATUS: ACTIVE`

Parses ADF Voice doc to identify Customer and Sales Up


**Group** Sales

## Constructors
### `ADFVoice()`
---
## Fields

### `callerFirst` → `String`


### `callerLast` → `String`


### `companyNumber` → `String`


### `phoneNumber` → `String`


---
## Methods
### `parseADF(String XML, String toEmail)`
#### Parameters

|Param|Description|
|---|---|
|`XML`||
|`toEmail`||

#### Return

**Type**

boolean

**Description**

boolean


**Method** parseADF

### `unpackDoc(DOM.Xmlnode nodes)`

Unpack XML, Set Traffic Type, Locate Customer and get Matching Sales Up

#### Parameters

|Param|Description|
|---|---|
|`nodes`||

#### Return

**Type**

boolean

**Description**

boolean


**Method** unpackDoc

### `parseDateTime(String d)`

Formats Date/Time to the following: 2013-06-04T23:41:55Z

#### Parameters

|Param|Description|
|---|---|
|`d`||

#### Return

**Type**

DateTime

**Description**

DateTime


**Method** parseDateTime

### `alertFailedADF(String emailBody)`

Sends email alert notifying DealerTeam of ADF Voice Package Failure for an Org.

#### Parameters

|Param|Description|
|---|---|
|`emailBody`||

#### Return

**Type**

void

**Description**

void


**Method** alertFailedADF

### `setCompanyNumber(String toEmail)`

Capture local part of email for reference in routing table.

#### Parameters

|Param|Description|
|---|---|
|`toEmail`||

#### Return

**Type**

void

**Description**

void


**Method** setCompanyNumber

---
## Classes
### ADFException

**Inheritance**

ADFException


---
