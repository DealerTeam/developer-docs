---
layout: default
---
# DealershipLocationAPI class

@description

---
## Properties

### `AuraFee` → `List<`

### `CoveredSystems` → `List<CoveredSystem>`

@description

### `Fees` → `List<Fee>`

@description

---
## Methods
### `createLocationFees(Dealer_Location__c dealerLocation, String feeJSON)` → `String`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | n |
|`` | N |

### `editFee(Dealer_Location__c location, String feeJSON)` → `Dealer_Location__c`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | n |
|`` | N |

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
|`` | d |

### `getLocationFeesLWC(Id LocationId)` → `List<AuraFee>`
---
## Inner Classes

### DealershipLocationAPI.AuraFee class
---
#### Properties

##### `feeCode` → `String`

##### `feeDefaultAmount` → `String`

##### `feeDefaultAmountByFormulaField` → `String`

##### `feeDefaultByFormulaField` → `String`

##### `feeDefaultOnDeals` → `String`

##### `feeDefaultOnDealsByFormulaField` → `String`

##### `feeDescription` → `String`

##### `feeName` → `String`

##### `feeTaxable` → `String`

---
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
