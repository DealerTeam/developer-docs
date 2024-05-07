---
layout: default
---
# FormManagerController

Service Layer controller for Aura and LWC components.  Used within the Form Manager UX.


**Author** DealerTeam.com, LLC


**Group** Sales

## Methods
### `public static FMFormWrapper getForms(Id locId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`locId`|locId description|

#### Returns

|Type|Description|
|---|---|
|`FMFormWrapper`|return description|


**Method** getForms

### `public static String getTabUrl()`

`AURAENABLED`
#### Returns

|Type|Description|
|---|---|
|`String`|return description|


**Method** getTabUrl

### `public static FormWrapper formData(String recordId)`

`AURAENABLED`

formData get necessary forms for form manager component

#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|

#### Returns

|Type|Description|
|---|---|
|`FormWrapper`|return description|

### `public static FormAPI uploadEnhancedForm(String formId, String fileName, String base64)`

`AURAENABLED`

routes an enhanced form upload request to FormAPI.storeEnhancedForm();

#### Parameters

|Param|Description|
|---|---|
|`formId`||
|`fileName`||
|`base64`||

### `public static string printDocument(String dealId, String formId)`

`AURAENABLED`

printDocument renders a single document in PSPDFKIT returning the DOCUMENT_ID from the Forms Server

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id of the Deal record|
|`formId`|Id of the Form to be rendered|

#### Returns

|Type|Description|
|---|---|
|`string`|String representing the Document_ID|

### `public static string bundleDocuments(String recordId, List<String> documentIds)`

`AURAENABLED`

bundle multiple pspdfkit documents into a single source document

#### Parameters

|Param|Description|
|---|---|
|`documentIds`|documentIds are a list of PSPDFKIT document_ids to merge|

#### Returns

|Type|Description|
|---|---|
|`string`|return string JSON merge print result|

### `public static String fdfCode(String formId)`

`AURAENABLED`

retrieves fdf code

#### Parameters

|Param|Description|
|---|---|
|`formId`||

### `public static efFieldMap getEfFieldMap()`

`AURAENABLED`
### `public static string getImpactRendererSetting(String config)`

`AURAENABLED`
### `public static List<Form__c> allForms(String recordId)`
#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|

#### Returns

|Type|Description|
|---|---|
|`List<Form__c>`|return description|


**Method** allForms

### `public static List<Form__c> locationForms(List<Form__c> allForms, String recordId)`

returns only forms related to the location of the provided deal

#### Parameters

|Param|Description|
|---|---|
|`recordId`|Id of the deal|

#### Returns

|Type|Description|
|---|---|
|`List<Form__c>`|return description|


**Method** locationForms

### `public static List<Form__c> applicableForms(String recordId)`
#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|

#### Returns

|Type|Description|
|---|---|
|`List<Form__c>`|return description|


**Method** applicableForms

### `public static List<Deal_Form__c> selectedForms(String recordId)`
#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|

#### Returns

|Type|Description|
|---|---|
|`List<Deal_Form__c>`|return description|


**Method** selectedForms

### `public static Boolean removeForm(String recordId, String formId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|
|`formId`|formId description|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|


**Method** removeForm

### `public static Boolean addForms(String recordId, List<String> formIds)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|
|`formIds`|formIds description|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|


**Method** addForms

### `public static Boolean updateLastPrinted(String recordId, List<String> formIds)`

`AURAENABLED`

sets the last updated by and date for a list of forms

#### Parameters

|Param|Description|
|---|---|
|`recordId`|deal Id used to query for deal forms|
|`formIds`|forms used to query for deal forms|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|return description|


**Method** updateLastPrinted

### `public static String printForms(String recordId, List<String> formIds)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId description|
|`formIds`|formIds description|

#### Returns

|Type|Description|
|---|---|
|`String`|return description|


**Method** printForms

### `public static void updateFDFJSON(String recordId, String fdfJSON)`

`AURAENABLED`
### `public static String convertFDF(String formId)`

`AURAENABLED`
---
## Classes
### efFieldMap
#### Constructors
##### `public efFieldMap()`
---
#### Fields

##### `public deal` → `List&lt;String&gt;`

`AURAENABLED` 

##### `public buyer` → `List&lt;String&gt;`

`AURAENABLED` 

##### `public cobuyer` → `List&lt;String&gt;`

`AURAENABLED` 

##### `public vehicle` → `List&lt;String&gt;`

`AURAENABLED` 

##### `public location` → `List&lt;String&gt;`

`AURAENABLED` 

##### `public financeCo` → `List&lt;String&gt;`

`AURAENABLED` 

##### `public tradeIn1` → `List&lt;String&gt;`

`AURAENABLED` 

##### `public tradeIn2` → `List&lt;String&gt;`

`AURAENABLED` 

##### `public tradeIn3` → `List&lt;String&gt;`

`AURAENABLED` 

---

### FMFormWrapper

Nested wrapper class

#### Constructors
##### `public FMFormWrapper(List&lt;Form__c&gt; availableFormsT, List&lt;FormRef__c&gt; selectedFormRefsT)`
###### Parameters

|Param|Description|
|---|---|
|`availableFormsT`|availableFormsT description|
|`selectedFormRefsT`|selectedFormRefsT description|


**Method** FMFormWrapper

---
#### Properties

##### `public availableForms` → `List&lt;Form__c&gt;`

`AURAENABLED` 

List of form sobjects available for printing

##### `public selectedFormRefs` → `List&lt;FormRef__c&gt;`

`AURAENABLED` 

List of form reference of selected forms

---

### FormWrapper

This wrapper class organizes the form data for column based layout usage.

#### Constructors
##### `public FormWrapper(List&lt;Form__c&gt; availableForms, List&lt;Form__c&gt; locationForms, List&lt;Form__c&gt; applicableForms, List&lt;Deal_Form__c&gt; selectedForms)`

FormWrapper description

###### Parameters

|Param|Description|
|---|---|
|`availableForms`|availableForms description|
|`locationForms`|locationForms description|
|`applicableForms`|applicableForms description|
|`selectedForms`|selectedForms description|

##### `public FormWrapper(List&lt;Form__c&gt; availableForms, List&lt;Form__c&gt; applicableForms, List&lt;Deal_Form__c&gt; selectedForms)`
---
#### Properties

##### `public availableForms` → `List&lt;Form__c&gt;`

`AURAENABLED` 

##### `public locationForms` → `List&lt;Form__c&gt;`

`AURAENABLED` 

##### `public applicableForms` → `List&lt;Form__c&gt;`

`AURAENABLED` 

##### `public selectedForms` → `List&lt;Deal_Form__c&gt;`

`AURAENABLED` 

---

---
