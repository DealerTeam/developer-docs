# AppraisalFormsController

`APIVERSION: 45`

`STATUS: ACTIVE`

Print Controller for Appraisals Tested by AppraisalControllerTest


**Group** Sales

## Constructors
### `AppraisalFormsController(ApexPages.StandardController controller)`

Constructor

#### Parameters

|Param|Description|
|---|---|
|`controller`||


**Method** AppraisalFormsController

---
## Fields

### `form` → `dealer__Form__c`


To print Impact form

### `urlParams` → `Map<String,String>`


---
## Properties

### `appraisal` → `dealer__Appraisal__c`


### `formList` → `List<dealer__Form__c>`


Returns list of forms

### `form_id` → `String`


---
## Methods
### `static getcompiledFDF(String urlParams)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`urlParams`||

#### Return

**Type**

String

**Description**

String


**Method** getcompiledFDF

### `returnToAppraisal()`

Return to appraisal detail page

#### Return

**Type**

PageReference

**Description**

PageReference


**Method** returnToAppraisal

### `selectImpactForm()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** selectImpactForm

### `static compileFDF(String fd)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`fd`||

#### Return

**Type**

String

**Description**

String


**Method** compileFDF

---
