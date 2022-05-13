# DealForm_EXT

`APIVERSION: 45`

`STATUS: ACTIVE`

DealForm_EXT 
 * @group Sales

## Constructors
### `DealForm_EXT(ApexPages.StandardController controller)`

Constructor

#### Parameters
|Param|Description|
|---|---|

### `DealForm_EXT()`

DealForm_EXT 
     * @description

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


SoldOnProposal

### `sup` → `dealer__Sales_Up__c`


### `tradeInList` → `List<dealer__Trade_In__c>`


### `vehRetailPrice` → `Decimal`


---
## Methods
### `getVehRetail()`
### `calcTradeTaxCredit()`
### `getAutoGrantPayor()`
### `getPayor1()`

getPayor1 
     * @description

### `getPayor2()`
### `getPayor3()`
### `getServiceContractTotal()`
### `getLeadSourcePicklist()`
### `getLeadTypePicklist()`
### `getDiscounts()`
### `getTaxableFees()`
### `getNonTaxableFees()`
### `getTotalTradeGross()`
### `getTotalAllowance()`
### `getShowTradeAllowance()`
### `getInvoiceLogo()`
### `static createBlankDeal(String jsonPayload)`

`REMOTEACTION`
#### Parameters
|Param|Description|
|---|---|

---
