---
layout: default
---
# AppraisalFormsController

Print Controller for Appraisals Tested by AppraisalControllerTest


**Group** Sales

## Constructors
### `public AppraisalFormsController(ApexPages controller)`

Constructor

#### Parameters

|Param|Description|
|---|---|
|`controller`||


**Method** AppraisalFormsController

---
## Fields

### `public urlParams` → `Map<String,String>`


### `public form` → `dealer__Form__c`


To print Impact form

---
## Properties

### `public appraisal` → `dealer__Appraisal__c`


### `public form_id` → `String`


### `public formList` → `List<dealer__Form__c>`


Returns list of forms

---
## Methods
### `public static String getcompiledFDF(String urlParams)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`urlParams`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getcompiledFDF

### `public PageReference returnToAppraisal()`

Return to appraisal detail page

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** returnToAppraisal

### `public PageReference selectImpactForm()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** selectImpactForm

### `public static String compileFDF(String fd)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`fd`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** compileFDF

---
