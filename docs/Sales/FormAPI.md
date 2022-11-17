# FormAPI

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Sales

## Methods
### `static mergeForms(Id dealId, List<Form__c> forms)`
### `static getObjectFieldNames()`
### `static getObjectFieldNamesSimple()`
### `static viewEnhancedForm(String formId, String values)`

viewEnhancedForm renders the PSPDFKIT Form in the preview window

#### Parameters

|Param|Description|
|---|---|
|`formId`|Form__c RecordID|
|`values`|JSON encoded field values|

#### Return

**Type**

String

**Description**

returns a URL to view the Form

### `static storeEnhancedForm(Form__c form, String base64, String fileName)`

from uploads the base 64 representation of a form to PSPDFKit and saves its returned form field values to the Form__c sObject.

#### Parameters

|Param|Description|
|---|---|
|`form`|dealer__Form__c|
|`base64`|Base 64 encoded PDF|
|`filename`|form filename to be saved in PSPDFKit servers|

### `static storeFormSessionValues(String recordId, String documentId, List<Form__c> forms)`

generates the form session. Created while printing to dynamically populate the form once it is rendered.

### `static getPreview(dealer__Form__c form)`
### `static getFDF(dealer__Form__c form)`
### `static printForms(Id dealId, List<String> formIds)`
### `static convertFDF(Form__c form)`

convertFDF performs the action of removing an FDF Form, creating the same document in a PDF (PSPDFKIT) and converting the FDF Code to PSPDFKIT JSON

#### Parameters

|Param|Description|
|---|---|
|`form`|Specific Form__c sObject|

#### Return

**Type**

String

**Description**

return JSON Encoded Form Field Values

### `static bundleForms(Id dealId, list<Form__c> forms)`

bundleForms processes mulitple forms to create a single form.

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Deal Record Id|
|`forms`|Form__c[] list of records|

#### Return

**Type**

String

**Description**

The return string is a URL for the specific resource.

### `static printLegacyForm(String jsonBody)`

Prints a single FDF or VisualForce Page. This is to keep legacy forms compatible.

#### Parameters

|Param|Description|
|---|---|
|`jsonBody`|jsonBody description|

#### Return

**Type**

String

**Description**

return description

### `static saveFDFToFile(String formId, Id recordId, String externalURL)`

`FUTURE`

Saves FDF Form Print events as PDF Docuements to the record

#### Parameters

|Param|Description|
|---|---|
|`formId`|formId description|
|`recordId`|recordId description|
|`externalURL`|URL rendered FDF exists for download|

### `static saveLaserToFile(String formId, Id recordId)`

`FUTURE`

Saves VF Form Print events as PDF Docuements to the record

#### Parameters

|Param|Description|
|---|---|
|`formId`|formId description|
|`recordId`|recordId description|

### `static externalPDFToBlob(String externalURL)`
### `static generateFDF(Id dealId, List<Form__c> forms)`
### `static base64Decode(String s)`
### `static base64DecodePDFData(String s)`
### `static processFeeVariables(Form__c form, Deal__c deal)`
### `static lookupAppraisal(Id aprId)`
### `static lookupDeal(Id dealId)`
### `static lookupTradeIns(Id dealId)`
### `static getBuyer(dealer__Deal__c deal)`
### `static getCoBuyer(dealer__Deal__c deal)`
### `static getisPersonAccount(dealer__Deal__c deal)`
### `static retreiveTaxList(dealer__Deal__c deal)`
### `static retreiveDiscountList(dealer__Deal__c deal)`
### `static retreiveAftermarketList(dealer__Deal__c deal)`
### `static retreiveServiceContractList(dealer__Deal__c deal)`
### `static retrieveFees(Deal__c deal)`
### `static preventFieldOverlap(Set<String> fieldMetadataKeyset)`
---
## Classes
### FormAPIException

**Inheritance**

FormAPIException


### FormFieldValue

Deserializes PSPDFKit form field values.

#### Fields

##### `createdBy` → `string`

`AURAENABLED` 

##### `name` → `string`

`AURAENABLED` 

##### `type` → `string`

`AURAENABLED` 

##### `updatedBy` → `string`

`AURAENABLED` 

##### `value` → `string`

`AURAENABLED` 

---

### FormSession

Print Session Wrapper. Stores data and deserializes data from external APIs.

#### Constructors
##### `FormSession(String contentDocumentId, String documentId, List&lt;form__c&gt; forms)`
---
#### Methods
##### `storeValues()`
---

### PSPDFKitCallout

enhanced form Callout Body Wrapper

#### Constructors
##### `PSPDFKitCallout(String base64, string fileName)`
---
#### Fields

##### `base64` → `String`


##### `fileName` → `String`


---

### PSPDFKitData

Deserializes PSPDFKit form data.

#### Fields

##### `createdAt` → `string`

`AURAENABLED` 

##### `document_id` → `string`

`AURAENABLED` 

##### `errors` → `List&lt;String&gt;`

`AURAENABLED` 

##### `password_protected` → `Boolean`

`AURAENABLED` 

##### `sourcePdfSha256` → `string`

`AURAENABLED` 

##### `title` → `string`

`AURAENABLED` 

---

### PrintResult

Print result

#### Constructors
##### `PrintResult(String result, List&lt;String&gt; formsToAdd)`
###### Parameters

|Param|Description|
|---|---|
|`result`|result description|
|`formsToAdd`|adds these forms to the deal once printed|


**Method** PrintResult

##### `PrintResult()`

Constructor used to initialize a new PrintResult object instance.

---
#### Fields

##### `formFieldValues` → `List&lt;FormFieldValue&gt;`

`AURAENABLED` 

---
#### Properties

##### `SessionValueId` → `String`

`AURAENABLED` 

##### `data` → `PSPDFKitData`

`AURAENABLED` 

##### `formsToAdd` → `List&lt;String&gt;`

`AURAENABLED` 

List of forms to be added to the print request

##### `resource` → `String`

`AURAENABLED` 

result contains the print request result

---

### PrintResultResource

Deserializes PDFTK (Legacy FDF Forms) response.

#### Fields

##### `resource` → `string`

`AURAENABLED` 

---

### SessionValueResponse

Used to deserialize a FormSession response. Includes RequestID For future consumption.

#### Fields

##### `RequestId` → `string`


---

### formWrapper
#### Constructors
##### `formWrapper(String documentId, String docType, String content, string mergeData, String recordId, Boolean flatten)`
---

---
