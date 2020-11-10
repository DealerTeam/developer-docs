---
layout: default
---
# ServiceJobTriggerHandler class

 Date            |Developer            |Work# Notes ---------------------------------------------------------------------------- 2016.10.14       |Sneha                |Case# 00002076 Prevent deletion of service job if line total is greater than 0 2017.01.05       |Gaurav              |W-000858 Modified ServiceJobLinkParent trigger on Service Job Line for restricting the user from manually adjusting Cost.

---
## Properties

### `ListServiceOrder` → `List<Service_Repair_Order__c>`

### `ListUser` → `List<User>`

### `StandardOpCodeList` → `List<StandardOpCode__c>`

---
## Methods
### `handleBeforeDelete(List<Service_Job__c> ListServiceJob)` → `void`
### `handleBeforeInsert(List<Service_Job__c> ListServiceJob)` → `void`
### `handleBeforeUpdate(List<Service_Job__c> ListServiceJob,Map<Id,Service_Job__c> MapServiceJob)` → `void`
---
