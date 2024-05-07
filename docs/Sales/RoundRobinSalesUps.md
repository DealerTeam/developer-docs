---
layout: default
---
# RoundRobinSalesUps



**Group** Sales

## Constructors
### `public RoundRobinSalesUps(ApexPages ssc)`
---
## Fields

### `public reAssignContact` → `List<Contact>`


### `public contactsInList` → `Set<Id>`


### `public upSet` → `Set<Id>`


### `public userMap` → `Map<Id,User>`


### `public startInt` → `integer`


### `public notifyTasks` → `List<Task>`


### `public reAssignTasks` → `Map<Id,Task>`


### `public reAssignTasksList` → `List<Task>`


### `public tasksToRM` → `List<Task>`


### `public updateAssignedTasks` → `List<Task>`


### `public upAfterList` → `List<salesUpBA>`


### `public up` → `List<dealer__Sales_Up__c>`


### `public MovedUps` → `List<dealer__Sales_Up__c>`


---
## Properties

### `public receivingUsers` → `List<User>`


### `public sendingUser` → `User`


### `public notifyRecipient` → `Boolean`


### `public updateContactRecord` → `Boolean`


### `public userListSize` → `decimal`


### `public reassignUpsListSize` → `decimal`


### `public selectedUsers` → `SelectOption`


### `public allUsers` → `SelectOption`


---
## Methods
### `public PageReference ReAssign()`
### `public Id nextUser()`
### `public void reAssignBlock()`
### `public void emailMeResults()`
### `public String buildHTMLTableOfResults()`
---
## Classes
### salesUpBA
#### Constructors
##### `public salesUpBA(dealer__Sales_Up__c a, String bu, String au)`
---
#### Properties

##### `public baUp` → `dealer__Sales_Up__c`


##### `public beforeUser` → `String`


##### `public afterUser` → `String`


---

---
