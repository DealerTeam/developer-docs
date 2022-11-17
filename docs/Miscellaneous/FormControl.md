# FormControl

`APIVERSION: 45`

`STATUS: ACTIVE`
## Constructors
### `FormControl()`
---
## Fields

### `config` → `dealer__SalesDeskLogSettings__c`


### `formLines` → `Map<Integer,List<List<String>>>`


---
## Properties

### `aftermarketList` → `List<dealer__After_Market__c>`


### `appraisal` → `dealer__Appraisal__c`


### `appraisal_id` → `String`


### `buyer` → `Account`


### `cobuyer` → `Account`


### `deal` → `dealer__Deal__c`


### `deal_id` → `String`


### `deal_name` → `String`


### `discountList` → `List<dealer__Discount_Rebate__c>`


### `financeCo` → `dealer__Finance_Company__c`


### `form` → `dealer__Form__c`


### `formCode` → `String`


### `form_id` → `String`


### `form_id_editor` → `String`


### `location` → `dealer__Dealer_Location__c`


### `newForm` → `dealer__Form__c`


### `serviceContractList` → `List<dealer__Service_Contract__c>`


### `sup` → `dealer__Sales_Up__c`


### `taxList` → `List<dealer__Deal_Tax__c>`


### `tradeIn1` → `dealer__Trade_In__c`


### `tradeIn2` → `dealer__Trade_In__c`


### `tradeIn3` → `dealer__Trade_In__c`


### `tradeInList` → `List<dealer__Trade_In__c>`


### `tradeInList2` → `List<dealer__Trade_In__c>`


### `vehicle` → `dealer__Vehicle_Inventory__c`


---
## Methods
### `getConfig()`
### `getObjectFieldNames()`
### `getObjectFieldNamesSimple()`
### `newForm()`
### `saveNewForm()`
### `updateForm()`
### `formsList()`
### `getPreview()`
### `getFDF()`

getFDF - fdf string compiler

#### Return

**Type**

Component.Apex.OutputText

**Description**

OutputText component for render in page

### `base64Decode(String s)`
### `lookupForm(Id formId)`
### `static getForm(Id formId)`

`AURAENABLED`
### `lookupAppraisal(Id AprId)`
#### Parameters

|Param|Description|
|---|---|
|`appraisalId`|record Id of the Appraisal you would like to view|

#### Return

**Type**

dealer__Appraisal__c

**Description**

[returns a database query of the selected appraisal]


**Method** lookupAppraisal

### `lookupDeal(Id dealId)`
#### Parameters

|Param|Description|
|---|---|
|`dealId`|record Id of the deal you would like to view|

#### Return

**Type**

dealer__Deal__c

**Description**

[returns a database query of the selected deal]


**Method** lookupDeal

### `lookupTradeIns(Id dealId)`

**Method** lookupTradeIns

### `getForms()`
### `compileFormSource()`
### `setDealId()`
### `getBuyer()`
### `getCoBuyer()`
### `getisPersonAccount()`
### `gettradeIn1()`
### `gettradeIn2()`
### `gettradeIn3()`
### `retreiveTaxList()`
### `retreiveDiscountList()`
### `retreiveAftermarketList()`
### `retreiveServiceContractList()`
---
## Classes
### cDeal
#### Constructors
##### `cDeal(dealer__Deal__c d)`
---
#### Properties

##### `Id` → `String`


##### `buyerName` → `String`


##### `name` → `String`


---

---
