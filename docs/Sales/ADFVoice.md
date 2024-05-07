---
layout: default
---
# ADFVoice

Parses ADF Voice doc to identify Customer and Sales Up


**Group** Sales

## Constructors
### `public ADFVoice()`
---
## Fields

### `public phoneNumber` → `String`


### `public callerFirst` → `String`


### `public callerLast` → `String`


### `public companyNumber` → `String`


---
## Methods
### `public boolean parseADF(String XML, String toEmail)`
#### Parameters

|Param|Description|
|---|---|
|`XML`||
|`toEmail`||

#### Returns

|Type|Description|
|---|---|
|`boolean`|boolean|


**Method** parseADF

### `public boolean unpackDoc(DOM nodes)`

Unpack XML, Set Traffic Type, Locate Customer and get Matching Sales Up

#### Parameters

|Param|Description|
|---|---|
|`nodes`||

#### Returns

|Type|Description|
|---|---|
|`boolean`|boolean|


**Method** unpackDoc

### `public DateTime parseDateTime(String d)`

Formats Date/Time to the following: 2013-06-04T23:41:55Z

#### Parameters

|Param|Description|
|---|---|
|`d`||

#### Returns

|Type|Description|
|---|---|
|`DateTime`|DateTime|


**Method** parseDateTime

### `public void alertFailedADF(String emailBody)`

Sends email alert notifying DealerTeam of ADF Voice Package Failure for an Org.

#### Parameters

|Param|Description|
|---|---|
|`emailBody`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** alertFailedADF

### `public void setCompanyNumber(String toEmail)`

Capture local part of email for reference in routing table.

#### Parameters

|Param|Description|
|---|---|
|`toEmail`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** setCompanyNumber

---
## Classes
### ADFException

**Inheritance**

ADFException


---
