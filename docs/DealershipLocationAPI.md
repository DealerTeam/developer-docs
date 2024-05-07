---
layout: default
---
# DealershipLocationAPI



**Class** DealershipLocationAPI


**Group** 

## Fields

### `global Fees` → `List<Fee>`


### `public AuraFee` → `List<AuraFee>`


### `global CoveredSystems` → `List<CoveredSystem>`


---
## Methods
### `global static String formLogoURL(Id locationId)`
#### Parameters

|Param|Description|
|---|---|
|`locationId`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** formLogoURL


**Descriptoin** 

### `public static Map<Id,String> formLogoUrlByLocation(List<Dealer_Location__c> locations)`
#### Parameters

|Param|Description|
|---|---|
|`List`|<Dealer_Location__c>|

#### Returns

|Type|Description|
|---|---|
|`Map<Id,String>`|Map<Id,String>|


**Method** formLogoUrlByLocation

### `public static String createLocationFees(Dealer_Location__c dealerLocation, String feeJSON)`
#### Parameters

|Param|Description|
|---|---|
|`dealerLocation`||
|`feeJSON`||

#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** createLocationFees

### `global static List<Fee> getLocationFees(Id LocationId)`
#### Parameters

|Param|Description|
|---|---|
|`LocationId`||

#### Returns

|Type|Description|
|---|---|
|`List<Fee>`|List<Fee>|


**Method** getLocationFees

### `public static List<AuraFee> getLocationFeesLWC(Id LocationId)`
### `public static Dealer_Location__c editFee(Dealer_Location__c location, String feeJSON)`
#### Parameters

|Param|Description|
|---|---|
|`location`||
|`feeJSON`||

#### Returns

|Type|Description|
|---|---|
|`Dealer_Location__c`|Dealer_Location__c|


**Method** editFee

### `global static List<CoveredSystem> getCoveredSystems(Id LocationId)`
#### Parameters

|Param|Description|
|---|---|
|`LocationId`||

#### Returns

|Type|Description|
|---|---|
|`List<CoveredSystem>`|List<CoveredSystem>|


**Method** getCoveredSystems

---
## Classes
### Fee


#### Properties

##### `global feeName` → `String`


##### `global feeDescription` → `String`


##### `global feeCode` → `String`


##### `global feeDefaultAmountByFormulaField` → `String`


##### `global feeDefaultOnDealsByFormulaField` → `String`


##### `global feeDefaultByFormulaField` → `String`


##### `global feeDefaultAmount` → `Decimal`


##### `global feeDefaultOnDeals` → `Boolean`


##### `global feeTaxable` → `Boolean`


---

### AuraFee
#### Properties

##### `public feeName` → `String`

`AURAENABLED` 

##### `public feeDescription` → `String`

`AURAENABLED` 

##### `public feeCode` → `String`

`AURAENABLED` 

##### `public feeDefaultAmountByFormulaField` → `String`

`AURAENABLED` 

##### `public feeDefaultOnDealsByFormulaField` → `String`

`AURAENABLED` 

##### `public feeDefaultByFormulaField` → `String`

`AURAENABLED` 

##### `public feeDefaultAmount` → `String`

`AURAENABLED` 

##### `public feeDefaultOnDeals` → `String`

`AURAENABLED` 

##### `public feeTaxable` → `String`

`AURAENABLED` 

---

### CoveredSystem


#### Properties

##### `global systemCovered` → `String`


##### `global duration` → `String`


##### `global warrantyType` → `String`


---

### DealershipLocationAPIException



**Inheritance**

DealershipLocationAPIException


---
