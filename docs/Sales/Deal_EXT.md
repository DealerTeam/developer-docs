# Deal_EXT

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** Deal_EXT


**Group** Sales

## Constructors
### `Deal_EXT(ApexPages.StandardController stdController)`
#### Parameters

|Param|Description|
|---|---|
|`stdController`||


**Method** Deal_EXT

---
## Fields

### `buyer` → `Contact`


### `dealDefaults` → `list<dealer__DMS_Settings__c>`


### `dealTitle` → `String`


---
## Properties

### `DateofFirstPayment` → `Date`


### `Days` → `Decimal`


### `DealDate` → `Date`


### `DocFee` → `Decimal`


### `PPY` → `Decimal`


### `Rate` → `Decimal`


### `Term` → `Decimal`


### `forms` → `List<dealer__Form__c>`


---
## Methods
### `static lookupBuyer(String bid)`
#### Parameters

|Param|Description|
|---|---|
|`bid`||

#### Return

**Type**

Contact

**Description**

Contact


**Method** lookupBuyer

### `populateBuyerData(Contact c)`
#### Parameters

|Param|Description|
|---|---|
|`c`||

#### Return

**Type**

void

**Description**

void


**Method** populateBuyerData

### `static selectStockNumber(String stkno)`

`REMOTEACTION`
#### Parameters

|Param|Description|
|---|---|
|`stkno`||

#### Return

**Type**

List&lt;dealer__Vehicle_Inventory__c&gt;

**Description**

List&lt;dealer__Vehicle_Inventory__c&gt;


**Method** selectStockNumber

### `getdealTitle()`
#### Return

**Type**

String

**Description**

String


**Method** getdealTitle

### `save()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** save

### `static updateSalesUp(List<Id> supIdLst)`

`FUTURE`
---
## Classes
### DealException

**Inheritance**

DealException


---
