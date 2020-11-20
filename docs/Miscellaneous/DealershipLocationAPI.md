---
layout: default
---
# DealershipLocationAPI class

@description

---
## Properties

### `CoveredSystems` → `List<CoveredSystem>`

@description

### `Fees` → `List<Fee>`

@description

---
## Methods
### `formLogoURL(Id locationId)` → `String`

 formLogoURL

#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `getCoveredSystems(Id LocationId)` → `List<CoveredSystem>`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `getLocationFees(Id LocationId)` → `List<Fee>`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | n |
|`` | N |
|`` | d |

---
## Inner Classes

### DealershipLocationAPI.CoveredSystem class

@description

---
#### Properties

##### `duration` → `String`

##### `systemCovered` → `String`

##### `warrantyType` → `String`

---
### DealershipLocationAPI.DealershipLocationAPIException class

@description

---
### DealershipLocationAPI.Fee class

@description

---
#### Properties

##### `feeCode` → `String`

##### `feeDefaultAmount` → `Decimal`

##### `feeDefaultAmountByFormulaField` → `String`

##### `feeDefaultByFormulaField` → `String`

##### `feeDefaultOnDeals` → `Boolean`

##### `feeDefaultOnDealsByFormulaField` → `String`

##### `feeDescription` → `String`

##### `feeName` → `String`

##### `feeTaxable` → `Boolean`

---
