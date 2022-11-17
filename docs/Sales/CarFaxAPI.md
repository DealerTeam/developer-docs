# CarFaxAPI

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** CarFaxAPI


**Group** Sales

## Methods
### `static CreateRequest(CarFaxAPI.Request request)`
#### Parameters

|Param|Description|
|---|---|
|`request`||

#### Return

**Type**

Response

**Description**

Response


**Method** CreateRequest

### `static CreateVINRequest(String VIN, Boolean purchaseIfNecessary)`
### `static CreateRequest(Id ServiceVehicleId, Boolean purchaseIfNecessary)`
### `static CreateBatchableRequest(Id ServiceVehicleId, Id userId, Boolean purchaseIfNecessary)`
### `static logout()`
### `static GetAuthURL()`
---
## Classes
### CarFaxAPIException

**Inheritance**

CarFaxAPIException


### Request
#### Properties

##### `password` → `String`


##### `reportType` → `String`


##### `username` → `String`


##### `vin` → `String`


---

### Response
#### Properties

##### `AccidentCount` → `String`


##### `AccidentIndicator` → `String`


##### `BrandedTitleIndicator` → `String`


##### `DamageIndicator` → `String`


##### `Errors` → `String[]`


##### `FrameDamageIndicator` → `String`


##### `MajorProblemIndicator` → `String`


##### `NumberOfOwners` → `String`


##### `ServiceRecordCount` → `String`


##### `VehicleHistoryReportUrl` → `String`


---

---
