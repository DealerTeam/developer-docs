# SalesUpController

`APIVERSION: 45`

`STATUS: ACTIVE`



**Group** Sales

## Methods
### `static suggestResults(String name, String fName, String lName, String phone, String email)`

`AURAENABLED`
### `static getRecordTypes()`

`AURAENABLED`
### `static getSourcePicklistValues()`

`AURAENABLED`
### `static getStatusPicklistValues()`

`AURAENABLED`
### `static getLeadTypePicklistValues()`

`AURAENABLED`
### `static createContainerObjects()`

`AURAENABLED`
### `static getUserLocation()`

`AURAENABLED`
### `static getCustomer(String objId)`

`AURAENABLED`
### `static searchAccounts(String searchTerm)`

`AURAENABLED`
### `static selectedAccount(String acctId)`

`AURAENABLED`
### `static recentAccounts()`

`AURAENABLED`
### `static searchContacts(String searchTerm, String accId)`

`AURAENABLED`
### `static relatedContacts(String accountId)`

`AURAENABLED`
### `static selectedContact(String contactId)`

`AURAENABLED`
### `static businessContacts(Account account)`

`AURAENABLED`
### `static parentAccount(String contactId)`

`AURAENABLED`
### `static determineAccountType(Account account)`

`AURAENABLED`
### `static doCreate(Account account, Contact contact, Sales_Up__c salesUp)`

`AURAENABLED`
### `static findCustomerDuplicates(Account account)`

`AURAENABLED`
### `static getFieldLabels()`

`AURAENABLED`
### `static suggestSUPResults(String acctId)`

`AURAENABLED`
### `static getPersonAccountStatus(String acctId)`

`AURAENABLED`
### `static getSalesUpFieldset()`

`AURAENABLED`
### `static getIsCompact()`

`AURAENABLED`
---
## Classes
### fieldSetWrapper
#### Fields

##### `fieldName` → `String`

`AURAENABLED` 

##### `label` → `String`

`AURAENABLED` 

##### `required` → `Boolean`

`AURAENABLED` 

##### `type` → `String`

`AURAENABLED` 

---

### recordTypeWrapper
#### Constructors
##### `recordTypeWrapper(RecordType defaultType, List&lt;RecordType&gt; types)`
---
#### Properties

##### `defaultType` → `RecordType`


##### `types` → `List&lt;RecordType&gt;`


---

---
