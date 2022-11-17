# DealPrintController

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** DealPrintController


**Group** Sales

## Constructors
### `DealPrintController(ApexPages.StandardController controller)`
#### Parameters

|Param|Description|
|---|---|
|`controller`||


**Method** DealPrintController

---
## Properties

### `InvoiceLogo` → `String`


### `amList` → `List<After_Market__c>`


### `amListNonTaxable` → `List<After_Market__c>`


### `amListTaxable` → `List<After_Market__c>`


### `dealId` → `Id`


### `dealW` → `DealAPI.Deal`


### `hasTradeIn` → `Boolean`


### `printedForm` → `Form__c`


### `tradeInWrapper` → `List<payOffWrapper>`


### `tradeVehicle` → `Vehicle_Inventory__c`


---
## Methods
### `getamList()`

getter method for supplying printable after market items to deal forms

#### Return

**Type**

List&lt;After_Market__c&gt;

**Description**

List&lt;after_market__c&gt; List of form printable after market records


**Method** getAmList

### `gettradeInWrapper()`

getter class for wrapping related  loanPayoff and trade records by appraisal

#### Return

**Type**

List&lt;payOffWrapper&gt;

**Description**

List&lt;payOffWrapper&gt; List of related loanPayoff and trade In records


**Method** gettradeInWrapper

---
## Classes
### payOffWrapper
#### Properties

##### `TradeIn` → `dealer__Trade_In__c`


##### `loanPayOff` → `dealer__LoanPayoff__c`


---

---
