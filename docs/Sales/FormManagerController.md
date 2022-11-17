# FormManagerController

`APIVERSION: 45`

`STATUS: ACTIVE`

Service Layer controller for Aura and LWC components.  Used within the Form Manager UX.


**Author** DealerTeam.com, LLC


**Group** Sales

## Methods
### `static getForms(Id locId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`locId`|locId description|

#### Return

**Type**

FMFormWrapper

**Description**

return description


**Method** getForms

### `static getTabUrl()`

`AURAENABLED`
#### Return

**Type**

String

**Description**

return description


**Method** getTabUrl

### `static formData(String recordId)`

`AURAENABLED`

formData get necessary forms for form manager component

#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|

#### Return

**Type**

FormWrapper

**Description**

return description

### `static uploadEnhancedForm(String formId, String fileName, String base64)`

`AURAENABLED`

routes an enhanced form upload request to FormAPI.storeEnhancedForm();

#### Parameters

|Param|Description|
|---|---|
|`formId`||
|`fileName`||
|`base64`||

### `static fdfCode(String formId)`

`AURAENABLED`

retrieves fdf code

#### Parameters

|Param|Description|
|---|---|
|`formId`||

### `static getEfFieldMap()`

`AURAENABLED`
### `static getImpactRendererSetting(String config)`

`AURAENABLED`
### `static allForms(String recordId)`
#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|

#### Return

**Type**

List&lt;Form__c&gt;

**Description**

return description


**Method** allForms

### `static locationForms(List<Form__c> allForms, String recordId)`

returns only forms related to the location of the provided deal

#### Parameters

|Param|Description|
|---|---|
|`recordId`|Id of the deal|

#### Return

**Type**

List&lt;Form__c&gt;

**Description**

return description


**Method** locationForms

### `static applicableForms(String recordId)`
#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|

#### Return

**Type**

List&lt;Form__c&gt;

**Description**

return description


**Method** applicableForms

### `static selectedForms(String recordId)`
#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|

#### Return

**Type**

List&lt;Deal_Form__c&gt;

**Description**

return description


**Method** selectedForms

### `static removeForm(String recordId, String formId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|
|`formId`|formId description|

#### Return

**Type**

Boolean

**Description**

return description


**Method** removeForm

### `static addForms(String recordId, List<String> formIds)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|
|`formIds`|formIds description|

#### Return

**Type**

Boolean

**Description**

return description


**Method** addForms

### `static updateLastPrinted(String recordId, List<String> formIds)`

`AURAENABLED`

sets the last updated by and date for a list of forms

#### Parameters

|Param|Description|
|---|---|
|`recordId`|deal Id used to query for deal forms|
|`formIds`|forms used to query for deal forms|

#### Return

**Type**

Boolean

**Description**

return description


**Method** updateLastPrinted

### `static printForms(String recordId, List<String> formIds)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|
|`formIds`|formIds description|

#### Return

**Type**

String

**Description**

return description


**Method** printForms

### `static updateFDFJSON(String recordId, String fdfJSON)`

`AURAENABLED`
### `static convertFDF(String formId)`

`AURAENABLED`
---
## Classes
### FMFormWrapper

Nested wrapper class

#### Constructors
##### `FMFormWrapper(List&lt;Form__c&gt; availableFormsT, List&lt;FormRef__c&gt; selectedFormRefsT)`
###### Parameters

|Param|Description|
|---|---|
|`availableFormsT`|availableFormsT description|
|`selectedFormRefsT`|selectedFormRefsT description|


**Method** FMFormWrapper

---
#### Properties

##### `availableForms` → `List&lt;Form__c&gt;`

`AURAENABLED` 

List of form sobjects available for printing

##### `selectedFormRefs` → `List&lt;FormRef__c&gt;`

`AURAENABLED` 

List of form reference of selected forms

---

### FormWrapper

This wrapper class organizes the form data for column based layout usage.

#### Constructors
##### `FormWrapper(List&lt;Form__c&gt; availableForms, List&lt;Form__c&gt; locationForms, List&lt;Form__c&gt; applicableForms, List&lt;Deal_Form__c&gt; selectedForms)`

FormWrapper description

###### Parameters

|Param|Description|
|---|---|
|`availableForms`|availableForms description|
|`locationForms`|locationForms description|
|`applicableForms`|applicableForms description|
|`selectedForms`|selectedForms description|

##### `FormWrapper(List&lt;Form__c&gt; availableForms, List&lt;Form__c&gt; applicableForms, List&lt;Deal_Form__c&gt; selectedForms)`
---
#### Properties

##### `applicableForms` → `List&lt;Form__c&gt;`

`AURAENABLED` 

##### `availableForms` → `List&lt;Form__c&gt;`

`AURAENABLED` 

##### `locationForms` → `List&lt;Form__c&gt;`

`AURAENABLED` 

##### `selectedForms` → `List&lt;Deal_Form__c&gt;`

`AURAENABLED` 

---

### efFieldMap
#### Constructors
##### `efFieldMap()`
---
#### Fields

##### `buyer` → `List&lt;String&gt;`

`AURAENABLED` 

##### `cobuyer` → `List&lt;String&gt;`

`AURAENABLED` 

##### `deal` → `List&lt;String&gt;`

`AURAENABLED` 

##### `financeCo` → `List&lt;String&gt;`

`AURAENABLED` 

##### `location` → `List&lt;String&gt;`

`AURAENABLED` 

##### `tradeIn1` → `List&lt;String&gt;`

`AURAENABLED` 

##### `tradeIn2` → `List&lt;String&gt;`

`AURAENABLED` 

##### `tradeIn3` → `List&lt;String&gt;`

`AURAENABLED` 

##### `vehicle` → `List&lt;String&gt;`

`AURAENABLED` 

---

---
