# DealPrintController class

@description

---
## Constructors
### `DealPrintController(ApexPages.StandardController controller)`
#### Parameters

| Param | Description |
| ----- | ----------- |
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

### `tradeVehicle` → `Vehicle_Inventory__c`

---
## Methods
### `getamList()` → `List<After_Market__c>`

getter method for supplying printable after market items to deal forms

#### Parameters

| Param | Description |
| ----- | ----------- |
|`` | e |

#### Return

**Type**

List&lt;After_Market__c&gt;

**Description**

List&lt;after_market__c&gt; List of form printable after market records

### `gettradeInWrapper()` → `List<payOffWrapper>`

getter class for wrapping related  loanPayoff and trade records by appraisal

#### Parameters

| Param | Description |
| ----- | ----------- |
|`` | e |

#### Return

**Type**

List&lt;payOffWrapper&gt;

**Description**

List&lt;payOffWrapper&gt; List of related loanPayoff and trade In records

---
## Inner Classes

### DealPrintController.payOffWrapper class
---
#### Properties

##### `TradeIn` → `dealer__Trade_In__c`

##### `loanPayOff` → `dealer__LoanPayoff__c`

---
