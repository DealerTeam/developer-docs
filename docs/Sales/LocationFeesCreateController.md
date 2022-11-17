# LocationFeesCreateController

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** LocationFeesCreateController


**Group** Sales

## Methods
### `static getLocations()`

`AURAENABLED`
#### Return

**Type**

List&lt;Dealer_Location__c&gt;

**Description**

List&lt;Dealer_Location__c&gt;


**Method** getLocations

### `static doCreateFee(Id locationId, String feeJSON)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`locationId`||
|`feeJSON`||

#### Return

**Type**

String

**Description**

String


**Method** doCreateFee

### `static getLocationFees(Id locationId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`locationId`||

#### Return

**Type**

Dealer_Location__c

**Description**

Dealer_Location__c


**Method** getLocationFees

### `static getFeeData(String locId)`

`AURAENABLED`
### `static getTabUrl(String sobjectName)`

`AURAENABLED`
### `static getTabURLSync(String sobjectName)`

`AURAENABLED`
### `static saveEdit(Id locationId, String feeJSON)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`locationId`||
|`feeJSON`||

#### Return

**Type**

Dealer_Location__c

**Description**

Dealer_Location__c


**Method** saveEdit

### `static getLocationAssignment(String feeMasterId)`

`AURAENABLED`
### `static deleteLocationFeeFromMaster(String feeMasterId, String locationId)`

`AURAENABLED`
### `static getLocationFee(String locationId, String feeMasterId)`

`AURAENABLED`
---
## Classes
### LocationAssignment
#### Constructors
##### `LocationAssignment(String feeMasterId)`
---
#### Fields

##### `availableLocations` → `List&lt;Dealer_Location__c&gt;`

`AURAENABLED` 

##### `feeMaster` → `FeeMaster__c`

`AURAENABLED` 

##### `selectedLocations` → `List&lt;Dealer_Location__c&gt;`

`AURAENABLED` 

---

### LocationFees

Nested wrapper class

#### Constructors
##### `LocationFees(String locId)`
---
#### Properties

##### `availableFees` → `List&lt;FeeMaster__c&gt;`

`AURAENABLED` 

List of form sobjects available for printing

##### `selectedFees` → `List&lt;LocationFee__c&gt;`

`AURAENABLED` 

List of form reference of selected forms

---

---
