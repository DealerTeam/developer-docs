---
layout: default
---
# ERPMap

from a defined custom metadata record, maps sObject data to DMS data.


**Group** DMS

## Constructors
### `public ERPMap(DMSERPEvent__mdt event, DMSDataEventAPI eventData)`

Constructor to initialize DATA_MAP

#### Parameters

|Param|Description|
|---|---|
|`event`|event description|

---
## Fields

### `public event_DATA` → `DMSDataEventAPI`


### `public DATA_MAP` → `Map<String,String>`


### `public MAPPED_DATA` → `Map<String,Object>`


---
## Methods
### `public void MapData(Map<String,Object> fieldsToValue)`

Maps data using the data Map

#### Parameters

|Param|Description|
|---|---|
|`o`|Salesforce Object to map|

---
## Classes
### ERPInvalidJSONMapException

**Inheritance**

ERPInvalidJSONMapException


---
