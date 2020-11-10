---
layout: default
---
# SMS class
---
## Constructors
### `SMS()`
---
## Properties

### `WhatId` → `Id`

### `c` → `publi`

### `customerId` → `String`

### `jsonPayload` → `String`

### `message` → `String`

### `mobile` → `String`

### `prospect` → `dealer__Sales_Up__c`

### `selectedTemplate` → `Id`

### `sendStatus` → `Boolean`

---
## Methods
### `cancel()` → `PageReference`
### `getAllProspectFields()` → `void`

 Get all prospect fields, both custom and managed for use in the Form Compiler

### `getMessageHistory()` → `List<Task>`

 Get Previous Txt message interaction

### `getcompiledMessage()` → `Component.Apex.OutputText`

 Compile Form Content

### `gettemplateSelect()` → `List<SelectOption>`

 SelectOption to render the list in the User Interface

### `send()` → `PageReference`
### `setContact(String Id)` → `Contact`
### `templates()` → `List<EmailTemplate>`

 List of available templates for use in the Text Message

---
## Inner Classes

### SMS.msg class
---
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
