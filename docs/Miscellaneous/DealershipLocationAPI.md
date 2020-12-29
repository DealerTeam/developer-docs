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

#### Return

**Type**

String

**Description**

String

### `getCoveredSystems(Id LocationId)` → `List<CoveredSystem>`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

#### Return

**Type**

List<CoveredSystem>

**Description**

List<CoveredSystem>

### `getLocationFees(Id LocationId)` → `List<Fee>`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | n |
|`` | N |
|`` | d |

#### Return

**Type**

List<Fee>

**Description**

List<Fee>

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
