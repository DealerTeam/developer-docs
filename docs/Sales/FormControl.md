---
layout: default
---
# FormControl

FormControl provides service layer logic to forms printing.  Currently the form printing is driven via dynamic component output for formula evaluation.


**Group** Sales


**Notes** Summer '24 introduces FormulaEvaluation class in Apex.  This may replace the DynmicComponent output for formula evaluation.

## Constructors
### `public FormControl()`

FormControl constructor.  The constructor initializes the form, deal, and appraisal records to be displayed.

---
## Fields

### `public config` → `dealer__SalesDeskLogSettings__c`


---
## Properties

### `public form_id` → `String`


### `public form_id_editor` → `String`


### `public deal_id` → `String`


### `public appraisal_id` → `String`


### `public deal_name` → `String`


### `public formCode` → `String`


### `public appraisal` → `dealer__Appraisal__c`


### `public form` → `dealer__Form__c`


### `public newForm` → `dealer__Form__c`


### `public sup` → `dealer__Sales_Up__c`


### `public deal` → `dealer__Deal__c`


### `public vehicle` → `dealer__Vehicle_Inventory__c`


### `public location` → `dealer__Dealer_Location__c`


### `public financeCo` → `dealer__Finance_Company__c`


### `public buyer` → `Account`


### `public cobuyer` → `Account`


### `public tradeInList` → `List<dealer__Trade_In__c>`


### `public taxList` → `List<dealer__Deal_Tax__c>`


### `public discountList` → `List<dealer__Discount_Rebate__c>`


### `public aftermarketList` → `List<dealer__After_Market__c>`


### `public serviceContractList` → `List<dealer__Service_Contract__c>`


### `public serviceContractMap` → `Map<String,List<dealer__Service_Contract__c>>`


### `public feeList` → `List<dealer__Sales_Fee__c>`


### `public feeMap` → `Map<String,dealer__Sales_Fee__c>`


### `public tradeInList2` → `List<dealer__Trade_In__c>`


### `public tradeIn1` → `dealer__Trade_In__c`


### `public tradeIn2` → `dealer__Trade_In__c`


### `public tradeIn3` → `dealer__Trade_In__c`


---
## Methods
### `public dealer__SalesDeskLogSettings__c getConfig()`
### `public List<String> getObjectFieldNames()`
### `public String getObjectFieldNamesSimple()`
### `public PageReference newForm()`
### `public PageReference saveNewForm()`
### `public PageReference updateForm()`

Used when printing Impact Forms from the FormManager component.

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference to the ImpactForms page|

### `public PageReference formsList()`

Used when printing Impact Forms from the FormManager component.

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference to the ImpactForms page|

### `public Component getPreview()`

getPreview - preview string compiler

#### Returns

|Type|Description|
|---|---|
|`Component`|OutputText component for render in page|

### `public Component getFDF()`

getFDF - fdf string compiler

#### Returns

|Type|Description|
|---|---|
|`Component`|OutputText component for render in page|


**Note** This method is used to generate the FDF string for the form heavily through the application

### `public String base64Decode(String s)`

base64Decode description

#### Parameters

|Param|Description|
|---|---|
|`s`|s description|

#### Returns

|Type|Description|
|---|---|
|`String`|String Base64 Encoded form for passing into JSON|

### `public Form__c lookupForm(Id formId)`

lookupForm based on Form Record ID

#### Parameters

|Param|Description|
|---|---|
|`formId`|Form Record ID|

#### Returns

|Type|Description|
|---|---|
|`Form__c`|Form__c Form Record|

### `public static Form__c getForm(Id formId)`

`AURAENABLED`

getForm returns the form object based on Form Record ID

#### Parameters

|Param|Description|
|---|---|
|`formId`|Form Record ID|

#### Returns

|Type|Description|
|---|---|
|`Form__c`|Form__c Form Record|

### `public Appraisal__c lookupAppraisal(Id aprId)`
#### Parameters

|Param|Description|
|---|---|
|`Id`|record Id of the Appraisal you would like to view|

#### Returns

|Type|Description|
|---|---|
|`Appraisal__c`|Appraisal__c [returns a database query of the selected appraisal]|


**Method** lookupAppraisal

### `public List<Trade_In__c> lookupTradeIns(Id dealId)`
#### Parameters

|Param|Description|
|---|---|
|`Id`|record Id of the deal you would like to view|

#### Returns

|Type|Description|
|---|---|
|`List<Trade_In__c>`|List<Trade_In__c> [returns a database query of the selected trade ins]|


**Method** lookupTradeIns retreives the trade in records based on the deal Id

### `public List<dealer__Form__c> getForms()`
#### Returns

|Type|Description|
|---|---|
|`List<dealer__Form__c>`|List<Form__c> [returns a database query of the selected forms]|


**Method** getForms returns a list of Impact Forms


**Note** This method is rarely used as Impact Forms are not frequently used in the application.

### `public PageReference compileFormSource()`
### `public PageReference setDealId()`

setDealId sets the deal Id based on the sales up record - Used in Impact Form Printing

#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|

### `public Account getBuyer()`

getBuyer returns the buyer account record

#### Returns

|Type|Description|
|---|---|
|`Account`|Account|

### `public Account getCoBuyer()`

getCoBuyer returns the co-buyer account record

#### Returns

|Type|Description|
|---|---|
|`Account`|Account|

### `public Boolean getisPersonAccount()`

getisPersonAccount returns a boolean value if the account is a person account

#### Returns

|Type|Description|
|---|---|
|`Boolean`|Boolean|

### `public List<Deal_Tax__c> retreiveTaxList()`

retreiveTaxList returns the tax list for the deal

#### Returns

|Type|Description|
|---|---|
|`List<Deal_Tax__c>`|List<Deal_Tax__c>|

### `public List<Discount_Rebate__c> retreiveDiscountList()`

retreiveDiscountList obtains the discount list for the deal - This also includes rebates.

#### Returns

|Type|Description|
|---|---|
|`List<Discount_Rebate__c>`|List<Discount_Rebate__c>|

### `public List<After_Market__c> retreiveAftermarketList()`

retreiveAftermarketList returns the aftermarket list for the deal

#### Returns

|Type|Description|
|---|---|
|`List<After_Market__c>`|List<After_Market__c>|

### `public List<Service_Contract__c> retreiveServiceContractList()`

retreiveServiceContractList returns the service contracts listed on a deal

#### Returns

|Type|Description|
|---|---|
|`List<Service_Contract__c>`|List<Service_Contract__c>|

### `public List<Sales_Fee__c> retreiveFeeList()`

retreiveFeeList returns the list of Sales Fees for the deal.

#### Returns

|Type|Description|
|---|---|
|`List<Sales_Fee__c>`|List<Sales_Fee__c>|

### `private Map<String,Sales_Fee__c> setFeeMap(List<Sales_Fee__c> feeList)`

setFeeMap description

#### Parameters

|Param|Description|
|---|---|
|`List`|<Sales_Fee__c>|

#### Returns

|Type|Description|
|---|---|
|`Map<String,Sales_Fee__c>`|Map<String, Sales_Fee__c>|

### `private Map<String,List<Service_Contract__c>> setServiceContractMap(List<Service_Contract__c> serviceContractList)`
---
