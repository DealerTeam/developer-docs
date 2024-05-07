---
layout: default
---
# TaskRelateNameControlHandler
## Fields

### `public keyPrefix` → `String`


holds the keyPrefix of the sales up object to compare with below

### `public statusMap` → `Map<String,TaskStatus>`


holds TaskStatus records to allow access to actual IsClosed value. IsClosed on the task is updated after Before Triggers so is not accurate in BEFORE context.

---
## Methods
### `public static void markComplete(List<Task> triggerNew)`

Runs before insert/update and updates Date_Completed__c the first time a closed status is selected


**Method** markComplete

### `public static void setQuickNote(List<Task> triggerNew)`
### `public static void clearComplete(List<Task> triggerNew, Map<Id,Task> triggerOldMap)`

Runs before update and clears Date_Completed__c if isClosed becomes false after being true


**Method** clearComplete

### `public static void getRelatedSalesUps(List<Task> triggerOld, System operation)`

Runs after insert, update or delete and updates sales ups related by whatId


**Method** getRelatedSalesUps

### `private static void updateRelatedSalesUps(List<Id> taskId, Map<Id,Task> supIdToTask, System action)`

Handles updating task related fields on sales ups when task is inserted, updated, or deleted


**Method** updateRelatedSalesUps

---
