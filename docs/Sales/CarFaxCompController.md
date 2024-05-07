---
layout: default
---
# CarFaxCompController



**Class** CarFaxCompController


**Group** Sales

## Constructors
### `public CarFaxCompController()`
---
## Properties

### `public vin` → `String`


### `public type` → `String`


### `public response` → `CarFaxResponse`


### `public pageErrors` → `String`


---
## Methods
### `public void RunCarFaxVF()`
#### Returns

|Type|Description|
|---|---|
|`void`|void|


**Method** RunCarFaxVF

### `public static string getVehicleVin(String recordId)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`recordId`||

#### Returns

|Type|Description|
|---|---|
|`string`|string|


**Method** getVehicleVin

### `public static CarFaxResponse RunCarFaxReport(string vin, string reportType)`

`AURAENABLED`
#### Parameters

|Param|Description|
|---|---|
|`vin`||
|`reportType`||

#### Returns

|Type|Description|
|---|---|
|`CarFaxResponse`|CarFaxResponse|


**Method** RunCarFaxReport

---
## Classes
### CarFaxResponse
#### Properties

##### `public vehicle` → `Service_Vehicle__c`

`AURAENABLED` 

##### `public error` → `String`

`AURAENABLED` 

---

---
