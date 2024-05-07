---
layout: default
---
# VehicleEquipmentViewControl

Controller for VehicleEquipmentView components in both LEX and Classic


**Test** TestVehicleEquipmentViewControl


**Group** Sales

## Constructors
### `public VehicleEquipmentViewControl()`
---
## Properties

### `public totalRecords` → `Integer`


### `public vehicleEquipment` → `List<Decode_Values__b>`


---
## Methods
### `public void QueryEquipment()`
### `public static Service_Vehicle__c getServiceVehicle(id vehicleId)`
### `public static String CreateEquipmentTable(String vehicleId)`

`AURAENABLED`
---
## Classes
### DataTableResponse
#### Constructors
##### `public DataTableResponse()`
---
#### Properties

##### `public columns` → `List&lt;DataTableColumn&gt;`


##### `public data` → `List&lt;Decode_Values__b&gt;`


---

### DataTableColumn
#### Constructors
##### `public DataTableColumn(String label, Boolean sortable, String fieldName, String type)`
---
#### Properties

##### `public label` → `String`


##### `public sortable` → `Boolean`


##### `public fieldName` → `String`


##### `public type` → `String`


---

### VehicleEquipmentViewControlException

**Inheritance**

VehicleEquipmentViewControlException


---
