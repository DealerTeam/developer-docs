---
layout: default
---
# FinanceAPI



**Group** Sales

## Constructors
### `public FinanceAPI()`
---
## Methods
### `public static Decimal calculateMonthlyPayment(Decimal principle, Decimal rate, Decimal term, Decimal days)`

Calculates total payments for term of a loan

#### Parameters

|Param|Description|
|---|---|
|`principle`|principle|
|`rate`|rate|
|`term`|term in months|
|`days`|days until first payment|

#### Returns

|Type|Description|
|---|---|
|`Decimal`|return description|


**Name** calculateTotalOfPayments

### `public static Decimal calculateTotalOfPayments(Decimal principle, Decimal rate, Decimal term, Decimal days)`

Calculates total payments for term of a loan

#### Parameters

|Param|Description|
|---|---|
|`principle`|principle|
|`rate`|rate|
|`term`|term in months|
|`days`|days until first payment|

#### Returns

|Type|Description|
|---|---|
|`Decimal`|return description|


**Name** calculateTotalOfPayments

---
## Classes
### financeTable
#### Constructors
##### `public financeTable(Decimal principle, Decimal down, Decimal rate, Decimal increment, Decimal days)`
---
#### Fields

##### `private step` → `Decimal`


##### `private terms` → `List&lt;Decimal&gt;`


##### `public header` → `financeTableHeader`

`AURAENABLED` 

##### `public rows` → `List&lt;financeTableRow&gt;`

`AURAENABLED` 

---

### financeTableHeader
#### Constructors
##### `public financeTableHeader(Decimal increment1, Decimal increment2, Decimal increment3, Decimal increment4)`
---
#### Fields

##### `public term` → `String`

`AURAENABLED` 

##### `public rate` → `String`

`AURAENABLED` 

##### `public increment1` → `Decimal`

`AURAENABLED` 

##### `public increment2` → `Decimal`

`AURAENABLED` 

##### `public increment3` → `Decimal`

`AURAENABLED` 

##### `public increment4` → `Decimal`

`AURAENABLED` 

---

### financeTableRow
#### Constructors
##### `public financeTableRow(Decimal term, Decimal rate, Decimal payment1, Decimal payment2, Decimal payment3, Decimal payment4)`
---
#### Fields

##### `public term` → `Decimal`

`AURAENABLED` 

##### `public rate` → `Decimal`

`AURAENABLED` 

##### `public payment1` → `Decimal`

`AURAENABLED` 

##### `public payment2` → `Decimal`

`AURAENABLED` 

##### `public payment3` → `Decimal`

`AURAENABLED` 

##### `public payment4` → `Decimal`

`AURAENABLED` 

---

---
