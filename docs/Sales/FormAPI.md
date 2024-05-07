---
layout: default
---
# FormAPI

FormAPI provides programatic access to the forms print subsystem.


**Group** Sales

## Methods
### `global static String mergeForms(Id dealId, List<Form__c> forms)`

mergeForms is a globally accessible method allowing users to print bundes.

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Id of the deal record|
|`forms`|List of Forms to be printed|

#### Returns

|Type|Description|
|---|---|
|`String`|Returns a string repsenting the bundle of the forms|

### `public static List<String> getObjectFieldNames()`
### `public static String getObjectFieldNamesSimple()`

getObjectFieldNamesSimple obtains the field names for the Deal object

#### Returns

|Type|Description|
|---|---|
|`String`|JSON string with field schema of Deal__c object|

### `public static String viewEnhancedForm(String formId, String values)`

viewEnhancedForm renders the PSPDFKIT Form in the preview window

#### Parameters

|Param|Description|
|---|---|
|`formId`|Form__c RecordID|
|`values`|JSON encoded field values|

#### Returns

|Type|Description|
|---|---|
|`String`|returns a URL to view the Form|

### `public static PrintResult storeEnhancedForm(Form__c form, String base64, String fileName)`

from uploads the base 64 representation of a form to PSPDFKit and saves its returned form field values to the Form__c sObject.

#### Parameters

|Param|Description|
|---|---|
|`form`|dealer__Form__c|
|`base64`|Base 64 encoded PDF|
|`filename`|form filename to be saved in PSPDFKit servers|

### `private static List<FormFieldValue> preserveEnhancedFDFValues(List<FormFieldValue> existingValues, List<FormFieldValue> newValues)`

preserves existing FDF Code values saved when using the Enhanced PDF uploader (Type PDF / PSPDFKit)

#### Parameters

|Param|Description|
|---|---|
|`existingValues`|List of existing Form Field Values|
|`newValues`|List of new Form Field Values|

### `public static string storeFormSessionValues(String recordId, String documentId, List<Form__c> forms)`

generates the form session. Created while printing to dynamically populate the form once it is rendered.

#### Parameters

|Param|Description|
|---|---|
|`recordId`|recordId Polymorhpic Id of the record to be printed|
|`documentId`|documentId Document ID of the form to be printed|
|`forms`|forms List of forms to be printed|

#### Returns

|Type|Description|
|---|---|
|`string`|requestId of the form session|

### `public static Component getPreview(Form__c form)`

getPreview returns a preview of the form via Component.Apex.OutputText for the Visualforce Page

#### Parameters

|Param|Description|
|---|---|
|`form`|getPreview record|

#### Returns

|Type|Description|
|---|---|
|`Component`|form via Component.Apex.OutputText|

### `public static Component getFDF(Form__c form)`

getFDF renders an FDF Code for the Visualforce Page

#### Parameters

|Param|Description|
|---|---|
|`form`|form record to process|

#### Returns

|Type|Description|
|---|---|
|`Component`|Component.Apex.OutputText representing the FDF Code|

### `public static String printForms(Id dealId, List<String> formIds)`

printForms processes the list of forms to be printed

#### Parameters

|Param|Description|
|---|---|
|`dealId`|dealId of the Deal record to print|
|`formIds`|formIds to be processed in the print|

#### Returns

|Type|Description|
|---|---|
|`String`|String contianing the PrintResult for openning the combined record on the Server|

### `private static void updatePrintedForms(Id dealId, List<Deal_Form__c> formsPrinted)`

updateFormsPrinted will identify all forms printed and upddate the records that are associated and create new records that are not yet stored in Deal_Forms__c

#### Parameters

|Param|Description|
|---|---|
|`formsPrinted`|List of Forms without a deal_form__c ID|

### `public static String convertFDF(Form__c form)`

convertFDF performs the action of removing an FDF Form, creating the same document in a PDF (PSPDFKIT) and converting the FDF Code to PSPDFKIT JSON

#### Parameters

|Param|Description|
|---|---|
|`form`|Specific Form__c sObject|

#### Returns

|Type|Description|
|---|---|
|`String`|return JSON Encoded Form Field Values|

### `public static String mergeBundle(String recordId, List<String> documentIds, String mergeOptions)`

mergeBundle takes a list of documents in PSPDFKIT and creates a single document

#### Parameters

