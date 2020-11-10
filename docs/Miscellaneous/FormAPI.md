---
layout: default
---
# FormAPI class
---
## Methods
### `base64Decode(String s)` → `String`
### `bundleForms(Id dealId, List < Form__c > forms)` → `String`
### `getBuyer(dealer__Deal__c deal)` → `Account`
### `getCoBuyer(dealer__Deal__c deal)` → `Account`
### `getFDF(dealer__Form__c form)` → `Component.Apex.OutputText`
### `getObjectFieldNames()` → `List<String>`
### `getObjectFieldNamesSimple()` → `String`
### `getPreview(dealer__Form__c form)` → `Component.Apex.OutputText`
### `getisPersonAccount(dealer__Deal__c deal)` → `Boolean`
### `lookupAppraisal(Id aprId)` → `dealer__Appraisal__c`
### `lookupDeal(Id dealId)` → `dealer__Deal__c`
### `lookupTradeIns(Id dealId)` → `List<dealer__Trade_In__c>`
### `mergeForms(Id dealId, List<Form__c> forms)` → `String`
### `preventFieldOverlap(Set<String> fieldMetadataKeyset)` → `List<String>`
### `processFeeVariables(Form__c form, Deal__c deal)` → `Form__c`
### `retreiveAftermarketList(dealer__Deal__c deal)` → `List<dealer__After_Market__c>`
### `retreiveDiscountList(dealer__Deal__c deal)` → `List<dealer__Discount_Rebate__c>`
### `retreiveServiceContractList(dealer__Deal__c deal)` → `List<dealer__Service_Contract__c>`
### `retreiveTaxList(dealer__Deal__c deal)` → `List<dealer__Deal_Tax__c>`
### `retrieveFees(Deal__c deal)` → `dealer__Sales_Fee__c>`
---
## Inner Classes

### FormAPI.FormAPIException class
---
### FormAPI.formWrapper class
---
#### Constructors
##### `formWrapper(String documentId, String docType, String content, string mergeData)`
---
