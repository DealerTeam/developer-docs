# HistoricalDataController

`APIVERSION: 46`

`STATUS: ACTIVE`
## Methods
### `static objectLabels()`

`AURAENABLED`
### `static historicalVinData(String recordId)`

`AURAENABLED`
---
## Classes
### HistoricalVinData
#### Constructors
##### `HistoricalVinData(List&lt;RowData&gt; deals, List&lt;RowData&gt; trades, List&lt;RowData&gt; serviceRepairOrders, List&lt;RowData&gt; appraisals, List&lt;RowData&gt; vehicleInventory)`
---
#### Fields

##### `Appraisals` → `List&lt;RowData&gt;`

`AURAENABLED` 

##### `Deals` → `List&lt;RowData&gt;`

`AURAENABLED` 

##### `ServiceRepairOrders` → `List&lt;RowData&gt;`

`AURAENABLED` 

##### `Trades` → `List&lt;RowData&gt;`

`AURAENABLED` 

##### `VehicleInventory` → `List&lt;RowData&gt;`

`AURAENABLED` 

---

### RowData
#### Constructors
##### `RowData(String name, String recordLink, String createdByName, DateTime createdDate)`
---
#### Fields

##### `CreatedByName` → `String`

`AURAENABLED` 

##### `CreatedDate` → `DateTime`

`AURAENABLED` 

##### `Name` → `String`

`AURAENABLED` 

##### `RecordLink` → `String`

`AURAENABLED` 

---

---
