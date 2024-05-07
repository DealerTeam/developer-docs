---
layout: default
---
# CarFaxAPI



**Class** CarFaxAPI


**Group** Sales

## Methods
### `public static Response CreateRequest(CarFaxAPI request)`
#### Parameters

|Param|Description|
|---|---|
|`request`||

#### Returns

|Type|Description|
|---|---|
|`Response`|Response|


**Method** CreateRequest

### `public static Carfax CreateVINRequest(String VIN, Boolean purchaseIfNecessary)`
### `public static Carfax CreateRequest(Id ServiceVehicleId, Boolean purchaseIfNecessary)`
### `public static Carfax CreateBatchableRequest(Id ServiceVehicleId, Id userId, Boolean purchaseIfNecessary)`
### `public static Carfax logout()`
### `public static Carfax GetAuthURL()`
### `private static Carfax GetCarfax(Service_Vehicle__c vehicle, Id userId, Boolean purchaseIfNecessary)`
---
## Classes
### Request
#### Properties

##### `public vin` → `String`


##### `public username` → `String`


##### `public password` → `String`


##### `public reportType` → `String`


---

### Response
#### Properties

##### `public AccidentCount` → `String`


##### `public AccidentIndicator` → `String`


##### `public BrandedTitleIndicator` → `String`


##### `public DamageIndicator` → `String`


##### `public FrameDamageIndicator` → `String`


##### `public MajorProblemIndicator` → `String`


##### `public VehicleHistoryReportUrl` → `String`


##### `public NumberOfOwners` → `String`


##### `public ServiceRecordCount` → `String`


##### `public Errors` → `String`


---

### CarFaxAPIException

**Inheritance**

CarFaxAPIException


---
