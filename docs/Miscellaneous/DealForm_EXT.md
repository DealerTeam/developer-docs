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
|Param|Description|
|-----|-----------|
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

List<dealer__Discount_Rebate__c>

**Description**

List<dealer__Discount_Rebate__c>

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

List<SelectOption>

**Description**

List<SelectOption>

### `getNonTaxableFees()` → `List<dealer__Sales_Fee__c>`
#### Return

**Type**

List<dealer__Sales_Fee__c>

**Description**

List<dealer__Sales_Fee__c>

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

List<dealer__Sales_Fee__c>

**Description**

List<dealer__Sales_Fee__c>

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
