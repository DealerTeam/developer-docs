# VehicleEquipmentViewControl

`APIVERSION: 45`

`STATUS: ACTIVE`

Controller for VehicleEquipmentView components in both LEX and Classic


**Test** TestVehicleEquipmentViewControl


**Group** Sales

## Constructors
### `VehicleEquipmentViewControl()`
---
## Properties

### `totalRecords` → `Integer`


### `vehicleEquipment` → `List<Decode_Values__b>`


---
## Methods
### `QueryEquipment()`
### `static getServiceVehicle(id vehicleId)`
### `static CreateEquipmentTable(String vehicleId)`

`AURAENABLED`
---
## Classes
### DataTableColumn
#### Constructors
##### `DataTableColumn(String label, Boolean sortable, String fieldName, String type)`
---
#### Properties

##### `fieldName` → `String`


##### `label` → `String`


##### `sortable` → `Boolean`


##### `type` → `String`


---

### DataTableResponse
#### Constructors
##### `DataTableResponse()`
---
#### Properties

##### `columns` → `List&lt;DataTableColumn&gt;`


##### `data` → `List&lt;Decode_Values__b&gt;`


---

### VehicleEquipmentViewControlException

**Inheritance**

VehicleEquipmentViewControlException


---
