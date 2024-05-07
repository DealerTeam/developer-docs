---
layout: default
---
# DMSRecordAPI
## Constructors
### `public DMSRecordAPI()`
---
## Methods
### `private static String DMSRecordConfiguration(String sObjectName)`

retrieves configuration from custom metadata definition for a specified sObject

### `public static Configuration getRecord(Id recordId, String sObjectName)`

retrieves a record from a connected DMS instance (Dealerstar)

### `public static Configuration saveRecord(Id recordId, String recordJSON)`

retrieves a record from a connected DMS instance (Dealerstar)

### `private static Map<String,Object> dynamicQueryObject(Configuration configuration, String sObjectName, Id recordId)`

Builds a dynmaic query from a Configuration MDT and returns the record in a Map&lt;String,Object&gt;

---
## Classes
### Configuration
#### Fields

##### `public table` → `string`

`AURAENABLED` 

##### `public setupTable` → `string`

`AURAENABLED` 

##### `public idMapping` → `idMapping`

`AURAENABLED` 

##### `public filters` → `List&lt;Filter&gt;`

`AURAENABLED` 

##### `public fields` → `List&lt;Field&gt;`

`AURAENABLED` 

---

### idMapping
#### Fields

##### `public crmField` → `String`

`AURAENABLED` 

##### `public dmsField` → `String`

`AURAENABLED` 

---

### Filter
#### Fields

##### `public crmField` → `string`

`AURAENABLED` 

##### `public dmsField` → `string`

`AURAENABLED` 

##### `public operator` → `string`

`AURAENABLED` 

---

### Field
#### Fields

##### `public value` → `String`

`AURAENABLED` 

##### `public type` → `String`

`AURAENABLED` 

##### `public dmsField` → `String`

`AURAENABLED` 

##### `public view` → `String`

`AURAENABLED` 

##### `public customObject` → `String`

`AURAENABLED` 

---

### Error
#### Fields

##### `public code` → `Integer`


##### `public message` → `String`


---

### DMSRecordAPIException

**Inheritance**

DMSRecordAPIException


---
