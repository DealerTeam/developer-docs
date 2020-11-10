---
layout: default
---
# DesiredVehicleController class
---
## Methods
### `getDesiredVehicles(Id supId)` → `desiredVehicleWrapper`
### `getPrimaryVehicle(Id supId)` → `List<dealer__Desired_Vehicle__c>`
### `getSalesUp(Id recordId)` → `Sales_Up__c`
### `getVehicleInventoryRecord(Id vehicleId)` → `dealer__Vehicle_Inventory__c`
### `getVehicles(Id supId)` → `List<dealer__Desired_Vehicle__c>`
### `removePrimaryVehicle(Id dvId, Id supId)` → `string`
### `setPrimary(Id dvId, Id supId)` → `string`
---
## Inner Classes

### DesiredVehicleController.desiredVehicleWrapper class
---
#### Constructors
##### `desiredVehicleWrapper(List<Desired_Vehicle__c> vehicles, List<Desired_Vehicle__c> primaryVehicle)`
---
#### Properties

##### `primaryVehicle` → `List<Desired_Vehicle__c>`

##### `vehicles` → `List<Desired_Vehicle__c>`

---
