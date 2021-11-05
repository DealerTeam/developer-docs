# DealForm_EXT class

Mobility Deal Controller Extension

---
## Constructors
### `DealForm_EXT(ApexPages.StandardController controller)`

Constructor
### `DealForm_EXT()`
---
## Properties

### `TradeTaxCredit` → `Decimal`

@description

### `deal` → `global`

@description

### `dealId` → `String`

@description

### `selectedKits` → `List<dealer__After_Market__c>`

@description

### `serviceContractPremium` → `Decimal`

Forms Variables

### `soldOnProposal` → `List<dealer__Service_Contract__c>`

getter for service contracts sold on proposal

### `sup` → `dealer__Sales_Up__c`

@description

### `tradeInList` → `List<dealer__Trade_In__c>`

@description

### `urlParams` → `Map<String, String>`

@description

### `vehRetailPrice` → `Decimal`

@description

---
## Methods
### `calcTradeTaxCredit()` → `decimal`
#### Return

**Type**

decimal

**Description**

decimal

### `createBlankDeal(String jsonPayload)` → `Id`
#### Parameters

| Param | Description |
| ----- | ----------- |
|`` | d |

#### Return

**Type**

Id

**Description**

Id

### `getAutoGrantPayor()` → `Account`
### `getDiscounts()` → `List<dealer__Discount_Rebate__c>`
#### Return

**Type**

List&lt;dealer__Discount_Rebate__c&gt;

**Description**

List&lt;dealer__Discount_Rebate__c&gt;

### `getInvoiceLogo()` → `String`
#### Return

**Type**

String

**Description**

String

### `getLeadSourcePicklist()` → `List<SelectOption>`
### `getLeadTypePicklist()` → `List<SelectOption>`

 getLeadTypePicklist

#### Return

**Type**

List&lt;SelectOption&gt;

**Description**

List&lt;SelectOption&gt;

### `getNonTaxableFees()` → `List<dealer__Sales_Fee__c>`
#### Return

**Type**

List&lt;dealer__Sales_Fee__c&gt;

**Description**

List&lt;dealer__Sales_Fee__c&gt;

### `getPayor1()` → `Account`
### `getPayor2()` → `Account`
### `getPayor3()` → `Account`
### `getServiceContractTotal()` → `Decimal`

 getServiceContractTotal

#### Return

**Type**

Decimal

**Description**

Decimal

### `getShowTradeAllowance()` → `boolean`
#### Return

**Type**

boolean

**Description**

boolean

### `getTaxableFees()` → `List<dealer__Sales_Fee__c>`
#### Return

**Type**

List&lt;dealer__Sales_Fee__c&gt;

**Description**

List&lt;dealer__Sales_Fee__c&gt;

### `getTotalAllowance()` → `Decimal`
#### Return

**Type**

Decimal

**Description**

Decimal

### `getTotalTradeGross()` → `Decimal`
#### Return

**Type**

Decimal

**Description**

Decimal

### `getVehRetail()` → `Decimal`

 getVehRetail

#### Return

**Type**

Decimal

**Description**

Decimal

---
