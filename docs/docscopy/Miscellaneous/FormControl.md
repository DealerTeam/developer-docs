---
layout: default
---
# FormControl class

 Date            |Developer            |Work# Notes -- 2016.11.23      |Sneha Utture            |Case #2193 Created FormAPI class based on the FormControl class to use static methods to perform functions as the service layer of the application

---
## Constructors
### `FormControl()`
---
## Properties

### `aftermarketList` → `List<dealer__After_Market__c>`

### `appraisal` → `dealer__Appraisal__c`

### `appraisal_id` → `String`

### `config` → `dealer__SalesDeskLogSettings__c`

### `deal` → `public`

### `deal_id` → `String`

### `deal_name` → `String`

### `discountList` → `List<dealer__Discount_Rebate__c>`

### `financeCo` → `dealer__Finance_Company__c`

### `form` → `dealer__Form__c`

### `formCode` → `String`

### `formLines` → `List<List<String>>>`

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
### `base64Decode(String s)` → `String`
### `compileFormSource()` → `PageReference`
### `formsList()` → `PageReference`
### `getBuyer()` → `Account`
### `getCoBuyer()` → `Account`
### `getConfig()` → `dealer__SalesDeskLogSettings__c`
### `getFDF()` → `Component.Apex.OutputText`

 getFDF - fdf string compiler

### `getForm(Id formId)` → `Form__c`
### `getForms()` → `List<dealer__Form__c>`
### `getObjectFieldNames()` → `List<String>`
### `getObjectFieldNamesSimple()` → `String`
### `getPreview()` → `Component.Apex.OutputText`
### `getisPersonAccount()` → `Boolean`
### `gettradeIn1()` → `dealer__Trade_In__c`
### `gettradeIn2()` → `dealer__Trade_In__c`
### `gettradeIn3()` → `dealer__Trade_In__c`
### `lookupAppraisal(Id AprId)` → `dealer__Appraisal__c`

 lookupAppraisal

#### Parameters
|Param|Description|
|-----|-----------|
|`appraisalId` |  record Id of the Appraisal you would like to view |

### `lookupDeal(Id dealId)` → `dealer__Deal__c`

 lookupDeal

#### Parameters
|Param|Description|
|-----|-----------|
|`dealId` |  record Id of the deal you would like to view |

### `lookupForm(Id formId)` → `dealer__Form__c`
### `lookupTradeIns(Id dealId)` → `List<dealer__Trade_In__c>`

 lookupTradeIns

### `newForm()` → `PageReference`
### `retreiveAftermarketList()` → `List<dealer__After_Market__c>`
### `retreiveDiscountList()` → `List<dealer__Discount_Rebate__c>`
### `retreiveServiceContractList()` → `List<dealer__Service_Contract__c>`
### `retreiveTaxList()` → `List<dealer__Deal_Tax__c>`
### `saveNewForm()` → `PageReference`
### `setDealId()` → `PageReference`
### `updateForm()` → `PageReference`
---
## Inner Classes

### FormControl.cDeal class
---
#### Constructors
##### `cDeal(dealer__Deal__c d)`
---
#### Properties

##### `Id` → `String`

##### `buyerName` → `String`

##### `name` → `String`

---
