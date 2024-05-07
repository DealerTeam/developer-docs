---
layout: default
---
# SalesUpController



**Group** Sales

## Methods
### `public static List<List<sObject>> suggestResults(String name, String fName, String lName, String phone, String email)`

`AURAENABLED`
### `public static String getRecordTypes()`

`AURAENABLED`
### `public static List<String> getSourcePicklistValues()`

`AURAENABLED`
### `public static List<String> getStatusPicklistValues()`

`AURAENABLED`
### `public static List<String> getLeadTypePicklistValues()`

`AURAENABLED`
### `public static List<sObject> createContainerObjects()`

`AURAENABLED`
### `public static List<sObject> getUserLocation()`

`AURAENABLED`
### `public static List<sObject> getCustomer(String objId)`

`AURAENABLED`
### `public static List<LookupSearchResult> searchAccounts(String searchTerm)`

`AURAENABLED`
### `public static List<LookupSearchResult> selectedAccount(String acctId)`

`AURAENABLED`
### `public static List<LookupSearchResult> recentAccounts()`

`AURAENABLED`
### `public static List<LookupSearchResult> searchContacts(String searchTerm, String accId)`

`AURAENABLED`
### `public static List<LookupSearchResult> relatedContacts(String accountId)`

`AURAENABLED`
### `public static List<LookupSearchResult> selectedContact(String contactId)`

`AURAENABLED`
### `public static List<Contact> businessContacts(Account account)`

`AURAENABLED`
### `public static Account parentAccount(String contactId)`

`AURAENABLED`
### `public static Account determineAccountType(Account account)`

`AURAENABLED`
### `public static List<sObject> doCreate(Account account, Contact contact, Sales_Up__c salesUp)`

`AURAENABLED`
### `public static List<sObject> findCustomerDuplicates(Account account)`

`AURAENABLED`
### `public static Map<String,String> getFieldLabels()`

`AURAENABLED`
### `private static Account formatPersonAccount(Account account)`
### `private static Account formatBusinesssAccount(Account account)`
### `public static List<List<sObject>> suggestSUPResults(String acctId)`

`AURAENABLED`
### `public static Boolean getPersonAccountStatus(String acctId)`

`AURAENABLED`
### `public static List<FieldSetWrapper> getSalesUpFieldset()`

`AURAENABLED`
### `public static Boolean getIsCompact()`

`AURAENABLED`
---
## Classes
### recordTypeWrapper
#### Constructors
##### `public recordTypeWrapper(RecordType defaultType, List&lt;RecordType&gt; types)`
---
#### Properties

##### `public defaultType` → `RecordType`


##### `public types` → `List&lt;RecordType&gt;`


---

---
