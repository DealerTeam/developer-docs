# MyDealershipControl

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** MyDealershipControl

## Methods
### `static getAllLocations()`

`AURAENABLED`

returns list of all dealer locations as well as the Id of all locations the user is a DLU at

#### Return

**Type**

locationWrapper

**Description**

locationWrapper - wrapper class with all dealer location objects and DLU Ids


**Method** getAllLocations

### `static getUserInfo()`

`AURAENABLED`

**Method** getUserInfo

### `static getUserLocation()`

`AURAENABLED`
### `static getMyDealerships()`

`AURAENABLED`
#### Return

**Type**

List&lt;dealer__Dealer_Location__c&gt;

**Description**

List&lt;dealer__Dealer_Location__c&gt;


**Method** getMyDealerships

### `static getBDCPermissions()`

`AURAENABLED`
#### Return

**Type**

BDCPermission

**Description**

BDCPermission


**Method** getBDCPermissions

### `static chooseDealership(String selectedDealershipId)`

`AURAENABLED`

choose dealership

#### Parameters

|Param|Description|
|---|---|
|`selectedDealershipId`||

### `static updateUser(User user)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`user`||


**Method** updateUser

### `static getBDCRead()`

`AURAENABLED`
#### Return

**Type**

Boolean

**Description**

Boolean


**Method** getBDCRead

### `static getBDCWrite()`

`AURAENABLED`
#### Return

**Type**

Boolean

**Description**

Boolean


**Method** getBDCWrite

### `static getBDCStatus()`

`AURAENABLED`

**Method** getBDCStatus

### `static updateBDC(Boolean inBDC)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`inBDC`||

#### Return

**Type**

void

**Description**

void


**Method** updateBDC

---
## Classes
### BDCPermission


#### Constructors
##### `BDCPermission(Boolean readT, Boolean editT)`
---
#### Properties

##### `edit` → `Boolean`

`AURAENABLED` 

##### `read` → `Boolean`

`AURAENABLED` 

---

### locationWrapper
#### Properties

##### `allLocations` → `List&lt;SObject&gt;`

`AURAENABLED` 

##### `approvedLocations` → `List&lt;Id&gt;`

`AURAENABLED` 

##### `selectedId` → `Id`

`AURAENABLED` 

---

---
