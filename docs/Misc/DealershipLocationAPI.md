# DealershipLocationAPI

`APIVERSION: 45`

`STATUS: ACTIVE`

## Fields

### `CoveredSystems` → `List<CoveredSystem>`

### `Fees` → `List<Fee>`

***

## Methods

### `static formLogoURL(Id locationId)`

#### Parameters

### `static getLocationFees(Id LocationId)`

#### Parameters

### `static getCoveredSystems(Id LocationId)`

#### Parameters

***

## Classes

### CoveredSystem

#### Properties

**`duration` → `String`**

**`systemCovered` → `String`**

**`warrantyType` → `String`**

***

### DealershipLocationAPIException

### Fee

#### Properties

**`feeCode` → `String`**

**`feeDefaultAmount` → `Decimal`**

**`feeDefaultAmountByFormulaField` → `String`**

**`feeDefaultByFormulaField` → `String`**

**`feeDefaultOnDeals` → `Boolean`**

**`feeDefaultOnDealsByFormulaField` → `String`**

**`feeDescription` → `String`**

**`feeName` → `String`**

**`feeTaxable` → `Boolean`**

***

***
