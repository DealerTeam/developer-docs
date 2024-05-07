---
layout: default
---
# Deal_EXT



**Class** Deal_EXT


**Group** Sales

## Constructors
### `public Deal_EXT(ApexPages stdController)`
#### Parameters

|Param|Description|
|---|---|
|`stdController`||


**Method** Deal_EXT

---
## Fields

### `public dealDefaults` → `list<dealer__DMS_Settings__c>`


### `public buyer` → `Contact`


### `public dealTitle` → `String`


---
## Properties

### `private deal` → `dealer__Deal__c`


### `public forms` → `List<dealer__Form__c>`


### `public DealDate` → `Date`


### `public Rate` → `Decimal`


### `public Term` → `Decimal`


### `public Days` → `Decimal`


### `public PPY` → `Decimal`


### `public DateofFirstPayment` → `Date`


### `public DocFee` → `Decimal`


---
## Methods
### `public static Contact lookupBuyer(String bid)`
#### Parameters

|Param|Description|
|---|---|
|`bid`||

#### Returns

|Type|Description|
|---|---|
|`Contact`|Contact|


**Method** lookupBuyer

### `public void populateBuyerData(Contact c)`
#### Parameters

|Param|Description|
|---|---|
|`c`||

#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** populateBuyerData

### `public static List<dealer__Vehicle_Inventory__c> selectStockNumber(String stkno)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`stkno`||

#### Returns

|Type|Description|
|---|---|
|`List<dealer__Vehicle_Inventory__c>`|List<dealer__Vehicle_Inventory__c>|


**Method** selectStockNumber

### `public String getdealTitle()`
#### Returns

|Type|Description|
|---|---|
|`String`|String|


**Method** getdealTitle

### `public PageReference save()`
#### Returns

|Type|Description|
|---|---|
|`PageReference`|PageReference|


**Method** save

### `public static void updateSalesUp(List<Id> supIdLst)`

`FUTURE`
---
## Classes
### DealException

**Inheritance**

DealException


---
