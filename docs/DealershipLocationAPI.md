# DealershipLocationAPI

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** DealershipLocationAPI


**Group** 

## Fields

### `CoveredSystems` → `List<CoveredSystem>`


### `Fees` → `List<Fee>`


---
## Methods
### `static formLogoURL(Id locationId)`
#### Parameters

|Param|Description|
|---|---|
|`locationId`||

#### Return

**Type**

String

**Description**

String


**Method** formLogoURL


**Descriptoin** 

### `static getLocationFees(Id LocationId)`
#### Parameters

|Param|Description|
|---|---|
|`LocationId`||

#### Return

**Type**

List&lt;Fee&gt;

**Description**

List&lt;Fee&gt;


**Method** getLocationFees

### `static getCoveredSystems(Id LocationId)`
#### Parameters

|Param|Description|
|---|---|
|`LocationId`||

#### Return

**Type**

List&lt;CoveredSystem&gt;

**Description**

List&lt;CoveredSystem&gt;


**Method** getCoveredSystems

---
## Classes
### CoveredSystem


#### Properties

##### `duration` → `String`


##### `systemCovered` → `String`


##### `warrantyType` → `String`


---

### DealershipLocationAPIException



### Fee


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

---
