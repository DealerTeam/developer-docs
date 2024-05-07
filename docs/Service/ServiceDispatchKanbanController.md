---
layout: default
---
# ServiceDispatchKanbanController



**Group** Service

## Fields

### `public REPAIR_ORDER_MOVED` → `String`


---
## Methods
### `public static DataFetchResult initialize()`

`AURAENABLED`
### `public static StatusUpdateResult updateDispatchStatus(Id dispatchEventId, String newStatus, List<String> ordering)`

`AURAENABLED`
### `private static void getDispatchStatuses(DataFetchResult result)`
### `private static void fetchDispatchEvents(DataFetchResult result)`
---
## Classes
### Column
#### Constructors
##### `public Column(String label, Boolean isDropEnabled)`
---
#### Properties

##### `public label` → `String`

`AURAENABLED` 

##### `public isDropEnabled` → `Boolean`

`AURAENABLED` 

---

### DataFetchResult
#### Properties

##### `public columns` → `List&lt;Column&gt;`

`AURAENABLED` 

##### `public rows` → `Map&lt;String,List&lt;DispatchEvent__c&gt;&gt;`

`AURAENABLED` 

---

### StatusUpdateResult
#### Constructors
##### `public StatusUpdateResult(Boolean isSuccess, String title, String message)`
---
#### Properties

##### `public isSuccess` → `Boolean`

`AURAENABLED` 

##### `public title` → `String`

`AURAENABLED` 

##### `public message` → `String`

`AURAENABLED` 

---

---
