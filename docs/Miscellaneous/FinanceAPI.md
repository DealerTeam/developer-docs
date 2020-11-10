---
layout: default
---
# FinanceAPI class
---
## Constructors
### `FinanceAPI()`
---
## Methods
### `calculateMonthlyPayment(Decimal principle, Decimal rate, Decimal term, Decimal days)` → `Decimal`
---
## Inner Classes

### FinanceAPI.financeTable class
---
#### Constructors
##### `financeTable(Decimal principle, Decimal down, Decimal rate, Decimal increment, Decimal days)`
---
#### Properties

##### `header` → `financeTableHeader`

##### `rows` → `List<financeTableRow>`

---
### FinanceAPI.financeTableHeader class
---
#### Constructors
##### `financeTableHeader(Decimal increment1, Decimal increment2, Decimal increment3, Decimal increment4)`
---
#### Properties

##### `increment1` → `Decimal`

##### `increment2` → `Decimal`

##### `increment3` → `Decimal`

##### `increment4` → `Decimal`

##### `rate` → `String`

##### `term` → `String`

---
### FinanceAPI.financeTableRow class
---
#### Constructors
##### `financeTableRow(Decimal term, Decimal rate, Decimal payment1, Decimal payment2, Decimal payment3, Decimal payment4)`
---
#### Properties

##### `payment1` → `Decimal`

##### `payment2` → `Decimal`

##### `payment3` → `Decimal`

##### `payment4` → `Decimal`

##### `rate` → `Decimal`

##### `term` → `Decimal`

---
