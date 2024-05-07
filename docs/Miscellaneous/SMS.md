---
layout: default
---
# SMS
## Constructors
### `public SMS()`
---
## Fields

### `public mobile` → `String`


---
## Properties

### `public customerId` → `String`


### `public c` → `Contact`


### `public WhatId` → `Id`


### `public message` → `String`


### `public sendStatus` → `Boolean`


### `public jsonPayload` → `String`


### `public selectedTemplate` → `Id`


### `public prospect` → `dealer__Sales_Up__c`


---
## Methods
### `public Contact setContact(String Id)`
### `public PageReference send()`
### `public PageReference cancel()`
### `public List<Task> getMessageHistory()`

Get Previous Txt message interaction

### `public List<EmailTemplate> templates()`

List of available templates for use in the Text Message

### `public List<SelectOption> gettemplateSelect()`

SelectOption to render the list in the User Interface

### `public void getAllProspectFields()`

Get all prospect fields, both custom and managed for use in the Form Compiler

### `public Component getcompiledMessage()`

Compile Form Content

---
## Classes
### msg
#### Constructors
##### `public msg(String p, String t, String k, String epn, String woid, String whid)`
---
#### Properties

##### `public phone` → `string`


##### `public txt` → `string`


##### `public key` → `string`


##### `public pn` → `string`


##### `public whoid` → `string`


##### `public whatid` → `string`


---

---
