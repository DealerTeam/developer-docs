# ContactsMassTransfer

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** ContactsMassTransfer


**Group** Sales

## Constructors
### `ContactsMassTransfer()`
---
## Fields

### `AvailableParticipantList` → `List<String>`


### `ContactList` → `List<Contacts>`


### `ContactsList` → `List<Contact>`


### `con` → `Contact`


### `participantList` → `List<SelectOption>`


---
## Properties

### `EnteredSearchBox` → `boolean`


### `EnteredTransferBox` → `boolean`


### `displayErrorMessage` → `boolean`


### `showListOfContacts` → `boolean`


---
## Methods
### `getContactList()`
#### Return

**Type**

List&lt;Contacts&gt;

**Description**

List&lt;Contacts&gt;


**Method** getContactList

### `getCon()`
#### Return

**Type**

Contact

**Description**

Contact


**Method** getCon

### `setCon(Id conId)`
#### Parameters

|Param|Description|
|---|---|
|`conId`||

#### Return

**Type**

void

**Description**

void


**Method** setCon

### `Cancel()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** Cancel

### `Transfer()`
#### Return

**Type**

PageReference

**Description**

PageReference


**Method** Transfer

### `search()`
#### Return

**Type**

void

**Description**

void


**Method** search

### `setParticipant(List<String> values)`
#### Parameters

|Param|Description|
|---|---|
|`values`||

#### Return

**Type**

void

**Description**

void


**Method** setParticipant

### `getParticipant()`
#### Return

**Type**

List&lt;String&gt;

**Description**

List&lt;String&gt;


**Method** getParticipant

### `getParticipants()`

List of Available Users

#### Return

**Type**

List&lt;SelectOption&gt;

**Description**

List&lt;SelectOption&gt;


**Method** getParticipants

---
## Classes
### Contacts



**Method** Contacts

#### Properties

##### `Email` → `String`


##### `Id` → `String`


##### `Name` → `String`


##### `OwnerId` → `String`


##### `OwnerName` → `String`


##### `Phone` → `String`


##### `isChecked` → `Boolean`


---

---
