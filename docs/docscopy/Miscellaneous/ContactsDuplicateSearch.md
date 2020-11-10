---
layout: default
---
# ContactsDuplicateSearch class

@description

---
## Constructors
### `ContactsDuplicateSearch(ApexPages.StandardController c)`
#### Parameters
|Param|Description|
|-----|-----------|
|`` | c |

---
## Properties

### `ActiveRecordsCount` → `Integer`

### `ModelKeyList` → `List<VINDecoder_DataOneSoftware.StyleData>`

@description

### `SelectedStyleId` → `String`

@description

### `activeContacts` → `List<AvaliableContacts>`

@description

### `ddat` → `VINDecoder_DataOneSoftware.DecodeResponseStruct`

@description

### `dms` → `dealer__DMS_Settings__c`

@description

### `isMerge` → `Boolean`

@description

### `matchEscape` → `Boolean`

@description

### `sdat` → `VINDecoder_DataOneSoftware.StyleData`

@description

### `searchContactResults` → `List<Contact>`

@description

### `searchCustomerSize` → `Integer`

### `searchOptions` → `searchUps`

@description

### `searchUpsResults` → `List<dealer__Sales_Up__c>`

@description

### `searchUpsSize` → `Integer`

### `selectedCustomerId` → `Id`

### `up` → `Contact`

@description

### `vd` → `VINDecoder`

@description

---
## Methods
### `FindDupes()` → `PageReference`
### `getSelectedStyleId()` → `String`
### `getUserId()` → `String`
### `getUserName()` → `String`
### `isBlank(String s)` → `Boolean`
### `mergeRecords()` → `pageReference`
### `searchExistingContacts(String firstName, String lastName, String emailAddress, String primaryPhone, String mobilePhone)` → `List<Contact>`
### `setSelectedStyleId(String SelectedStyleId)` → `void`
---
## Inner Classes

### ContactsDuplicateSearch.AvaliableContacts class
---
#### Constructors
##### `AvaliableContacts()`
---
#### Properties

##### `counter` → `Integer`

##### `isChecked` → `Boolean`

##### `junctionRecord` → `Contact`

---
### ContactsDuplicateSearch.SalesUpException class
---
### ContactsDuplicateSearch.searchUps class
---
#### Constructors
##### `searchUps(boolean inFirst, boolean inLast, boolean inEmailAddr, boolean inPhoneNum, boolean inMobileNum,string firstn, string lastn, string uemail, string uphone, string umobile)`
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