|Param|Description|
|---|---|
|`documentIds`|list of document Ids to be merged|
|`mergeOptions`|Reserved for future use.  (https://pspdfkit.com/guides/processor/api/build-api-reference/)|

#### Returns

|Type|Description|
|---|---|
|`String`|String representing the final merged document ID|

### `public static String bundleForms(Id dealId, list<Form__c> forms)`

bundleForms processes mulitple forms to create a single form.

#### Parameters

|Param|Description|
|---|---|
|`dealId`|Deal Record Id|
|`forms`|Form__c[] list of records|

#### Returns

|Type|Description|
|---|---|
|`String`|The return string is a URL for the specific resource.|

### `public static String printLegacyForm(String jsonBody)`

Prints a single FDF or VisualForce Page. This is to keep legacy forms compatible.

#### Parameters

|Param|Description|
|---|---|
|`jsonBody`|jsonBody description|

#### Returns

|Type|Description|
|---|---|
|`String`|return description|

### `private static List<String> createRemoteVFResource(Id dealId, List<Form__c> forms)`
### `public static Void saveFDFToFile(String formId, Id recordId, String externalURL)`

`FUTURE`

Saves FDF Form Print events as PDF Docuements to the record

#### Parameters

|Param|Description|
|---|---|
|`formId`|formId description|
|`recordId`|recordId description|
|`externalURL`|URL rendered FDF exists for download|

### `public static Void saveLaserToFile(String formId, Id recordId)`

`FUTURE`

Saves VF Form Print events as PDF Docuements to the record

#### Parameters

|Param|Description|
|---|---|
|`formId`|formId description|
|`recordId`|recordId description|

### `private static void createContentVersion(Form__c form, Id recordId, blob resource)`

Creates a new File or updates its version

#### Parameters

|Param|Description|
|---|---|
|`form`|form|
|`recordId`|recordId|
|`resource`|Blob of the file to be updated|

### `private static void createLink(Id dealId, Id cdId)`

Links the ContentDocument with a record Id

#### Parameters

|Param|Description|
|---|---|
|`dealId`|dealId description|
|`cdId`|cdId description|

### `public static Blob externalPDFToBlob(String externalURL)`
### `public static Map<String,String> generateFDF(Id dealId, List<Form__c> forms)`

generateFDF uses a list of forms to generate the FDF Code for the forms engine

#### Parameters

|Param|Description|
|---|---|
|`dealId`|String deal ID record to processs the forms based upon|

#### Returns

|Type|Description|
|---|---|
|`Map<String,String>`|Map of String , String representing the FDF Code compiled based on Document Content ID|

### `private static String generateBodyJSON(Map<String,String> fdfMap, List<String> forms, Id recordId)`
### `public static String base64Decode(String s)`
### `public static String base64DecodePDFData(String s)`
### `public static Form__c processFeeVariables(Form__c form, Deal__c deal)`

processFeeVariables This routine splits the fee variables into parts for processing.

#### Parameters

|Param|Description|
|---|---|
|`form`|Form sObject|
|`deal`|Deal sObject|

#### Returns

|Type|Description|
|---|---|
|`Form__c`|Form__c object with fdf compile code replaced wuth Form Code values|

### `public static dealer__Appraisal__c lookupAppraisal(Id aprId)`

lookupAppraisal generates appraisal data for the Forms engine

#### Parameters

|Param|Description|
|---|---|
|`aprId`|aprId description|

#### Returns

|Type|Description|
|---|---|
|`dealer__Appraisal__c`|return description|

### `public static dealer__Deal__c lookupDeal(Id dealId)`

lookupDeal obtains the values for the Form engine

#### Parameters

|Param|Description|
|---|---|
|`dealId`|dealId description|

#### Returns

|Type|Description|
|---|---|
|`dealer__Deal__c`|return deal object|

### `public static List<dealer__Trade_In__c> lookupTradeIns(Id dealId)`
### `public static Account getBuyer(dealer__Deal__c deal)`
### `public static Account getCoBuyer(dealer__Deal__c deal)`
### `public static Boolean getIsPersonAccount(dealer__Deal__c deal)`

getisPersonAccount returns a boolean value if the account is a person account

#### Parameters

|Param|Description|
|---|---|
|`deal`|Deal__c record|

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean value if the account is a person account|

### `public static List<dealer__Deal_Tax__c> retreiveTaxList(dealer__Deal__c deal)`
### `public static List<dealer__Discount_Rebate__c> retreiveDiscountList(dealer__Deal__c deal)`
### `public static List<dealer__After_Market__c> retreiveAftermarketList(dealer__Deal__c deal)`

retreiveAftermarketList description

#### Parameters

|Param|Description|
|---|---|
|`deal`|Deal record for processing|

#### Returns

|Type|Description|
|---|---|
|`List<dealer__After_Market__c>`|List<After_Market__c> of length 10|

### `public static List<Service_Contract__c> retreiveServiceContractList(dealer__Deal__c deal)`

retreiveServiceContractList obtains the service contracts sold on a deal and returns a list of at least 10 items

#### Parameters

|Param|Description|
|---|---|
|`deal`|Deal__c record|

#### Returns

|Type|Description|
|---|---|
|`List<Service_Contract__c>`|List<Service_Contract__c> of length 10|

### `public static List<Sales_Fee__c> retreiveFeeList(Deal__c deal)`

retreiveFeeList obtains the fees for the deal and returns a list of at least 10 items

#### Parameters

|Param|Description|
|---|---|
|`Deal__c`|deal record|

#### Returns

|Type|Description|
|---|---|
|`List<Sales_Fee__c>`|return description|

### `public static Map<String,dealer__Sales_Fee__c> retrieveFees(Deal__c deal)`

retrieveFees Obtains deals fees for the form engine and sets an array based on Fee_Code__c

#### Parameters

|Param|Description|
|---|---|
|`deal`|deal description|

#### Returns

|Type|Description|
|---|---|
|`Map<String,dealer__Sales_Fee__c>`|Map of String, Sales_Fee__c assembled by Fee_Code__c|

### `public static List<String> preventFieldOverlap(Set<String> fieldMetadataKeyset)`
---
## Classes
### PrintResult

Print result

#### Constructors
##### `public PrintResult(String result, List&lt;String&gt; formsToAdd)`
###### Parameters

|Param|Description|
|---|---|
|`result`|result description|
|`formsToAdd`|adds these forms to the deal once printed|


**Method** PrintResult

##### `public PrintResult(String result)`
##### `public PrintResult()`

Constructor used to initialize a new PrintResult object instance.

---
#### Fields

##### `public formFieldValues` → `List&lt;FormFieldValue&gt;`

`AURAENABLED` 

---
#### Properties

##### `public resource` → `String`

`AURAENABLED` 

result contains the print request result

##### `public data` → `PSPDFKitData`

`AURAENABLED` 

##### `public SessionValueId` → `String`

`AURAENABLED` 

##### `public formsToAdd` → `List&lt;String&gt;`

`AURAENABLED` 

List of forms to be added to the print request

---

### MergeBundleResponse
#### Fields

##### `public data` → `PSPDFKitData`


---

### PSPDFKitData

Deserializes PSPDFKit form data.

#### Fields

##### `public createdAt` → `string`

`AURAENABLED` 

##### `public document_id` → `string`

`AURAENABLED` 

##### `public errors` → `List&lt;String&gt;`

`AURAENABLED` 

##### `public password_protected` → `Boolean`

`AURAENABLED` 

##### `public sourcePdfSha256` → `string`

`AURAENABLED` 

##### `public title` → `string`

`AURAENABLED` 

---

### FormFieldValue

Deserializes PSPDFKit form field values.

#### Fields

##### `public createdBy` → `string`

`AURAENABLED` 

##### `public name` → `string`

`AURAENABLED` 

##### `public updatedBy` → `string`

`AURAENABLED` 

##### `public value` → `string`

`AURAENABLED` 

##### `public type` → `string`

`AURAENABLED` 

---

### PrintResultResource

Deserializes PDFTK (Legacy FDF Forms) response.

#### Fields

##### `public resource` → `string`

`AURAENABLED` 

---

### formWrapper
#### Constructors
##### `public formWrapper(String documentId, String docType, String content, string mergeData, String recordId, Boolean flatten)`
---
#### Fields

##### `private documentId` → `String`


##### `private docType` → `String`


##### `private content` → `String`


##### `private mergeData` → `String`


##### `private recordId` → `String`


##### `private flatten` → `Boolean`


---

### SessionValueResponse

Used to deserialize a FormSession response. Includes RequestID For future consumption.

#### Fields

##### `public RequestId` → `string`


---

### FormSession

Print Session Wrapper. Stores data and deserializes data from external APIs.

#### Constructors
##### `public FormSession(String contentDocumentId, String documentId, List&lt;form__c&gt; forms)`
##### `public FormSession(String contentDocumentId, String documentId)`
---
#### Fields

##### `private contentDocumentId` → `String`


##### `private documentId` → `String`


##### `private values` → `String`


##### `private user` → `User`


##### `private sessionId` → `String`


##### `private organization` → `Organization`


##### `private instanceUrl` → `String`


##### `private requestId` → `String`


##### `private flatten` → `Boolean`


##### `private formName` → `String`


##### `private jwtUsername` → `String`


---
#### Methods
##### `public string storeValues()`
---

### PSPDFKitCallout

enhanced form Callout Body Wrapper

#### Constructors
##### `public PSPDFKitCallout(String base64, string fileName)`
---
#### Fields

##### `public base64` → `String`


##### `public fileName` → `String`


---

### FormAPIException

**Inheritance**

FormAPIException


---
