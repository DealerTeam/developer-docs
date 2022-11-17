# TaskRelateNameControlHandler

`APIVERSION: 48`

`STATUS: ACTIVE`
## Fields

### `keyPrefix` → `String`


holds the keyPrefix of the sales up object to compare with below

### `statusMap` → `Map<String,TaskStatus>`


holds TaskStatus records to allow access to actual IsClosed value. IsClosed on the task is updated after Before Triggers so is not accurate in BEFORE context.

---
## Methods
### `static markComplete(List<Task> triggerNew)`

Runs before insert/update and updates Date_Completed__c the first time a closed status is selected


**Method** markComplete

### `static setQuickNote(List<Task> triggerNew)`
### `static clearComplete(List<Task> triggerNew, Map<Id,Task> triggerOldMap)`

Runs before update and clears Date_Completed__c if isClosed becomes false after being true


**Method** clearComplete

### `static getRelatedSalesUps(List<Task> triggerOld, System.TriggerOperation operation)`

Runs after insert, update or delete and updates sales ups related by whatId


**Method** getRelatedSalesUps

---
