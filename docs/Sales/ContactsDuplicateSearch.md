---
layout: default
---
# ContactsDuplicateSearch



**Class** ContactsDuplicateSearch


**Group** Sales

## Constructors
### `public ContactsDuplicateSearch(ApexPages c)`
#### Parameters

|Param|Description|
|---|---|
|`c`||


**Method** ContactsDuplicateSearch

---
## Fields

### `public up` → `Contact`


### `public ModelKeyList` → `List<VINDecoder_DataOneSoftware.StyleData>`


### `public sdat` → `VINDecoder_DataOneSoftware`


### `public ddat` → `VINDecoder_DataOneSoftware`


### `public SelectedStyleId` → `String`


### `public matchEscape` → `Boolean`


### `public vd` → `VINDecoder`


---
## Properties

### `public searchOptions` → `searchUps`


### `public searchContactResults` → `List<Contact>`


### `public searchUpsResults` → `List<dealer__Sales_Up__c>`


### `public dms` → `dealer__DMS_Settings__c`


### `public activeContacts` → `List<AvaliableContacts>`


### `public isMerge` → `Boolean`


### `public selectedCustomerId` → `Id`


### `public searchCustomerSize` → `Integer`


### `public searchUpsSize` → `Integer`


### `public ActiveRecordsCount` → `Integer`


---
## Methods
### `public String getUserName()`
### `public String getUserId()`
### `public List<Contact> searchExistingContacts(String firstName, String lastName, String emailAddress, String primaryPhone, String mobilePhone)`
### `public PageReference FindDupes()`
### `public Boolean isBlank(String s)`
### `public String getSelectedStyleId()`
### `public void setSelectedStyleId(String SelectedStyleId)`
### `public pageReference mergeRecords()`
---
## Classes
### searchUps
#### Constructors
##### `public searchUps(boolean inFirst, boolean inLast, boolean inEmailAddr, boolean inPhoneNum, boolean inMobileNum, string firstn, string lastn, string uemail, string uphone, string umobile)`
---
#### Properties

##### `public inFirstName` → `boolean`


##### `public inLastName` → `boolean`


##### `public inEmail` → `boolean`


##### `public inPhone` → `boolean`


##### `public inMobile` → `boolean`


##### `public firstName` → `String`


##### `public lastName` → `String`


##### `public upEmail` → `String`


##### `public upPhone` → `String`


##### `public upMobile` → `String`


---

### SalesUpException

**Inheritance**

SalesUpException


### AvaliableContacts
#### Constructors
##### `public AvaliableContacts()`
---
#### Properties

##### `public isChecked` → `Boolean`


##### `public counter` → `Integer`


##### `public junctionRecord` → `Contact`


---

---
