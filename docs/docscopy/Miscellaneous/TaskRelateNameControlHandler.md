---
layout: default
---
# TaskRelateNameControlHandler class
---
## Properties

### `keyPrefix` → `String`

holds the keyPrefix of the sales up object to compare with below

### `statusMap` → `TaskStatus>`

holds TaskStatus records to allow access to actual IsClosed value. IsClosed on the task is updated after Before Triggers so is not accurate in BEFORE context.

---
## Methods
### `clearComplete(List<Task> triggerNew, Map<Id, Task> triggerOldMap)` → `void`

Runs before update and clears Date_Completed__c if isClosed becomes false after being true

### `getRelatedSalesUps(List<Task> triggerOld, System.TriggerOperation operation)` → `void`

Runs after insert, update or delete and updates sales ups related by whatId

### `markComplete(List<Task> triggerNew)` → `void`

Runs before insert/update and updates Date_Completed__c the first time a closed status is selected

### `setQuickNote(List<Task> triggerNew)` → `void`
---
