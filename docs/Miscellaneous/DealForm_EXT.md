---
layout: default
---
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

### `urlParams` → `String>`

@description

### `vehRetailPrice` → `Decimal`

@description

---
## Methods
### `calcTradeTaxCredit()` → `decimal`
### `createBlankDeal(String jsonPayload)` → `Id`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `getAutoGrantPayor()` → `Account`
### `getDiscounts()` → `List<dealer__Discount_Rebate__c>`
### `getInvoiceLogo()` → `String`
### `getLeadSourcePicklist()` → `List<SelectOption>`
### `getLeadTypePicklist()` → `List<SelectOption>`

 getLeadTypePicklist

### `getNonTaxableFees()` → `List<dealer__Sales_Fee__c>`
### `getPayor1()` → `Account`
### `getPayor2()` → `Account`
### `getPayor3()` → `Account`
### `getServiceContractTotal()` → `Decimal`

 getServiceContractTotal

### `getShowTradeAllowance()` → `boolean`
### `getTaxableFees()` → `List<dealer__Sales_Fee__c>`
### `getTotalAllowance()` → `Decimal`
### `getTotalTradeGross()` → `Decimal`
### `getVehRetail()` → `Decimal`

 getVehRetail

---
