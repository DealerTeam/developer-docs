---
layout: default
---
# ServiceDispatchKanbanController class
---
## Properties

### `REPAIR_ORDER_MOVED` → `String`

---
## Methods
### `initialize()` → `DataFetchResult`
### `updateDispatchStatus( Id dispatchEventId, String newStatus, List<String> ordering )` → `StatusUpdateResult`
---
## Inner Classes

### ServiceDispatchKanbanController.Column class

 Update all the RO Dispatch Event records with the new ordering.

---
#### Constructors
##### `Column( String label, Boolean isDropEnabled )`
---
#### Properties

##### `isDropEnabled` → `Boolean`

##### `label` → `String`

---
### ServiceDispatchKanbanController.DataFetchResult class
---
#### Properties

##### `columns` → `List<Column>`

##### `rows` → `List<DispatchEvent__c>>`

---
### ServiceDispatchKanbanController.StatusUpdateResult class
---
#### Constructors
##### `StatusUpdateResult( Boolean isSuccess, String title, String message )`
---
#### Properties

##### `isSuccess` → `Boolean`

##### `message` → `String`

##### `title` → `String`

---
