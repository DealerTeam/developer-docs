---
layout: default
---
# Form_EXT

Form_EXT - Form manager and interaction class


**Group** Sales

## Constructors
### `public Form_EXT(ApexPages sc)`

Form_EXT (Constructor)

#### Parameters

|Param|Description|
|---|---|
|`sc`|ApexPages Standard Controller|

---
## Properties

### `public form` → `dealer__Form__c`


### `public documentId` → `String`


### `public fdf` → `String`


### `public document` → `Document`


---
## Methods
### `public PageReference uploadPDF()`

uploadPDF - Upload the form content in BASE64 to the docgen server for storage in the database

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|

### `public void handleUpload()`
### `public Pagereference handleFDF()`
---
