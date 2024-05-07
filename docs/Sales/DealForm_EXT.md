---
layout: default
---
# DealForm_EXT

Mobility Deal Controller Extension


**Class** DealForm_EXT


**Group** Sales

## Constructors
### `global DealForm_EXT(ApexPages controller)`

Constructor

### `global DealForm_EXT()`

**Method** DealForm_EXT

---
## Fields

### `global urlParams` → `Map<String,String>`


---
## Properties

### `global dealId` → `String`


### `global vehRetailPrice` → `Decimal`


### `global deal` → `dealer__Deal__c`


### `global sup` → `dealer__Sales_Up__c`


### `global TradeTaxCredit` → `Decimal`


### `global serviceContractPremium` → `Decimal`


Forms Variables

### `global soldOnProposal` → `List<dealer__Service_Contract__c>`


getter for service contracts sold on proposal

### `global tradeInList` → `List<dealer__Trade_In__c>`


### `global selectedKits` → `List<dealer__After_Market__c>`


---
## Methods
### `global Decimal getVehRetail()`
#### Returns

|Type|Description|
|---|---|
|`Decimal`|Decimal|


**Method** getVehRetail

### `global decimal calcTradeTaxCredit()`
#### Returns

|Type|Description|
|---|---|
|`decimal`|decimal|


**Method** calcTradeTaxCredit description

### `global Account getAutoGrantPayor()`

**Method** getAutoGrantPayor

### `global Account getPayor1()`

**Method** getPayor1

### `global Account getPayor2()`
### `global Account getPayor3()`
### `global Decimal getServiceContractTotal()`
#### Returns

|Type|Description|
|---|---|
|`Decimal`|Decimal|


**Method** getServiceContractTotal

### `global List<SelectOption> getLeadSourcePicklist()`
### `global List<SelectOption> getLeadTypePicklist()`
#### Returns

|Type|Description|
|---|---|
|`List<SelectOption>`|List<SelectOption>|


**Method** getLeadTypePicklist

### `global List<dealer__Discount_Rebate__c> getDiscounts()`
#### Returns

|Type|Description|
|---|---|
|`List<dealer__Discount_Rebate__c>`|List<dealer__Discount_Rebate__c>|


**Method** getDiscounts

### `global List<dealer__Sales_Fee__c> getTaxableFees()`
#### Returns

|Type|Description|
|---|---|
|`List<dealer__Sales_Fee__c>`|List<dealer__Sales_Fee__c>|


**Method** getTaxableFees

### `global List<dealer__Sales_Fee__c> getNonTaxableFees()`
#### Returns

|Type|Description|
|---|---|
|`List<dealer__Sales_Fee__c>`|List<dealer__Sales_Fee__c>|


**Method** getNonTaxableFees

### `global Decimal getTotalTradeGross()`
#### Returns

|Type|Description|
|---|---|
|`Decimal`|Decimal|


**Method** getTotalTradeGross description

### `global Decimal getTotalAllowance()`
#### Returns

|Type|Description|
|---|---|
|`Decimal`|Decimal|


**Method** getTotalAllowance

### `global boolean getShowTradeAllowance()`
#### Returns

|Type|Description|
|---|---|
|`boolean`|boolean|


**Method** getShowTradeAllowance

### `global String getInvoiceLogo()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getInvoiceLogo

### `global static Id createBlankDeal(String jsonPayload)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`jsonPayload`||

#### Returns

|Type|Description|
|---|---|
|`Id`|Id|


**Method** createBlankDeal

---
