# DMSRecordController

`APIVERSION: 52`

`STATUS: ACTIVE`

UI controller for the dmsRecord.js LWC.


**Group** Accounting

## Constructors
### `DMSRecordController()`
---
## Methods
### `static getConfiguration(String recordId, String sObjectName)`

`AURAENABLED`

Retrieves a defined Configuration from a sObject

#### Return

**Type**

DMSRecordAPI.Configuration

**Description**

DMSRecordAPI.Configuration

### `static saveRecord(String recordId, String recordJSON)`

`AURAENABLED`

Based on the defined configuration construct and save the record to the connected Database.

#### Return

**Type**

DMSRecordAPI.Configuration

**Description**

DMSRecordAPI.Configuration

### `static querySetupTable(String table)`

`AURAENABLED`

Queries table data, will return all records.

---
