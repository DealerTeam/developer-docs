---
layout: default
---
# DealPrintController



**Class** DealPrintController


**Group** Sales

## Constructors
### `global DealPrintController(ApexPages controller)`
#### Parameters

|Param|Description|
|---|---|
|`controller`||


**Method** DealPrintController

---
## Properties

### `global amListTaxable` → `List<After_Market__c>`

`DEPRECATED` 

### `global amListNonTaxable` → `List<After_Market__c>`

`DEPRECATED` 

### `global dealW` → `DealAPI`


### `global InvoiceLogo` → `String`


### `global amList` → `List<After_Market__c>`


### `global tradeInWrapper` → `List<payOffWrapper>`


### `global hasTradeIn` → `Boolean`


### `global tradeVehicle` → `Vehicle_Inventory__c`


### `global printedForm` → `Form__c`


### `public dealId` → `Id`


---
## Methods
### `global List<After_Market__c> getamList()`

getter method for supplying printable after market items to deal forms

#### Returns

|Type|Description|
|---|---|
|`List<After_Market__c>`|List<after_market__c> List of form printable after market records|


**Method** getAmList

### `global List<payOffWrapper> gettradeInWrapper()`

getter class for wrapping related  loanPayoff and trade records by appraisal

#### Returns

|Type|Description|
|---|---|
|`List<payOffWrapper>`|List<payOffWrapper> List of related loanPayoff and trade In records|


**Method** gettradeInWrapper

---
## Classes
### payOffWrapper
#### Constructors
##### `private payOffWrapper(dealer__Trade_In__c trades, dealer__LoanPayoff__c payOffs)`
---
#### Properties

##### `global TradeIn` → `dealer__Trade_In__c`


##### `global loanPayOff` → `dealer__LoanPayoff__c`


---

---
