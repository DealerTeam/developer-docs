# DealForm_EXT

`APIVERSION: 45`

`STATUS: ACTIVE`

Mobility Deal Controller Extension


**Class** DealForm_EXT


**Group** Sales

## Constructors
### `DealForm_EXT(ApexPages.StandardController controller)`

Constructor

### `DealForm_EXT()`

**Method** DealForm_EXT

---
## Fields

### `urlParams` → `Map<String,String>`


---
## Properties

### `TradeTaxCredit` → `Decimal`


### `deal` → `dealer__Deal__c`


### `dealId` → `String`


### `selectedKits` → `List<dealer__After_Market__c>`


### `serviceContractPremium` → `Decimal`


Forms Variables

### `soldOnProposal` → `List<dealer__Service_Contract__c>`


getter for service contracts sold on proposal

### `sup` → `dealer__Sales_Up__c`


### `tradeInList` → `List<dealer__Trade_In__c>`


### `vehRetailPrice` → `Decimal`


---
## Methods
### `getVehRetail()`
#### Return

**Type**

Decimal

**Description**

Decimal


**Method** getVehRetail

### `calcTradeTaxCredit()`
#### Return

**Type**

decimal

**Description**

decimal


**Method** calcTradeTaxCredit description

### `getAutoGrantPayor()`

**Method** getAutoGrantPayor

### `getPayor1()`

**Method** getPayor1

### `getPayor2()`
### `getPayor3()`
### `getServiceContractTotal()`
#### Return

**Type**

Decimal

**Description**

Decimal


**Method** getServiceContractTotal

### `getLeadSourcePicklist()`
### `getLeadTypePicklist()`
#### Return

**Type**

List&lt;SelectOption&gt;

**Description**

List&lt;SelectOption&gt;


**Method** getLeadTypePicklist

### `getDiscounts()`
#### Return

**Type**

List&lt;dealer__Discount_Rebate__c&gt;

**Description**

List&lt;dealer__Discount_Rebate__c&gt;


**Method** getDiscounts

### `getTaxableFees()`
#### Return

**Type**

List&lt;dealer__Sales_Fee__c&gt;

**Description**

List&lt;dealer__Sales_Fee__c&gt;


**Method** getTaxableFees

### `getNonTaxableFees()`
#### Return

**Type**

List&lt;dealer__Sales_Fee__c&gt;

**Description**

List&lt;dealer__Sales_Fee__c&gt;


**Method** getNonTaxableFees

### `getTotalTradeGross()`
#### Return

**Type**

Decimal

**Description**

Decimal


**Method** getTotalTradeGross description

### `getTotalAllowance()`
#### Return

**Type**

Decimal

**Description**

Decimal


**Method** getTotalAllowance

### `getShowTradeAllowance()`
#### Return

**Type**

boolean

**Description**

boolean


**Method** getShowTradeAllowance

### `getInvoiceLogo()`
#### Return

**Type**

String

**Description**

String


**Method** getInvoiceLogo

### `static createBlankDeal(String jsonPayload)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`jsonPayload`||

#### Return

**Type**

Id

**Description**

Id


**Method** createBlankDeal

---
