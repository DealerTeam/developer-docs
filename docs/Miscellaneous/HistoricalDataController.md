---
layout: default
---
# HistoricalDataController class
---
## Methods
### `historicalVinData(String recordId)` → `string`
### `objectLabels()` → `Map<String,String>`
---
## Inner Classes

### HistoricalDataController.HistoricalVinData class
---
#### Constructors
##### `HistoricalVinData(List<RowData> deals,List<RowData> trades,List<RowData> serviceRepairOrders,List<RowData> appraisals,List<RowData> vehicleInventory)`
---
#### Properties

##### `Appraisals` → `List<RowData>`

##### `Deals` → `List<RowData>`

##### `ServiceRepairOrders` → `List<RowData>`

##### `Trades` → `List<RowData>`

##### `VehicleInventory` → `List<RowData>`

---
### HistoricalDataController.RowData class
---
#### Constructors
##### `RowData(String name, String recordLink, String createdByName, DateTime createdDate)`
---
#### Properties

##### `CreatedByName` → `String`

##### `CreatedDate` → `DateTime`

##### `Name` → `String`

##### `RecordLink` → `String`

---
