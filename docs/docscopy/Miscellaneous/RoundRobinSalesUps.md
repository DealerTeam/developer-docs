---
layout: default
---
# RoundRobinSalesUps class
---
## Constructors
### `RoundRobinSalesUps(ApexPages.standardSetController ssc)`
---
## Properties

### `MovedUps` → `List<dealer__Sales_Up__c>`

### `allUsers` → `SelectOption[]`

### `contactsInList` → `Set<Id>`

### `notifyRecipient` → `Boolean`

### `notifyTasks` → `List<Task>`

### `reAssignContact` → `List<Contact>`

### `reAssignTasks` → `Task>`

### `reAssignTasksList` → `List<Task>`

### `reassignUpsListSize` → `decimal`

### `receivingUsers` → `List<User>`

### `selectedUsers` → `SelectOption[]`

### `sendingUser` → `User`

### `startInt` → `integer`

### `tasksToRM` → `List<Task>`

### `up` → `List<dealer__Sales_Up__c>`

### `upAfterList` → `List<salesUpBA>`

### `upSet` → `Set<Id>`

### `updateAssignedTasks` → `List<Task>`

### `updateContactRecord` → `Boolean`

### `userListSize` → `decimal`

### `userMap` → `User>`

---
## Methods
### `ReAssign()` → `PageReference`
### `buildHTMLTableOfResults()` → `String`
### `emailMeResults()` → `void`
### `nextUser()` → `Id`
### `reAssignBlock()` → `void`
---
## Inner Classes

### RoundRobinSalesUps.salesUpBA class
---
#### Properties

##### `afterUser` → `String`

##### `baUp` → `dealer__Sales_Up__c`

##### `beforeUser` → `String`

---
#### Methods
##### `salesUpBa(dealer__Sales_Up__c a, String bu, String au)` → `public`
---
