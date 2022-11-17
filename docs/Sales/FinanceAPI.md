# FinanceAPI

`APIVERSION: 47`

`STATUS: ACTIVE`



**Group** Sales

## Constructors
### `FinanceAPI()`
---
## Methods
### `static calculateMonthlyPayment(Decimal principle, Decimal rate, Decimal term, Decimal days)`
---
## Classes
### financeTable
#### Constructors
##### `financeTable(Decimal principle, Decimal down, Decimal rate, Decimal increment, Decimal days)`
---
#### Fields

##### `header` → `financeTableHeader`

`AURAENABLED` 

##### `rows` → `List&lt;financeTableRow&gt;`

`AURAENABLED` 

---

### financeTableHeader
#### Constructors
##### `financeTableHeader(Decimal increment1, Decimal increment2, Decimal increment3, Decimal increment4)`
---
#### Fields

##### `increment1` → `Decimal`

`AURAENABLED` 

##### `increment2` → `Decimal`

`AURAENABLED` 

##### `increment3` → `Decimal`

`AURAENABLED` 

##### `increment4` → `Decimal`

`AURAENABLED` 

##### `rate` → `String`

`AURAENABLED` 

##### `term` → `String`

`AURAENABLED` 

---

### financeTableRow
#### Constructors
##### `financeTableRow(Decimal term, Decimal rate, Decimal payment1, Decimal payment2, Decimal payment3, Decimal payment4)`
---
#### Fields

##### `payment1` → `Decimal`

`AURAENABLED` 

##### `payment2` → `Decimal`

`AURAENABLED` 

##### `payment3` → `Decimal`

`AURAENABLED` 

##### `payment4` → `Decimal`

`AURAENABLED` 

##### `rate` → `Decimal`

`AURAENABLED` 

##### `term` → `Decimal`

`AURAENABLED` 

---

---
