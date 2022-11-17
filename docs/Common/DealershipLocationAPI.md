# DealershipLocationAPI

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** DealershipLocationAPI


**Group** Common

## Fields

### `AuraFee` → `List<AuraFee>`


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

### `static formLogoUrlByLocation(List<Dealer_Location__c> locations)`
#### Parameters

|Param|Description|
|---|---|
|`List`|<Dealer_Location__c>|

#### Return

**Type**

Map&lt;Id,String&gt;

**Description**

Map&lt;Id,String&gt;


**Method** formLogoUrlByLocation

### `static createLocationFees(Dealer_Location__c dealerLocation, String feeJSON)`
#### Parameters

|Param|Description|
|---|---|
|`dealerLocation`||
|`feeJSON`||

#### Return

**Type**

String

**Description**

String


**Method** createLocationFees

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

### `static getLocationFeesLWC(Id LocationId)`
### `static editFee(Dealer_Location__c location, String feeJSON)`
#### Parameters

|Param|Description|
|---|---|
|`location`||
|`feeJSON`||

#### Return

**Type**

Dealer_Location__c

**Description**

Dealer_Location__c


**Method** editFee

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
### AuraFee
#### Properties

##### `feeCode` → `String`

`AURAENABLED` 

##### `feeDefaultAmount` → `String`

`AURAENABLED` 

##### `feeDefaultAmountByFormulaField` → `String`

`AURAENABLED` 

##### `feeDefaultByFormulaField` → `String`

`AURAENABLED` 

##### `feeDefaultOnDeals` → `String`

`AURAENABLED` 

##### `feeDefaultOnDealsByFormulaField` → `String`

`AURAENABLED` 

##### `feeDescription` → `String`

`AURAENABLED` 

##### `feeName` → `String`

`AURAENABLED` 

##### `feeTaxable` → `String`

`AURAENABLED` 

---

### CoveredSystem


#### Properties

##### `duration` → `String`


##### `systemCovered` → `String`


##### `warrantyType` → `String`


---

### DealershipLocationAPIException



**Inheritance**

DealershipLocationAPIException


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
