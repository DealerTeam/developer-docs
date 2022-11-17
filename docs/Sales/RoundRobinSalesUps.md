# RoundRobinSalesUps

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Sales

## Constructors
### `RoundRobinSalesUps(ApexPages.standardSetController ssc)`
---
## Fields

### `MovedUps` → `List<dealer__Sales_Up__c>`


### `contactsInList` → `Set<Id>`


### `notifyTasks` → `List<Task>`


### `reAssignContact` → `List<Contact>`


### `reAssignTasks` → `Map<Id,Task>`


### `reAssignTasksList` → `List<Task>`


### `startInt` → `integer`


### `tasksToRM` → `List<Task>`


### `up` → `List<dealer__Sales_Up__c>`


### `upAfterList` → `List<salesUpBA>`


### `upSet` → `Set<Id>`


### `updateAssignedTasks` → `List<Task>`


### `userMap` → `Map<Id,User>`


---
## Properties

### `allUsers` → `SelectOption[]`


### `notifyRecipient` → `Boolean`


### `reassignUpsListSize` → `decimal`


### `receivingUsers` → `List<User>`


### `selectedUsers` → `SelectOption[]`


### `sendingUser` → `User`


### `updateContactRecord` → `Boolean`


### `userListSize` → `decimal`


---
## Methods
### `ReAssign()`
### `nextUser()`
### `reAssignBlock()`
### `emailMeResults()`
### `buildHTMLTableOfResults()`
---
## Classes
### salesUpBA
#### Constructors
##### `salesUpBA(dealer__Sales_Up__c a, String bu, String au)`
---
#### Properties

##### `afterUser` → `String`


##### `baUp` → `dealer__Sales_Up__c`


##### `beforeUser` → `String`


---

---
