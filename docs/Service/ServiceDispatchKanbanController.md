# ServiceDispatchKanbanController

`APIVERSION: 46`

`STATUS: ACTIVE`



**Group** Service

## Fields

### `REPAIR_ORDER_MOVED` → `String`


---
## Methods
### `static initialize()`

`AURAENABLED`
### `static updateDispatchStatus(Id dispatchEventId, String newStatus, List<String> ordering)`

`AURAENABLED`
---
## Classes
### Column
#### Constructors
##### `Column(String label, Boolean isDropEnabled)`
---
#### Properties

##### `isDropEnabled` → `Boolean`

`AURAENABLED` 

##### `label` → `String`

`AURAENABLED` 

---

### DataFetchResult
#### Properties

##### `columns` → `List&lt;Column&gt;`

`AURAENABLED` 

##### `rows` → `Map&lt;String,List&lt;DispatchEvent__c&gt;&gt;`

`AURAENABLED` 

---

### StatusUpdateResult
#### Constructors
##### `StatusUpdateResult(Boolean isSuccess, String title, String message)`
---
#### Properties

##### `isSuccess` → `Boolean`

`AURAENABLED` 

##### `message` → `String`

`AURAENABLED` 

##### `title` → `String`

`AURAENABLED` 

---

---
