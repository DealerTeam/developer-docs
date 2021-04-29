# DealPrintController class

@description

---
## Constructors
### `DealPrintController(ApexPages.StandardController controller)`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | r |

---
## Properties

### `InvoiceLogo` → `String`

@description

### `amList` → `List<After_Market__c>`

### `amListNonTaxable` → `List<After_Market__c>`

### `amListTaxable` → `List<After_Market__c>`

### `dealW` → `DealAPI.Deal`

@description

### `hasTradeIn` → `Boolean`

### `tradeInWrapper` → `List<payOffWrapper>`

---
## Methods
### `getamList()` → `List<After_Market__c>`
### `gettradeInWrapper()` → `List<payOffWrapper>`
---
## Inner Classes

### DealPrintController.payOffWrapper class
---
#### Properties

##### `TradeIn` → `dealer__Trade_In__c`

##### `loanPayOff` → `dealer__LoanPayoff__c`

---
