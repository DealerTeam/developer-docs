# ContactsDuplicateSearch

`APIVERSION: 45`

`STATUS: ACTIVE`



**Class** ContactsDuplicateSearch


**Group** Sales

## Constructors
### `ContactsDuplicateSearch(ApexPages.StandardController c)`
#### Parameters

|Param|Description|
|---|---|
|`c`||


**Method** ContactsDuplicateSearch

---
## Fields

### `ModelKeyList` → `List<VINDecoder_DataOneSoftware.StyleData>`


### `SelectedStyleId` → `String`


### `ddat` → `VINDecoder_DataOneSoftware.DecodeResponseStruct`


### `matchEscape` → `Boolean`


### `sdat` → `VINDecoder_DataOneSoftware.StyleData`


### `up` → `Contact`


### `vd` → `VINDecoder`


---
## Properties

### `ActiveRecordsCount` → `Integer`


### `activeContacts` → `List<AvaliableContacts>`


### `dms` → `dealer__DMS_Settings__c`


### `isMerge` → `Boolean`


### `searchContactResults` → `List<Contact>`


### `searchCustomerSize` → `Integer`


### `searchOptions` → `searchUps`


### `searchUpsResults` → `List<dealer__Sales_Up__c>`


### `searchUpsSize` → `Integer`


### `selectedCustomerId` → `Id`


---
## Methods
### `getUserName()`
### `getUserId()`
### `searchExistingContacts(String firstName, String lastName, String emailAddress, String primaryPhone, String mobilePhone)`
### `FindDupes()`
### `isBlank(String s)`
### `getSelectedStyleId()`
### `setSelectedStyleId(String SelectedStyleId)`
### `mergeRecords()`
---
## Classes
### AvaliableContacts
#### Constructors
##### `AvaliableContacts()`
---
#### Properties

##### `counter` → `Integer`


##### `isChecked` → `Boolean`


##### `junctionRecord` → `Contact`


---

### SalesUpException

**Inheritance**

SalesUpException


### searchUps
#### Constructors
##### `searchUps(boolean inFirst, boolean inLast, boolean inEmailAddr, boolean inPhoneNum, boolean inMobileNum, string firstn, string lastn, string uemail, string uphone, string umobile)`
---
#### Properties

##### `firstName` → `String`


##### `inEmail` → `boolean`


##### `inFirstName` → `boolean`


##### `inLastName` → `boolean`


##### `inMobile` → `boolean`


##### `inPhone` → `boolean`


##### `lastName` → `String`


##### `upEmail` → `String`


##### `upMobile` → `String`


##### `upPhone` → `String`


---

---
