# DMSRecordAPI

`APIVERSION: 52`

`STATUS: ACTIVE`
## Constructors
### `DMSRecordAPI()`
---
## Methods
### `static getRecord(Id recordId, String sObjectName)`

retrieves a record from a connected DMS instance (Dealerstar)

### `static saveRecord(Id recordId, String recordJSON)`

retrieves a record from a connected DMS instance (Dealerstar)

---
## Classes
### Configuration
#### Fields

##### `fields` → `List&lt;Field&gt;`

`AURAENABLED` 

##### `filters` → `List&lt;Filter&gt;`

`AURAENABLED` 

##### `idMapping` → `idMapping`

`AURAENABLED` 

##### `setupTable` → `string`

`AURAENABLED` 

##### `table` → `string`

`AURAENABLED` 

---

### DMSRecordAPIException

**Inheritance**

DMSRecordAPIException


### Error
#### Fields

##### `code` → `Integer`


##### `message` → `String`


---

### Field
#### Fields

##### `customObject` → `String`

`AURAENABLED` 

##### `dmsField` → `String`

`AURAENABLED` 

##### `type` → `String`

`AURAENABLED` 

##### `value` → `String`

`AURAENABLED` 

##### `view` → `String`

`AURAENABLED` 

---

### Filter
#### Fields

##### `crmField` → `string`

`AURAENABLED` 

##### `dmsField` → `string`

`AURAENABLED` 

##### `operator` → `string`

`AURAENABLED` 

---

### idMapping
#### Fields

##### `crmField` → `String`

`AURAENABLED` 

##### `dmsField` → `String`

`AURAENABLED` 

---

---
