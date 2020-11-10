---
layout: default
---
# ContactsMassTransfer class

@description

---
## Constructors
### `ContactsMassTransfer()`
---
## Properties

### `AvailableParticipantList` → `List<String>`

@description

### `ContactList` → `List<Contacts>`

@description

### `ContactsList` → `List<Contact>`

@description

### `EnteredSearchBox` → `boolean`

@description

### `EnteredTransferBox` → `boolean`

@description

### `con` → `Contact`

@description

### `displayErrorMessage` → `boolean`

@description

### `participantList` → `List<SelectOption>`

@description

### `showListOfContacts` → `boolean`

@description

---
## Methods
### `Cancel()` → `PageReference`
### `Transfer()` → `PageReference`
### `getCon()` → `Contact`
### `getContactList()` → `List<Contacts>`
### `getParticipant()` → `List<String>`

 getParticipant

### `getParticipants()` → `List<SelectOption>`

List of Available Users

### `search()` → `void`
### `setCon(Id conId)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | d |

### `setParticipant(List<String> values)` → `void`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | s |

---
## Inner Classes

### ContactsMassTransfer.Contacts class

@description

---
#### Properties

##### `Email` → `String`

##### `Id` → `String`

##### `Name` → `String`

##### `OwnerId` → `String`

##### `OwnerName` → `String`

##### `Phone` → `String`

##### `isChecked` → `Boolean`

---
