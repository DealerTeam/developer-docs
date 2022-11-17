# SalesLead_EXT

`APIVERSION: 45`

`STATUS: ACTIVE`

SalesLead_EXT - Cotnrols interaction wiht the salesup object


**Group** Sales

## Constructors
### `SalesLead_EXT(ApexPages.StandardController c)`
---
## Fields

### `InstalledEquipment` → `List<VinDecoderAPI.InstalledEquipment>`


### `ModelKeyList` → `List<VINDecoderDataObject.Style>`


### `OptEquip` → `List<VinDecoderAPI.OptionalEquipment>`


### `SelectedStyleId` → `String`


### `matchEscape` → `Boolean`


### `up` → `dealer__Sales_Up__c`


### `upList` → `List<dealer__Sales_Up__c>`


### `vd` → `VINDecoder`


---
## Properties

### `ActiveRecordsCount` → `Integer`


### `acctLabel` → `String`


### `activeSalesup` → `List<AvaliableSalesUp>`


### `businessAccountId` → `Id`


### `crm` → `dealer__CRMSettings__c`


### `dms` → `dealer__DMS_Settings__c`


### `fromB2BAccount` → `Boolean`


### `fromCreatePage` → `Boolean`


### `fromFDPage` → `Boolean`


### `hasDuplicateResult` → `Boolean`


### `isMerge` → `Boolean`


### `isPersonsAccountsEnabled` → `Boolean`


### `nomatchstring` → `String`


### `searchAccountResults` → `List<Account>`


### `searchAccountSize` → `Integer`


### `searchContactCount` → `integer`


### `searchContactResults` → `List<Contact>`


### `searchCustomerSize` → `Integer`


### `searchOptions` → `searchUps`


### `searchUpCount` → `integer`


### `searchUpsResults` → `List<dealer__Sales_Up__c>`


### `searchUpsSize` → `Integer`


### `selectedAccountId` → `Id`


### `selectedCustomerId` → `Id`


### `serVehicleList` → `List<dealer__Service_Vehicle__c>`


### `skipSearch` → `Boolean`


### `supLabel` → `String`


### `vehicleInventory` → `dealer__Vehicle_Inventory__c`


---
## Methods
### `getDuplicateRecords()`
### `getNewPageFields()`
### `getLexPreference()`
### `getBusinessContacts()`
### `setSupFieldsFromContact()`
### `redirectLex()`

redirectLex - Determines the experience the user is expecting and directs them to the right new page

#### Return

**Type**

PageReference

**Description**

pageRefence


**Notes** based on the users preferences this method is called on page load to direct the user to the right location.

### `singleQuotes(String str)`
### `salesUpview()`
### `customSave()`
### `cancel()`

**Method** : Cancel


**Description** : return the user to the cancel page

### `searchTradeVIN()`
### `getUserName()`
### `getUserId()`
### `getup()`
### `getUpList()`
### `Create()`
### `saveDuplicateOverride()`

**Method** SaveOverride

### `lookUp(String upID)`
### `noMatch()`
### `attachLead()`
### `isBlank(String s)`
### `customDoDecode()`

Returns reference to the Service Vehicle version of VIN Decode

#### Return

**Type**

PageReference

**Description**

A reference to VINDecodeServiceVehicleStyleSelect.page


**Author** Mimi Sakarett


**Date** 2016.03.14

### `doDecode()`
### `decodeTradePage()`
### `editTradeVINPage()`
### `getModelKeyList()`
### `getDecode()`
### `getSelectedStyleId()`
### `setSelectedStyleId(String SelectedStyleId)`
### `mergeRecords()`
### `getKeyPrefix()`
### `getRecordTypeName()`
### `getInventoryVehicle()`
### `createInventory()`
### `FindFromCreatePage()`
### `FindDupesFromFD()`
### `FindDupes()`

Checks custom setting to determine whether to use native or non native duplicate catching

#### Return

**Type**

PageReference

**Description**

PageReference to SalesUpDuplicateSearch.page


**Author** Mimi Sakarett


**Date** 2016.02.08

### `NonNativeFindDupes()`

Searches existing Accounts and Sales Ups for a match to the current Sales Up.

#### Return

**Type**

PageReference

**Description**

PageReference to SalesUpDuplicateSearch.page


**Author** Mimi Sakarett


**Date** 2016.02.08

### `NativeFindDupes()`
### `CreateSU()`
### `NonNativeCreateSU()`
### `NativeCreateSU()`
### `searchExistingDataSOSL(searchUps searchOptions)`
### `static lookupCallerId(String sParam)`

`REMOTEACTION`
---
## Classes
### AvaliableSalesUp
#### Constructors
##### `AvaliableSalesUp()`
---
#### Properties

##### `counter` → `Integer`


##### `isChecked` → `Boolean`


##### `junctionRecord` → `Sales_up__c`


---

### SalesUpException

**Inheritance**

SalesUpException


### UpException

**Inheritance**

UpException


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
