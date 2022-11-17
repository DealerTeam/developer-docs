# CarFaxCompController

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** CarFaxCompController


**Group** Sales

## Constructors
### `CarFaxCompController()`
---
## Properties

### `pageErrors` → `String`


### `response` → `CarFaxResponse`


### `type` → `String`


### `vin` → `String`


---
## Methods
### `RunCarFaxVF()`
#### Return

**Type**

void

**Description**

void


**Method** RunCarFaxVF

### `static getVehicleVin(String recordId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`recordId`||

#### Return

**Type**

string

**Description**

string


**Method** getVehicleVin

### `static RunCarFaxReport(string vin, string reportType)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`vin`||
|`reportType`||

#### Return

**Type**

CarFaxResponse

**Description**

CarFaxResponse


**Method** RunCarFaxReport

---
## Classes
### CarFaxResponse
#### Properties

##### `error` → `String`

`AURAENABLED` 

##### `vehicle` → `Service_Vehicle__c`

`AURAENABLED` 

---

---
