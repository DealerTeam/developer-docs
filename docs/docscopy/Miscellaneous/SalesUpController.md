---
layout: default
---
# SalesUpController class
---
## Methods
### `businessContacts(Account account)` → `List<Contact>`
### `createContainerObjects()` → `>`
### `determineAccountType(Account account)` → `Account`
### `doCreate(Account account, Contact contact, Sales_Up__c salesUp)` → `>`
### `findCustomerDuplicates(Account account)` → `>`
### `getCustomer(String objId)` → `List<sObject>`
### `getFieldLabels()` → `Map<String,String>`
### `getLeadTypePicklistValues()` → `>`
### `getPersonAccountStatus(String acctId)` → `Boolean`
### `getRecordTypes()` → `String`
### `getSalesUpFieldset()` → `List<fieldSetWrapper>`
### `getSourcePicklistValues()` → `>`
### `getStatusPicklistValues()` → `>`
### `getUserLocation()` → `List<sObject>`
### `parentAccount(String contactId)` → `Account`
### `recentAccounts()` → `List<LookupSearchResult>`
### `relatedContacts(String accountId)` → `List<LookupSearchResult>`
### `searchAccounts(String searchTerm)` → `List<LookupSearchResult>`
### `searchContacts(String searchTerm, String accId)` → `List<LookupSearchResult>`
### `selectedAccount(String acctId)` → `List<LookupSearchResult>`
### `selectedContact(String contactId)` → `List<LookupSearchResult>`
### `suggestResults(String name, String fName, String lName, String phone, String email)` → `>`
### `suggestSUPResults(String acctId)` → `>`
---
## Inner Classes

### SalesUpController.fieldSetWrapper class
---
#### Properties

##### `fieldName` → `String`

##### `required` → `Boolean`

---
### SalesUpController.recordTypeWrapper class
---
#### Constructors
##### `recordTypeWrapper(RecordType defaultType, List<RecordType> types)`
---
#### Properties

##### `defaultType` → `RecordType`

##### `types` → `List<RecordType>`

---
