# Form_EXT

`APIVERSION: 45`

`STATUS: ACTIVE`

Form_EXT - Form manager and interaction class


**Group** Sales

## Constructors
### `Form_EXT(ApexPages.StandardController sc)`

Form_EXT (Constructor)

#### Parameters

|Param|Description|
|---|---|
|`sc`|ApexPages Standard Controller|

---
## Properties

### `document` → `Document`


### `documentId` → `String`


### `fdf` → `String`


### `form` → `dealer__Form__c`


---
## Methods
### `uploadPDF()`

uploadPDF - Upload the form content in BASE64 to the docgen server for storage in the database

#### Return

**Type**

PageReference

**Description**

PageReference

### `handleUpload()`
### `handleFDF()`
---
