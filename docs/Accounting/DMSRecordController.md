---
layout: default
---
# DMSRecordController

UI controller for the dmsRecord.js LWC.


**Group** Accounting

## Constructors
### `public DMSRecordController()`
---
## Methods
### `public static DMSRecordAPI getConfiguration(String recordId, String sObjectName)`

`AURAENABLED`

Retrieves a defined Configuration from a sObject

#### Returns

|Type|Description|
|---|---|
|`DMSRecordAPI`|DMSRecordAPI.Configuration|

### `public static DMSRecordAPI saveRecord(String recordId, String recordJSON)`

`AURAENABLED`

Based on the defined configuration construct and save the record to the connected Database.

#### Returns

|Type|Description|
|---|---|
|`DMSRecordAPI`|DMSRecordAPI.Configuration|

### `public static Map<String,Object> querySetupTable(String table)`

`AURAENABLED`

Queries table data, will return all records.

---
