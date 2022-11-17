# SMS

`APIVERSION: 45`

`STATUS: ACTIVE`
## Constructors
### `SMS()`
---
## Fields

### `mobile` → `String`


---
## Properties

### `WhatId` → `Id`


### `c` → `Contact`


### `customerId` → `String`


### `jsonPayload` → `String`


### `message` → `String`


### `prospect` → `dealer__Sales_Up__c`


### `selectedTemplate` → `Id`


### `sendStatus` → `Boolean`


---
## Methods
### `setContact(String Id)`
### `send()`
### `cancel()`
### `getMessageHistory()`

Get Previous Txt message interaction

### `templates()`

List of available templates for use in the Text Message

### `gettemplateSelect()`

SelectOption to render the list in the User Interface

### `getAllProspectFields()`

Get all prospect fields, both custom and managed for use in the Form Compiler

### `getcompiledMessage()`

Compile Form Content

---
## Classes
### msg
#### Constructors
##### `msg(String p, String t, String k, String epn, String woid, String whid)`
---
#### Properties

##### `key` → `string`


##### `phone` → `string`


##### `pn` → `string`


##### `txt` → `string`


##### `whatid` → `string`


##### `whoid` → `string`


---

---
